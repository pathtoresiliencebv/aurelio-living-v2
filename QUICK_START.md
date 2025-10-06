# 🚀 Aurelio Living - Quick Start Guide

## ✨ What's New

Your Aurelio Living store now includes:

1. **Multi-Store Setup** - Run multiple stores on subdomains
2. **POS Barcode Scanner** - Scan and lookup products instantly
3. **SHEIN Product Import** - Automated product importing from SHEIN

---

## 📋 Installation Steps

### 1. Run Migrations

```bash
cd "/home/jason/AURELIO LIVING/spree_starter"
bin/rails db:migrate
```

This creates:
- `barcode` columns in products/variants
- `spree_shein_imports` table

### 2. Update Environment Variables

Add to `.env`:

```bash
# Multi-Store
SPREE_ROOT_DOMAIN=myaurelio.com

# SHEIN Import (get token from https://apify.com)
APIFY_API_TOKEN=your_apify_token_here
```

### 3. Start Sidekiq (for SHEIN imports)

```bash
bundle exec sidekiq
```

Or in background:
```bash
bundle exec sidekiq -d
```

### 4. Restart Server

```bash
bin/rails server -p 3001
```

---

## 🎯 Quick Access

### Admin Panel URLs

- **Barcode Scanner**: http://localhost:3001/admin/barcode_scanner
- **SHEIN Imports**: http://localhost:3001/admin/shein_imports
- **Multi-Store Settings**: http://localhost:3001/admin/stores

---

## 🔍 Feature 1: POS Barcode Scanner

### Quick Test

1. Go to **Admin → Products → Any Product**
2. Scroll to **Barcode** section
3. Click **Generate Barcode**
4. Go to **Admin → Barcode Scanner**
5. Enter the barcode and press Enter
6. Product details appear! ✅

### Add Barcode to Existing Product

```ruby
# Rails console
product = Spree::Product.first
product.barcode = "1234567890123"
product.save!
```

---

## 🛍️ Feature 2: SHEIN Product Import

### Quick Test (5 minutes)

1. **Get Apify Token**:
   - Sign up: https://apify.com
   - Get token: https://apify.com/account/integrations
   - Add to `.env`: `APIFY_API_TOKEN=your_token`

2. **Start Import**:
   - Go to **Admin → SHEIN Imports → New Import**
   - Search term: "test product"
   - Max items: 5
   - Click **Start Import**

3. **Wait & Process**:
   - Status will change: `pending` → `scraping` → `scraped`
   - Click **Process Import** when ready
   - Products will be imported!

### Import from SHEIN Category

1. Find a category on SHEIN (e.g., Women's Dresses)
2. Copy the URL: `https://www.shein.com/women-dresses-c-1727.html`
3. Go to **Admin → SHEIN Imports → New Import**
4. Select **"Import from Category URL"**
5. Paste URL and start import

---

## 🌐 Feature 3: Multi-Store Setup

### Create a New Store

**Method 1: Admin Panel**
1. Go to **Admin → Multi-Store → New Store**
2. Fill in:
   - Name: "Aurelio Outlet"
   - Code: "outlet"
   - Currency: EUR
   - Locale: nl
3. Click **Create**

**Method 2: Rake Task**
```bash
bin/rails spree:multistore:create_store["Aurelio Outlet","outlet"]
```

**Method 3: Rails Console**
```ruby
Spree::Store.create!(
  name: 'Aurelio Outlet',
  code: 'outlet',
  mail_from_address: 'noreply@myaurelio.com',
  default_currency: 'EUR',
  default_locale: 'nl'
)
```

### Access Your Stores

**Local Development** (using lvh.me):
- Main store: http://lvh.me:3001
- Outlet store: http://outlet.lvh.me:3001

**Production** (after DNS setup):
- Main store: https://myaurelio.com
- Outlet store: https://outlet.myaurelio.com

---

## 🚀 Deployment to Render

### 1. Commit & Push

```bash
cd "/home/jason/AURELIO LIVING/spree_starter"
chmod +x commit_all_extensions.sh
./commit_all_extensions.sh
```

### 2. Configure Render Environment

Go to Render Dashboard → Your Service → Environment:

```
SPREE_ROOT_DOMAIN=myaurelio.com
APIFY_API_TOKEN=your_apify_token
```

### 3. Add Sidekiq Worker

Create new **Worker** service on Render:
- **Name**: aurelio-sidekiq
- **Runtime**: Ruby
- **Build Command**: `bundle install`
- **Start Command**: `bundle exec sidekiq`
- **Branch**: main
- **Plan**: Starter ($7/month)

### 4. Configure DNS

Add these records to your domain:

```
A     @                  → YOUR_RENDER_IP
CNAME www                → myaurelio.com
CNAME *                  → myaurelio.com  (wildcard!)
```

Or if using Render custom domains:
```
CNAME @                  → your-app.onrender.com
CNAME *                  → your-app.onrender.com
```

### 5. Test Deployment

- Visit: https://myaurelio.com
- Test barcode scanner: https://myaurelio.com/admin/barcode_scanner
- Test SHEIN import: https://myaurelio.com/admin/shein_imports

---

## 📊 Common Tasks

### List All Stores

```bash
bin/rails spree:multistore:list_stores
```

### Update Store URLs (after changing domain)

```bash
bin/rails spree:multistore:update_store_urls
```

### Generate Barcodes for All Products

```ruby
# Rails console
Spree::Product.all.each do |product|
  product.generate_barcode if product.barcode.blank?
  product.save!
end
```

### Check SHEIN Import Status

```ruby
# Rails console
import = Spree::SheinImport.last
puts "Status: #{import.status}"
puts "Products imported: #{import.products_imported_count}"
```

---

## 🆘 Troubleshooting

### Barcode Scanner Not Working

**Problem**: Barcode lookup returns 404

**Solution**:
1. Check product has a barcode: `Spree::Product.first.barcode`
2. Add barcode if missing: `product.update(barcode: '123456')`
3. Test again

### SHEIN Import Stuck

**Problem**: Import stuck in "scraping"

**Solution**:
1. Check Sidekiq is running: `ps aux | grep sidekiq`
2. Check Apify dashboard: https://console.apify.com
3. Check logs: `tail -f log/sidekiq.log`

### Multi-Store Subdomain Not Working

**Problem**: Can't access outlet.myaurelio.com

**Solution**:
1. **Local**: Use `lvh.me` instead of `localhost`
2. **Production**: Check DNS wildcard record is configured
3. Verify store exists: `Spree::Store.find_by(code: 'outlet')`

### Missing Environment Variables

**Problem**: `APIFY_API_TOKEN is required`

**Solution**:
1. Add to `.env` file: `APIFY_API_TOKEN=your_token`
2. Restart server: `bin/rails server -p 3001`
3. Or use Render dashboard environment variables

---

## 📚 Documentation

- **Multi-Store Guide**: `MULTISTORE_SETUP.md`
- **Extensions Documentation**: `EXTENSIONS_POS_SHEIN.md`
- **Spree Docs**: https://spreecommerce.org/docs
- **Apify Docs**: https://docs.apify.com

---

## ✅ Verification Checklist

After deployment, verify:

- [ ] Migrations ran successfully
- [ ] Barcode scanner works
- [ ] SHEIN import test completed (5 products)
- [ ] Multi-store accessible via subdomains
- [ ] Sidekiq running
- [ ] Environment variables set
- [ ] DNS configured (production only)

---

**Questions?** Check the detailed docs or Rails logs!

**Happy selling! 🎉**
