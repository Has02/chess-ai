# Multi-stage Dockerfile for Chess AI
# Stage 1: Base image with Python and system dependencies
FROM python:3.11-slim as base

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r chessai && useradd -r -g chessai chessai

# Set working directory
WORKDIR /app

# Stage 2: Development stage
FROM base as development

# Install development dependencies
RUN pip install --upgrade pip

# Copy requirements first for better caching
COPY requirements.txt requirements-dev.txt ./
RUN pip install -r requirements.txt -r requirements-dev.txt

# Copy source code
COPY . .

# Change ownership to non-root user
RUN chown -R chessai:chessai /app
USER chessai

# Expose port for development server
EXPOSE 8000

# Default command for development
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

# Stage 3: Production stage
FROM base as production

# Install only production dependencies
RUN pip install --upgrade pip

# Copy requirements
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy source code
COPY . .

# Change ownership to non-root user
RUN chown -R chessai:chessai /app
USER chessai

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Production command
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
