import { Injectable } from '@angular/core';

import { Category } from '../models/category';
import { CartItem } from '../models/cart-item';
import { Toast } from '../models/toast';
import { Product } from '../models/product';

@Injectable({
  providedIn: 'root',
})
export class Store {
  categories: Category[] = [];
  cart: CartItem[] = [];
  adminLogged: boolean = false;
  toasts: Toast[] = [];

  getTotalItems(): number {
    return this.cart.reduce((sum: number, item: CartItem) => sum + item.quantity, 0);
  }

  showToast(message: string, type: string = 'success') {
    const toast: Toast = {
      id: Date.now(),
      message,
      type,
    };

    this.toasts.push(toast);
    setTimeout(() => {
      this.toasts = this.toasts.filter((t) => t.id !== toast.id);
    }, 3000);
  }

  addToCart(productId: string) {
    console.log('Producto añadido');
  }
}
