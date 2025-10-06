#!/bin/bash
# Setup Ruby 3.3.0 in WSL Ubuntu
# Run this in actual WSL terminal (not Git Bash)

echo "🔧 Setting up Ruby 3.3.0 for WSL..."

# Check if running in WSL
if ! grep -qi microsoft /proc/version 2>/dev/null; then
    echo "⚠️  WARNING: This doesn't look like WSL!"
    echo "Please run this script in WSL Ubuntu terminal"
    exit 1
fi

# Install dependencies
echo "📦 Installing build dependencies..."
sudo apt update
sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev \
    autoconf bison build-essential libyaml-dev libreadline-dev \
    libncurses5-dev libffi-dev libgdbm-dev

# Install rbenv
echo "📦 Installing rbenv..."
if [ ! -d "$HOME/.rbenv" ]; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# Configure shell
echo "⚙️  Configuring shell..."
if ! grep -q 'rbenv init' ~/.bashrc; then
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
fi

# Load rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"

# Install Ruby 3.3.0
echo "💎 Installing Ruby 3.3.0 (this may take 5-10 minutes)..."
rbenv install 3.3.0 -s
rbenv global 3.3.0

# Install bundler
echo "📦 Installing bundler..."
gem install bundler

# Verify
echo ""
echo "✅ Setup complete!"
echo ""
ruby -v
bundler -v
echo ""
echo "🚀 Now you can run:"
echo "   cd ~/AURELIO\ LIVING/spree_starter"
echo "   bundle install"
echo "   bin/rails server"
