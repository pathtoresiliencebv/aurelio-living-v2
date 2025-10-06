# 🌐 Render DNS Setup voor Multi-Store (Wildcard Subdomains)

## 📋 Overzicht

Voor multi-store met subdomains (`outlet.myaurelio.com`, `nl.myaurelio.com`, etc.) heb je **2 dingen** nodig:

1. **Hoofddomain** toevoegen aan Render
2. **Wildcard subdomain** toevoegen aan Render
3. **DNS records** configureren bij je domain provider

---

## 🚀 Stap 1: Custom Domain toevoegen in Render

### 1.1 Ga naar Render Dashboard

1. Open: https://dashboard.render.com
2. Selecteer je service: **`aurelio-living-v2-upgraded`**
3. Klik op **"Settings"** tab
4. Scroll naar **"Custom Domains"**

### 1.2 Voeg Hoofddomain toe

Klik **"+ Add Custom Domain"**:

```
Domain: myaurelio.com
```

Render geeft je nu een **CNAME target**, bijvoorbeeld:
```
your-app-name.onrender.com
```

### 1.3 Voeg Wildcard Subdomain toe

Klik nogmaals **"+ Add Custom Domain"**:

```
Domain: *.myaurelio.com
```

Render geeft ook hier een **CNAME target**.

**BELANGRIJK**: Sommige domain providers ondersteunen geen wildcard CNAME. Dan moet je een **A record** gebruiken (zie Stap 2).

---

## 🌍 Stap 2: DNS Records configureren bij je Domain Provider

### Optie A: Cloudflare (AANBEVOLEN)

Cloudflare ondersteunt wildcards goed en heeft gratis SSL.

#### 1. Voeg A Record toe voor hoofddomain

| Type | Name | Content | Proxy | TTL |
|------|------|---------|-------|-----|
| A | @ | `IP_VAN_RENDER` | ✅ Proxied | Auto |

**IP van Render krijgen:**
```bash
# Ping je Render app
ping your-app-name.onrender.com
```

Of gebruik het IP dat Render in de Custom Domain sectie toont.

#### 2. Voeg CNAME Record toe voor www

| Type | Name | Content | Proxy | TTL |
|------|------|---------|-------|-----|
| CNAME | www | myaurelio.com | ✅ Proxied | Auto |

#### 3. Voeg A Record toe voor wildcard

| Type | Name | Content | Proxy | TTL |
|------|------|---------|-------|-----|
| A | * | `IP_VAN_RENDER` | ✅ Proxied | Auto |

**BELANGRIJK**: Zet **Proxy status** op **Proxied** (oranje wolkje) voor gratis SSL!

---

### Optie B: Andere DNS Providers (GoDaddy, Namecheap, etc.)

#### Voor providers die CNAME wildcards ondersteunen:

| Type | Name | Content | TTL |
|------|------|---------|-----|
| CNAME | @ | your-app-name.onrender.com | 3600 |
| CNAME | www | your-app-name.onrender.com | 3600 |
| CNAME | * | your-app-name.onrender.com | 3600 |

#### Voor providers zonder CNAME wildcard support:

| Type | Name | Content | TTL |
|------|------|---------|-----|
| A | @ | `IP_VAN_RENDER` | 3600 |
| CNAME | www | myaurelio.com | 3600 |
| A | * | `IP_VAN_RENDER` | 3600 |

**Let op**: Render's IP kan veranderen! Gebruik daarom bij voorkeur Cloudflare.

---

### Optie C: TransIP (Nederlandse provider)

1. Log in op TransIP Control Panel
2. Ga naar **Domeinen** → **myaurelio.com** → **DNS**

Voeg deze records toe:

| Naam | TTL | Type | Waarde |
|------|-----|------|--------|
| @ | 3600 | A | `IP_VAN_RENDER` |
| www | 3600 | CNAME | myaurelio.com |
| * | 3600 | A | `IP_VAN_RENDER` |

---

## 🔍 Stap 3: Verificatie in Render

1. Ga terug naar **Render Dashboard** → **Custom Domains**
2. Wacht tot beide domains **"Verified"** zijn (kan 5-30 minuten duren)
3. Render genereert automatisch **gratis SSL certificaten**

Status overzicht:
```
✅ myaurelio.com          - Verified, SSL Active
✅ *.myaurelio.com        - Verified, SSL Active
```

---

## 🧪 Stap 4: Test je Multi-Store Setup

### 4.1 Update Environment Variable

Zorg dat in **Render** → **Environment**:

```
SPREE_ROOT_DOMAIN=myaurelio.com
```

### 4.2 Deploy & Restart

1. Klik **"Manual Deploy"** → **"Deploy latest commit"**
2. Wacht tot deployment klaar is

### 4.3 Maak Test Stores

Via Rails Console op Render:

