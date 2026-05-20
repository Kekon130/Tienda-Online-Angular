# Tienda Online Angular

An e-commerce single-page application built with Angular 21, Bootstrap 5, and PostgREST. Products are served from a PostgreSQL database through an auto-generated REST API, with no custom backend code required.

## Architecture

```
┌────────────┐     ┌────────────┐     ┌────────────┐
│  Angular   │────▶│  PostgREST │────▶│ PostgreSQL │
│  (nginx)   │     │  REST API  │     │   shop_db  │
│  :4200     │     │  :3000     │     │   :5432    │
└────────────┘     └────────────┘     └────────────┘
                         │
                   ┌─────┴──────┐
                   │ Swagger UI │
                   │   :8080    │
                   └────────────┘
```

| Service        | Port | Description                                      |
|----------------|------|--------------------------------------------------|
| Angular App    | 4200 | Frontend SPA served by nginx                     |
| PostgREST      | 3000 | Auto-generated REST API from the database schema |
| PostgreSQL     | 5432 | Database with seeded product catalog             |
| Swagger UI     | 8080 | Interactive API documentation                    |

## Getting Started

### With Docker (recommended)

```bash
docker compose up --build
```

Open `http://localhost:4200` in your browser.

### Local Development

Prerequisites: Node.js 22+, pnpm

```bash
# Start the backend services
docker compose up db server

# Install dependencies and start the dev server
pnpm install
pnpm start
```

The dev server runs on `http://localhost:4200` and proxies API calls to `http://localhost:3000`.

## Project Structure

```
src/app/
├── components/         # UI components
├── models/             # TypeScript interfaces
├── services/           # API and state management
└── environments/       # Per-environment configuration
db/
└── init.sql            # Database schema and seed data
```

## Components

### App (`app.ts`)
Root component. Bootstraps the application, fetches the product inventory on init, and composes the top-level layout: header, cart, admin modal, toast container, and the product listing.

### Header (`components/header/`)
Sticky navigation bar with a gradient background. Contains the store logo, a cart button with a live item count badge, and an admin access button.

### Products (`components/products/`)
Displays all categories as a Bootstrap accordion. Each category section expands to show a responsive grid of product cards: 1 column on mobile, 2 on tablets, 3 on desktop.

### Product Card (`components/product-card/`)
Individual product display with image, name, description, code, price, and stock status. Includes an "Add to cart" button that is disabled when stock is zero. Cards have a hover elevation effect and reduced opacity when out of stock.

### Cart (`components/cart/`)
Off-canvas sidebar showing cart items with quantity controls, per-item subtotals, and a running total. Includes three actions:
- **Add/Remove** — Adjust quantities per item (stock is tracked in real time)
- **Realizar Pedido** — Checkout (clears the cart)
- **Vaciar Carrito** — Empties the cart and returns all quantities to inventory

### Admin Modal (`components/admin-modal/`)
Bootstrap modal that wraps the admin login and admin panel. Opened by the shield button in the header.

### Admin Login (`components/admin-login/`)
Password form for admin access. Default password: `123456`. Hidden once authenticated.

### Admin Panel (`components/admin-panel/`)
Tabbed interface (visible after login) with two forms:
- **Nueva Categoria** — Create a category by name
- **Nuevo Producto** — Create a product with category, name, code, description, price, stock, and image URL

### Toast Container (`components/toast-container/`)
Notification system that displays success/error messages at the top of the page. Toasts auto-dismiss after 3 seconds with a slide-down animation.

## Services

### Store (`services/store.ts`)
Central state management using Angular signals. Manages:
- `categories` — Product catalog organized by category
- `cart` — Shopping cart items with quantities
- `adminLogged` — Admin authentication state
- `toasts` — Active toast notifications

Key methods: `addToCart()`, `removeFromCart()`, `emptyCart()`, `checkout()`, `createCategory()`, `createProduct()`, `login()`, `showToast()`.

### API (`services/api.ts`)
HTTP client that fetches categories and products from PostgREST. Uses Angular's `HttpClient` with `firstValueFrom` to convert observables to promises. The base URL is configured per environment (`localhost:3000` in dev, `/api` in production behind nginx).

## Models

| Model      | Fields                                                    |
|------------|-----------------------------------------------------------|
| `Product`  | id, name, description, price, stock, image, code          |
| `Category` | id, name, products                                        |
| `CartItem` | product, quantity                                         |
| `Toast`    | id, message, type                                         |

## Database

PostgreSQL with a `shop` schema containing two tables:

- **categories** — 5 seeded categories: Ropa, Calzado, Accesorios, Electronica, Hogar
- **products** — 36 seeded products with prices, stock levels, and Unsplash images

Access is managed through PostgREST roles:
- `web_anon` — Read-only anonymous access
- `authenticator` — Full-privilege login role

## Tech Stack

- **Frontend:** Angular 21 (standalone components, signals, built-in control flow)
- **UI:** Bootstrap 5.3, Bootstrap Icons
- **API:** PostgREST 14 (auto-generated REST from PostgreSQL)
- **Database:** PostgreSQL 18
- **Containerization:** Docker Compose with 4 services
- **Web Server:** nginx (production)
