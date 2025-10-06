# Extra Spree Extensions - SEO, Translations & Affiliates

## 🆕 Nieuw Toegevoegde Extensions

### 1. 🗺️ Spree Sitemap - SEO Essentieel!

**GitHub:** https://github.com/spree-contrib/spree_sitemap

**Functionaliteit:**
- Automatische XML sitemap generatie
- Notificatie naar search engines (Google, Bing, Yahoo)
- Support voor grote product catalogs
- Gzip compressie
- Amazon S3 support

**Configuration:**

```ruby
# config/sitemap.rb (automatisch aangemaakt na install)
SitemapGenerator::Sitemap.default_host = "https://www.aurelioliving.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Products
  add products_path, priority: 0.7, changefreq: 'daily'
  
  Spree::Product.find_each do |product|
    add product_path(product), lastmod: product.updated_at, priority: 0.9
  end
  
  # Taxons (Categories)
  Spree::Taxon.find_each do |taxon|
    add nested_taxons_path(taxon.permalink), priority: 0.7
  end
  
  # Static pages
  add '/about', priority: 0.5, changefreq: 'monthly'
  add '/contact', priority: 0.5
end
```

**Daily Cron Job:**

```ruby
# config/schedule.rb (met Whenever gem)
every 1.day, at: '5:00 am' do
  rake '-s sitemap:refresh'
end
```

**Gebruik:**

```bash
# Generate sitemap manually
rake sitemap:refresh

# Generate and ping search engines
rake sitemap:refresh:no_ping
```

**Robots.txt:**

```
# public/robots.txt
Sitemap: https://www.aurelioliving.com/sitemap.xml.gz
```

**Features:**
- ✅ Automatische product URLs
- ✅ Taxon/Category URLs
- ✅ Static pages
- ✅ Search engine notifications
- ✅ Multi-lingual support
- ✅ S3 hosting compatible

---

### 2. 🤖 Spree Automation Interfaces - AI Translations

**GitHub:** https://github.com/spree-contrib/spree_automation_interfaces

**Functionaliteit:**
- Automated product translations
- AI-powered translation service integration
- Bulk translate products
- Multi-language support

**Use Case:**
Automatisch producten vertalen van NL → EN, FR, DE, etc.

**Setup Translation Provider:**

```ruby
# app/services/deepl_translations_provider.rb
class DeeplTranslationsProvider
  def call(source_attributes:, source_locale:, target_locale:)
    # Gebruik DeepL, Google Translate, of OpenAI
    {
      name: translate(source_attributes['name'], source_locale, target_locale),
      description: translate(source_attributes['description'], source_locale, target_locale),
      meta_title: translate(source_attributes['meta_title'], source_locale, target_locale),
      meta_description: translate(source_attributes['meta_description'], source_locale, target_locale)
    }
  end
  
  private
  
  def translate(text, from, to)
    return text if text.blank?
    
    # DeepL API example
    client = DeepL::Client.new(ENV['DEEPL_API_KEY'])
    result = client.translate(text, from.upcase, to.upcase)
    result.text
  end
end
```

**Configure Provider:**

```ruby
# config/initializers/spree_automation_interfaces.rb
Rails.application.config.after_initialize do
  SpreeAutomationInterfaces::Dependencies.products_automated_translations_provider = 'DeeplTranslationsProvider'
end
```

**Admin Usage:**
1. Go to product edit page
2. Click "Translations" tab
3. Click "Automated Translate" button
4. Select target language(s)
5. Translations are automatically generated!

**Recommended APIs:**
- **DeepL** - Best quality translations
- **Google Cloud Translation** - Good quality, cheaper
- **OpenAI GPT-4** - Context-aware, can maintain brand voice
- **Microsoft Translator** - Good for Azure integrations

**Example with OpenAI:**

```ruby
# Gemfile
gem 'ruby-openai'

# app/services/openai_translations_provider.rb
class OpenaiTranslationsProvider
  def call(source_attributes:, source_locale:, target_locale:)
    prompt = <<~PROMPT
      Translate the following product information from #{source_locale} to #{target_locale}.
      Maintain a premium, professional tone suitable for luxury home & living products.
      
      Product Name: #{source_attributes['name']}
      Description: #{source_attributes['description']}
      
      Return ONLY the translations in JSON format:
      {"name": "...", "description": "..."}
    PROMPT
    
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.3
      }
    )
    
    JSON.parse(response.dig("choices", 0, "message", "content"))
  end
end
```

---

### 3. 💰 Spree Affiliate - Commission Tracking

**GitHub:** https://github.com/spree-contrib/spree_affiliate

**Functionaliteit:**
- Affiliate partner management
- Commission tracking
- Referral link generation
- Performance analytics
- Payout management

**Use Cases:**
- Influencer marketing
- Partner programs
- Referral programs
- Commission-based sales

**Setup:**

```ruby
# Create affiliate partners
affiliate = Spree::Affiliate.create!(
  name: "Interior Design Blog",
  email: "partner@example.com",
  commission_rate: 10.0, # 10% commission
  tracking_code: "INTDESIGN2024"
)

# Generate referral links
# https://aurelioliving.com?ref=INTDESIGN2024
```

**Commission Calculation:**

```ruby
# Automatically tracks when orders use affiliate code
# Calculates commission on order completion
# Admin can view and manage payouts

# Example:
# Order total: €500
# Commission rate: 10%
# Affiliate earns: €50
```

**Admin Features:**
1. **Affiliate Management**
   - Create/edit affiliates
   - Set commission rates
   - Track performance

