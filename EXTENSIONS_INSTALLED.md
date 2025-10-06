# Spree Extensions - Installatie Instructies

## ✅ Extensions Toegevoegd aan Gemfile

De volgende extensions zijn toegevoegd aan je `Gemfile`:

### 🎯 ESSENTIËLE EXTENSIONS

1. **spree_reviews** - Product Reviews & Ratings
   - Klanten kunnen producten beoordelen en reviewen
   - Star ratings (1-5 sterren)
   - Admin moderatie van reviews
   - **Admin:** Settings → Reviews

2. **spree_related_products** - Gerelateerde Producten
   - "Customers also bought" sectie
   - "Related products" op product pagina's
   - Manually link gerelateerde producten
   - **Admin:** Products → Edit Product → Related Products tab

3. **spree_volume_pricing** - Volume/Bulk Prijzen
   - Kortingen bij grotere aantallen
   - Bijvoorbeeld: "Koop 10+, krijg 15% korting"
   - Per variant configureerbaar
   - **Admin:** Products → Edit Variant → Volume Prices

4. **spree_shipstation** - ShipStation Integratie
   - Automatische order sync naar ShipStation
   - Tracking numbers terug naar Spree
   - Print shipping labels
   - **Admin:** Settings → ShipStation

5. **spree_product_assembly** - Product Bundels
   - Maak product bundles/sets
   - Bijvoorbeeld: "Office Starter Kit" met meerdere producten
   - Voorraad management voor bundels
   - **Admin:** Products → Edit Product → Parts tab

6. **searchkick** - Elasticsearch Zoeken
   - Geavanceerde zoekfunctionaliteit
   - Typo-tolerant zoeken
   - Filters en facets
   - **Note:** Vereist Elasticsearch server

7. **prawn & prawn-table** - PDF Generatie
   - Voor facturen en documenten
   - Custom PDF layouts mogelijk
   - Gebruikt voor print invoices

## 🚀 Installatie Uitvoeren

### Optie 1: Automatisch Script (Aanbevolen)

```bash
# Maak script executable
chmod +x install_extensions.sh

# Voer installatie uit
./install_extensions.sh
```

### Optie 2: Handmatige Stappen

```bash
# 1. Installeer gems
bundle install

# 2. Run generators
bin/rails g spree_reviews:install
bin/rails g spree_related_products:install
bin/rails g spree_volume_pricing:install
bin/rails g spree_shipstation:install
bin/rails g spree_product_assembly:install

# 3. Installeer migrations
bin/rake railties:install:migrations

# 4. Run migrations
bin/rails db:migrate

# 5. Restart server
# Stop server (Ctrl+C)
bin/rails server -p 3001
```

## ⚙️ Post-Installatie Configuratie

### 1. Reviews Configuration

```ruby
# config/initializers/spree.rb
Spree::Reviews::Config.tap do |config|
  config.require_login = true # Alleen ingelogde users kunnen reviewen
  config.track_locale = true # Track review taal
  config.include_unapproved_reviews = false # Goedkeuring vereist
end
```

**Admin Acties:**
- Ga naar Settings → Reviews
- Stel moderatie regels in
- Kies email notificaties

### 2. Related Products

**Admin Acties:**
- Edit een product
- Ga naar "Related Products" tab
- Selecteer gerelateerde producten
- Save

**Display in Storefront:**
- Automatisch zichtbaar op product pagina
- Customize template: `app/views/spree/products/_related.html.erb`

### 3. Volume Pricing

**Admin Acties:**
- Edit een product variant
- Ga naar "Volume Prices" tab
- Add pricing tier:
  - Van: 10 stuks
  - Prijs: €45.00
  - (Normaal €50.00)
- Save

**Voorbeeld:**
```
1-9 stuks: €50.00 per stuk
10-49 stuks: €45.00 per stuk (-10%)
50+ stuks: €40.00 per stuk (-20%)
```

### 4. ShipStation Integration

**Setup:**
1. Ga naar Settings → ShipStation
2. Krijg API credentials van ShipStation.com
3. Voer API Key en Secret in
4. Select stores to sync
5. Test connection

**Features:**
- Auto-export nieuwe orders
- Import tracking numbers
- Sync order status

### 5. Product Assembly (Bundles)

**Maak een Bundle:**
1. Create new product: "Office Starter Kit"
2. Ga naar "Parts" tab
3. Add parts:
   - 1x Desk Chair
   - 1x Desk Lamp
   - 1x Mouse Pad
4. Set bundle price
5. Save

**Voorraad:**
- Automatisch berekend op basis van parts
- Bundle niet beschikbaar als part out of stock

### 6. Searchkick (Elasticsearch)

**Vereist Elasticsearch Server:**

