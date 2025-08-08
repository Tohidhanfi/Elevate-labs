# Task 4: Version-Controlled DevOps Project with Git

## 🎯 **Objective**
Manage a DevOps project using Git best practices with proper branching strategies, commit conventions, and collaborative workflows.

## 🛠️ **Tools Used**
- **Git**: Version control system
- **GitHub**: Remote repository hosting
- **Node.js**: Demo application

## 📁 **Project Structure**
```
task-4/
├── README.md                 # Main documentation
├── .gitignore               # Git ignore patterns
├── src/                     # Source code
│   ├── app.js              # Express application
│   ├── package.json        # Dependencies
│   ├── utils/              # Utilities
│   └── public/             # Dashboard
├── scripts/                 # Deployment script
└── tests/                  # Unit tests
```

## 🔄 **Git Workflow**

### **Branching Strategy**
- **Main**: Production code
- **Develop**: Integration branch
- **Feature**: Individual features
- **Release**: Release preparation
- **Hotfix**: Critical fixes

### **Commit Convention**
```
type(scope): description

feat: new feature
fix: bug fix
docs: documentation
style: formatting
refactor: code refactoring
test: adding tests
chore: maintenance
```

### **Pull Request Process**
1. Create feature branch from develop
2. Make changes and commit
3. Push to remote repository
4. Create Pull Request
5. Code review and approval
6. Merge to develop

## 🚀 **Quick Start**

### **Setup**
```bash
# Clone repository
git clone <repository-url>
cd task-4

# Install dependencies
cd src
npm install

# Run application
npm start
```

### **Git Setup**
```bash
# Initialize repository
git init
git add .
git commit -m "feat: initial project setup"

# Create branches
git checkout -b develop
git checkout -b feature/user-auth
```

### **Tagging**
```bash
# Create release tag
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0
```

## 🧪 **Testing**
```bash
# Run tests
npm test

# Run with coverage
npm run test:coverage
```

## 📈 **Learning Outcomes**

### **Git Best Practices**
- ✅ Proper commit messages
- ✅ Branch naming conventions
- ✅ Pull request workflows
- ✅ Code review processes
- ✅ Tagging strategies

### **DevOps Workflows**
- ✅ Version control management
- ✅ Collaborative development
- ✅ Code quality assurance
- ✅ Release management

## 🎯 **Demonstration Guide**

### **1. Repository Overview**
- Show GitHub repository with branches
- Demonstrate commit history
- Display pull request workflow

### **2. Branching Strategy**
```bash
# Show all branches
git branch -a

# Demonstrate branch switching
git checkout develop
git checkout feature/user-auth
```

### **3. Commit History**
```bash
# Show commit log with graph
git log --oneline --graph --all
```

### **4. Pull Request Process**
- Navigate to GitHub
- Show pull request creation
- Demonstrate review process
- Show merge workflow

### **5. Tagging Demonstration**
```bash
# Show tags
git tag -l

# Create new tag
git tag -a v1.1.0 -m "Release 1.1.0"
```

## 🔧 **Configuration Files**

- **.gitignore**: Excludes unnecessary files
- **package.json**: Project dependencies and scripts
- **README.md**: Main project documentation

---

**🎉 This project demonstrates professional Git workflows and DevOps best practices!** 