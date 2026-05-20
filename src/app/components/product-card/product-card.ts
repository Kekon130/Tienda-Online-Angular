import { DecimalPipe } from '@angular/common';
import { Component, inject, Input } from '@angular/core';
import { Store } from '../../services/store';
import { Product } from '../../models/product';

@Component({
  selector: 'app-product-card',
  imports: [DecimalPipe],
  templateUrl: './product-card.html',
  styleUrl: './product-card.css',
})
export class ProductCard {
  @Input() product!: Product;
  store = inject(Store);
}
