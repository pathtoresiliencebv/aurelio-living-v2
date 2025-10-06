# Aurelio Living Custom Theme - Implementatie Guide

## Optie 1: Custom Spree Theme (Aanbevolen)

### Stap 1: Genereer Custom Theme

```bash
bin/rails g spree:storefront:theme AurelioTheme
```

Dit creëert:
- `app/models/spree/themes/aurelio_theme.rb` - Theme definitie
- `app/views/spree/themes/aurelio/` - Custom templates
- Theme settings in admin dashboard

### Stap 2: Theme Preferences Definiëren

```ruby
# app/models/spree/themes/aurelio_theme.rb
module Spree
  module Themes
    class AurelioTheme < Spree::Theme
      def self.metadata
        {
          authors: ['Aurelio Living'],
          license: 'Proprietary'
        }
      end

      # === BRAND COLORS ===
      # Premium warm tones voor home & living
      preference :primary_color, :string, default: '#2C3E50'      # Deep Navy
      preference :accent_color, :string, default: '#E8D5B7'        # Warm Beige
      preference :success_color, :string, default: '#27AE60'       # Fresh Green
      preference :danger_color, :string, default: '#E74C3C'
      preference :neutral_color, :string, default: '#95A5A6'
      
      preference :background_color, :string, default: '#FAFAFA'
      preference :text_color, :string, default: '#2C3E50'

      # === TYPOGRAPHY ===
      preference :font_family, :string, default: 'Montserrat'     # Modern & clean
      preference :header_font_family, :string, default: 'Playfair Display' # Elegant
      preference :font_size_scale, :integer, default: 100
      preference :header_font_size_scale, :integer, default: 110
      preference :headings_uppercase, :boolean, default: false

      # === BUTTONS ===
      preference :button_background_color, :string, default: '#2C3E50'
      preference :button_text_color, :string, default: '#FFFFFF'
      preference :button_border_radius, :integer, default: 4       # Subtle rounded
      preference :button_border_thickness, :integer, default: 0
      preference :button_hover_background_color, :string, default: '#1A252F'

      # === PRODUCT IMAGES ===
      preference :product_listing_image_height, :integer, default: 400
      preference :product_listing_image_width, :integer, default: 400
      preference :product_listing_image_height_mobile, :integer, default: 250
      preference :product_listing_image_width_mobile, :integer, default: 250

      # === BORDERS ===
      preference :border_color, :string, default: '#E8D5B7'
      preference :border_width, :integer, default: 1
      preference :border_radius, :integer, default: 8

      # === INPUTS ===
      preference :input_background_color, :string, default: '#FFFFFF'
      preference :input_border_color, :string, default: '#DDD'
      preference :input_border_radius, :integer, default: 6
      preference :input_text_color, :string, default: '#2C3E50'
    end
  end
end
```

### Stap 3: Registreer Theme

```ruby
# config/initializers/spree.rb
Rails.application.config.after_initialize do
  Rails.application.config.spree.themes << Spree::Themes::AurelioTheme
end
```

### Stap 4: Custom CSS

```bash
touch app/assets/stylesheets/aurelio_custom.css
```

```css
/* app/assets/stylesheets/aurelio_custom.css */

/* === CUSTOM GOOGLE FONTS === */
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap');

/* === AURELIO LIVING BRANDING === */
.aurelio-hero {
  background: linear-gradient(135deg, #2C3E50 0%, #34495E 100%);
  color: white;
  padding: 80px 20px;
  text-align: center;
}

.aurelio-hero h1 {
  font-family: 'Playfair Display', serif;
  font-size: 3.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.aurelio-hero p {
  font-family: 'Montserrat', sans-serif;
  font-size: 1.2rem;
  opacity: 0.9;
}

/* === PRODUCT CARDS === */
.product-card {
  border: 1px solid #E8D5B7;
  border-radius: 8px;
  transition: all 0.3s ease;
  background: white;
  overflow: hidden;
}

.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(44, 62, 80, 0.12);
}

.product-card img {
  width: 100%;
  height: 400px;
  object-fit: cover;
}

.product-card .product-info {
  padding: 20px;
}

.product-card h3 {
  font-family: 'Montserrat', sans-serif;
  font-size: 1.1rem;
  font-weight: 600;
  color: #2C3E50;
  margin-bottom: 0.5rem;
}

.product-card .price {
  font-size: 1.3rem;
  color: #27AE60;
  font-weight: 600;
}

/* === BUTTONS === */
.btn-aurelio-primary {
  background: #2C3E50;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 12px 32px;
  font-family: 'Montserrat', sans-serif;
  font-weight: 600;
  transition: all 0.3s ease;
  cursor: pointer;
}

.btn-aurelio-primary:hover {
  background: #1A252F;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(44, 62, 80, 0.3);
}

/* === NAVIGATION === */
.aurelio-navbar {
  background: white;
  border-bottom: 1px solid #E8D5B7;
  padding: 16px 0;
}

.aurelio-navbar .logo {
  font-family: 'Playfair Display', serif;
  font-size: 1.8rem;
  font-weight: 700;
  color: #2C3E50;
}

/* === CATEGORIES === */
.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 24px;
  padding: 40px 0;
}

.category-card {
  position: relative;
  height: 300px;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
}

.category-card img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.category-card:hover img {
  transform: scale(1.05);
}

.category-card .overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(44, 62, 80, 0.9), transparent);
  padding: 30px 20px;
  color: white;
}

.category-card h3 {
  font-family: 'Playfair Display', serif;
  font-size: 1.5rem;
  margin: 0;
}
```

