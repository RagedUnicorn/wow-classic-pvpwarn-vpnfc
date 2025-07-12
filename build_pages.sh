#!/bin/bash

echo "Building GitHub Pages site..."

# Remove old assets in docs if they exist
if [ -d "docs/assets" ]; then
    echo "Removing old docs/assets folder..."
    rm -rf docs/assets
fi

# Copy assets folder to docs
echo "Copying assets folder to docs..."
cp -r assets docs/

echo "Build complete!"
echo ""
echo "To test locally:"
echo "1. Navigate to the docs folder: cd docs"
echo "2. Start a local server:"
echo "   - Python 3: python -m http.server 8000"
echo "   - Python 2: python -m SimpleHTTPServer 8000"
echo "   - Node.js: npx http-server -p 8000"
echo "3. Open http://localhost:8000 in your browser"
