# How-to Guide Template

A concrete example of a well-structured how-to guide following documentation standards.

---

# How to: Configure CORS for Your API

Enable Cross-Origin Resource Sharing (CORS) to allow requests from different domains.

## Prerequisites

- [ ] Node.js/Express application running
- [ ] Basic understanding of HTTP headers

## Steps

### 1. Install CORS Package

```bash
npm install cors
```

### 2. Configure Middleware

Add to your main server file after `express()`:

```javascript
const cors = require('cors')

// For development - allow all origins
app.use(cors())

// For production - specify allowed origins
app.use(cors({
  origin: 'https://yourdomain.com',
  credentials: true
}))
```

### 3. Test Configuration

```bash
curl -I -X OPTIONS https://localhost:3000/api/test \
  -H "Origin: https://yourdomain.com"
```

Should return headers including:

```
Access-Control-Allow-Origin: https://yourdomain.com
```

## Variations

### Multiple Allowed Origins

```javascript
app.use(cors({
  origin: [
    'https://app.example.com',
    'https://admin.example.com'
  ]
}))
```

### Dynamic Origin Validation

```javascript
app.use(cors({
  origin: (origin, callback) => {
    const allowedOrigins = ['https://app.example.com']

    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  }
}))
```

### With Specific Methods

```javascript
app.use(cors({
  origin: 'https://yourdomain.com',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}))
```

## Troubleshooting

### CORS errors persist after configuration

1. Check browser console for specific origin being blocked
2. Verify `origin` matches exactly (including `https://` vs `http://`)
3. Clear browser cache and retry

### Preflight requests failing

Ensure OPTIONS method is allowed:

```javascript
app.options('*', cors())
```

### Credentials not being sent

Set `credentials: true` in cors config AND `credentials: 'include'` in fetch:

```javascript
// Server
app.use(cors({ origin: 'https://yourdomain.com', credentials: true }))

// Client
fetch(url, { credentials: 'include' })
```

## See Also

- [CORS Reference](./cors-reference.md) - All configuration options
- [Security Headers Guide](./security-headers.md) - Additional security

---

## Why This Template Works

### Goal in Title

"How to: Configure CORS" - immediately clear what reader will accomplish.

### Minimal Prerequisites

Only what's needed for this specific task.

### Direct Steps

No unnecessary explanation - just the path to the goal.

### Variations Section

Shows common alternative configurations without cluttering main steps.

### Troubleshooting

Addresses common issues with solutions.

### See Also

Links to related documentation for deeper understanding.
