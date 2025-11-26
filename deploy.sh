#!/bin/bash

echo "🚀 UCU Innovators Hub - Deployment Script"
echo "=========================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are installed"

# Install backend dependencies
echo "📦 Installing backend dependencies..."
cd backend
npm install

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd ../frontend
npm install

# Build frontend for production
echo "🔨 Building frontend for production..."
npm run build

echo "✅ Frontend built successfully"

# Go back to root
cd ..

echo ""
echo "🎉 Installation completed!"
echo ""
echo "📋 Next Steps:"
echo "1. Set up MongoDB Atlas (recommended) or local MongoDB"
echo "2. Update backend/.env with your MongoDB connection string"
echo "3. For production deployment:"
echo "   - Deploy backend/ to Railway, Render, or similar"
echo "   - Deploy frontend/dist/ to Vercel, Netlify, or similar"
echo ""
echo "🔧 Quick start for development:"
echo "Terminal 1: cd backend && npm run dev"
echo "Terminal 2: cd frontend && npm run dev"
echo ""
echo "🌐 Then visit: http://localhost:5173"
echo ""
echo "📚 For detailed setup instructions, see README.md"