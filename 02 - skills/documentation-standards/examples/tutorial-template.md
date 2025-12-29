# Tutorial Template

A concrete example of a well-structured tutorial following documentation standards.

---

# Tutorial: Build Your First REST API

By the end of this tutorial, you'll have a working REST API with user registration and basic CRUD operations.

**Time required:** ~30 minutes

## What You'll Learn

- Set up a Node.js/Express project
- Create RESTful endpoints
- Handle JSON requests and responses
- Test your API with curl

## Prerequisites

Before starting, make sure you have:

- [ ] Node.js 18+ installed ([download](https://nodejs.org))
- [ ] A code editor (VS Code recommended)
- [ ] A terminal/command prompt
- [ ] About 30 minutes

**Note:** This tutorial is for beginners. No prior API experience needed.

## Part 1: Project Setup (~5 min)

### Step 1: Create Project Directory

Open your terminal and run:

```bash
mkdir my-api
cd my-api
```

### Step 2: Initialize npm

```bash
npm init -y
```

You should see:

```
Wrote to /path/to/my-api/package.json
```

### Step 3: Install Express

```bash
npm install express
```

You should see:

```
added 57 packages in 3s
```

### Checkpoint

At this point, you should have:

- [ ] A `my-api` folder
- [ ] A `package.json` file
- [ ] A `node_modules` folder

## Part 2: Your First Endpoint (~10 min)

### Step 1: Create Server File

Create a new file called `server.js`:

```javascript
const express = require('express')
const app = express()

// Parse JSON bodies
app.use(express.json())

// Hello World endpoint
app.get('/', (req, res) => {
  res.json({ message: 'Hello World' })
})

// Start server
app.listen(3000, () => {
  console.log('Server running on http://localhost:3000')
})
```

### Step 2: Run the Server

```bash
node server.js
```

Expected output:

```
Server running on http://localhost:3000
```

### Step 3: Test the Endpoint

Open a new terminal and run:

```bash
curl http://localhost:3000
```

You should see:

```json
{"message":"Hello World"}
```

Congratulations! You just created your first API endpoint.

### Checkpoint

- [ ] Server running on port 3000
- [ ] GET / returns JSON message
- [ ] No errors in terminal

## Part 3: Add CRUD Operations (~15 min)

### Step 1: Add In-Memory Storage

Update `server.js` - add this after `app.use(express.json())`:

```javascript
// In-memory storage
let users = []
let nextId = 1
```

### Step 2: Create User Endpoint

Add this before `app.listen`:

```javascript
// Create user
app.post('/users', (req, res) => {
  const { name, email } = req.body

  if (!name || !email) {
    return res.status(400).json({ error: 'Name and email required' })
  }

  const user = { id: nextId++, name, email }
  users.push(user)

  res.status(201).json(user)
})
```

### Step 3: List Users Endpoint

Add this after the create endpoint:

```javascript
// List users
app.get('/users', (req, res) => {
  res.json(users)
})
```

### Step 4: Get Single User Endpoint

```javascript
// Get user by ID
app.get('/users/:id', (req, res) => {
  const user = users.find(u => u.id === parseInt(req.params.id))

  if (!user) {
    return res.status(404).json({ error: 'User not found' })
  }

  res.json(user)
})
```

### Step 5: Test Your API

Restart your server (Ctrl+C, then `node server.js`).

Create a user:

```bash
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John", "email": "john@example.com"}'
```

You should see:

```json
{"id":1,"name":"John","email":"john@example.com"}
```

List users:

```bash
curl http://localhost:3000/users
```

You should see:

```json
[{"id":1,"name":"John","email":"john@example.com"}]
```

### Checkpoint

- [ ] POST /users creates a user
- [ ] GET /users lists all users
- [ ] GET /users/:id returns single user
- [ ] Invalid requests return error messages

## Summary

You've learned how to:

- Set up an Express.js project
- Create GET and POST endpoints
- Handle JSON request/response
- Return appropriate status codes
- Test APIs with curl

Your complete `server.js` should look like this:

```javascript
const express = require('express')
const app = express()

app.use(express.json())

let users = []
let nextId = 1

app.get('/', (req, res) => {
  res.json({ message: 'Hello World' })
})

app.post('/users', (req, res) => {
  const { name, email } = req.body

  if (!name || !email) {
    return res.status(400).json({ error: 'Name and email required' })
  }

  const user = { id: nextId++, name, email }
  users.push(user)

  res.status(201).json(user)
})

app.get('/users', (req, res) => {
  res.json(users)
})

app.get('/users/:id', (req, res) => {
  const user = users.find(u => u.id === parseInt(req.params.id))

  if (!user) {
    return res.status(404).json({ error: 'User not found' })
  }

  res.json(user)
})

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000')
})
```

## Troubleshooting

### "Cannot find module 'express'"

**Symptom:** Error when running `node server.js`

**Solution:** Run `npm install express` in the project directory

### Port 3000 already in use

**Symptom:** `EADDRINUSE` error

**Solution:** Change the port number in `app.listen(3001, ...)` or stop the other process

### curl command not found

**Symptom:** Terminal doesn't recognize `curl`

**Solution:** On Windows, use PowerShell or install curl. Alternatively, use Postman.

## Need Help?

- [Express.js Documentation](https://expressjs.com/)
- [Tutorial: Add a Database](./tutorial-database.md)
- [How-to: Deploy to Production](../how-to/deploy.md)
- [API Reference](../reference/api.md)

---

## Why This Template Works

### Clear Time Estimate

States "~30 minutes" upfront and breaks down time per section.

### Checklist Prerequisites

Uses `- [ ]` format for easy mental tracking.

### Numbered Parts with Checkpoints

Breaks tutorial into digestible parts with verification points.

### Hand-Holding

Every step is explicit with expected output shown.

### Complete Code at End

Provides full working code for reference.

### Troubleshooting Section

Addresses common beginner issues.

### "Need Help?" Section

Provides actionable next steps and resources.
