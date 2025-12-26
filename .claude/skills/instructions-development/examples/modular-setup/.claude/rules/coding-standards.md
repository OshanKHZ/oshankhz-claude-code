---
paths: src/**/*.{ts,tsx}
---

# Coding Standards

Applied to all TypeScript files in src/

## Naming Conventions

### Files

- **Components**: PascalCase.tsx (e.g., `ProductCard.tsx`, `UserProfile.tsx`)
- **Pages**: kebab-case.tsx (e.g., `product-detail.tsx`, `user-settings.tsx`)
- **Hooks**: camelCase with `use` prefix (e.g., `useCart.ts`, `useAuth.ts`)
- **Utilities**: camelCase.ts (e.g., `formatPrice.ts`, `dateUtils.ts`)
- **Constants**: SCREAMING_SNAKE_CASE.ts (e.g., `API_ENDPOINTS.ts`)
- **Types**: PascalCase.ts (e.g., `Product.ts`, `User.ts`)

### Code

- **Functions/Variables**: camelCase
  - `getUserData`, `calculateTotal`, `isActive`
- **Components/Classes**: PascalCase
  - `ProductCard`, `UserService`, `ShoppingCart`
- **Constants**: SCREAMING_SNAKE_CASE
  - `API_URL`, `MAX_ITEMS`, `DEFAULT_LOCALE`
- **Booleans**: Use `is/has/can/should` prefix
  - `isLoading`, `hasPermission`, `canEdit`, `shouldShow`

### Examples

```typescript
// ✅ Good
const fetchProductData = async (productId: string) => {...}
const isAvailable = checkStock(product)
const MAX_CART_ITEMS = 50

// ❌ Bad
const FetchProductData = async (productid: string) => {...}
const available = checkStock(product)
const max_cart_items = 50
```

## Import Order

Strict import ordering for consistency:

```typescript
// 1. React/Next.js (framework)
import { useState, useEffect } from 'react'
import Link from 'next/link'
import Image from 'next/image'

// 2. External dependencies
import { useQuery } from '@tanstack/react-query'
import { z } from 'zod'
import clsx from 'clsx'

// 3. Internal aliases (@/)
import { api } from '@/lib/api'
import { Button } from '@/shared/ui'
import { useCart } from '@/features/cart'

// 4. Relative imports
import { ProductCard } from './ProductCard'
import { formatPrice } from './utils'

// 5. Types (if not inline)
import type { Product } from '@/entities/product'
import type { User } from '@/entities/user'
```

## Quality Rules

### Function Length

- **Target**: <30 lines per function
- **Hard limit**: <50 lines
- **If longer**: Extract helper functions or refactor

### Function Complexity

- **Max parameters**: 3-4 (use object parameter if more needed)
- **Single responsibility**: Each function does ONE thing
- **Early returns**: Avoid deep nesting

```typescript
// ✅ Good - Early returns, clear flow
function validateProduct(product: Product): boolean {
  if (!product.name) return false
  if (!product.price || product.price < 0) return false
  if (!product.stock || product.stock < 0) return false
  return true
}

// ❌ Bad - Deep nesting
function validateProduct(product: Product): boolean {
  if (product.name) {
    if (product.price && product.price >= 0) {
      if (product.stock && product.stock >= 0) {
        return true
      }
    }
  }
  return false
}
```

### Object Parameters

When function needs >4 parameters, use object:

```typescript
// ✅ Good - Object parameter
function createProduct({
  name,
  price,
  category,
  description,
  imageUrl
}: ProductInput): Product {...}

// ❌ Bad - Too many parameters
function createProduct(
  name: string,
  price: number,
  category: string,
  description: string,
  imageUrl: string
): Product {...}
```

## Code Organization

### DRY (Don't Repeat Yourself)

Extract repeated code when used **3+ times**:

```typescript
// ✅ Good - Extracted after 3rd use
const formatPrice = (price: number) => {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD'
  }).format(price)
}

// Use everywhere
const productPrice = formatPrice(product.price)
const cartTotal = formatPrice(cart.total)
const shipping = formatPrice(shippingCost)
```

### Single Responsibility

Each function/component should have ONE clear purpose:

