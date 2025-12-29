# Reference Documentation Template

A concrete example of a well-structured reference documentation following documentation standards.

---

# Configuration Reference

Complete reference for all configuration options.

## Overview

Configuration via `config.json`, environment variables, or programmatic API.

**Priority:** Environment variables > Config file > Defaults

## Server Options

### `port`

- **Type:** `number`
- **Default:** `3000`
- **Env:** `APP_PORT`
- **CLI:** `--port`

Port number for the HTTP server.

```json
{ "port": 8080 }
```

### `host`

- **Type:** `string`
- **Default:** `"0.0.0.0"`
- **Env:** `APP_HOST`

Host address to bind to. Use `"127.0.0.1"` for localhost only.

```json
{ "host": "127.0.0.1" }
```

### `ssl.enabled`

- **Type:** `boolean`
- **Default:** `false`
- **Env:** `APP_SSL_ENABLED`

Enable HTTPS server.

### `ssl.cert`

- **Type:** `string`
- **Default:** `null`
- **Env:** `APP_SSL_CERT`
- **Required if:** `ssl.enabled` is `true`

Path to SSL certificate file.

### `ssl.key`

- **Type:** `string`
- **Default:** `null`
- **Env:** `APP_SSL_KEY`
- **Required if:** `ssl.enabled` is `true`

Path to SSL private key file.

## Database Options

### `database.url`

- **Type:** `string`
- **Required:** Yes
- **Env:** `DATABASE_URL`

Database connection string.

**Format:** `protocol://user:pass@host:port/database`

```json
{ "database": { "url": "postgres://localhost:5432/myapp" } }
```

### `database.pool.min`

- **Type:** `number`
- **Default:** `2`
- **Env:** `DATABASE_POOL_MIN`

Minimum connections in pool.

### `database.pool.max`

- **Type:** `number`
- **Default:** `10`
- **Env:** `DATABASE_POOL_MAX`

Maximum connections in pool.

### `database.ssl`

- **Type:** `boolean | object`
- **Default:** `false`
- **Env:** `DATABASE_SSL`

Enable SSL for database connection.

**Valid values:**

- `false` - Disabled
- `true` - Enabled with default settings
- `{ rejectUnauthorized: false }` - Enabled, accept self-signed certs

## Logging Options

### `logging.level`

- **Type:** `string`
- **Default:** `"info"`
- **Env:** `LOG_LEVEL`

Minimum log level to output.

**Valid values:**

| Value | Description |
|-------|-------------|
| `"debug"` | All messages including debug |
| `"info"` | Info, warnings, and errors |
| `"warn"` | Warnings and errors only |
| `"error"` | Errors only |
| `"silent"` | No output |

### `logging.format`

- **Type:** `string`
- **Default:** `"json"`
- **Env:** `LOG_FORMAT`

Log output format.

**Valid values:**

- `"json"` - Structured JSON logs (recommended for production)
- `"pretty"` - Human-readable colored output (development)

### `logging.timestamp`

- **Type:** `boolean`
- **Default:** `true`
- **Env:** `LOG_TIMESTAMP`

Include timestamp in log messages.

## Cache Options

### `cache.enabled`

- **Type:** `boolean`
- **Default:** `true`
- **Env:** `CACHE_ENABLED`

Enable response caching.

### `cache.ttl`

- **Type:** `number`
- **Default:** `300`
- **Env:** `CACHE_TTL`

Default cache TTL in seconds.

### `cache.driver`

- **Type:** `string`
- **Default:** `"memory"`
- **Env:** `CACHE_DRIVER`

Cache storage backend.

**Valid values:**

- `"memory"` - In-memory cache (single instance only)
- `"redis"` - Redis backend (requires `cache.redis.url`)

### `cache.redis.url`

- **Type:** `string`
- **Default:** `null`
- **Env:** `REDIS_URL`
- **Required if:** `cache.driver` is `"redis"`

Redis connection URL.

## Complete Example

```json
{
  "port": 8080,
  "host": "0.0.0.0",
  "ssl": {
    "enabled": true,
    "cert": "/etc/ssl/cert.pem",
    "key": "/etc/ssl/key.pem"
  },
  "database": {
    "url": "postgres://user:pass@localhost:5432/myapp",
    "pool": {
      "min": 5,
      "max": 20
    },
    "ssl": true
  },
  "logging": {
    "level": "info",
    "format": "json"
  },
  "cache": {
    "enabled": true,
    "ttl": 600,
    "driver": "redis",
    "redis": {
      "url": "redis://localhost:6379"
    }
  }
}
```

## Environment Variables Quick Reference

| Variable | Config Path | Default |
|----------|-------------|---------|
| `APP_PORT` | port | 3000 |
| `APP_HOST` | host | 0.0.0.0 |
| `DATABASE_URL` | database.url | - |
| `DATABASE_POOL_MIN` | database.pool.min | 2 |
| `DATABASE_POOL_MAX` | database.pool.max | 10 |
| `LOG_LEVEL` | logging.level | info |
| `LOG_FORMAT` | logging.format | json |
| `CACHE_ENABLED` | cache.enabled | true |
| `CACHE_TTL` | cache.ttl | 300 |
| `REDIS_URL` | cache.redis.url | - |

---

## Why This Template Works

### Exhaustive

Every option documented with type, default, and description.

### Consistent Format

Same structure for each option: Type, Default, Env, Description.

### Multiple Formats

Shows JSON config and env variables for each option.

### Quick Reference Table

Environment variables table for easy scanning.

### Complete Example

Working configuration showing all options together.

### Valid Values

Clearly lists all acceptable values for enum-type options.
