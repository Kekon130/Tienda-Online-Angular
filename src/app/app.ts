import { Component, inject, signal, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';

import { Header } from './components/header/header';
import { Products } from './components/products/products';
import { ToastContainer } from './components/toast-container/toast-container';
import { Api } from './services/api';
import { Store } from './services/store';
import { Category } from './models/category';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterModule, Header, Products, ToastContainer],
  templateUrl: './app.html',
  // styleUrl: './app.css',
})
export class App implements OnInit {
  protected readonly title = signal('angular-shop');

  private api = inject(Api);
  private store = inject(Store);

  ngOnInit(): void {
    this.api.fetchInventory().then((inventory: Category[]) => {
      this.store.categories = inventory;
    });
    console.log(this.store.categories);
  }
}
