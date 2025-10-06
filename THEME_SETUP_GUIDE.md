# 🎨 Aurelio Living Theme - Setup Guide

## ✅ Theme Status

**Theme**: Aurelio Living Custom Theme
**Location**: `app/models/spree/themes/aurelio_living.rb`
**CSS**: `app/assets/stylesheets/themes/aurelio_living/theme.css`
**Status**: ✅ Registered in Spree

---

## 🚀 Activating the Theme

### **Method 1: Via Admin Panel (Recommended)**

1. **Go to Admin**: http://your-domain.com/admin
2. **Navigate to**: Storefront → Settings → General
3. **Find**: "Theme" dropdown
4. **Select**: "Aurelio Living"
5. **Save**: Click "Update"

### **Method 2: Via Rails Console**

```ruby
# In Render Shell or local console
store = Spree::Store.default
store.update(theme: 'Spree::Themes::AurelioLiving')
```

### **Method 3: Via Rake Task (All Stores)**

```bash
# After deployment, run in Render Shell:
bin/rails aurelio:set_theme
```

This sets Aurelio Living as the default theme for ALL stores.

---

## 🎨 Customizing Your Theme

### **Access Theme Editor:**

1. **Admin Panel** → **Storefront** → **Themes**
2. Find **"Aurelio Living"**
3. Click **"Customize"**
4. Adjust settings:
   - Colors (Primary, Accent, Background, etc.)
   - Typography (Fonts, Sizes)
   - Buttons (Style, Border, Shadow)
   - Borders (Radius, Width)
   - Product Images (Dimensions)

---

## 🎯 Theme Features (90+ Preferences!)

### **Colors (30+ options)**
- Primary, Accent, Danger, Success, Neutral
- Background, Text, Border colors
- Button colors (Primary & Secondary)
- Input field colors
- Checkout sidebar colors
- Navigation colors
- Footer colors
- Badge colors (Sale, New, In Stock)

### **Typography**
- Body font family
- Header font family
- Font size scale (adjustable %)
- Headings uppercase toggle
- Custom font code (Google Fonts, etc.)

### **Buttons**
- Background & hover colors
- Border thickness, opacity, radius
- Shadow settings (offset, blur, opacity)
- Primary & Secondary variants

### **Inputs**
- Text, background, border colors
- Focus states
- Border radius & thickness
- Shadow settings

### **Borders**
- Width, radius, color
- Shadow effects
- Sidebar borders
- Checkout dividers

### **Product Images**
- Listing image dimensions (desktop & mobile)
- Height & width controls

### **Custom Components**
- Hero section styling
- Badge border radius
- Navigation hover effects
- Footer link colors

---

## 📋 Current Theme ("Copy #1 of Default")

**Issue**: You created a copy of the Default theme, but it's not the Aurelio Living theme yet.

**Solution**:

### **Option A: Activate Aurelio Living** (Recommended)

1. Go to **Storefront → Themes**
2. You should see **"Aurelio Living"** in the list
3. Click **"Make Live"** or **"Customize"**

**If you don't see "Aurelio Living":**
- Run: `bin/rails aurelio:list_themes` (to check if it's registered)
- Restart your server
- Clear browser cache

### **Option B: Delete Copy, Use Original**

1. Delete "Copy #1 of Default"
2. Select "Aurelio Living" as your theme
3. Customize it as needed

---

## 🔧 Troubleshooting

### **Theme not showing up?**

**Check registration:**
```bash
bin/rails aurelio:list_themes
```

Should show:
```
📋 Available themes:
  - Spree::Themes::AurelioLiving
    Name: Aurelio Living
    Description: Premium e-commerce theme for home & living products
    Version: 1.0.0
```

**If not listed:**
1. Check `config/initializers/spree.rb`
2. Look for: `Rails.application.config.spree.themes << Spree::Themes::AurelioLiving`
3. Restart server

### **CSS not loading?**

**Check asset pipeline:**
```bash
# Precompile assets
bin/rails assets:precompile

# Or in development
bin/rails assets:clobber
```

### **Preferences not saving?**

**Clear cache:**
```bash
bin/rails tmp:cache:clear
```

**Or via console:**
```ruby
Rails.cache.clear
```

---

## 🎨 Example Customization

### **Via Theme Editor:**

1. **Colors**:
   - Primary: `#2C5F2D` (Forest Green)
   - Accent: `#F8F5F0` (Cream)
   - Danger: `#C73528` (Red)
   
2. **Typography**:
   - Font Family: `Montserrat`
   - Header Font: `Playfair Display`
   - Headings Uppercase: Off
   
3. **Buttons**:
   - Border Radius: `8px` (Rounded corners)
   - Shadow: Medium
   
4. **Product Images**:
   - Desktop: 400x400px
   - Mobile: 300x300px

### **Via Code (Advanced)**:

```ruby
# config/initializers/theme_preferences.rb
Rails.application.config.after_initialize do
  store = Spree::Store.default
  theme = store.theme_instance
  
  if theme.is_a?(Spree::Themes::AurelioLiving)
    theme.preferred_primary_color = '#2C5F2D'
    theme.preferred_font_family = 'Montserrat'
    theme.save!
  end
end
```

---

## 📊 Theme Structure

```
app/
├── models/
│   └── spree/
│       └── themes/
│           └── aurelio_living.rb       # Theme class with 90+ preferences
├── assets/
│   └── stylesheets/
│       └── themes/
│           └── aurelio_living/
│               └── theme.css           # CSS using theme preferences
└── views/
    └── spree/
        └── shared/
            ├── _aurelio_product_card.html.erb
            ├── _aurelio_hero_section.html.erb
            ├── _aurelio_features_grid.html.erb
            ├── _aurelio_header.html.erb
            └── _aurelio_footer.html.erb
```

---

## 🚀 Quick Start

**After deployment:**

```bash
# 1. Check available themes
bin/rails aurelio:list_themes

# 2. Set Aurelio Living as default
bin/rails aurelio:set_theme

# 3. Restart server (if local)
bin/rails restart

# 4. Open admin panel
# http://your-domain.com/admin

# 5. Go to Storefront → Themes → Customize
# Adjust colors, fonts, etc!
```

---

## 📚 Resources

- **Spree Themes Docs**: https://spreecommerce.org/docs/developer/customization/themes
- **Tailwind CSS**: https://tailwindcss.com/docs
- **Google Fonts**: https://fonts.google.com

---

**Questions?** Check the theme file at `app/models/spree/themes/aurelio_living.rb` for all available preferences!
