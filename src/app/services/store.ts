import { Injectable } from '@angular/core';

import { Category } from '../models/category';
import { CartItem } from '../models/cart-item';
import { Toast } from '../models/toast';

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
}
