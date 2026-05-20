import { DecimalPipe } from '@angular/common';
import { Component, computed, inject } from '@angular/core';
import { Store } from '../../services/store';

@Component({
  selector: 'app-cart',
  imports: [DecimalPipe],
  templateUrl: './cart.html',
  styleUrl: './cart.css',
})
export class Cart {
  store = inject(Store);

  total = computed(() =>
    this.store.cart().reduce((sum, item) => sum + item.product.price * item.quantity, 0),
  );
}
