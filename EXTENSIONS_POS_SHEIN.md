# Aurelio Living - Custom Extensions

## 📦 Overview

This document covers two custom extensions built for Aurelio Living:

1. **POS Barcode Scanner** - Point of Sale barcode scanning system
2. **SHEIN Product Import** - Automated product import from SHEIN using Apify

---

## 🔍 Extension 1: POS Barcode Scanner

### Features

- ✅ Add barcode field to Products and Variants
- ✅ Barcode scanner interface in Admin Panel
- ✅ Real-time product lookup by barcode
- ✅ Audio feedback (beep on success/error)
- ✅ Auto-generate unique barcodes
- ✅ EAN-13 validation
- ✅ Recent scans history
- ✅ Product quick view with image, price, and stock

### Installation

#### 1. Run Migrations

```bash
bin/rails db:migrate
```

This adds `barcode` column to `spree_products` and `spree_variants` tables.

#### 2. Access Barcode Scanner

Navigate to: **Admin Panel → Tools → Barcode Scanner**

Or directly: `http://localhost:3001/admin/barcode_scanner`

### Usage

#### Scanning Products

1. Go to **Admin → Barcode Scanner**
2. Use a physical barcode scanner or manually type barcode
3. Press Enter or click **Lookup**
4. Product details will appear with:
   - Product image
   - Name and SKU
   - Price
   - Stock level
   - Edit button

#### Adding Barcodes to Products

**Method 1: Manual Entry**
1. Edit a product in Admin Panel
2. Find **Barcode** section
3. Enter barcode manually

**Method 2: Auto-Generate**
1. Edit a product in Admin Panel
2. Click **Generate Barcode** button
3. A unique barcode will be created (format: `AL{timestamp}{id}`)

#### API Endpoints

##### Lookup Product by Barcode

```bash
POST /admin/barcode_scanner/lookup
Content-Type: application/json

{
  "barcode": "1234567890123"
}
```

**Response:**
```json
{
  "success": true,
  "product": {
    "id": 1,
    "name": "Product Name",
    "sku": "SKU-123",
    "barcode": "1234567890123",
    "price": "$99.99",
    "url": "/admin/products/1/edit",
    "image_url": "/path/to/image.jpg",
    "available": true,
    "stock": 50
  }
}
```

##### Generate Barcode for Product

```bash
POST /admin/barcode_scanner/generate
Content-Type: application/json

{
  "product_id": 1
}
```

**Response:**
```json
{
  "success": true,
  "barcode": "AL17041234565678"
}
```

### Barcode Formats Supported

- **EAN-13** (13 digits with checksum validation)
- **UPC** (12 digits)
- **Code128** (alphanumeric)
- **Custom** (AL prefix format)

### Model Methods

```ruby
# Product/Variant methods
product.generate_barcode  # Auto-generate unique barcode
product.validate_barcode_format  # Validate EAN-13/UPC format

# Scopes
Spree::Product.with_barcode  # Products that have barcodes
Spree::Product.find_by_barcode('123456')  # Lookup by barcode
```

---

## 🛍️ Extension 2: SHEIN Product Import

### Features

- ✅ Import products from SHEIN via Apify scraper
- ✅ Search by keyword or category URL
- ✅ Automated background processing
- ✅ Real-time import status tracking
- ✅ Auto-publish imported products (optional)
- ✅ Batch import up to 1000 products
- ✅ Product variants (size, color)
- ✅ Image import
- ✅ SHEIN metadata preservation

### Prerequisites

1. **Apify Account**
   - Sign up: https://apify.com
   - Get API token: https://apify.com/account/integrations

2. **Environment Variable**

```bash
# Add to .env
APIFY_API_TOKEN=your_apify_api_token_here
```

### Installation

#### 1. Run Migrations

```bash
bin/rails db:migrate
```

This creates `spree_shein_imports` table.

#### 2. Configure Sidekiq (Background Jobs)

Ensure Sidekiq is running:

```bash
bundle exec sidekiq
```

#### 3. Access SHEIN Import

Navigate to: **Admin Panel → Tools → SHEIN Imports**

Or directly: `http://localhost:3001/admin/shein_imports`

### Usage

#### Import Products by Search Term

1. Go to **Admin → SHEIN Imports → New Import**
2. Select **"Search by Term"**
3. Enter search keywords (e.g., "women dresses", "winter coats")
4. Set **Max Items** (1-1000)
5. Optionally check **Auto-publish Products**
6. Click **Start Import**

#### Import Products from Category URL

1. Go to **Admin → SHEIN Imports → New Import**
2. Select **"Import from Category URL"**
3. Paste SHEIN category URL (e.g., `https://www.shein.com/women-dresses-c-1727.html`)
4. Set **Max Items**
5. Click **Start Import**

### Import Process

The import happens in 3 stages:

1. **Scraping** (30 seconds - 5 minutes)
   - Apify scraper fetches product data from SHEIN
   - Status: `scraping`

2. **Scraped** (manual or auto)
   - Products are scraped and ready to import
   - Status: `scraped`
   - Click **Process Import** to continue

3. **Processing** (1-10 minutes depending on product count)
   - Products are created in Spree
   - Images are downloaded
   - Variants are created
   - Status: `processing` → `completed`

### Imported Product Data

Each imported product includes:

- ✅ **Name** (from SHEIN title)
- ✅ **Description** (from SHEIN details)
- ✅ **Price** (converted from SHEIN price)
- ✅ **SKU** (format: `SHEIN-{product_code}`)
- ✅ **Images** (up to 5 images)
- ✅ **Variants** (sizes, colors if available)
- ✅ **Metadata**:
  - `shein_product_code`
  - `shein_url`
  - `shein_category`
  - `shein_brand`
  - `imported_at`

