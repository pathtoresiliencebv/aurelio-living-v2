namespace :admin do
  desc "Setup default admin user for Aurelio Living"
  task setup: :environment do
    puts "🔧 Setting up admin user..."
    
    admin = Spree::AdminUser.find_or_initialize_by(email: 'admin@aurelioliving.com')
    
    if admin.new_record?
      admin.password = 'Admin123!'
      admin.password_confirmation = 'Admin123!'
      admin.save!
      puts "✅ New admin user created!"
    else
      admin.password = 'Admin123!'
      admin.password_confirmation = 'Admin123!'
      admin.save!
      puts "✅ Admin user password updated!"
    end
    
    puts ""
    puts "=" * 60
    puts "ADMIN CREDENTIALS:"
    puts "Email:    admin@aurelioliving.com"
    puts "Password: Admin123!"
    puts "=" * 60
    puts "Login at: https://aurelio-living-v2-upgraded.onrender.com/admin_users/login"
    puts ""
  end
end
