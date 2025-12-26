# Architecture: Feature-Sliced Design

Complete FSD guidelines for e-commerce platform.

## Overview

Feature-Sliced Design (FSD) is a standardized architecture for frontend applications that prevents spaghetti code through strict dependency layers.

**Why FSD for this project**:
- Large codebase with multiple teams
- Complex user workflows (browse, cart, checkout, orders)
- Need for clear boundaries between features
- Scalability and maintainability over time

## Layers

From high-level (app) to low-level (shared):

### 1. app/ - Application Level

Application shell, initialization, providers.

```
src/app/
├── layout.tsx          # Root layout
├── providers.tsx       # Global providers (theme, auth, query)
└── styles/
    └── globals.css
```

**Contains**: Routing, global providers, app initialization
**Can import from**: All layers
**Cannot import**: N/A (top layer)

### 2. pages/ - Route Pages

Full pages corresponding to routes.

```
src/pages/
├── home/
│   ├── ui/
│   │   └── HomePage.tsx
│   └── index.ts
├── product-detail/
│   ├── ui/
│   │   └── ProductDetailPage.tsx
│   ├── model/
│   │   └── useProductDetail.ts
│   └── index.ts
└── checkout/
    └── ...
```

**Contains**: Page components, page-level logic
**Can import from**: widgets, features, entities, shared
**Cannot import**: app, other pages

### 3. widgets/ - Autonomous Blocks

Composite blocks like header, footer, sidebar.

```
src/widgets/
├── header/
│   ├── ui/
│   │   ├── Header.tsx
│   │   └── NavMenu.tsx
│   └── index.ts
├── product-filters/
│   ├── ui/
│   │   └── ProductFilters.tsx
│   ├── model/
│   │   └── useFilters.ts
│   └── index.ts
└── shopping-cart-sidebar/
    └── ...
```

**Contains**: Complex UI blocks combining multiple features
**Can import from**: features, entities, shared
**Cannot import**: app, pages, other widgets

### 4. features/ - User Interactions

Specific user actions and interactions.

```
src/features/
├── add-to-cart/
│   ├── ui/
│   │   └── AddToCartButton.tsx
│   ├── model/
│   │   └── useAddToCart.ts
│   └── index.ts
├── product-search/
│   ├── ui/
│   │   └── SearchBar.tsx
│   ├── model/
│   │   └── useSearch.ts
│   ├── api/
│   │   └── searchProducts.ts
│   └── index.ts
└── user-auth/
    ├── ui/
    │   ├── LoginForm.tsx
    │   └── RegisterForm.tsx
    ├── model/
    │   ├── useAuth.ts
    │   └── authStore.ts
    ├── api/
    │   └── authApi.ts
    └── index.ts
```

**Contains**: User interactions, feature-specific logic
**Can import from**: entities, shared
**Cannot import**: app, pages, widgets, other features

### 5. entities/ - Business Entities

Core business entities and their operations.

```
src/entities/
├── product/
│   ├── ui/
│   │   └── ProductCard.tsx
│   ├── model/
│   │   ├── types.ts
│   │   └── productSchema.ts
│   ├── api/
│   │   └── productApi.ts
│   └── index.ts
├── user/
│   ├── ui/
│   │   └── UserAvatar.tsx
│   ├── model/
│   │   └── types.ts
│   └── index.ts
└── order/
    └── ...
```

**Contains**: Business entities, entity-specific logic
**Can import from**: shared only
**Cannot import**: app, pages, widgets, features, other entities

### 6. shared/ - Shared Resources

Reusable code with no business logic.

```
src/shared/
├── ui/
│   ├── button/
│   ├── input/
│   ├── card/
│   └── modal/
├── lib/
│   ├── api/
│   ├── hooks/
│   └── utils/
├── config/
│   └── constants.ts
└── types/
    └── common.ts
```

**Contains**: UI kit, utilities, configs, common types
**Can import from**: Nothing (bottom layer)
**Cannot import**: Any layer above

## Dependency Rules

### Strict Rule: Unidirectional Flow

```
app ──→ pages ──→ widgets ──→ features ──→ entities ──→ shared
  ↓       ↓         ↓           ↓           ↓           ×
  ✓       ✓         ✓           ✓           ✓        (imports nothing)
```

**Lower layers CANNOT import from higher layers.**

### Examples

```typescript
// ✅ Good - Higher imports from lower
// In pages/home/
import { ProductFilters } from '@/widgets/product-filters'
import { ProductCard } from '@/entities/product'

// In features/add-to-cart/
import { Product } from '@/entities/product'
import { Button } from '@/shared/ui'

// ❌ Bad - Lower imports from higher
// In entities/product/
import { AddToCartButton } from '@/features/add-to-cart' // FORBIDDEN

// In features/search/
import { HomePage } from '@/pages/home' // FORBIDDEN
```

## Slice Structure (Segments)

Each slice (feature, entity, widget) uses segments:

```
feature-name/
├── ui/              # Components
├── model/           # State, hooks, types, business logic
├── api/             # API calls, data fetching
├── lib/             # Utilities specific to this slice
└── index.ts         # Public API (barrel export)
```

### Segment Usage

