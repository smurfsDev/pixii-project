import { Routes } from '@angular/router';
import { ClaimsComponent } from './pages/claims/claims.component';
import { HomeComponent } from './pages/home/home.component';
export const AppRoutes: Routes = [
	{ path: '', component: HomeComponent },
	{ path: 'claims', component: ClaimsComponent },
];