### Background Jobs

- **SheinImportJob**: Starts Apify scraper
- **SheinStatusCheckJob**: Monitors scraper progress
- **SheinProcessJob**: Imports products into Spree

### API Integration

The extension uses **Apify API** to scrape SHEIN:

```ruby
# Start scrape
service = Spree::SheinImportService.new(api_token: 'your_token')
result = service.start_scrape(
  search_term: 'women dresses',
  max_items: 100
)

# Check status
status = service.check_run_status(result[:run_id])

# Get products
products = service.get_scraped_products(status[:dataset_id])

# Import into Spree
import_result = service.import_products(products[:products])
```

### Troubleshooting

#### Import Stuck in "Scraping"

- **Cause**: Apify scraper is still running or failed
- **Solution**: Check Apify dashboard or wait 5-10 minutes

#### Products Not Importing

- **Cause**: Invalid SHEIN data format
- **Solution**: Check import errors in Admin Panel

#### Missing Images

- **Cause**: Image URLs are invalid or blocked
- **Solution**: Images are skipped, products still import

#### Rate Limiting

- **Cause**: Too many requests to Apify
- **Solution**: Wait a few minutes between imports

### Pricing

**Apify Pricing**: https://apify.com/pricing

- **Free Tier**: $5 credit/month (~50-100 products)
- **Starter**: $49/month (~1000 products)
- **Scale**: $149/month (~5000 products)

### Model Structure

```ruby
# SheinImport model
class Spree::SheinImport < Spree.base_class
  belongs_to :user
  belongs_to :store, optional: true
  
  # Status: pending, scraping, scraped, processing, completed, failed
  validates :status, presence: true
  
  serialize :scraped_data, JSON
  serialize :import_results, JSON
  serialize :errors, JSON
end
```

### Customization

#### Change Apify Actor

Edit `app/services/spree/shein_import_service.rb`:

```ruby
SHEIN_ACTOR_ID = 'your_custom_actor_id'
```

#### Modify Product Mapping

Edit `create_or_update_product` method in `app/services/spree/shein_import_service.rb`:

```ruby
def create_or_update_product(shein_data, options = {})
  # Customize product attributes here
  product.assign_attributes(
    name: shein_data['name'],
    price: parse_price(shein_data['price']) * 1.5,  # Add markup
    # ...
  )
end
```

---

## 🚀 Deployment

### Environment Variables

Add to `.env` or Render environment:

```bash
# SHEIN Import
APIFY_API_TOKEN=your_apify_api_token

# Multi-Store (if using)
SPREE_ROOT_DOMAIN=myaurelio.com
```

### Database Migrations

```bash
# Local
bin/rails db:migrate

# Render (automatic on deploy)
# Or manually:
bin/rake db:migrate
```

### Background Jobs

Ensure Sidekiq is running in production:

```yaml
# render.yaml (if using Render)
services:
  - type: worker
    name: aurelio-sidekiq
    env: ruby
    buildCommand: bundle install
    startCommand: bundle exec sidekiq
```

---

## 📊 Admin Menu Integration

Both extensions appear in **Admin Panel**:

- **Barcode Scanner**: `/admin/barcode_scanner`
- **SHEIN Imports**: `/admin/shein_imports`

To add to sidebar navigation, edit `config/initializers/spree.rb`:

```ruby
Rails.application.config.after_initialize do
  Spree::Backend::Config.configure do |config|
    config.menu_items << config.class::MenuItem.new(
      label: 'Barcode Scanner',
      icon: 'fa-barcode',
      url: '/admin/barcode_scanner',
      match_path: '/barcode_scanner'
    )
    
    config.menu_items << config.class::MenuItem.new(
      label: 'SHEIN Imports',
      icon: 'fa-download',
      url: '/admin/shein_imports',
      match_path: '/shein_imports'
    )
  end
end
```

---

## 🧪 Testing

### Barcode Scanner

```bash
# Test barcode lookup
curl -X POST http://localhost:3001/admin/barcode_scanner/lookup \
  -H "Content-Type: application/json" \
  -d '{"barcode":"1234567890123"}'

# Test barcode generation
curl -X POST http://localhost:3001/admin/barcode_scanner/generate \
  -H "Content-Type: application/json" \
  -d '{"product_id":1}'
```

### SHEIN Import

```ruby
# Rails console
service = Spree::SheinImportService.new(api_token: ENV['APIFY_API_TOKEN'])

# Test scrape
result = service.start_scrape(search_term: 'test product', max_items: 5)

# Check status
status = service.check_run_status(result[:run_id])

# Test import
products = [{ 'name' => 'Test Product', 'price' => '19.99', 'productCode' => 'TEST123' }]
import_result = service.import_products(products)
```

---

## 📝 Maintenance

### Clean Up Old Imports

```ruby
# Delete imports older than 30 days
Spree::SheinImport.where('created_at < ?', 30.days.ago).destroy_all
```

### Re-process Failed Imports

```ruby
# Find failed imports
failed = Spree::SheinImport.failed

# Retry
failed.each do |import|
  import.update(status: 'scraped')
  SheinProcessJob.perform_later(import.id)
end
```

---

## 🆘 Support

For issues or questions:

1. Check import status in Admin Panel
2. Review Sidekiq logs: `http://localhost:3001/sidekiq`
3. Check Rails logs: `tail -f log/development.log`
4. Review Apify dashboard: https://console.apify.com

---

**Created for Aurelio Living** | Version 1.0 | January 2025
