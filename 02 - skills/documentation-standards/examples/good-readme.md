# Example: Well-Structured README

This is an example of a well-structured root README following documentation standards.

---

# FastAPI Starter

Production-ready FastAPI template with authentication, database, and testing setup.

![CI](https://github.com/user/fastapi-starter/workflows/CI/badge.svg)
![Python](https://img.shields.io/badge/python-3.11+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Quick Start

```bash
# Clone and run
git clone https://github.com/user/fastapi-starter.git
cd fastapi-starter
cp .env.example .env
docker-compose up -d

# API available at http://localhost:8000
# Docs at http://localhost:8000/docs
```

## Features

- JWT authentication with refresh tokens
- PostgreSQL with async SQLAlchemy
- Alembic migrations
- Pytest with async support
- Docker and docker-compose
- OpenAPI documentation

## Installation

### Prerequisites

- Python 3.11+
- PostgreSQL 14+
- Docker (optional)

### Local Setup

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
# Edit .env with your database credentials

# Run migrations
alembic upgrade head

# Start server
uvicorn app.main:app --reload
```

### Docker Setup

```bash
docker-compose up -d
```

## Usage

### Authentication

```python
import httpx

# Register
response = httpx.post("http://localhost:8000/auth/register", json={
    "email": "user@example.com",
    "password": "securepassword"
})

# Login
response = httpx.post("http://localhost:8000/auth/login", json={
    "email": "user@example.com",
    "password": "securepassword"
})
token = response.json()["access_token"]

# Use token
response = httpx.get(
    "http://localhost:8000/users/me",
    headers={"Authorization": f"Bearer {token}"}
)
```

### Creating Resources

```python
response = httpx.post(
    "http://localhost:8000/items",
    headers={"Authorization": f"Bearer {token}"},
    json={"name": "My Item", "description": "A test item"}
)
```

## Project Structure

```
app/
├── api/           # Route handlers
├── core/          # Config, security, dependencies
├── models/        # SQLAlchemy models
├── schemas/       # Pydantic schemas
└── services/      # Business logic
tests/             # Pytest tests
```

## Configuration

Key environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| DATABASE_URL | PostgreSQL connection string | Required |
| SECRET_KEY | JWT signing key | Required |
| DEBUG | Enable debug mode | false |

See [Configuration Reference](./docs/configuration.md) for all options.

## Testing

```bash
# Run all tests
pytest

# With coverage
pytest --cov=app

# Specific test file
pytest tests/test_auth.py
```

## Documentation

- [API Reference](./docs/api.md)
- [Configuration](./docs/configuration.md)
- [Deployment Guide](./docs/deployment.md)

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

MIT - see [LICENSE](./LICENSE)

---

## Why This README Works

### Quick Start First

Gets developers running in <2 minutes with copy-paste commands.

### Progressive Disclosure

- Quick Start → Immediate gratification
- Installation → More detail when needed
- Usage → Examples for common tasks
- Docs links → Deep dives elsewhere

### Practical Examples

Real code, not `foo/bar`. Shows actual authentication flow.

### Clear Structure

Predictable sections. Easy to scan.

### Linked Resources

Doesn't try to include everything. Links to detailed docs.
