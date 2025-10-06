# ☁️ Cloudflare + Render Setup voor Aurelio Living Multi-Store

## 🎯 Waarom Cloudflare + Render?

✅ **Gratis SSL** voor wildcard subdomains (`*.myaurelio.com`)
✅ **Gratis CDN** - 30-50% snellere laadtijden wereldwijd
✅ **DDoS bescherming** - Automatisch geblokkeerd
✅ **Altijd online** - Cache bij downtime
✅ **Geen IP changes** - Zelfs als Render's IP verandert
✅ **Email routing** - Gratis email forwarding
✅ **Analytics** - Gratis bezoekers statistieken

---

## 📋 Stap-voor-Stap Setup (15 minuten)

### **Stap 1: Cloudflare Account aanmaken** (2 min)

1. Ga naar: https://cloudflare.com/sign-up
2. Email + wachtwoord invullen
3. Account activeren via email

**✅ Klaar!**

---

### **Stap 2: Domain toevoegen aan Cloudflare** (5 min)

1. Klik **"+ Add a Site"** in Cloudflare Dashboard
2. Voer je domain in: `myaurelio.com`
3. Klik **"Add site"**

#### Selecteer Plan

4. Selecteer **"Free"** plan (€0/maand)
5. Klik **"Continue"**

#### DNS Records Scannen

6. Cloudflare scant automatisch je bestaande DNS records
7. Klik **"Continue"**

**✅ Je DNS records zijn geïmporteerd!**

---

### **Stap 3: Nameservers updaten** (3 min)

Cloudflare geeft je **2 nameservers**, bijvoorbeeld:

```
chad.ns.cloudflare.com
uma.ns.cloudflare.com
```

#### Bij je huidige Domain Provider:

**TransIP:**
1. Login op TransIP Control Panel
2. Ga naar **Domeinen** → **myaurelio.com**
3. Klik **Nameservers**
4. Selecteer **"Aangepaste nameservers"**
5. Voer Cloudflare nameservers in
6. Klik **Opslaan**

**GoDaddy:**
1. Login op GoDaddy
2. Ga naar **My Products** → **Domains**
3. Klik op je domain → **Manage DNS**
4. Scroll naar **Nameservers** → **Change**
5. Selecteer **"Custom"**
6. Voer Cloudflare nameservers in
7. Klik **Save**

**Namecheap:**
1. Login op Namecheap
2. Ga naar **Domain List** → je domain
3. Scroll naar **Nameservers**
4. Selecteer **"Custom DNS"**
5. Voer Cloudflare nameservers in
6. Klik **✓**

**⏱️ Propagatie tijd**: 5 minuten - 24 uur (meestal binnen 1 uur)

---

### **Stap 4: DNS Records configureren in Cloudflare** (5 min)

1. Ga naar **Cloudflare Dashboard** → **DNS** → **Records**
2. Klik **"+ Add record"** voor elk van deze:

#### DNS Records voor Render

| Type | Name | Target/Content | Proxy Status | TTL |
|------|------|----------------|--------------|-----|
| CNAME | @ | `aurelio-living-v2-upgraded.onrender.com` | ✅ Proxied | Auto |
| CNAME | www | `myaurelio.com` | ✅ Proxied | Auto |
| CNAME | * | `aurelio-living-v2-upgraded.onrender.com` | ✅ Proxied | Auto |

**BELANGRIJK**: 
- ✅ **Oranje wolkje** = Proxied (Cloudflare CDN + SSL)
- ⚠️ **Grijs wolkje** = DNS Only (geen Cloudflare voordelen)

**Zorg dat alle 3 records PROXIED zijn!**

#### Email Records (optioneel)

Als je email wilt gebruiken (`noreply@myaurelio.com`):

| Type | Name | Target/Content | Priority | Proxy |
|------|------|----------------|----------|-------|
| MX | @ | `mail.yourprovider.com` | 10 | DNS Only |
| TXT | @ | `v=spf1 include:_spf.yourprovider.com ~all` | - | DNS Only |

---

### **Stap 5: SSL/TLS Configureren** (1 min)

1. Ga naar **Cloudflare** → **SSL/TLS**
2. Selecteer **"Full (strict)"** mode

#### Wat betekent dit?

- **Off**: Geen SSL (niet aanbevolen!)
- **Flexible**: SSL tussen browser ↔ Cloudflare (niet veilig!)
- **Full**: SSL tussen browser ↔ Cloudflare ↔ Render (basis)
- **Full (strict)** ✅: SSL + certificaat validatie (VEILIG!)

