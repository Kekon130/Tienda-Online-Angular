import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { Product } from '../models/product';
import { Category } from '../models/category';

@Injectable({
  providedIn: 'root',
})
export class Api {
  private http = inject(HttpClient);
  private API = 'http://localhost:3000';

  private getCategories(): Promise<Category[]> {
    return firstValueFrom(this.http.get<any[]>(`${this.API}/categories`));
  }

  private getProducts(category_id: string): Promise<Product[]> {
    return firstValueFrom(
      this.http.get<Product[]>(`${this.API}/products?category_id=eq.${category_id}`),
    );
  }

  async fetchInventory(): Promise<Category[]> {
    try {
      const categories = await this.getCategories();
      const inventory = await Promise.all(
        categories.map(async (category: Category) => {
          const products = await this.getProducts(category.id);
          return {
            ...category,
            products,
          };
        }),
      );
      console.log(inventory);

      return inventory;
    } catch (error) {
      throw new Error('Error al cargar el inventario');
    }
  }
}