```bash
# macOS
brew install elasticsearch
brew services start elasticsearch

# Ubuntu/WSL
sudo apt-get install elasticsearch
sudo service elasticsearch start

# Check if running
curl http://localhost:9200
```

**Configure in Spree:**

```ruby
# app/models/spree/product_decorator.rb
module Spree
  module ProductDecorator
    def self.prepended(base)
      base.class_eval do
        searchkick word_start: [:name, :description],
                   suggest: [:name],
                   searchable: [:name, :description]
        
        def search_data
          {
            name: name,
            description: description,
            price: price,
            taxon_names: taxons.pluck(:name),
            available: available?,
            created_at: created_at
          }
        end
      end
    end
  end
end

Spree::Product.prepend(Spree::ProductDecorator)
```

**Reindex Products:**
```bash
bin/rails searchkick:reindex CLASS=Spree::Product
```

**Search in Controller:**
```ruby
@products = Spree::Product.search(params[:keywords], 
  fields: [:name, :description],
  match: :word_start,
  limit: 20
)
```

### 7. PDF Invoices (Prawn)

**Create Invoice Generator:**

```ruby
# app/services/spree/invoice_generator.rb
module Spree
  class InvoiceGenerator
    def initialize(order)
      @order = order
    end
    
    def generate
      Prawn::Document.new do |pdf|
        pdf.text "Invoice ##{@order.number}", size: 24, style: :bold
        pdf.move_down 20
        
        # Order details
        pdf.text "Date: #{@order.completed_at.strftime('%d/%m/%Y')}"
        pdf.text "Customer: #{@order.email}"
        pdf.move_down 20
        
        # Line items table
        pdf.table(line_items_data, header: true)
        
        # Total
        pdf.move_down 20
        pdf.text "Total: #{@order.display_total}", size: 16, style: :bold
      end.render
    end
    
    private
    
    def line_items_data
      [['Product', 'Quantity', 'Price', 'Total']] +
      @order.line_items.map do |item|
        [
          item.product.name,
          item.quantity,
          item.display_price,
          item.display_total
        ]
      end
    end
  end
end
```

**Usage:**
```ruby
pdf = Spree::InvoiceGenerator.new(@order).generate
send_data pdf, filename: "invoice-#{@order.number}.pdf", type: 'application/pdf'
```

## 🧪 Testing Extensions

### 1. Test Reviews
```bash
# In Rails console
order = Spree::Order.complete.last
product = order.products.first
review = Spree::Review.create!(
  product: product,
  user: order.user,
  rating: 5,
  title: "Great product!",
  review: "Very satisfied with this purchase."
)
```

### 2. Test Related Products
```bash
# In Rails console
product1 = Spree::Product.first
product2 = Spree::Product.second
product1.related_products << product2
```

### 3. Test Volume Pricing
```bash
# In Rails console
variant = Spree::Variant.first
Spree::VolumePrice.create!(
  variant: variant,
  range: "(10...50)",
  amount: 45.00
)
```

## 🚨 Troubleshooting

### Issue: Extension generator not found
```bash
# Herinstall gem
bundle install
# Clear Spring cache
bin/spring stop
# Retry generator
bin/rails g spree_reviews:install
```

### Issue: Migration conflicts
```bash
# Check pending migrations
bin/rails db:migrate:status
# Run specific migration
bin/rails db:migrate:up VERSION=20240101000000
```

### Issue: Searchkick connection error
```bash
# Check Elasticsearch status
curl http://localhost:9200
# Restart Elasticsearch
brew services restart elasticsearch
```

### Issue: Assets not loading
```bash
# Precompile assets
bin/rails assets:precompile
# Restart server
```

## 📝 Extension URLs & Resources

- **Reviews:** https://github.com/spree-contrib/spree_reviews
- **Related Products:** https://github.com/spree-contrib/spree_related_products
- **Volume Pricing:** https://github.com/spree-contrib/spree_volume_pricing
- **ShipStation:** https://github.com/spree-contrib/spree_shipstation
- **Product Assembly:** https://github.com/spree-contrib/spree-product-assembly
- **Searchkick:** https://github.com/ankane/searchkick
- **Prawn:** https://github.com/prawnpdf/prawn

## 🎯 Next Steps

1. ✅ Extensions toegevoegd aan Gemfile
2. ⏳ Run `./install_extensions.sh`
3. ⏳ Restart Rails server
4. ⏳ Configure extensions in admin
5. ⏳ Test each extension
6. ⏳ Customize templates if needed
7. ⏳ Setup Elasticsearch (for searchkick)
8. ⏳ Configure ShipStation API
9. ⏳ Train team on new features

---

**Status:** Ready to Install  
**Gemfile Updated:** ✅  
**Installation Script Created:** ✅  
**Next:** Run `chmod +x install_extensions.sh && ./install_extensions.sh`

