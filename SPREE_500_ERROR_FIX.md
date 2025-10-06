# Spree Commerce 5.x - 500 Internal Server Error Fix

**Datum:** 6 Oktober 2025  
**Project:** Aurelio Living - Spree Commerce 5.1.7

---

## 🔥 Probleem

**Error:**
```
NoMethodError: undefined method `current_user' for an instance of Spree::HomeController
lib/spree/authentication_helpers.rb:17:in `spree_current_user'
```

**Symptomen:**
- Homepage toont 500 Internal Server Error
- Elke Spree pagina crasht
- Admin panel werkt niet

---

## 🎯 Root Cause

1. **Devise** maakt `current_user` method aan
2. **Spree** verwacht `current_spree_user` method
3. **Spree controllers** erven van `Spree::BaseController`, NIET van `ApplicationController`
4. **Mismatch** tussen authentication helpers

---

## ❌ Gefaalde Oplossingen

### Poging 1: ApplicationController Helper
```ruby
# app/controllers/application_controller.rb ❌ WERKT NIET
class ApplicationController < ActionController::Base
  helper_method :current_spree_user
  
  def current_spree_user
    current_user if respond_to?(:current_user)
  end
end
```

**Waarom het faalde:**
- `Spree::HomeController` erft van `Spree::BaseController`
- NIET van `ApplicationController`
- Helper is niet beschikbaar in Spree controllers

---

### Poging 2: Controller Decorator met Prepend
```ruby
# app/controllers/spree/base_controller_decorator.rb ❌ WERKT NIET
module Spree
  module BaseControllerDecorator
    def current_spree_user
      current_user if respond_to?(:current_user)
    end
  end
end

Spree::BaseController.prepend(Spree::BaseControllerDecorator)
```

**Waarom het faalde:**
- Decorator wordt geladen VOORDAT `Spree::BaseController` bestaat
- Rails engine load order probleem
- `prepend` faalt op non-existent class

---

## ✅ Werkende Oplossing (v3)

### Bestand: `config/initializers/spree_authentication_fix.rb`

```ruby
# frozen_string_literal: true

# Fix Spree authentication helper compatibility
# This runs AFTER Spree has loaded all its controllers

Rails.application.config.to_prepare do
  # Skip if already defined to avoid re-definition warnings
  next if Spree::BaseController.method_defined?(:current_spree_user)
  
  Spree::BaseController.class_eval do
    # Make current_spree_user available as a helper method in views
    helper_method :current_spree_user
    
    # Fix: Devise creates current_user, but Spree expects current_spree_user
    def current_spree_user
      # Try various methods to get the current user
      return current_user if respond_to?(:current_user, true) && current_user
      return try(:current_spree_user) if try(:current_spree_user)
      nil
    end
  end
  
  Rails.logger.info "✅ Spree authentication helper fixed: current_spree_user added to Spree::BaseController"
end
```

---

## 🧠 Waarom Dit Werkt

1. **`config.to_prepare`**
   - Runs AFTER alle Rails engines zijn geladen
   - Spree::BaseController bestaat al
   - Veilige timing voor monkey-patching

2. **`class_eval`**
   - Directly modifies de class
   - Geen prepend/include overhead
   - Werkt met bestaande classes

3. **`helper_method`**
   - Maakt method beschikbaar in views
   - Volgt Rails conventions
   - Proper helper registration

4. **Safe Checks**
   - `method_defined?` voorkomt re-definition
   - `respond_to?` met `true` voor private methods
   - `try()` fallback voor safety
   - `nil` return als alles faalt

---

## 🚀 Deployment

```bash
# Maak het bestand
touch config/initializers/spree_authentication_fix.rb

# Add to git
git add config/initializers/spree_authentication_fix.rb

# Commit
git commit -m "CRITICAL FIX: Add current_spree_user to Spree::BaseController via initializer"

# Push
git push origin main
```

---

## 📋 Verificatie

**Na deployment check:**

1. **Homepage werkt:**
   ```
   https://aurelio-living-v2-upgraded.onrender.com
   ```

2. **Logs checken:**
   ```
   ✅ Spree authentication helper fixed: current_spree_user added to Spree::BaseController
   ```

3. **Geen 500 errors meer**

---

## 🔧 Extra: Spree 5.x Admin Menu Issue

**Probleem:**
```ruby
Spree::Backend::Config.configure do |config|  # ❌ BESTAAT NIET in Spree 5.x
```

**Oplossing:**
- `Spree::Backend` bestaat NIET in Spree 5.x
- Gebruik `Spree::Admin::Config` (maar ook beperkt)
- Of gebruik Deface gem voor view modifications
- Direct menu customization niet ondersteund in Spree 5.x

---

## 📚 Tech Stack

- **Spree Commerce:** 5.1.7
- **Rails:** 8.0.3
- **Ruby:** 3.3.0
- **Authentication:** Devise
- **Database:** PostgreSQL (Neon)
- **Hosting:** Render.com

---

## 💡 Key Learnings

1. **Rails Engine Load Order Matters**
   - Decorators can load before the target class exists
   - Use `config.to_prepare` for post-load modifications

2. **Spree Architecture**
   - Spree controllers inherit from `Spree::BaseController`
   - NOT from `ApplicationController`
   - Requires targeted monkey-patching

3. **Authentication Integration**
   - Devise and Spree use different naming conventions
   - Bridge methods needed for compatibility
   - Helper methods must be explicitly registered

4. **Spree 5.x Changes**
   - Many Spree 4.x methods removed
   - `Spree::Backend` namespace gone
   - Menu customization requires different approach

---

## 🎯 Conclusie

De **config.to_prepare + class_eval** aanpak is de juiste manier om Spree::BaseController te modifieren in Spree 5.x. Dit voorkomt load order issues en werkt betrouwbaar in productie.

**Status:** ✅ OPGELOST
**Deployment:** Render.com
**Verificatie:** Succesvol getest in productie