3. Scroll naar **"Edge Certificates"**
4. Zet **"Always Use HTTPS"** aan
5. Zet **"Automatic HTTPS Rewrites"** aan

**✅ SSL is nu actief voor alle subdomains!**

---

### **Stap 6: Render Custom Domains toevoegen**

1. Ga naar **Render Dashboard**: https://dashboard.render.com
2. Selecteer je service: `aurelio-living-v2-upgraded`
3. Klik **Settings** → scroll naar **Custom Domains**

#### Voeg Domains toe:

Klik **"+ Add Custom Domain"** voor elk:

```
myaurelio.com
*.myaurelio.com
```

**Status:**
- ⏳ "Verifying..." (5-30 minuten)
- ✅ "Verified" (DNS geconfigureerd!)
- 🔒 "SSL Active" (Certificaat klaar!)

**Let op**: Met Cloudflare Proxied mode krijgt Render mogelijk een warning. **Negeer dit** - het werkt perfect!

---

### **Stap 7: Render Environment Variable**

1. Render Dashboard → **Environment**
2. Klik **"+ Add Environment Variable"**

```
Key:   SPREE_ROOT_DOMAIN
Value: myaurelio.com
```

3. Klik **"Save Changes"**
4. Klik **"Manual Deploy"** → **"Deploy latest commit"**

**⏱️ Deployment duurt 3-5 minuten**

---

### **Stap 8: Verificatie & Testing**

#### Check DNS Propagatie

1. Ga naar: https://dnschecker.org
2. Zoek naar: `myaurelio.com`
3. Type: `A` of `CNAME`

**Verwacht resultaat**: 
- Groene vinkjes wereldwijd
- Target: Cloudflare IP of je Render URL

#### Test Wildcard Subdomain

```bash
# Via terminal
nslookup outlet.myaurelio.com
nslookup random123.myaurelio.com

# Beide moeten hetzelfde IP/CNAME tonen
```

#### Test in Browser

Open deze URLs:

- ✅ https://myaurelio.com
- ✅ https://www.myaurelio.com
- ✅ https://outlet.myaurelio.com
- ✅ https://test.myaurelio.com

**Verwacht resultaat**: Alle URLs laden je Spree app (of 404 als store niet bestaat)

---

## 🎨 Stap 9: Cloudflare Optimalisaties (Optioneel)

### Cache Alles voor Snelheid

1. Cloudflare → **Caching** → **Configuration**
2. **Caching Level**: Standard
3. **Browser Cache TTL**: 4 hours

### Auto Minify (kleinere files)

1. Cloudflare → **Speed** → **Optimization**
2. Auto Minify:
   - ✅ JavaScript
   - ✅ CSS
   - ✅ HTML

### Brotli Compressie

1. Cloudflare → **Speed** → **Optimization**
2. ✅ **Brotli** aan

### Rocket Loader (snellere JS)

1. Cloudflare → **Speed** → **Optimization**
2. **Rocket Loader**: On

**⚡ Je site is nu 30-50% sneller!**

---

## 📊 Stap 10: Analytics Bekijken

1. Cloudflare → **Analytics** → **Traffic**

Zie:
- 📈 Requests per dag
- 🌍 Bezoekers per land
- 🚫 Geblokkeerde threats
- 💾 Bandwidth bespaart door cache

**Helemaal gratis!**

---

## 🔒 Stap 11: Beveiliging (Optioneel)

### Firewall Rules

1. Cloudflare → **Security** → **WAF**
2. Klik **"Create rule"**

**Voorbeeld: Blokkeer bekende bots**

```
Rule name: Block Bad Bots
Field: Known Bots
Operator: equals
Value: On
Action: Block
```

### Rate Limiting

Voorkom DDoS attacks:

1. Cloudflare → **Security** → **Rate Limiting**
2. Klik **"Create rule"**

**Voorbeeld: Max 10 requests per 10 seconden**

```
Rule name: API Rate Limit
URL: myaurelio.com/api/*
Requests: 10
Period: 10 seconds
Action: Block
```

---

## 🆘 Troubleshooting

### ❌ "Too many redirects" (redirect loop)

**Oorzaak**: SSL mode staat op "Flexible"

**Oplossing**:
1. Cloudflare → **SSL/TLS**
2. Zet op **"Full (strict)"**
3. Wacht 1 minuut
4. Hard refresh: Ctrl+Shift+R

### ❌ "Domain not verified" in Render

**Oorzaak**: DNS nog niet gepropageerd of verkeerde records

**Oplossing**:
1. Check DNS: https://dnschecker.org
2. Wacht 30 minuten
3. Zorg dat CNAME record bestaat
4. Check of Cloudflare nameservers actief zijn bij je domain provider

