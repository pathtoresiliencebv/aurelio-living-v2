# Plan van Aanpak (PVA) - Aurelio Living Custom Theme

## 🎯 Project Doelstelling

Het dupliceren en aanpassen van het standaard Spree Commerce thema naar een moderne, premium e-commerce ervaring voor Aurelio Living die volledig aanpasbaar is via de Spree Theme Editor.

## 📊 Project Context

**Project:** Aurelio Living E-commerce Platform  
**Framework:** Spree Commerce 5.1.7 op Rails 8.0.3  
**Huidige Situatie:** Standaard Spree thema actief  
**Gewenste Situatie:** Custom Aurelio Living thema met moderne UI/UX

## 🎨 Design Requirements (Gebaseerd op Mockups)

### Kleurenschema
- **Primary Color:** `#000000` (Zwart - voor tekst en CTA's)
- **Accent Color:** `#F0EFE9` (Beige/Cream - voor achtergronden)
- **Background:** `#FFFFFF` (Wit)
- **Border Color:** `#E9E7DC` (Licht beige)
- **Success Color:** `#00C773` (Groen - "FREE" badges)
- **Danger/Sale Color:** `#C73528` (Rood - sale badges)

### Typografie
- **Font Family:** Inter (body & headers)
- **Font Scale:** 100%
- **Headings:** Niet uppercase, modern en clean

### UI Elementen

#### Buttons
- Border radius: Volledig afgerond (100px) voor primary buttons
- Rechthoekig voor secondary buttons
- Border width: 1px
- Hover effecten met kleur transitie

#### Product Cards
- Clean, minimalist design
- Hover effecten op afbeeldingen
- Badge ondersteuning (Sale, New)
- Prijs display met oude prijs doorgestreept
- "TOEVOEGEN" button per product

#### Navigation
- Dark mode toggle (zon/maan icoon)
- Taal selector (NL)
- Telefoon nummer prominent
- Wishlist icoon
- Winkelwagen met item count badge
- Search bar met zwarte "SEARCH" button

#### Hero Section
- Full-width hero met product showcase
- "IN STOCK NOW" badge (groen)
- Grote, duidelijke product titel
- Beschrijving tekst
- Prominente prijs display met savings badge
- Dubbele CTA buttons: "ADD TO CART" en "VIEW DETAILS"

#### Features Section (USP's)
- 4-kolom layout met iconen
- "Gratis Verzending & Retour" (Snelle levering wereldwijd)
- "Geld Terug Garantie" (30 dagen retourbeleid)
- "Online Ondersteuning 24/7" (Deskundige hulp op elk moment)
- "Regelmatige Aanbiedingen" (Exclusieve ledenkorting)

### Sections die Benodigd Zijn

1. **Homepage Sections**
   - Hero Banner met Product Showcase
   - Features/USP Icons Section
   - "Aanbevolen voor U" (Recommended Products)
   - Featured Products Grid
   - Content Blocks (How To, Services)

2. **Product List Page**
   - Product Grid met filters
   - Category badges
   - Sort opties

3. **Product Detail Page**
   - Image gallery
   - Product info sidebar
   - "TOEVOEGEN AAN WINKELWAGEN" button
   - Product eigenschappen (Materiaal, Levertijd, Garantie)
   - Related products

4. **Cart Sidebar**
   - Slide-in cart overlay
   - Item thumbnails met quantity controls
   - Subtotal, Tax (BTW), Shipping
   - "PROCEED TO CHECKOUT" button
   - "CONTINUE SHOPPING" link

5. **Footer**
   - "ATELIER COLLECTION" branding block
   - Shop links (Meubels, Decoratie, Verlichting, Textiel)
   - Informatie links (Over Ons, Contact, Verzending, Retourneren)
   - Newsletter signup
   - Copyright

## 🏗️ Technische Architectuur

### Thema Structuur
```
app/
├── models/
│   └── spree/
│       └── themes/
│           └── aurelio_living.rb          # Theme class met preferences
├── views/
│   └── themes/
│       └── aurelio_living/
│           ├── layouts/
│           │   ├── _header.html.erb
│           │   ├── _footer.html.erb
│           │   └── application.html.erb
│           ├── spree/
│           │   ├── home/
│           │   │   └── index.html.erb
│           │   ├── products/
│           │   │   ├── index.html.erb
│           │   │   └── show.html.erb
│           │   └── shared/
│           │       ├── _hero_section.html.erb
│           │       ├── _features_section.html.erb
│           │       └── _product_card.html.erb
│           └── sections/                  # Page Builder sections
│               ├── hero_banner.html.erb
│               ├── features_grid.html.erb
│               └── product_carousel.html.erb
├── assets/
│   ├── stylesheets/
│   │   └── themes/
│   │       └── aurelio_living/
│   │           ├── _variables.css         # CSS custom properties
│   │           ├── _components.css        # UI components
│   │           ├── _products.css          # Product styling
│   │           └── theme.css              # Main theme file
│   └── javascripts/
│       └── themes/
│           └── aurelio_living/
│               ├── cart.js                # Cart functionality
│               └── theme.js               # Theme JS
└── helpers/
    └── spree/
        └── themes/
            └── aurelio_living_helper.rb   # Theme helpers
```

### Page Builder Integratie
```ruby
# Custom Page Sections
- Spree::PageSections::HeroBanner
- Spree::PageSections::FeaturesGrid
- Spree::PageSections::ProductCarousel
- Spree::PageSections::ContentBlocks
- Spree::PageSections::NewsletterSignup

# Custom Page Blocks
- Spree::PageBlocks::USPIcon
- Spree::PageBlocks::ProductCard
- Spree::PageBlocks::CategoryCard
```

## 📋 Implementation Steps

### Fase 1: Theme Setup (Week 1)
1. ✅ **Generate Theme Structure**
   ```bash
   bin/rails g spree:storefront:theme AurelioLiving
   ```

2. **Define Theme Preferences**
   - Alle kleuren configureerbaar maken
   - Typografie instellingen
   - Button styles
   - Border en shadow instellingen
   - Product image dimensions

3. **Register Theme**
   ```ruby
   # config/initializers/spree.rb
   Rails.application.config.after_initialize do
     Rails.application.config.spree.themes << Spree::Themes::AurelioLiving
   end
   ```

### Fase 2: Base Styling (Week 1-2)
4. **CSS Variables Setup**
   - Implementeer alle design tokens als CSS variables
   - Configureer Tailwind met custom colors

5. **Component Styling**
   - Buttons (primary, secondary, outline)
   - Forms en inputs
   - Cards
   - Badges
   - Navigation elements

### Fase 3: Layout Components (Week 2)
6. **Header Component**
   - Logo
   - Search bar
   - Navigation menu
   - User actions (dark mode, language, wishlist, cart)
   - Mobile responsive menu

7. **Footer Component**
   - Multi-column layout
   - Newsletter form
   - Social links
   - Copyright info

### Fase 4: Page Sections (Week 2-3)
8. **Hero Banner Section**
   - Configurable via Page Builder
   - Image upload
   - Text overlays
   - CTA buttons
   - Badge support

9. **Features Grid Section**
   - Icon picker
   - Configurable columns
   - Text content editable

10. **Product Sections**
    - Product carousel
    - Product grid
    - Featured products
    - Related products

### Fase 5: Product Templates (Week 3)
11. **Product Listing Page**
    - Grid layout
    - Filters sidebar
    - Sort options
    - Pagination

12. **Product Detail Page**
    - Image gallery with zoom
    - Product info sidebar
    - Add to cart functionality
    - Product attributes
    - Related products section

### Fase 6: Cart & Checkout (Week 3-4)
13. **Cart Sidebar**
    - Slide-in overlay
    - Line items with thumbnails
    - Quantity controls
    - Price summary
    - Checkout CTA

14. **Checkout Flow Styling**
    - Address forms
    - Shipping options
    - Payment methods
    - Order review

### Fase 7: Page Builder Integration (Week 4)
15. **Custom Page Sections**
    - Implement PageSection classes
    - Add preference definitions
    - Create section templates
    - Register sections

16. **Custom Page Blocks**
    - Implement PageBlock classes
    - Add block templates
    - Register blocks

### Fase 8: Theme Editor Configuration (Week 4)
17. **Admin Interface Setup**
    - Ensure all theme preferences appear in admin
    - Test color pickers
    - Test typography controls
    - Test dimension controls

18. **Documentation**
    - Create theme usage guide
    - Document all customizable settings
    - Add screenshots

### Fase 9: Testing & Optimization (Week 5)
19. **Functionality Testing**
    - Test all pages
    - Test responsive design
    - Test cart functionality
    - Test checkout flow

20. **Performance Optimization**
    - Optimize images
    - Minimize CSS/JS
    - Test loading times

21. **Browser Testing**
    - Chrome
    - Firefox
    - Safari
    - Edge
    - Mobile browsers

### Fase 10: Documentation & Knowledge Storage (Week 5)
22. **Store Implementation Knowledge**
    - Document theme patterns
    - Document customization approaches
    - Store in Byterover MCP for future reference

23. **User Documentation**
    - Theme editor guide
    - Customization examples
    - Troubleshooting guide

## 🎛️ Theme Preferences Configuration

```ruby
module Spree
  module Themes
    class AurelioLiving < Spree::Theme
      def self.metadata
        {
          name: 'Aurelio Living',
          authors: ['Aurelio Living Team'],
          description: 'Premium e-commerce theme for home & living products',
          version: '1.0.0',
          license: 'Proprietary'
        }
      end

      # COLORS - Main
      preference :primary_color, :string, default: '#000000'
      preference :accent_color, :string, default: '#F0EFE9'
      preference :background_color, :string, default: '#FFFFFF'
      preference :text_color, :string, default: '#000000'
      preference :border_color, :string, default: '#E9E7DC'
      preference :success_color, :string, default: '#00C773'
      preference :danger_color, :string, default: '#C73528'
      preference :neutral_color, :string, default: '#999999'

      # BUTTONS
      preference :button_background_color, :string, default: '#000000'
      preference :button_text_color, :string, default: '#ffffff'
      preference :button_hover_background_color, :string, default: '#333333'
      preference :button_hover_text_color, :string, default: '#ffffff'
      preference :button_border_radius, :integer, default: 100
      preference :button_border_width, :integer, default: 1
      preference :button_border_opacity, :integer, default: 100

      # SECONDARY BUTTONS
      preference :secondary_button_background_color, :string, default: '#FFFFFF'
      preference :secondary_button_text_color, :string, default: '#000000'
      preference :secondary_button_hover_background_color, :string, default: '#000000'
      preference :secondary_button_hover_text_color, :string, default: '#FFFFFF'

      # INPUTS
      preference :input_background_color, :string, default: '#ffffff'
      preference :input_border_color, :string, default: '#E9E7DC'
      preference :input_text_color, :string, default: '#000000'
      preference :input_border_radius, :integer, default: 8
      preference :input_border_width, :integer, default: 1

      # TYPOGRAPHY
      preference :font_family, :string, default: 'Inter'
      preference :header_font_family, :string, default: 'Inter'
      preference :font_size_scale, :integer, default: 100
      preference :header_font_size_scale, :integer, default: 100
      preference :headings_uppercase, :boolean, default: false

      # BORDERS
      preference :border_width, :integer, default: 1
      preference :border_radius, :integer, default: 6

      # PRODUCT IMAGES
      preference :product_listing_image_height, :integer, default: 300
      preference :product_listing_image_width, :integer, default: 300
      preference :product_listing_image_height_mobile, :integer, default: 190
      preference :product_listing_image_width_mobile, :integer, default: 190

      # HERO SECTION
      preference :hero_background_color, :string, default: '#F0EFE9'
      preference :hero_text_color, :string, default: '#000000'
      preference :hero_min_height, :integer, default: 600

      # BADGES
      preference :badge_border_radius, :integer, default: 4
      preference :sale_badge_background, :string, default: '#C73528'
      preference :new_badge_background, :string, default: '#00C773'
    end
  end
end
```

## 📦 Deliverables

1. **Custom Theme Files**
   - Theme model class
   - All view templates
   - Stylesheet files
   - JavaScript files
   - Helper methods

2. **Page Builder Components**
   - Page sections (min. 5)
   - Page blocks (min. 3)
   - Section configurations

3. **Documentation**
   - Theme installation guide
   - Customization guide
   - Page builder usage guide
   - Troubleshooting guide

4. **Testing**
   - Functionality test report
   - Browser compatibility report
   - Performance metrics

## ⏱️ Timeline

**Totale Duur:** 5 weken

- **Week 1:** Theme setup & base styling
- **Week 2:** Layout components & page sections  
- **Week 3:** Product templates & cart/checkout
- **Week 4:** Page builder integration & admin configuration
- **Week 5:** Testing, optimization & documentation

## 🎯 Success Criteria

✅ Alle thema elementen zijn aanpasbaar via de Spree Theme Editor  
✅ Design matched de mockup images 100%  
✅ Responsive op alle devices (mobile, tablet, desktop)  
✅ Page Builder secties werken correct  
✅ Performance: pagina laadtijd < 3 seconden  
✅ Browser compatibiliteit: Chrome, Firefox, Safari, Edge  
✅ Alle Spree functionaliteit blijft intact  
✅ Code is gedocumenteerd en maintainable  
✅ Theme is activeerbaar in admin zonder code changes  

## 🔧 Technical Requirements

- Ruby 3.3.0
- Rails 8.0.3
- Spree Commerce 5.1.7
- Tailwind CSS
- PostgreSQL database
- Inter font family (Google Fonts)

## 📚 Resources

- Spree Commerce Theming Documentation
- Context7 MCP documentation queries
- Design mockup images
- Existing Spree default theme

## 🚀 Next Steps

1. Approve this PVA
2. Generate theme structure
3. Begin implementation according to timeline
4. Regular progress reviews
5. Testing & deployment

---

**Opgesteld:** {{current_date}}  
**Project:** Aurelio Living Custom Theme  
**Version:** 1.0  
**Status:** Ready for Approval

