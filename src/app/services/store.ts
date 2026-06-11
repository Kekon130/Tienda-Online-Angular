import { Injectable, signal } from '@angular/core';

import { Category } from '../models/category';
import { CartItem } from '../models/cart-item';
import { Toast } from '../models/toast';
import { Product } from '../models/product';

@Injectable({
  providedIn: 'root',
})
export class Store {
  categories = signal<Category[]>([]);
  cart = signal<CartItem[]>([]);
  adminLogged = signal(false);
  toasts = signal<Toast[]>([]);
  darkMode = signal<boolean>(false);

  constructor() {
    // Restaura la preferencia de tema guardada y la aplica al documento.
    const stored = localStorage.getItem('theme');
    this.setTheme(stored === 'dark');
  }

  toggleTheme() {
    this.setTheme(!this.darkMode());
  }

  private setTheme(dark: boolean) {
    this.darkMode.set(dark);
    const theme = dark ? 'dark' : 'light';
    document.documentElement.setAttribute('data-bs-theme', theme);
    localStorage.setItem('theme', theme);
  }

  showToast(message: string, type: string = 'success') {
    const toast: Toast = {
      id: Date.now(),
      message,
      type,
    };

    this.toasts.update((t) => [...t, toast]);
    setTimeout(() => {
      this.toasts.update((t) => t.filter((item) => item.id !== toast.id));
    }, 3000);
  }

  addToCart(productId: string) {
    let selectedProduct: Product | null = null;

    this.categories.update((cats) =>
      cats.map((category) => ({
        ...category,
        products: category.products.map((product) => {
          if (product.id === productId && product.stock > 0) {
            selectedProduct = { ...product, stock: product.stock - 1 };
            return selectedProduct;
          }
          return product;
        }),
      })),
    );

    if (selectedProduct) {
      this.cart.update((cart) => {
        const existing = cart.find((item) => item.product.id === productId);
        if (existing) {
          return cart.map((item) =>
            item.product.id === productId
              ? { ...item, product: selectedProduct!, quantity: item.quantity + 1 }
              : item,
          );
        }
        return [...cart, { product: selectedProduct!, quantity: 1 }];
      });

      this.showToast('Producto Añadido a la Cesta', 'success');
    }
  }

  removeFromCart(productId: string) {
    const item = this.cart().find((item) => item.product.id === productId);

    if (item) {
      this.categories.update((cats) =>
        cats.map((category) => ({
          ...category,
          products: category.products.map((product) =>
            product.id === productId ? { ...product, stock: product.stock + 1 } : product,
          ),
        })),
      );

      this.cart.update((cart) =>
        item.quantity <= 1
          ? cart.filter((i) => i.product.id !== productId)
          : cart.map((i) =>
              i.product.id === productId ? { ...i, quantity: i.quantity - 1 } : i,
            ),
      );
    }
  }

  emptyCart() {
    if (this.cart().length === 0) {
      this.showToast('El Carrito está vacío', 'danger');
      return;
    }

    const items = this.cart();
    this.categories.update((cats) =>
      cats.map((cat) => ({
        ...cat,
        products: cat.products.map((product) => {
          const cartItem = items.find((i) => i.product.id === product.id);
          return cartItem ? { ...product, stock: product.stock + cartItem.quantity } : product;
        }),
      })),
    );
    this.cart.set([]);
    this.showToast('Carrito vaciado correctamente', 'success');
  }

  checkout() {
    if (this.cart().length === 0) {
      this.showToast('El Carrito está vacío', 'danger');
    } else {
      this.cart.set([]);
      this.showToast('Pedido realizado correctamente', 'success');
    }
  }

  login(password: string) {
    if (password !== '123456') {
      this.showToast('Contraseña Incorrecta', 'danger');
    } else {
      this.adminLogged.set(true);
      this.showToast('Acceso de Administrador Concedido', 'success');
    }
  }

  createCategory(name: string) {
    const id = crypto.randomUUID();
    this.categories.update((cats) => [...cats, { id, name, products: [] }]);
    this.showToast('Categoría creada correctamente', 'success');
  }

  createProduct(categoryId: string, product: Omit<Product, 'id'>) {
    const id = crypto.randomUUID();
    // Aseguramos al menos una imagen para que la miniatura/hover funcionen.
    const images = product.images?.length
      ? product.images
      : ['https://placehold.co/600x400?text=Sin+imagen'];
    const newProduct: Product = { ...product, id, images, image: images[0] };

    this.categories.update((cats) =>
      cats.map((cat) =>
        cat.id === categoryId ? { ...cat, products: [...cat.products, newProduct] } : cat,
      ),
    );
    this.showToast('Producto creado correctamente', 'success');
  }
}
