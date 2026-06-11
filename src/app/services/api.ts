import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { Product } from '../models/product';
import { Category } from '../models/category';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class Api {
  private http = inject(HttpClient);
  private API = environment.apiUrl;

  private getCategories(): Promise<Category[]> {
    return firstValueFrom(this.http.get<any[]>(`${this.API}/categories`));
  }

  private async getProducts(category_id: string): Promise<Product[]> {
    const rows = await firstValueFrom(
      this.http.get<any[]>(
        `${this.API}/products?select=*,product_images(image_url,is_primary)&category_id=eq.${category_id}`,
      ),
    );
    return rows.map((row) => this.mapProduct(row));
  }

  // Construye un Product a partir de la fila de PostgREST, ordenando las
  // imágenes con la primaria (is_primary) en primer lugar.
  private mapProduct(row: any): Product {
    const images: string[] = (row.product_images ?? [])
      .slice()
      .sort((a: any, b: any) => Number(b.is_primary) - Number(a.is_primary))
      .map((img: any) => img.image_url);

    const PLACEHOLDER = 'https://placehold.co/600x400?text=Sin+imagen';
    const list = images.length > 0 ? images : [PLACEHOLDER];

    return {
      id: row.id,
      name: row.name,
      description: row.description,
      price: row.price,
      stock: row.stock,
      code: row.code,
      images: list,
      image: list[0],
    };
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
