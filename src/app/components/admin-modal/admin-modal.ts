import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { AdminLogin } from '../admin-login/admin-login';
import { AdminPanel } from '../admin-panel/admin-panel';

@Component({
  selector: 'app-admin-modal',
  standalone: true,
  imports: [CommonModule, AdminLogin, AdminPanel],
  templateUrl: './admin-modal.html',
  styleUrl: './admin-modal.css',
})
export class AdminModal {}
