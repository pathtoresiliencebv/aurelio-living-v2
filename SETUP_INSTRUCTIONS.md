# Spree Starter Setup Instructions

## Problem Solved: SECRET_KEY_BASE Error

The error you encountered was caused by missing environment variables:
- `SECRET_KEY_BASE` was not set
- `DATABASE_URL` was not set

## Solution Applied

I've added fallback values in `config/application.rb` that will automatically set the SECRET_KEY_BASE for development:

```ruby
# Set fallback secret key base for development (only if not set)
if Rails.env.development? && ENV['SECRET_KEY_BASE'].blank?
  ENV['SECRET_KEY_BASE'] = 'development_secret_key_base_please_change_in_production'
end
```

**For Neon Database**: The application will use your `DATABASE_URL` and `DATABASE_DIRECT_URL` from your `.env` file.

## Next Steps for Neon Database

1. **Create a .env file** with your Neon database configuration:
   ```bash
   DATABASE_URL=postgresql://username:password@your-neon-host:5432/your-database-name
   DATABASE_DIRECT_URL=postgresql://username:password@your-neon-host:5432/your-database-name
   SECRET_KEY_BASE=your_secret_key_base_here
   RAILS_ENV=development
   ```

2. **Run the setup command**:
   ```bash
   bin/setup
   ```

   Or use the Neon-specific setup script:
   ```bash
   # For Linux/WSL
   source setup_neon.sh && bin/setup
   
   # For Windows
   setup_neon.bat && bin/setup
   ```

## Alternative: Manual Environment Setup

If you prefer to set environment variables manually, you can:

### Option 1: Use the provided scripts
```bash
# For Linux/WSL
source setup_env.sh && bin/setup

# For Windows
setup_env.bat && bin/setup
```

### Option 2: Set environment variables manually
```bash
export SECRET_KEY_BASE=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")
export DATABASE_URL="postgresql://postgres:password@localhost:5432/spree_starter_development"
export RAILS_ENV=development
bin/setup
```

## Neon Database Configuration

Make sure your Neon database is configured with:
- **DATABASE_URL**: Your main Neon connection string
- **DATABASE_DIRECT_URL**: Your direct Neon connection string (for migrations)
- **Database**: Your Neon database name
- **Host**: Your Neon host (e.g., ep-xxx.us-east-1.aws.neon.tech)
- **Port**: 5432 (default)
- **Username**: Your Neon username
- **Password**: Your Neon password

You can find these values in your Neon dashboard under "Connection Details".

## Production Warning

⚠️ **Important**: The fallback SECRET_KEY_BASE is only for development. For production, you MUST set a proper SECRET_KEY_BASE environment variable.

## Troubleshooting

If you still get errors:
1. Check that PostgreSQL is running: `pg_ctl status`
2. Verify database exists: `psql -l | grep spree_starter`
3. Check database connection: `psql -h localhost -U postgres -d spree_starter_development`
