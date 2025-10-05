# Multi-Store Setup - Aurelio Living

## 🌐 Overview

Aurelio Living is configured for **multi-store functionality** with subdomain routing. Each store gets its own subdomain under `myaurelio.com`.

## Configuration

### Root Domain

The root domain is configured in `config/initializers/spree.rb`:

```ruby
Spree.root_domain = ENV.fetch('SPREE_ROOT_DOMAIN', 'myaurelio.com')
```

### Environment Variables

Add to your `.env` file:

```bash
# Production
SPREE_ROOT_DOMAIN=myaurelio.com

# Development (use lvh.me for local testing)
# SPREE_ROOT_DOMAIN=lvh.me
```

## 🏪 Store Structure

Each store automatically gets a subdomain based on its **code**:

- **Default Store**: `www.myaurelio.com` or `myaurelio.com`
- **Store 2**: `store2.myaurelio.com`
- **Custom Store**: `outlet.myaurelio.com`

## Creating New Stores

### Via Admin Panel

1. Go to **Admin Panel** → **Multi-Store** → **New Store**
2. Fill in store details:
   - **Name**: Display name (e.g., "Aurelio Outlet")
   - **Code**: URL identifier (e.g., "outlet")
   - **Currency**: EUR
   - **Locale**: nl
3. Click **Create**

### Via Rails Console

```ruby
# Create a new store
Spree::Store.create!(
  name: 'Aurelio Outlet',
  code: 'outlet',
  mail_from_address: 'noreply@myaurelio.com',
  default_currency: 'EUR',
  default_locale: 'nl'
)
```

### Via Rake Task

```bash
# Create with auto-generated code
bin/rails spree:multistore:create_store["Aurelio Outlet"]

# Create with custom code
bin/rails spree:multistore:create_store["Aurelio Outlet","outlet"]
```

## 🛠️ Management Tasks

### List All Stores

```bash
bin/rails spree:multistore:list_stores
```

### Update Store URLs

If you change the `SPREE_ROOT_DOMAIN`, run:

```bash
bin/rails spree:multistore:update_store_urls
```

This updates all store URLs to use the new root domain.

## 🌍 DNS Configuration

### Production Setup

For production on `myaurelio.com`, configure DNS:

1. **Main domain**:
   ```
   A     myaurelio.com     → YOUR_SERVER_IP
   CNAME www.myaurelio.com → myaurelio.com
   ```

2. **Wildcard subdomain**:
   ```
   CNAME *.myaurelio.com → myaurelio.com
   ```

### Render.com Setup

If deploying on Render:

1. Add custom domain: `myaurelio.com`
2. Add wildcard domain: `*.myaurelio.com`
3. Render will provide CNAME records to configure in your DNS

## 🔧 Development Setup

For local development, use `lvh.me` (resolves to 127.0.0.1):

```bash
# .env.development
SPREE_ROOT_DOMAIN=lvh.me
```

Access stores locally:
- Main: `http://lvh.me:3001`
- Store 2: `http://store2.lvh.me:3001`
- Outlet: `http://outlet.lvh.me:3001`

## 📊 Store Configuration

Each store can have independent:

- ✅ **Products**: Shared or store-specific inventory
- ✅ **Categories**: Custom taxonomies per store
- ✅ **Pricing**: Store-specific prices
- ✅ **Theme**: Different themes per store (via theme selector)
- ✅ **Languages**: nl, en, de, fr (via spree_i18n)
- ✅ **Currency**: EUR, USD, GBP
- ✅ **Shipping Methods**: Store-specific shipping
- ✅ **Payment Methods**: Store-specific gateways
- ✅ **Promotions**: Store-specific or global

## 🎨 Themes Per Store

In Admin Panel → **Settings** → **General Settings**:

1. Select the store
2. Choose **Theme**: `Aurelio Living` or custom theme
3. Customize theme preferences (colors, fonts, etc.)

## 📋 Common Use Cases

### 1. Main Store + Outlet Store

```ruby
# Main luxury store
main = Spree::Store.find_by(default: true)
main.update(name: 'Aurelio Living', code: 'main')

# Outlet/clearance store
outlet = Spree::Store.create!(
  name: 'Aurelio Outlet',
  code: 'outlet',
  mail_from_address: 'noreply@myaurelio.com',
  default_currency: 'EUR'
)
```

Access:
- Main: `https://myaurelio.com`
- Outlet: `https://outlet.myaurelio.com`

### 2. Multi-Country Stores

```ruby
# Netherlands
nl_store = Spree::Store.create!(
  name: 'Aurelio Living NL',
  code: 'nl',
  default_currency: 'EUR',
  default_locale: 'nl'
)

# Germany
de_store = Spree::Store.create!(
  name: 'Aurelio Living DE',
  code: 'de',
  default_currency: 'EUR',
  default_locale: 'de'
)

# Belgium
be_store = Spree::Store.create!(
  name: 'Aurelio Living BE',
  code: 'be',
  default_currency: 'EUR',
  default_locale: 'nl'
)
```

Access:
- Netherlands: `https://nl.myaurelio.com`
- Germany: `https://de.myaurelio.com`
- Belgium: `https://be.myaurelio.com`

### 3. B2C + B2B Stores

```ruby
# Consumer store
b2c = Spree::Store.find_by(default: true)
b2c.update(name: 'Aurelio Living', code: 'shop')

# Wholesale/B2B store
b2b = Spree::Store.create!(
  name: 'Aurelio Wholesale',
  code: 'b2b',
  mail_from_address: 'b2b@myaurelio.com',
  default_currency: 'EUR'
)
```

Access:
- Consumer: `https://shop.myaurelio.com`
- Wholesale: `https://b2b.myaurelio.com`

## 🔐 Security

- Each store has **independent sessions**
- Users can have **different roles per store**
- Configure store-specific **SSL certificates**
- Use **Content Security Policy** per store

## 📈 Analytics

Track each store separately in:

- **Google Analytics**: Different GA IDs per store
- **Facebook Pixel**: Store-specific pixels
- **Klaviyo**: Segment by store

Add in `app/views/spree/shared/_head.html.erb`:

```erb
<% if current_store.code == 'outlet' %>
  <!-- Outlet store specific tracking -->
<% elsif current_store.code == 'b2b' %>
  <!-- B2B store specific tracking -->
<% end %>
```

## 🆘 Troubleshooting

### Store URLs not updating

```bash
bin/rails spree:multistore:update_store_urls
```

### Can't access subdomain locally

Use `lvh.me` instead of `localhost`:
```bash
SPREE_ROOT_DOMAIN=lvh.me bin/rails server -p 3001
```

### Wildcard SSL issues

Ensure you have a **wildcard SSL certificate** covering `*.myaurelio.com`

## 📚 Resources

- [Spree Multi-Store Documentation](https://spreecommerce.org/docs/developer/multi-store/setup)
- [Spree Multi-Store Quickstart](https://spreecommerce.org/docs/developer/multi-store/quickstart)
- [Spree Store Model](https://api.spreecommerce.org/classes/Spree/Store.html)

---

**Need help?** Check the admin panel under **Multi-Store** or run `bin/rails spree:multistore:list_stores`
