# Spree Extensions - Installatie Analyse

## Huidige Status (Gemfile Analyse)

### ✅ Al Geïnstalleerd
1. **spree_i18n** - Internationalization support (lijn 125)
2. **spree_stripe** - Stripe payment integration (lijn 126)
3. **spree_google_analytics** - Google Analytics tracking (lijn 127)
4. **spree_klaviyo** - Klaviyo email marketing (lijn 128)
5. **spree_paypal_checkout** - PayPal payment integration (lijn 129)

### 📦 Te Installeren Extensions

#### 1. ✅ Spree I18N
**Status:** AL GEÏNSTALLEERD (regel 125)
```ruby
gem "spree_i18n"
```

#### 2. ❌ Flow Commerce
**Status:** NIET BESCHIKBAAR als officiële Spree extension
**Alternatief:** Flow.io is een third-party service die custom integratie vereist
**Actie:** SKIP - Vereist custom development

#### 3. 🟡 Print Invoice
**Gem:** `spree_print_invoice` of `spree_pdf_invoice`
**Status:** Community extension, mogelijk verouderd
**Alternatief:** Custom PDF generation met Prawn gem
**Aanbeveling:** Custom implementatie met `prawn` en `prawn-table`

#### 4. 🟡 Mailchimp E-commerce
**Gem:** `spree_chimpy` (verouderd) of `spree_mailchimp_ecommerce`
**Status:** Mailchimp API v3.0 vereist nieuwere implementatie
**Aanbeveling:** Gebruik `spree_klaviyo` (AL GEÏNSTALLEERD) - moderne alternatief

#### 5. ✅ Volume Pricing
**Gem:** `spree_volume_pricing`
**Status:** Community extension beschikbaar
**Installatie:** `gem 'spree_volume_pricing', github: 'spree-contrib/spree_volume_pricing'`

#### 6. ❌ Products Q&A
**Status:** Geen officiële extension
**Alternatief:** Custom implementatie of gebruik Disqus/Facebook Comments
**Aanbeveling:** Custom Q&A feature bouwen

#### 7. ✅ Searchkick (Elasticsearch)
**Gem:** `searchkick`
**Status:** Populaire Elasticsearch gem voor Rails
**Installatie:** `gem 'searchkick'`
**Note:** Vereist Elasticsearch server

#### 8. 🟡 EasyPost
**Gem:** `spree_easypost`
**Status:** Community extension beschikbaar
**Installatie:** `gem 'spree_easypost', github: 'spree-contrib/spree_easypost'`

#### 9. ✅ ShipStation
**Gem:** `spree_shipstation`
**Status:** Community extension beschikbaar
**Installatie:** `gem 'spree_shipstation', github: 'spree-contrib/spree_shipstation'`

#### 10. ✅ Reviews
**Gem:** `spree_reviews`
**Status:** Official Spree Contrib extension
**Installatie:** `gem 'spree_reviews', github: 'spree-contrib/spree_reviews'`

#### 11. ✅ AvaTax
**Gem:** `spree_avatax_official`
**Status:** Official Avalara extension
**Installatie:** `gem 'spree_avatax_official'`

#### 12. ✅ TaxJar
**Gem:** `spree_taxjar`
**Status:** Official TaxJar extension
**Installatie:** `gem 'taxjar-ruby'` en `gem 'spree_taxjar'`

#### 13. 🟡 Product Assembly
**Gem:** `spree_product_assembly`
**Status:** Community extension - mogelijk verouderd
**Installatie:** `gem 'spree_product_assembly', github: 'spree-contrib/spree_product_assembly'`

#### 14. ✅ Related Products
**Gem:** `spree_related_products`
**Status:** Community extension beschikbaar
**Installatie:** `gem 'spree_related_products', github: 'spree-contrib/spree_related_products'`

## Installatie Strategie

### Prioriteit 1 - ESSENTIALS (Aangeraden)
✅ Te installeren nu:
1. `spree_reviews` - Product reviews en ratings
2. `spree_related_products` - Related/Similar products
3. `searchkick` - Elasticsearch zoekfunctionaliteit
4. `spree_shipstation` - Shipping integratie
5. `spree_volume_pricing` - Bulk pricing

### Prioriteit 2 - TAX & SHIPPING
🟡 Te installeren op basis van requirement:
1. `spree_avatax_official` - Alleen als je AvaTax gebruikt
2. `spree_taxjar` - Alleen als je TaxJar gebruikt
3. `spree_easypost` - Alleen als je EasyPost shipping gebruikt

