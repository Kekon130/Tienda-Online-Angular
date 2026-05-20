import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Store } from '../../services/store';

@Component({
  selector: 'app-admin-panel',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './admin-panel.html',
  styleUrl: './admin-panel.css',
})
export class AdminPanel {
  store = inject(Store);
  activeTab: 'category' | 'product' = 'category';

  categoryName = '';

  productName = '';
  productDescription = '';
  productPrice = 0;
  productStock = 0;
  productImage = '';
  productCode = '';
  productCategoryId = '';

  submitCategory() {
    if (!this.categoryName.trim()) {
      this.store.showToast('El nombre de la categoría es obligatorio', 'danger');
      return;
    }
    this.store.createCategory(this.categoryName.trim());
    this.categoryName = '';
  }

  submitProduct() {
    if (!this.productCategoryId) {
      this.store.showToast('Selecciona una categoría', 'danger');
      return;
    }
    if (!this.productName.trim()) {
      this.store.showToast('El nombre del producto es obligatorio', 'danger');
      return;
    }
    this.store.createProduct(this.productCategoryId, {
      name: this.productName.trim(),
      description: this.productDescription.trim(),
      price: this.productPrice,
      stock: this.productStock,
      image: this.productImage.trim(),
      code: this.productCode.trim(),
    });
    this.productName = '';
    this.productDescription = '';
    this.productPrice = 0;
    this.productStock = 0;
    this.productImage = '';
    this.productCode = '';
    this.productCategoryId = '';
  }
}