- **ui/**: Always present for slices with components
- **model/**: State management, hooks, types, business logic
- **api/**: API calls, external data fetching
- **lib/**: Utilities, helpers specific to this slice

Not all segments needed for every slice.

## Public APIs (Barrel Exports)

**RULE**: Slices export only via `index.ts`

```typescript
// features/add-to-cart/index.ts
export { AddToCartButton } from './ui/AddToCartButton'
export { useAddToCart } from './model/useAddToCart'
export type { AddToCartOptions } from './model/types'

// DO NOT export internal implementation details
```

**Import from public API only**:

```typescript
// ✅ Good - Import from public API
import { AddToCartButton, useAddToCart } from '@/features/add-to-cart'

// ❌ Bad - Direct import bypassing public API
import { AddToCartButton } from '@/features/add-to-cart/ui/AddToCartButton'
```

## Guidelines

### 1. Colocation

Related code stays together within slice:

```
features/product-search/
├── ui/
│   ├── SearchBar.tsx        # Component
│   └── SearchResults.tsx    # Component
├── model/
│   ├── useSearch.ts         # Hook using this state
│   └── searchStore.ts       # State
└── api/
    └── searchApi.ts         # API call
```

### 2. Business Language

Use business/product language, not technical terms:

```
✅ features/user-registration/
✅ features/add-to-cart/
✅ features/apply-discount-code/

❌ features/form-handler/
❌ features/button-click-handler/
❌ features/data-fetcher/
```

### 3. Extract to Shared Only After 3rd Use

Don't prematurely extract to `shared/`. Wait until used 3+ times:

```
// Used in 1 place: Keep in slice
// Used in 2 places: Duplicate (favor duplication over wrong abstraction)
// Used in 3+ places: Extract to shared/
```

### 4. Autonomous Slices

Each slice should be:
- **Self-contained**: Has everything it needs
- **Independently testable**: Can test in isolation
- **Replaceable**: Can be removed without breaking others (minimal coupling)

### 5. Cross-Slice Communication

When features need to communicate:

**Option A**: Through shared entities
```typescript
// features/add-to-cart/ updates cart entity
// features/cart-summary/ reads cart entity
```

**Option B**: Through parent component (props)
```typescript
// pages/checkout/ coordinates multiple features
<CheckoutPage>
  <CartSummary items={items} />
  <PaymentForm onSubmit={handlePayment} />
</CheckoutPage>
```

**Option C**: Through shared state (Zustand store in shared/)
```typescript
// shared/lib/stores/cartStore.ts
// Multiple features can access
```

## Common Patterns

### Pattern 1: Feature Using Entity

```typescript
// features/add-to-cart/ui/AddToCartButton.tsx
import { Product } from '@/entities/product'
import { Button } from '@/shared/ui/button'

interface AddToCartButtonProps {
  product: Product
}

export function AddToCartButton({ product }: AddToCartButtonProps) {
  // Feature logic
}
```

### Pattern 2: Page Composing Widgets and Features

```typescript
// pages/product-detail/ui/ProductDetailPage.tsx
import { ProductInfo } from '@/widgets/product-info'
import { AddToCartButton } from '@/features/add-to-cart'
import { ProductReviews } from '@/widgets/product-reviews'

export function ProductDetailPage({ productId }: Props) {
  return (
    <>
      <ProductInfo productId={productId} />
      <AddToCartButton productId={productId} />
      <ProductReviews productId={productId} />
    </>
  )
}
```

### Pattern 3: Widget Using Multiple Features

```typescript
// widgets/header/ui/Header.tsx
import { SearchBar } from '@/features/product-search'
import { UserMenu } from '@/features/user-auth'
import { CartIcon } from '@/features/cart-preview'

export function Header() {
  return (
    <header>
      <SearchBar />
      <UserMenu />
      <CartIcon />
    </header>
  )
}
```

## Enforcement

### ESLint Rule (Recommended)

Use `@feature-sliced/eslint-config` to enforce dependency rules:

```bash
npm install -D @feature-sliced/eslint-config
```

```js
// .eslintrc.js
module.exports = {
  extends: ['@feature-sliced']
}
```

### Path Aliases

Configure path aliases for clean imports:

```json
// tsconfig.json
{
  "compilerOptions": {
    "paths": {
      "@/app/*": ["./src/app/*"],
      "@/pages/*": ["./src/pages/*"],
      "@/widgets/*": ["./src/widgets/*"],
      "@/features/*": ["./src/features/*"],
      "@/entities/*": ["./src/entities/*"],
      "@/shared/*": ["./src/shared/*"]
    }
  }
}
```

## Migration from Other Patterns

### From Flat Structure

1. Identify features, entities, widgets in current code
2. Create FSD layer directories
3. Move components to appropriate layers
4. Create index.ts barrel exports
5. Update imports to use path aliases
6. Install ESLint plugin to enforce rules

### From Feature-First

1. Feature-First features → FSD features (mostly same)
2. Identify cross-cutting concerns → widgets
3. Extract business entities → entities layer
4. Move shared utilities → shared layer
5. Create pages layer for routes

## Anti-Patterns

❌ **Circular dependencies between features**
```typescript
// features/a imports from features/b
// features/b imports from features/a
// Solution: Extract common logic to entities or shared
```

❌ **Importing from higher layers**
```typescript
// entities/product imports from features/add-to-cart
// Solution: Invert dependency, feature imports entity
```

❌ **Bypassing public API**
```typescript
// Importing directly from ui/ folder
import { Button } from '@/features/auth/ui/Button'
// Solution: Import from index.ts
import { Button } from '@/features/auth'
```

❌ **God features** (too much responsibility)
```typescript
// features/product/ containing search, filters, cart, etc.
// Solution: Split into focused features
```

❌ **Premature abstraction to shared/**
```typescript
// Extracting to shared/ after 1st use
// Solution: Wait until 3rd use, favor duplication
```
