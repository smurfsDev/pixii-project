import { Routes } from '@angular/router';
import { ClaimsComponent } from './pages/claims/claims.component';
import { LoginComponent } from './pages/account/login/login.component';
import { RegisterComponent } from './pages/account/register/register.component';
import { HomeComponent } from './pages/home/home.component';
import { AuthComponent } from './pages/account/auth/auth.component';
import { VerifyEmailComponent } from './pages/account/verify-email/verify-email.component';
import { ResetPasswordComponent } from './pages/account/reset-password/reset-password.component';
import { CheckemailComponent } from './pages/account/reset-password/checkemail/checkemail.component';
import { IsAuthenticatedGuard } from './is-authenticated.guard';
import { ChefComponent } from './pages/claims/chef/chef.component';
import { ResendVerificationComponent } from './pages/account/resend-verification/resend-verification.component';
import { UserComponent } from './pages/claims/user/user.component';
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
	path: 'chef',
	component: ChefComponent,
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
    // canActivate: [IsAuthenticatedGuard]

  },
  {
	path: 'resend-verification',
	component: ResendVerificationComponent,
  },
  { path: 'reset-password', component: ResetPasswordComponent },
  { path: 'checkemail', component: CheckemailComponent },
  { path: 'myclaims', component: UserComponent },

];
