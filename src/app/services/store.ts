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

  getTotalItems(): number {
    return this.cart().reduce((sum: number, item: CartItem) => sum + item.quantity, 0);
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

    this.categories.forEach((category: Category) => {
      category.products.forEach((product: Product) => {
        if (product.id === productId) {
          if (product.stock > 0) {
            product.stock--;
            selectedProduct = product;
          }
        }
      });
    });

    if (selectedProduct) {
      const item = this.cart.find((item: CartItem) => {
        return item.product.id === productId;
      });

      if (item) {
        item.quantity++;
      } else {
        this.cart.push({
          product: selectedProduct,
          quantity: 1,
        });
      }

      this.showToast('Producto Añadido a la Cesta', 'success');
    }
  }

  removeFromCart(productId: string) {
    const item = this.cart.find((item: CartItem) => {
      return item.product.id === productId;
    });

    if (item) {
      const updatedProduct: Product = {
        ...item.product,
        stock: item.product.stock++,
      };

      this.cart =
        item.quantity <= 1
          ? this.cart.filter((i: CartItem) => i.product.id !== productId)
          : this.cart.map((i: CartItem) =>
              i.product.id === productId ? { ...i, product: i.product, quantity: i.quantity-- } : i,
            );

      this.categories = this.categories.map((category: Category) => ({
        ...category,
        products: category.products.map((product: Product) =>
          product.id === productId ? updatedProduct : product,
        ),
      }));
    }
  }

  checkout() {
    if (this.cart.length === 0) {
      this.showToast('El Carrito está vacío', 'danger');
    } else {
      this.cart = [];
      this.showToast('Pedido realizado correctamente', 'success');
    }
  }
}