### ❌ Wildcard subdomain werkt niet

**Oorzaak**: `*` record mist of niet proxied

**Oplossing**:
1. Cloudflare → DNS → Records
2. Check of `*` (wildcard) record bestaat
3. Zorg dat het **Proxied** is (oranje wolkje)
4. Target moet zijn: `aurelio-living-v2-upgraded.onrender.com`

### ❌ "SSL Handshake failed"

**Oorzaak**: Certificaat nog niet klaar

**Oplossing**:
1. Wacht 15-30 minuten (Render & Cloudflare genereren SSL)
2. Check Render → Settings → Custom Domains → "SSL Active"
3. Check Cloudflare → SSL/TLS → Edge Certificates → Status

### ❌ Cloudflare geeft 520/521/522 error

**Oorzaak**: Render app is down of niet bereikbaar

**Oplossing**:
1. Check Render Dashboard → Service status
2. Check Render logs voor errors
3. Zorg dat app draait
4. Check of `aurelio-living-v2-upgraded.onrender.com` direct bereikbaar is

---

## 📋 Complete Checklist

### Cloudflare Setup
- [ ] Account aangemaakt
- [ ] Domain toegevoegd
- [ ] Nameservers geüpdatet bij domain provider
- [ ] DNS propagatie compleet (groene vinkjes op dnschecker.org)
- [ ] CNAME records toegevoegd: `@`, `www`, `*`
- [ ] Alle records zijn **Proxied** (oranje wolkje)
- [ ] SSL/TLS op **"Full (strict)"**
- [ ] "Always Use HTTPS" ingeschakeld

### Render Setup
- [ ] Custom domains toegevoegd: `myaurelio.com`, `*.myaurelio.com`
- [ ] Status is "Verified" + "SSL Active"
- [ ] Environment variable: `SPREE_ROOT_DOMAIN=myaurelio.com`
- [ ] App gedeployed met nieuwe settings

### Testing
- [ ] https://myaurelio.com werkt
- [ ] https://www.myaurelio.com werkt
- [ ] https://outlet.myaurelio.com werkt
- [ ] https://randomtest.myaurelio.com werkt
- [ ] SSL certificaat is geldig (slotje in browser)
- [ ] Geen redirect loops

### Optimalisatie (optioneel)
- [ ] Auto Minify ingeschakeld
- [ ] Brotli compressie aan
- [ ] Cache level ingesteld
- [ ] Analytics werkt

---

## 💰 Kosten

### Cloudflare Free Plan
- ✅ **€0/maand**
- ✅ Onbeperkte DDoS bescherming
- ✅ Gratis SSL voor alle subdomains
- ✅ Gratis CDN
- ✅ Gratis Analytics
- ✅ Email forwarding

### Wanneer upgraden naar Pro? (€20/maand)
- 🚀 Meer cache (sneller)
- 📱 Image optimization
- 📊 Geavanceerde analytics
- ⚡ 100% uptime garantie

**Voor een normale webshop is FREE meer dan genoeg!**

---

## 🎓 Extra Tips

### 1. Page Rules voor Cache

Cloudflare → **Rules** → **Page Rules**

**Cache alles op /products:**
```
URL: myaurelio.com/products*
Setting: Cache Level = Cache Everything
Browser Cache TTL: 4 hours
```

### 2. Email Forwarding

Cloudflare → **Email** → **Email Routing**

Forward emails:
```
noreply@myaurelio.com → jouw-email@gmail.com
support@myaurelio.com → jouw-email@gmail.com
```

**Helemaal gratis!**

### 3. Mobile Redirect

Als je een mobiele app hebt:

Cloudflare → **Rules** → **Redirect Rules**

```
If: User Agent contains "iPhone|Android"
Then: Redirect to app store
```

---

## 📚 Handige Links

- **Cloudflare Dashboard**: https://dash.cloudflare.com
- **Cloudflare Docs**: https://developers.cloudflare.com
- **DNS Checker**: https://dnschecker.org
- **SSL Checker**: https://www.ssllabs.com/ssltest/
- **Render Dashboard**: https://dashboard.render.com
- **Render Docs**: https://docs.render.com

---

## ✅ Resultaat

Na deze setup heb je:

- 🌐 Multi-store op subdomains
- 🔒 Gratis SSL voor alle domains
- ⚡ 30-50% snellere laadtijden
- 🛡️ DDoS bescherming
- 📊 Analytics
- 💰 Alles voor €0/maand extra!

**Perfect voor Aurelio Living!** 🎉

---

**Vragen?** Check de Troubleshooting sectie of vraag het me!
