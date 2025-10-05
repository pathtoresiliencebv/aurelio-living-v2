# Fix voor tsort LoadError in Rails 8.0.0

## Het Probleem
Je krijgt deze fout:
```
LoadError: cannot load such file -- /home/jason/.rbenv/versions/3.3.0/lib/ruby/gems/3.3.0/gems/tsort-0.2.0/lib/tsort.rb
```

Dit gebeurt vaak met Rails 8.0.0 omdat de tsort gem niet correct wordt geladen.

## Oplossing

### Optie 1: Automatische Fix (Aanbevolen)
```bash
# Run het fix script
chmod +x fix_rails8_tsort.sh
./fix_rails8_tsort.sh
```

### Optie 2: Handmatige Fix
```bash
# 1. Ga naar je project directory
cd "/home/jason/AURELIO LIVING/spree_starter"

# 2. Verwijder Gemfile.lock
rm -f Gemfile.lock

# 3. Clean bundle cache
bundle clean --force

# 4. Update bundler
gem update bundler

# 5. Reinstall gems
bundle install

# 6. Test tsort gem
ruby -e "require 'tsort'; puts 'tsort works!'"

# 7. Test Rails
bin/rails --version

# 8. Run setup
bin/setup
```

### Optie 3: Direct tsort installeren
```bash
# Installeer tsort gem direct
gem install tsort

# Test of het werkt
ruby -e "require 'tsort'; puts 'tsort works!'"

# Run setup
bin/setup
```

## Wat ik heb gedaan

1. **tsort gem toegevoegd** aan Gemfile met versie `~> 0.2`
2. **Fix scripts gemaakt** voor automatische reparatie
3. **Instructies geschreven** voor handmatige fix

## Test na de fix

Na het uitvoeren van een van de bovenstaande oplossingen, test of het werkt:

```bash
bin/setup
```

Als het nog steeds niet werkt, probeer dan:

```bash
# Check of tsort geïnstalleerd is
gem list tsort

# Check bundle status
bundle list | grep tsort

# Test Rails direct
bin/rails --version
```

## Waarom gebeurt dit?

Rails 8.0.0 is een nieuwe versie en heeft soms problemen met bepaalde gems, vooral tsort. Dit is een bekende issue die vaak voorkomt bij nieuwe Rails versies.
