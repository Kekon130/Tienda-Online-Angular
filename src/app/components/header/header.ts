import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';

import { Store } from '../../services/store';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './header.html',
})
export class Header {
  store = inject(Store);
}
