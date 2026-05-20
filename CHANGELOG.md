# Changelog

## [1.0.0] - 2026-05-20

### Added

- **Admin Panel** — Tabbed interface inside the admin modal with two forms:
  - Create Category: name input with validation
  - Create Product: category selector, name, code, description, price, stock, and image URL
- **Empty Cart** — "Vaciar Carrito" button that returns all product quantities back to inventory before clearing the cart
- **Store methods** — `createCategory()`, `createProduct()`, and `emptyCart()` in the Store service
- **Docker support** — Multi-stage Dockerfile (Node build + nginx serve), `.dockerignore`, and `nginx.conf` with API proxy and SPA routing
- **Angular app service** in `docker-compose.yaml` — builds and serves the frontend on port 4200
- **Environment files** — `environment.ts` (dev: `localhost:3000`) and `environment.production.ts` (prod: `/api` via nginx proxy)
- **Global styles** — CSS custom properties, light background, smooth scrollbar, card/button transitions
- **Product card hover effects** — Elevation and shadow animation on hover, disabled for out-of-stock items
- **Header redesign** — Gradient background with white icons and improved mobile spacing
- **Toast animations** — Slide-down entrance animation, responsive width (`min(400px, 90vw)`)
- **Accordion styling** — Blue-tinted active headers, subtle focus ring
- **Cart responsive layout** — Stacked layout on mobile, capped offcanvas width

### Changed

- **Migrated to Angular signals** — All Store properties (`categories`, `cart`, `toasts`, `adminLogged`) converted from plain values to signals; all reads use `()`, all writes use `.set()` / `.update()`
- **Migrated to built-in control flow** — Replaced all deprecated `*ngFor`, `*ngIf`, and `[ngClass]` directives with `@for`, `@if`, and `[class]` syntax across all templates
- **Removed CommonModule** — Cleaned up imports from components that no longer need it; `product-card` and `cart` now import only `DecimalPipe`
- **Product grid responsiveness** — Products display 1 per row (mobile), 2 per row (tablet `md`), 3 per row (desktop `lg`)
- **API service** — Uses `environment.apiUrl` instead of hardcoded `http://localhost:3000`
- **angular.json** — Added production `fileReplacements` for environment swap, raised budget limits
- **Admin modal** — Added `<app-admin-modal>` to the app template (was missing, causing the admin button to not work)

### Fixed

- **Components not rendering** — Angular 21 is zoneless by default; plain properties weren't triggering change detection. Fixed by converting to signals.
- **Admin modal not opening** — `AdminModal` component was never included in the app's component tree
- **`removeFromCart` bug** — Post-increment/decrement operators (`stock++`, `quantity--`) returned old values; replaced with proper immutable arithmetic
- **Product card CSS** — Fixed quoted values in `height: '240px'` that made the rule invalid
