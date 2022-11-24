import { Routes } from '@angular/router';
import { ClaimsComponent } from './pages/claims/claims.component';
import { LoginComponent } from './pages/account/login/login.component';
import { RegisterComponent } from './pages/account/register/register.component';
import { HomeComponent } from './pages/home/home.component';
import { AuthComponent } from './pages/account/auth/auth.component';
import { VerifyEmailComponent } from './pages/account/verify-email/verify-email.component';
import { IsAuthenticatedGuard } from './is-authenticated.guard';
export const AppRoutes: Routes = [
  {
    path: '',
    component: HomeComponent,
    // canActivate: [IsAuthenticatedGuard]
  },
  {
    path: 'claims',
    component: ClaimsComponent,
    canActivate: [IsAuthenticatedGuard]

  },
  {
    path: 'login',
    component: LoginComponent,


  },
  {
    path: 'register',
    component: RegisterComponent,


  },
  {
    path: 'auth',
    component: AuthComponent,


  },
  {
    path: 'verify',
    component: VerifyEmailComponent,
    canActivate: [IsAuthenticatedGuard]

  },
];