### Prioriteit 3 - CUSTOM DEVELOPMENT
❌ Skip of custom development:
1. Flow Commerce - Custom API integratie
2. Print Invoice - Custom PDF generation
3. Products Q&A - Custom feature
4. Product Assembly - Evalueer eerst of nodig

## Compatibility Notes

⚠️ **Rails 8.0 Compatibility**
Veel Spree extensions zijn gebouwd voor Rails 7.x. Mogelijke issues:
- Autoloading changes (Zeitwerk)
- View helpers compatibility
- Asset pipeline changes

**Aanbeveling:** Test elke extension grondig na installatie.

## Installation Commands

### Stap 1: Backup Gemfile
```bash
cp Gemfile Gemfile.backup
```

### Stap 2: Add Essential Extensions
```ruby
# Reviews and ratings
gem 'spree_reviews', github: 'spree-contrib/spree_reviews', branch: 'main'

# Related products
gem 'spree_related_products', github: 'spree-contrib/spree_related_products', branch: 'main'

# Volume/Bulk pricing
gem 'spree_volume_pricing', github: 'spree-contrib/spree_volume_pricing', branch: 'main'

# Elasticsearch search
gem 'searchkick'
gem 'elasticsearch', '~> 7.0'

# ShipStation integration
gem 'spree_shipstation', github: 'spree-contrib/spree_shipstation', branch: 'main'

# PDF Invoice (custom or prawn)
gem 'prawn'
gem 'prawn-table'
```

### Stap 3: Optional Tax Extensions
```ruby
# AvaTax (only if needed)
# gem 'spree_avatax_official'

# TaxJar (only if needed)
# gem 'taxjar-ruby'
# gem 'spree_taxjar'
```

### Stap 4: Bundle Install
```bash
bundle install
```

### Stap 5: Run Generators
```bash
bin/rails g spree_reviews:install
bin/rails g spree_related_products:install
bin/rails g spree_volume_pricing:install
# etc.
```

### Stap 6: Run Migrations
```bash
bin/rails db:migrate
```

## Extension Configuration

### Searchkick Setup
```ruby
# In your Product model (app/models/spree/product_decorator.rb)
Spree::Product.class_eval do
  searchkick word_start: [:name, :description]
  
  def search_data
    {
      name: name,
      description: description,
      price: price,
      taxon_names: taxons.pluck(:name)
    }
  end
end
```

### Reviews Configuration
```ruby
# config/initializers/spree.rb
Spree::Reviews::Config.tap do |config|
  config.require_login = true
  config.track_locale = true
  config.include_unapproved_reviews = false
end
```

## Post-Installation Checklist

- [ ] Run `bundle install`
- [ ] Run all extension generators
- [ ] Run `bin/rails db:migrate`
- [ ] Restart Rails server
- [ ] Test each extension in development
- [ ] Check for deprecation warnings
- [ ] Update initializers if needed
- [ ] Test in staging environment
- [ ] Update documentation

## Monitoring & Maintenance

**Extensions to Monitor:**
1. Check GitHub for updates
2. Watch for security advisories
3. Test before upgrading Spree
4. Keep gems updated regularly

## Alternative Solutions

**Instead of Extensions:**
1. **Klaviyo** (already installed) - Better than Mailchimp
2. **Custom PDF** with Prawn - Better than print_invoice gems
3. **Algolia** - Alternative to Elasticsearch/Searchkick
4. **Custom Q&A** - Built with Stimulus/Hotwire

## Recommended Final Gemfile Additions

```ruby
# === SPREE EXTENSIONS ===

# Reviews and Ratings
gem 'spree_reviews', github: 'spree-contrib/spree_reviews', branch: 'main'

# Related Products
gem 'spree_related_products', github: 'spree-contrib/spree_related_products', branch: 'main'

# Volume Pricing
gem 'spree_volume_pricing', github: 'spree-contrib/spree_volume_pricing', branch: 'main'

# Search (Elasticsearch)
gem 'searchkick'

# Shipping Integration
gem 'spree_shipstation', github: 'spree-contrib/spree_shipstation', branch: 'main'

# PDF Generation
gem 'prawn'
gem 'prawn-table'

# Optional: Tax Calculation Services
# Uncomment only if you use these services
# gem 'spree_avatax_official'
# gem 'taxjar-ruby'
```

---

**Status:** Ready for Implementation
**Next Step:** Review and approve extensions to install

