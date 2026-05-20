import { Component, inject } from '@angular/core';
import { Store } from '../../services/store';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-cart',
  imports: [CommonModule],
  templateUrl: './cart.html',
  styleUrl: './cart.css',
})
export class Cart {
  store = inject(Store);
}