```typescript
// ✅ Good - Single responsibility
function fetchProducts() {...}
function filterProducts(products, category) {...}
function sortProducts(products, order) {...}

// ❌ Bad - Multiple responsibilities
function fetchFilterAndSortProducts(category, order) {
  const products = fetchProducts()
  const filtered = filterProducts(products, category)
  const sorted = sortProducts(filtered, order)
  return sorted
}
```

## Comments

### When to Comment

- **Complex algorithms**: Non-obvious logic
- **Business rules**: Why specific values/rules exist
- **Workarounds**: Temporary fixes, browser quirks
- **Public APIs**: JSDoc for exported functions

### When NOT to Comment

- **Obvious code**: Self-explanatory operations
- **Redundant comments**: Just repeating what code says

```typescript
// ✅ Good - Explains WHY
// Using 300ms debounce to prevent duplicate submissions
// when user double-clicks the checkout button
const handleCheckout = debounce(processCheckout, 300)

// Stripe requires amount in cents (not dollars)
const amountInCents = total * 100

// ❌ Bad - Explains WHAT (code already says this)
// This function fetches products
function fetchProducts() {...}

// Set loading to true
setLoading(true)
```

### JSDoc for Public APIs

```typescript
/**
 * Calculates discounted price based on user's membership tier
 * @param basePrice - Original price in USD
 * @param userTier - User's membership level (bronze, silver, gold)
 * @returns Discounted price in USD
 */
export function calculateDiscount(
  basePrice: number,
  userTier: MembershipTier
): number {
  // Implementation
}
```

## Error Handling

### Always Handle Errors

```typescript
// ✅ Good - Proper error handling
try {
  const product = await fetchProduct(id)
  return product
} catch (error) {
  console.error('Failed to fetch product:', error)
  throw new Error(`Product fetch failed: ${error.message}`)
}

// ❌ Bad - Silent failure
try {
  const product = await fetchProduct(id)
  return product
} catch (error) {
  // Nothing - error silently swallowed
}
```

### Descriptive Error Messages

```typescript
// ✅ Good - Clear, actionable message
throw new Error('Invalid product ID: expected string, got undefined')

// ❌ Bad - Vague message
throw new Error('Invalid input')
```

### Propagate When Appropriate

Don't catch errors just to rethrow - let them bubble up:

```typescript
// ✅ Good - Let error bubble if you can't handle it
async function getProductWithReviews(id: string) {
  const product = await fetchProduct(id) // May throw
  const reviews = await fetchReviews(id) // May throw
  return { product, reviews }
}

// ❌ Bad - Unnecessary catch-rethrow
async function getProductWithReviews(id: string) {
  try {
    const product = await fetchProduct(id)
    const reviews = await fetchReviews(id)
    return { product, reviews }
  } catch (error) {
    throw error // Pointless
  }
}
```

## TypeScript Specific

### No `any` Type

```typescript
// ✅ Good - Proper types
function processResponse(data: unknown): Product {
  const validated = productSchema.parse(data)
  return validated
}

// ❌ Bad - Using any
function processResponse(data: any): Product {
  return data
}
```

### Type Inference

Let TypeScript infer when obvious:

```typescript
// ✅ Good - Inference works
const count = 0 // TypeScript knows it's number
const name = 'Product' // TypeScript knows it's string

// ❌ Bad - Redundant annotations
const count: number = 0
const name: string = 'Product'
```

But annotate return types:

```typescript
// ✅ Good - Explicit return type
function getProduct(id: string): Promise<Product> {
  return fetchProduct(id)
}

// ❌ Bad - No return type (harder to catch errors)
function getProduct(id: string) {
  return fetchProduct(id)
}
```

## Component-Specific

### Props Interface

```typescript
// ✅ Good - Clear interface
interface ProductCardProps {
  product: Product
  onAddToCart: (productId: string) => void
  isLoading?: boolean
}

export function ProductCard({
  product,
  onAddToCart,
  isLoading = false
}: ProductCardProps) {
  // Implementation
}
```

### Destructure Props

```typescript
// ✅ Good - Destructured props
function ProductCard({ product, onAddToCart }: ProductCardProps) {
  return <div>{product.name}</div>
}

// ❌ Bad - Using props object
function ProductCard(props: ProductCardProps) {
  return <div>{props.product.name}</div>
}
```

### Boolean Props Naming

```typescript
// ✅ Good - is/has prefix
<Button isLoading disabled={!isValid} />

// ❌ Bad - No prefix
<Button loading disabled={!valid} />
```
