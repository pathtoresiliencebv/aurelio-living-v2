namespace :spree do
  namespace :multistore do
    desc "Update all store URLs after root_domain change"
    task update_store_urls: :environment do
      puts "🔄 Updating store URLs for root domain: #{Spree.root_domain}"
      
      Spree::Store.all.each do |store|
        old_url = store.url
        store.save!
        puts "  ✓ Updated #{store.name}: #{old_url} → #{store.url}"
      end
      
      puts "✅ Successfully updated #{Spree::Store.count} store(s)"
    end
    
    desc "Create a new store with subdomain"
    task :create_store, [:name, :code] => :environment do |t, args|
      name = args[:name] || "New Store"
      code = args[:code] || name.parameterize
      
      store = Spree::Store.create!(
        name: name,
        code: code,
        mail_from_address: "noreply@#{Spree.root_domain}",
        default_currency: 'EUR',
        default_locale: 'nl'
      )
      
      puts "✅ Created new store:"
      puts "  Name: #{store.name}"
      puts "  Code: #{store.code}"
      puts "  URL: #{store.url}"
      puts ""
      puts "🌐 Access your store at: https://#{store.url}"
      puts "⚙️  Configure in Admin Panel: Settings → Domains"
    end
    
    desc "List all stores with their URLs"
    task list_stores: :environment do
      puts "📋 Multi-Store Overview"
      puts "=" * 60
      puts "Root Domain: #{Spree.root_domain}"
      puts ""
      
      Spree::Store.all.each_with_index do |store, index|
        puts "#{index + 1}. #{store.name}"
        puts "   Code: #{store.code}"
        puts "   URL: #{store.url}"
        puts "   Default: #{store.default? ? '✓' : '✗'}"
        puts ""
      end
      
      puts "Total stores: #{Spree::Store.count}"
    end
  end
end
