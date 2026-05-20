import { Component, inject, OnInit, signal } from '@angular/core';
import { RouterModule } from '@angular/router';

import { Header } from './components/header/header';
import { Products } from './components/products/products';
import { ToastContainer } from './components/toast-container/toast-container';
import { AdminModal } from './components/admin-modal/admin-modal';
import { Api } from './services/api';
import { Store } from './services/store';
import { Category } from './models/category';
import { Cart } from './components/cart/cart';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterModule, Header, Products, ToastContainer, Cart, AdminModal],
  templateUrl: './app.html',
  styleUrl: './app.css',
})
export class App implements OnInit {
  protected readonly title = signal('angular-shop');

  private api = inject(Api);
  private store = inject(Store);

  ngOnInit(): void {
    this.api.fetchInventory().then((inventory: Category[]) => {
      this.store.categories.set(inventory);
    });
  }
}
