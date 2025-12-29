# Example: Well-Structured API Documentation

This is an example of a well-documented API endpoint following documentation standards.

---

## POST /api/v1/orders

Create a new order for the authenticated user.

### Authentication

Requires Bearer token with `orders:write` scope.

### Rate Limits

- Standard: 100 requests/minute
- Burst: 20 requests/second

### Request

#### Headers

| Header | Required | Description |
|--------|----------|-------------|
| Authorization | Yes | Bearer token |
| Content-Type | Yes | Must be `application/json` |
| Idempotency-Key | No | Unique key to prevent duplicate orders |

#### Request Body

```json
{
  "items": [
    {
      "productId": "prod_abc123",
      "quantity": 2,
      "priceOverride": null
    }
  ],
  "shippingAddress": {
    "street": "123 Main St",
    "city": "San Francisco",
    "state": "CA",
    "postalCode": "94102",
    "country": "US"
  },
  "billingAddress": null,
  "couponCode": "SAVE10",
  "metadata": {
    "source": "web",
    "campaign": "summer-sale"
  }
}
```

#### Body Parameters

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| items | array | Yes | Order line items (1-100 items) |
| items[].productId | string | Yes | Product identifier |
| items[].quantity | integer | Yes | Quantity (1-999) |
| items[].priceOverride | number | No | Override unit price (admin only) |
| shippingAddress | object | Yes | Delivery address |
| shippingAddress.street | string | Yes | Street address |
| shippingAddress.city | string | Yes | City name |
| shippingAddress.state | string | Yes | State/province code |
| shippingAddress.postalCode | string | Yes | Postal/ZIP code |
| shippingAddress.country | string | Yes | ISO 3166-1 alpha-2 country code |
| billingAddress | object | No | Billing address (defaults to shipping) |
| couponCode | string | No | Discount coupon code |
| metadata | object | No | Custom key-value pairs (max 50 keys) |

### Response

#### 201 Created

Order successfully created.

```json
{
  "id": "ord_xyz789",
  "status": "pending",
  "items": [
    {
      "id": "li_001",
      "productId": "prod_abc123",
      "productName": "Widget Pro",
      "quantity": 2,
      "unitPrice": 29.99,
      "totalPrice": 59.98
    }
  ],
  "subtotal": 59.98,
  "discount": 6.00,
  "tax": 5.40,
  "shipping": 5.99,
  "total": 65.37,
  "currency": "USD",
  "shippingAddress": {
    "street": "123 Main St",
    "city": "San Francisco",
    "state": "CA",
    "postalCode": "94102",
    "country": "US"
  },
  "couponCode": "SAVE10",
  "metadata": {
    "source": "web",
    "campaign": "summer-sale"
  },
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

#### Response Fields

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique order identifier |
| status | enum | Order status: `pending`, `confirmed`, `shipped`, `delivered`, `cancelled` |
| items | array | Line items with calculated prices |
| subtotal | number | Sum of line item totals |
| discount | number | Coupon discount amount |
| tax | number | Calculated tax |
| shipping | number | Shipping cost |
| total | number | Final order total |
| currency | string | ISO 4217 currency code |
| createdAt | string | ISO 8601 creation timestamp |
| updatedAt | string | ISO 8601 last update timestamp |

#### 400 Bad Request

Invalid request data.

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request body",
    "details": [
      {
        "field": "items[0].quantity",
        "code": "OUT_OF_RANGE",
        "message": "Quantity must be between 1 and 999"
      }
    ]
  }
}
```

| Error Code | Description |
|------------|-------------|
| VALIDATION_ERROR | One or more fields invalid |
| INVALID_PRODUCT | Product ID not found or unavailable |
| INVALID_COUPON | Coupon code invalid or expired |
| INSUFFICIENT_STOCK | Product quantity exceeds available stock |

#### 401 Unauthorized

```json
{
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Invalid or expired token"
  }
}
```

#### 403 Forbidden

```json
{
  "error": {
    "code": "FORBIDDEN",
    "message": "Missing required scope: orders:write"
  }
}
```

#### 409 Conflict

Duplicate order (when using Idempotency-Key).

```json
{
  "error": {
    "code": "DUPLICATE_REQUEST",
    "message": "Order already created with this idempotency key",
    "existingOrderId": "ord_xyz789"
  }
}
```

#### 422 Unprocessable Entity

Business rule violation.

```json
{
  "error": {
    "code": "SHIPPING_UNAVAILABLE",
    "message": "Shipping not available to this address",
    "details": {
      "reason": "Country not supported",
      "country": "XX"
    }
  }
}
```

#### 429 Too Many Requests

```json
{
  "error": {
    "code": "RATE_LIMITED",
    "message": "Too many requests",
    "retryAfter": 30
  }
}
```

Response Headers:
- `Retry-After: 30`
- `X-RateLimit-Limit: 100`
- `X-RateLimit-Remaining: 0`
- `X-RateLimit-Reset: 1705315800`

### Examples

#### cURL

```bash
curl -X POST https://api.example.com/api/v1/orders \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Idempotency-Key: unique-request-id-123" \
  -d '{
    "items": [
      {"productId": "prod_abc123", "quantity": 2}
    ],
    "shippingAddress": {
      "street": "123 Main St",
      "city": "San Francisco",
      "state": "CA",
      "postalCode": "94102",
      "country": "US"
    }
  }'
```

#### JavaScript

```javascript
const response = await fetch('https://api.example.com/api/v1/orders', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json',
    'Idempotency-Key': crypto.randomUUID()
  },
  body: JSON.stringify({
    items: [
      { productId: 'prod_abc123', quantity: 2 }
    ],
    shippingAddress: {
      street: '123 Main St',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94102',
      country: 'US'
    }
  })
})

const order = await response.json()
console.log(`Order ${order.id} created: $${order.total}`)
```

#### Python

```python
import requests
import uuid

response = requests.post(
    'https://api.example.com/api/v1/orders',
    headers={
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json',
        'Idempotency-Key': str(uuid.uuid4())
    },
    json={
        'items': [
            {'productId': 'prod_abc123', 'quantity': 2}
        ],
        'shippingAddress': {
            'street': '123 Main St',
            'city': 'San Francisco',
            'state': 'CA',
            'postalCode': '94102',
            'country': 'US'
        }
    }
)

order = response.json()
print(f"Order {order['id']} created: ${order['total']}")
```

### Webhooks

Order creation triggers the `order.created` webhook event. See [Webhooks Documentation](./webhooks.md).

### Related Endpoints

- [GET /orders/:id](./get-order.md) - Get order details
- [GET /orders](./list-orders.md) - List user orders
- [POST /orders/:id/cancel](./cancel-order.md) - Cancel order
- [GET /products](./list-products.md) - List available products

---

## Why This API Doc Works

### Complete Request Documentation

Every parameter documented with type, required status, and constraints.

### All Response Codes

Not just success - every error with example payload and error codes.

### Real Examples

Three languages with realistic, copy-paste ready code.

### Consistent Format

Tables for parameters, JSON for examples, same structure throughout.

### Cross-References

Links to related endpoints and webhooks.
