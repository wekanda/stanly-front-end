# UCU Innovators Hub

A comprehensive web platform for showcasing and managing student innovation projects at Uganda Christian University.

## 🚀 Features

- **User Management**: Role-based authentication (Student, Supervisor, Admin)
- **Project Submission**: Students can submit projects with detailed information
- **Approval Workflow**: Supervisors can review and approve/reject submissions
- **Public Gallery**: Browse approved projects with filtering and search
- **Admin Dashboard**: Complete analytics and user/project management
- **Responsive Design**: Works perfectly on desktop and mobile

## 🛠️ Tech Stack

### Frontend
- React 18 with TypeScript
- Vite for build tooling
- Tailwind CSS for styling
- Axios for API calls
- React Router for navigation

### Backend
- Node.js with Express
- MongoDB with Mongoose
- JWT for authentication
- bcryptjs for password hashing
- Multer for file uploads

## 📋 Prerequisites

- Node.js (v16 or higher)
- MongoDB Atlas account (for production) or local MongoDB
- npm or yarn

## 🚀 Quick Start

### 1. Clone and Install

```bash
# Install backend dependencies
cd backend
npm install

# Install frontend dependencies
cd ../frontend
npm install
```

### 2. Environment Setup

#### Backend (.env)
```env
PORT=5000
NODE_ENV=development
MONGO_URI=mongodb://localhost:27017/mbale_innovators_hub
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
JWT_EXPIRE=7d
BCRYPT_ROUNDS=12
```

#### MongoDB Atlas Setup (Recommended for Production)
1. Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Create a free cluster
3. Get your connection string
4. Update `MONGO_URI` in `.env`

### 3. Run the Application

```bash
# Terminal 1: Start Backend
cd backend
npm run dev

# Terminal 2: Start Frontend
cd frontend
npm run dev
```

Visit `http://localhost:5173` to see the application!

## 🔐 Default Test Accounts

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@ucuhub.com | password123 |
| Supervisor | supervisor@ucuhub.com | password123 |
| Student | student@ucuhub.com | password123 |

## 📁 Project Structure

```
mbale-innovators-hub/
├── backend/
│   ├── src/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── middleware/
│   │   └── config/
│   ├── uploads/
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── context/
│   │   └── utils/
│   ├── public/
│   └── package.json
└── README.md
```

## 🌐 Deployment

### Backend Deployment (Railway, Render, etc.)
```bash
cd backend
npm run build
# Deploy to your preferred platform
```

### Frontend Deployment (Vercel, Netlify, etc.)
```bash
cd frontend
npm run build
# Deploy dist/ folder to your hosting platform
```

### Environment Variables for Production
```env
NODE_ENV=production
MONGO_URI=your_mongodb_atlas_connection_string
JWT_SECRET=your_secure_random_jwt_secret
```

## 📊 API Documentation

### Authentication Endpoints
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
- `GET /api/auth/me` - Get current user profile

### Project Endpoints
- `GET /api/projects` - Get all approved projects
- `POST /api/projects` - Submit new project (Students only)
- `GET /api/projects/user/me` - Get user's projects
- `PUT /api/projects/:id/approve` - Approve project (Supervisors/Admins)
- `PUT /api/projects/:id/reject` - Reject project (Supervisors/Admins)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

Built with ❤️ for UCU's innovation community

---

**UCU Innovators Hub** - Showcasing the future of Ugandan innovation! 🌟