```ruby
# Maak outlet store
Spree::Store.create!(
  name: 'Aurelio Outlet',
  code: 'outlet',
  mail_from_address: 'noreply@myaurelio.com',
  default_currency: 'EUR',
  default_locale: 'nl'
)

# Maak NL store
Spree::Store.create!(
  name: 'Aurelio Living NL',
  code: 'nl',
  mail_from_address: 'noreply@myaurelio.com',
  default_currency: 'EUR',
  default_locale: 'nl'
)
```

### 4.4 Test de URLs

Open in je browser:

- ✅ https://myaurelio.com (hoofdstore)
- ✅ https://www.myaurelio.com (hoofdstore)
- ✅ https://outlet.myaurelio.com (outlet store)
- ✅ https://nl.myaurelio.com (NL store)

**Verwachte resultaat**: Elke URL toont de juiste store!

---

## 🔧 Troubleshooting

### ❌ "Domain not verified"

**Probleem**: Render kan domain niet verifiëren

**Oplossing**:
1. Check DNS propagatie: https://dnschecker.org (zoek naar `myaurelio.com`)
2. Wacht 30-60 minuten (DNS propagatie duurt even)
3. Check of DNS records correct zijn ingesteld

### ❌ "SSL Certificate Error"

**Probleem**: HTTPS werkt niet

**Oplossing**:
1. Wacht tot Render "SSL Active" toont (kan 15-30 min duren)
2. Als Cloudflare: Zet SSL/TLS mode op **"Full (strict)"**
3. Force refresh: Ctrl+F5

### ❌ Wildcard subdomain werkt niet

**Probleem**: `outlet.myaurelio.com` geeft 404

**Oplossing**:
1. Check of `*.myaurelio.com` in Render custom domains staat
2. Check of wildcard DNS record bestaat
3. Test DNS: `nslookup outlet.myaurelio.com`
4. Check `SPREE_ROOT_DOMAIN` environment variable

### ❌ Redirect loop

**Probleem**: Pagina blijft redirecten

**Oplossing** (als je Cloudflare gebruikt):
1. Cloudflare Dashboard → SSL/TLS
2. Zet op **"Full (strict)"** (niet "Flexible"!)
3. Render → Settings → Enable "Force HTTPS"

---

## 📊 DNS Propagation Checken

### Online Tools

- https://dnschecker.org
- https://www.whatsmydns.net

Zoek naar:
- `myaurelio.com` (moet IP of CNAME tonen)
- `outlet.myaurelio.com` (moet IP of CNAME tonen)
- `randomtext.myaurelio.com` (moet IP of CNAME tonen)

### Via Terminal

```bash
# Check A record
dig myaurelio.com A

# Check wildcard
dig outlet.myaurelio.com A
dig test.myaurelio.com A

# Check CNAME
dig myaurelio.com CNAME
```

---

## 🎯 Aanbevolen Setup: Cloudflare

### Waarom Cloudflare?

✅ **Gratis SSL** voor wildcard subdomains
✅ **DDoS bescherming**
✅ **CDN** (snellere laadtijden)
✅ **Altijd online** (cache bij downtime)
✅ **Geen IP changes** (Render IP kan veranderen)

### Cloudflare Setup (5 minuten)

1. **Account aanmaken**: https://cloudflare.com/sign-up
2. **Domain toevoegen**: Volg de wizard
3. **Nameservers updaten** bij je domain provider:
   ```
   Cloudflare nameserver 1: chad.ns.cloudflare.com
   Cloudflare nameserver 2: uma.ns.cloudflare.com
   ```
4. **DNS records toevoegen** (zie "Optie A" hierboven)
5. **SSL/TLS mode**: Zet op **"Full (strict)"**
6. **Wacht 5-30 minuten** voor propagatie
7. **Klaar!** 🎉

---

## 📋 Checklist

- [ ] Custom domain toegevoegd in Render: `myaurelio.com`
- [ ] Wildcard subdomain toegevoegd in Render: `*.myaurelio.com`
- [ ] DNS A record: `@ → IP_VAN_RENDER`
- [ ] DNS A record: `* → IP_VAN_RENDER`
- [ ] DNS CNAME record: `www → myaurelio.com`
- [ ] Environment variable: `SPREE_ROOT_DOMAIN=myaurelio.com`
- [ ] Domains "Verified" in Render
- [ ] SSL "Active" in Render
- [ ] Test: https://myaurelio.com werkt
- [ ] Test: https://outlet.myaurelio.com werkt

---

## 🆘 Hulp Nodig?

**Render Docs**: https://docs.render.com/custom-domains

**Cloudflare Docs**: https://developers.cloudflare.com/dns/

**DNS Test Tools**:
- https://dnschecker.org
- https://www.whatsmydns.net
- https://mxtoolbox.com/DNSLookup.aspx

---

**Succes met je multi-store setup!** 🚀