2. **Analytics Dashboard**
   - Total clicks per affiliate
   - Conversion rates
   - Revenue generated
   - Pending commissions

3. **Payout Management**
   - View pending payouts
   - Mark as paid
   - Export reports

**Referral Link Usage:**

```erb
<!-- In your marketing emails or affiliate portal -->
<a href="https://aurelioliving.com/products/desk-chair?ref=<%= @affiliate.tracking_code %>">
  Shop Premium Office Furniture
</a>
```

**Cookie Tracking:**
```ruby
# Automatically sets cookie when ref parameter is present
# Cookie persists for 30 days (configurable)
# If customer orders within 30 days, affiliate gets commission
```

**Reporting:**

```ruby
# Generate affiliate report
Spree::Affiliate.find_each do |affiliate|
  {
    name: affiliate.name,
    clicks: affiliate.clicks_count,
    orders: affiliate.orders_count,
    revenue: affiliate.total_revenue,
    commission: affiliate.total_commission,
    conversion_rate: affiliate.conversion_rate
  }
end
```

**Email Notifications:**

```ruby
# config/initializers/spree_affiliate.rb
Spree::Affiliate.configure do |config|
  config.notify_on_new_order = true
  config.notify_on_commission_earned = true
  config.cookie_duration = 30.days
end
```

---

## 🚀 Installatie

Alle 3 extensions zijn al toegevoegd aan je `Gemfile`!

### Run Installatie:

```bash
cd "/home/jason/AURELIO LIVING/spree_starter"

# Run het installatie script
./install_extensions.sh
```

Het script installeert nu **11 extensions** in totaal:

### Core Extensions (8):
1. ✅ spree_reviews
2. ✅ spree_related_products
3. ✅ spree_volume_pricing
4. ✅ spree_shipstation
5. ✅ spree_product_assembly
6. ✅ searchkick
7. ✅ prawn (PDF)
8. ✅ prawn-table

### Extra Extensions (3):
9. ✅ **spree_sitemap** - SEO & Search Engines
10. ✅ **spree_automation_interfaces** - AI Translations
11. ✅ **spree_affiliate** - Affiliate Marketing

---

## 📊 Post-Installation Setup

### 1. Sitemap Setup

```bash
# Generate initial sitemap
rake sitemap:refresh

# Add to robots.txt
echo "Sitemap: https://www.aurelioliving.com/sitemap.xml.gz" >> public/robots.txt

# Setup daily cron
# Add to config/schedule.rb (Whenever gem):
every 1.day, at: '5:00 am' do
  rake '-s sitemap:refresh'
end
```

### 2. Translation Provider Setup

```bash
# Add translation service gem
# For DeepL:
bundle add deepl-rb

# For OpenAI:
bundle add ruby-openai

# Add API key to .env:
echo "DEEPL_API_KEY=your_key_here" >> .env
# or
echo "OPENAI_API_KEY=your_key_here" >> .env
```

Create provider file:
```bash
touch app/services/deepl_translations_provider.rb
```

### 3. Affiliate Program Setup

**Admin Steps:**
1. Go to Settings → Affiliates
2. Create first affiliate partner
3. Set commission rate (e.g., 10%)
4. Generate tracking code
5. Share referral link with partner

**Test Referral:**
```
https://localhost:3001?ref=TESTCODE123
```

---

## 🎯 Use Case Scenarios

### Scenario 1: SEO Optimization
**Problem:** Google can't find all your products  
**Solution:** Sitemap automatically updates daily with all products  
**Result:** Better search engine indexing, more organic traffic

### Scenario 2: International Expansion
**Problem:** Need product descriptions in 5 languages  
**Solution:** Automated translations with AI  
**Result:** 1-click translation, saves hours of manual work

### Scenario 3: Influencer Marketing
**Problem:** Want to work with interior design bloggers  
**Solution:** Give them unique referral codes  
**Result:** Track performance, pay commissions automatically

---

## 💡 Pro Tips

### Sitemap:
- Submit sitemap URL to Google Search Console
- Check for errors in sitemap
- Monitor crawl stats

### Translations:
- Always review AI translations before publishing
- Use consistent terminology across languages
- Consider hiring native speakers for final review

### Affiliates:
- Set competitive commission rates (5-15%)
- Provide marketing materials to affiliates
- Regular performance reports
- Timely payouts build trust

---

## ⚠️ Important Notes

### Sitemap:
- Runs automatically via cron
- Don't commit `public/sitemap*` to git
- Add to `.gitignore`

### Translations:
- AI translations are good but not perfect
- Review before publishing
- API costs apply (DeepL, OpenAI, etc.)

### Affiliates:
- Cookie tracking respects GDPR
- Inform users in privacy policy
- Clear terms & conditions for affiliates

---

## 📚 Resources

- **Sitemap:** https://github.com/spree-contrib/spree_sitemap
- **Automation:** https://github.com/spree-contrib/spree_automation_interfaces  
- **Affiliate:** https://github.com/spree-contrib/spree_affiliate
- **Google Search Console:** https://search.google.com/search-console
- **DeepL API:** https://www.deepl.com/pro-api
- **OpenAI API:** https://platform.openai.com/

---

**Total Extensions Installed:** 11  
**SEO:** ✅ Sitemap  
**AI:** ✅ Automated Translations  
**Marketing:** ✅ Affiliate Tracking  
**E-commerce:** ✅ Reviews, Related Products, Volume Pricing  
**Shipping:** ✅ ShipStation  
**Search:** ✅ Searchkick (Elasticsearch)  
**PDF:** ✅ Prawn  

**Status:** Ready to Install! 🚀

