# 🎨 Aurelio Living - Quick Theme Start

## ⚡ Snelle Start (5 minuten)

### Optie A: Custom Spree Theme (Aanbevolen voor Quick Launch)

```bash
# 1. Genereer theme
bin/rails g spree:storefront:theme AurelioTheme

# 2. Restart server
bin/rails restart

# 3. Activeer in admin
# Ga naar: http://localhost:3001/admin/themes
# Selecteer "Aurelio Theme" en klik "Activate"
```

**Klaar!** Je hebt nu een volledig aanpasbaar theme via de admin dashboard.

---

## 🎯 Theme Aanpassen via Admin Dashboard

1. **Open Theme Editor**: `http://localhost:3001/admin/themes/edit`

2. **Pas Brand Kleuren Aan**:
   - Primary Color → `#2C3E50` (Deep Navy)
   - Accent Color → `#E8D5B7` (Warm Beige)
   - Success Color → `#27AE60` (Fresh Green)

3. **Wijzig Typografie**:
   - Body Font → "Montserrat" (modern & clean)
   - Header Font → "Playfair Display" (elegant)
   - Font Size → 100% (of groter voor leesbaarheid)

4. **Configureer Buttons**:
   - Border Radius → 4px (subtiel afgerond)
   - Background → `#2C3E50`
   - Hover → `#1A252F`

5. **Product Afbeeldingen**:
   - Desktop: 400x400px
   - Mobile: 250x250px

6. **Save & Publish** ✅

---

## 🎨 Advanced: Custom CSS Toevoegen

```bash
# Creëer custom CSS file
touch app/assets/stylesheets/aurelio_branding.css
```

```css
/* app/assets/stylesheets/aurelio_branding.css */

/* Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&family=Playfair+Display:wght@400;700&display=swap');

/* Hero Section */
.aurelio-hero {
  background: linear-gradient(135deg, #2C3E50 0%, #34495E 100%);
  color: white;
  padding: 100px 20px;
  text-align: center;
}

.aurelio-hero h1 {
  font-family: 'Playfair Display', serif;
  font-size: 4rem;
  font-weight: 700;
  margin-bottom: 1rem;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
}

/* Product Grid */
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
  padding: 2rem 0;
}

.product-card {
  border: 1px solid #E8D5B7;
  border-radius: 12px;
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  background: white;
}

.product-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 32px rgba(44, 62, 80, 0.15);
}

/* Premium Button */
.btn-aurelio {
  background: #2C3E50;
  color: white;
  padding: 14px 40px;
  border-radius: 4px;
  border: none;
  font-family: 'Montserrat', sans-serif;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.btn-aurelio:hover {
  background: #1A252F;
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(44, 62, 80, 0.3);
}

/* Category Cards */
.category-card {
  position: relative;
  height: 350px;
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
}

.category-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(44, 62, 80, 0.95), transparent);
  padding: 40px 24px;
  color: white;
}

.category-overlay h3 {
  font-family: 'Playfair Display', serif;
  font-size: 2rem;
  margin: 0;
  font-weight: 700;
}
```

```css
/* app/assets/stylesheets/application.tailwind.css */
/* Voeg toe aan het begin: */
@import "aurelio_branding.css";
```

---

## 🖼️ Custom Homepage Template

```bash
# Kopieer Spree views
bin/rails g spree:frontend:copy_storefront

# Edit homepage
# File: app/views/spree/home/index.html.erb
```