### Stap 5: Import Custom CSS

```css
/* app/assets/stylesheets/application.tailwind.css */
@import "aurelio_custom.css";
```

### Stap 6: Custom Views (Optional)

```bash
# Kopieer alle Spree views naar je app voor customization
bin/rails g spree:frontend:copy_storefront
```

Dit creëert:
- `app/views/spree/products/` - Product templates
- `app/views/spree/shared/` - Gedeelde partials
- `app/views/spree/home/` - Homepage template

### Stap 7: Activeer in Admin Dashboard

1. Start server: `bin/rails server -p 3001`
2. Ga naar: `http://localhost:3001/admin/themes`
3. Selecteer **Aurelio Theme**
4. Pas kleuren aan via visuele editor
5. Save & Publish

---

## Optie 2: Headless Commerce met Next.js

### Architectuur

```
┌─────────────────┐         ┌──────────────────┐
│   Next.js App   │◄───────►│  Spree Backend   │
│   (Frontend)    │  API    │  (Headless)      │
│   Port 3000     │         │  Port 3001       │
└─────────────────┘         └──────────────────┘
```

### Voordelen van Next.js + Spree:

✅ **Modern React UI** - Volledige controle over frontend  
✅ **Server Components** - Snelle performance  
✅ **App Router** - Modern routing  
✅ **Image Optimization** - Automatisch geoptimaliseerde afbeeldingen  
✅ **SEO Excellence** - Ingebouwde metadata & OpenGraph  
✅ **Incremental Static Regeneration** - Best of both worlds  

### Nadelen:

❌ **Meer complexiteit** - 2 aparte projecten  
❌ **Extra hosting** - Vercel/Netlify voor Next.js  
❌ **Meer development tijd** - Alles zelf bouwen  
❌ **API management** - Extra overhead  

### Quick Start - Next.js Storefront

```bash
# In nieuwe directory (naast spree_starter)
npx create-next-app@latest aurelio-storefront --typescript --tailwind --app
cd aurelio-storefront

# Installeer Spree SDK
npm install @spree/storefront-api-v2-sdk
```

### Basis Setup

```typescript
// lib/spree.ts
import { makeClient } from '@spree/storefront-api-v2-sdk'

export const client = makeClient({
  host: process.env.NEXT_PUBLIC_SPREE_API_URL || 'http://localhost:3001',
  createFetcher: (fetcherOptions) => {
    return async (url, options = {}) => {
      const response = await fetch(url, {
        ...options,
        headers: {
          ...options.headers,
          'Content-Type': 'application/json',
        },
      })
      return response
    }
  },
})
```

```typescript
// app/products/page.tsx
import { client } from '@/lib/spree'

export default async function ProductsPage() {
  const response = await client.products.list()
  const products = response.success() ? response.data : []

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 p-8">
      {products.map((product) => (
        <div key={product.id} className="border rounded-lg overflow-hidden">
          <img 
            src={product.attributes.images[0]?.url} 
            alt={product.attributes.name}
            className="w-full h-64 object-cover"
          />
          <div className="p-4">
            <h3 className="font-bold">{product.attributes.name}</h3>
            <p className="text-green-600 text-xl">
              {product.attributes.display_price}
            </p>
          </div>
        </div>
      ))}
    </div>
  )
}
```

---

## 🎯 Aanbeveling

### Start met Optie 1 (Custom Spree Theme) als:
- Je snel wilt lanceren
- Je een bewezen platform wilt
- Je SEO belangrijk vindt
- Je team Ruby/Rails kent
- Je de Spree ecosystem wilt gebruiken

### Kies voor Optie 2 (Next.js) als:
- Je ultieme frontend controle wilt
- Je team React/TypeScript prefereert
- Je een native mobile app wilt toevoegen
- Je moderne frontend tooling wilt
- Je bereid bent meer tijd te investeren

### Hybrid Approach (Best of Both):
1. **Start met Custom Spree Theme** (week 1-2)
2. **Launch MVP snel** 
3. **Bouw Next.js parallel** (maand 2-3)
4. **Migreer geleidelijk** naar headless
5. **Behoud Spree admin** voor content management

---

## 📊 Vergelijkingstabel

| Feature | Custom Spree Theme | Next.js Headless |
|---------|-------------------|------------------|
| **Time to Market** | 1-2 weken | 1-2 maanden |
| **Maintenance** | ⭐⭐⭐⭐⭐ Makkelijk | ⭐⭐⭐ Moeilijker |
| **Performance** | ⭐⭐⭐⭐ Snel | ⭐⭐⭐⭐⭐ Zeer snel |
| **SEO** | ⭐⭐⭐⭐⭐ Excellent | ⭐⭐⭐⭐⭐ Excellent |
| **Customization** | ⭐⭐⭐⭐ Goed | ⭐⭐⭐⭐⭐ Onbeperkt |
| **Development Cost** | € | €€€ |
| **Hosting Cost** | € | €€ |

---

## 🚀 Volgende Stappen

**Direct beginnen met Custom Theme:**
```bash
bin/rails g spree:storefront:theme AurelioTheme
```

**Exploreren van Next.js:**
```bash
cd ..
npx create-next-app@latest aurelio-storefront
```

Welke optie spreekt je het meest aan?
