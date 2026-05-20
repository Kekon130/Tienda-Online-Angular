import { Component, inject } from '@angular/core';
import { Toast } from '../../models/toast';
import { Store } from '../../services/store';

@Component({
  selector: 'app-toast-container',
  imports: [],
  templateUrl: './toast-container.html',
  styleUrl: './toast-container.css',
})
export class ToastContainer {
  store = inject(Store);

  get toasts(): Toast[] {
    return this.store.toasts();
  }

  private escapeHtml(text: string): string {
    return text
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  renderToasts(): string {
    return this.store.toasts()
      .map((toast: Toast) => {
        return `
				<div id="${toast.id}" class="toast show text-bg-${toast.type} border-0 mb-2 toast-message">
					<div class="toast-body fs-5 fw-semibold text-center py-3">
						${this.escapeHtml(toast.message)}
					</div>
				</div>
			`;
      })
      .join('');
  }
}