```erb
<!-- app/views/spree/home/index.html.erb -->

<!-- Hero Section -->
<div class="aurelio-hero">
  <h1>Aurelio Living</h1>
  <p style="font-size: 1.3rem; margin-top: 1rem;">
    Premium Home & Living voor het moderne leven
  </p>
  <a href="/products" class="btn-aurelio" style="margin-top: 2rem; display: inline-block;">
    Shop Collectie
  </a>
</div>

<!-- Featured Categories -->
<div style="max-width: 1400px; margin: 0 auto; padding: 80px 20px;">
  <h2 style="font-family: 'Playfair Display', serif; font-size: 3rem; text-align: center; margin-bottom: 3rem;">
    Shop by Category
  </h2>
  
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 2rem;">
    <!-- Category: Living Room -->
    <div class="category-card">
      <%= image_tag 'categories/living-room.jpg', 
                    style: 'width: 100%; height: 100%; object-fit: cover;' %>
      <div class="category-overlay">
        <h3>Living Room</h3>
        <p>Comfort meets style</p>
      </div>
    </div>
    
    <!-- Category: Bedroom -->
    <div class="category-card">
      <%= image_tag 'categories/bedroom.jpg', 
                    style: 'width: 100%; height: 100%; object-fit: cover;' %>
      <div class="category-overlay">
        <h3>Bedroom</h3>
        <p>Your personal sanctuary</p>
      </div>
    </div>
    
    <!-- Category: Kitchen -->
    <div class="category-card">
      <%= image_tag 'categories/kitchen.jpg', 
                    style: 'width: 100%; height: 100%; object-fit: cover;' %>
      <div class="category-overlay">
        <h3>Kitchen</h3>
        <p>Where memories are made</p>
      </div>
    </div>
  </div>
</div>

<!-- Featured Products -->
<div style="background: #FAFAFA; padding: 80px 20px;">
  <div style="max-width: 1400px; margin: 0 auto;">
    <h2 style="font-family: 'Playfair Display', serif; font-size: 3rem; text-align: center; margin-bottom: 3rem;">
      Bestsellers
    </h2>
    
    <%= render 'spree/shared/products', 
               products: @products.featured.limit(6),
               taxon: @taxon %>
  </div>
</div>

<!-- Newsletter -->
<div style="background: #2C3E50; color: white; padding: 80px 20px; text-align: center;">
  <h2 style="font-family: 'Playfair Display', serif; font-size: 2.5rem; margin-bottom: 1rem;">
    Stay Inspired
  </h2>
  <p style="font-size: 1.2rem; margin-bottom: 2rem;">
    Ontvang styling tips en exclusive aanbiedingen
  </p>
  
  <form style="max-width: 500px; margin: 0 auto; display: flex; gap: 1rem;">
    <input type="email" 
           placeholder="Jouw email" 
           style="flex: 1; padding: 14px 20px; border-radius: 4px; border: none; font-size: 1rem;">
    <button type="submit" class="btn-aurelio" style="background: white; color: #2C3E50;">
      Inschrijven
    </button>
  </form>
</div>
```

---

## 🚀 Deploy naar Production

```bash
# Commit changes
git add .
git commit -m "Add Aurelio Living custom theme"
git push origin main

# Render zal automatisch deployen
# Check: https://dashboard.render.com/web/srv-d3h7vt63jp1c73favp80
```

---

## 📱 Next.js Alternative Setup (Later)

Als je later een Next.js frontend wilt:

```bash
# In een nieuwe directory (naast spree_starter)
npx create-next-app@latest aurelio-frontend --typescript --tailwind --app

cd aurelio-frontend

# Installeer Spree SDK
npm install @spree/storefront-api-v2-sdk

# Test API connection
# File: app/page.tsx
```

```typescript
import { makeClient } from '@spree/storefront-api-v2-sdk'

const client = makeClient({
  host: 'https://aurelio-living-v2-upgraded.onrender.com'
})

export default async function Home() {
  const response = await client.products.list()
  const products = response.success() ? response.data : []
  
  return (
    <main>
      <h1>Aurelio Living</h1>
      <div className="grid grid-cols-3 gap-4">
        {products.map(product => (
          <div key={product.id} className="border p-4 rounded">
            <h3>{product.attributes.name}</h3>
            <p>{product.attributes.display_price}</p>
          </div>
        ))}
      </div>
    </main>
  )
}
```

---

## 🎓 Hulpbronnen

- **Spree Docs**: https://docs.spreecommerce.org
- **Theme Guide**: https://docs.spreecommerce.org/developer/storefront/themes
- **API Reference**: https://docs.spreecommerce.org/api-reference
- **Next.js SDK**: https://www.npmjs.com/package/@spree/storefront-api-v2-sdk

---

## ✅ Checklist

- [ ] Custom theme gegenereerd
- [ ] Theme geactiveerd in admin
- [ ] Brand kleuren aangepast
- [ ] Custom CSS toegevoegd
- [ ] Homepage template aangepast
- [ ] Test op localhost:3001
- [ ] Deploy naar production
- [ ] Test op live URL

**Welk deel wil je als eerste implementeren?**
