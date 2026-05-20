import { Component, inject } from '@angular/core';
import { ProductCard } from '../product-card/product-card';
import { Store } from '../../services/store';

@Component({
  selector: 'app-products',
  imports: [ProductCard],
  templateUrl: './products.html',
  styleUrl: './products.css',
})
export class Products {
  store: Store = inject(Store);
}
