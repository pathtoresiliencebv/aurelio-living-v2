#!/bin/bash

echo "🎨 Loading Spree sample data..."

# Run the sample data loader
bin/rake spree_sample:load

echo "✅ Sample data loaded successfully!"
