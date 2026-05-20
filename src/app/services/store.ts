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
    console.log('Producto añadido');
  }
}
