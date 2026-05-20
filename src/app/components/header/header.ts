import { Component, inject } from '@angular/core';

import { Store } from '../../services/store';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [],
  templateUrl: './header.html',
  styleUrl: './header.css',
})
export class Header {
  store = inject(Store);
}
