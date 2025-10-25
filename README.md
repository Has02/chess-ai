# Chess AI

A chess AI project built with Python and FastAPI, containerized with Docker for easy deployment and development.

## 🚀 Quick Start with Docker

### Prerequisites
- Docker and Docker Compose installed
- Git

### Development Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd chess-ai
   ```

2. **Start development environment**
   ```bash
   # Start all services (app, Redis, PostgreSQL)
   docker-compose up chess-ai-dev redis postgres
   
   # Or start just the app for development
   docker-compose up chess-ai-dev
   ```

3. **Access the application**
   - API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

### Production Deployment

```bash
# Build and start production services
docker-compose up chess-ai-prod redis postgres

# Or run in detached mode
docker-compose up -d chess-ai-prod redis postgres
```

## 🛠️ Development

### Local Development (without Docker)

1. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   pip install -r requirements-dev.txt
   ```

3. **Run the application**
   ```bash
   uvicorn main:app --reload
   ```

### Docker Commands

```bash
# Build development image
docker-compose build chess-ai-dev

# Build production image
docker-compose build chess-ai-prod

# View logs
docker-compose logs chess-ai-dev

# Execute commands in container
docker-compose exec chess-ai-dev bash

# Stop all services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 📁 Project Structure

```
chess-ai/
├── Dockerfile              # Multi-stage Docker configuration
├── docker-compose.yml      # Development and production services
├── .dockerignore           # Files to exclude from Docker context
├── requirements.txt        # Production dependencies
├── requirements-dev.txt    # Development dependencies
├── main.py                 # FastAPI application (to be created)
└── README.md              # This file
```

## 🔧 Services

- **chess-ai-dev**: Development application with hot reload
- **chess-ai-prod**: Production application
- **redis**: Caching service for AI computations
- **postgres**: Database for storing game data

## 📝 Next Steps

1. Create the main FastAPI application (`main.py`)
2. Implement chess engine logic
3. Add AI algorithms (minimax, neural networks, etc.)
4. Create API endpoints for game management
5. Add unit tests and integration tests

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `docker-compose exec chess-ai-dev pytest`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
