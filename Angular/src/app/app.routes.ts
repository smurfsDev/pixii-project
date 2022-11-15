import { Routes } from '@angular/router';
import { ClaimsComponent } from './pages/claims/claims.component';
import { LoginComponent } from './pages/account/login/login.component';
import { RegisterComponent } from './pages/account/register/register.component';
import { HomeComponent } from './pages/home/home.component';

export const AppRoutes: Routes = [
	{ path: '', component: HomeComponent },
	{ path: 'claims', component: ClaimsComponent },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
];
