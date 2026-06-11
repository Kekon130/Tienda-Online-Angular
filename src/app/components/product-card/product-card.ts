import { DecimalPipe } from '@angular/common';
import { Component, inject, Input, OnDestroy, signal } from '@angular/core';
import { Store } from '../../services/store';
import { Product } from '../../models/product';

@Component({
  selector: 'app-product-card',
  imports: [DecimalPipe],
  templateUrl: './product-card.html',
  styleUrl: './product-card.css',
})
export class ProductCard implements OnDestroy {
  @Input() product!: Product;
  store = inject(Store);

  // Índice de la imagen mostrada e indicador de hover para el efecto de zoom.
  currentIndex = signal(0);
  hovering = signal(false);

  private cycleTimer?: ReturnType<typeof setInterval>;

  // Imagen actualmente visible (cae a la primaria si no hay galería).
  get currentImage(): string {
    return this.product.images?.[this.currentIndex()] ?? this.product.image;
  }

  // Al entrar el ratón: marcamos hover y, si hay varias imágenes, las rotamos.
  onMouseEnter() {
    this.hovering.set(true);
    if ((this.product.images?.length ?? 0) > 1) {
      this.cycleTimer = setInterval(() => {
        this.currentIndex.update((i) => (i + 1) % this.product.images.length);
      }, 1000);
    }
  }

  // Al salir el ratón: detenemos la rotación y volvemos a la miniatura.
  onMouseLeave() {
    this.hovering.set(false);
    this.stopCycle();
    this.currentIndex.set(0);
  }

  private stopCycle() {
    if (this.cycleTimer) {
      clearInterval(this.cycleTimer);
      this.cycleTimer = undefined;
    }
  }

  ngOnDestroy(): void {
    this.stopCycle();
  }
}
