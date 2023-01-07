import { Routes } from '@angular/router';
import { ClaimsComponent } from './pages/claims/claims.component';
import { HomeComponent } from './pages/home/home.component';
import { AuthComponent } from './pages/account/auth/auth.component';
import { VerifyEmailComponent } from './pages/account/verify-email/verify-email.component';
import { ResetPasswordComponent } from './pages/account/reset-password/reset-password.component';
import { CheckemailComponent } from './pages/account/reset-password/checkemail/checkemail.component';
import { IsAuthenticatedGuard } from './guards/is-authenticated.guard';
import { ChefComponent } from './pages/claims/chef/chef.component';

import { MgUsersComponent } from './pages/users/superAdmin/mg-users/mg-users.component';
import { HasRoleGuard } from './guards/has-role.guard';

import { ResendVerificationComponent } from './pages/account/resend-verification/resend-verification.component';
import { UserComponent } from './pages/claims/user/user.component';

export const AppRoutes: Routes = [
	{
		path: '',
		component: HomeComponent,
		canActivate: [IsAuthenticatedGuard],
	},
	{
		path: 'claims',
		component: ClaimsComponent,
		canActivate: [IsAuthenticatedGuard, HasRoleGuard],
		data: {
			role:
				[
					'SAV Manager', 'SAV Technician', 'Super Admin'
				]
		}

	},
	{
		path: 'chef',
		component: ChefComponent,
		canActivate: [IsAuthenticatedGuard, HasRoleGuard],
		data: {
			role:
				[
					'SAV Manager', 'Super Admin'
				]
		}
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
		path: 'manageUsers',
		component: MgUsersComponent,
		canActivate: [IsAuthenticatedGuard, HasRoleGuard],
		data: {
			role:
				[
					'Super Admin', 'Admin'
				]
		}
	},
	{
		path: 'resend-verification',
		component: ResendVerificationComponent,
	},
	{ path: 'reset-password', component: ResetPasswordComponent },
	{ path: 'checkemail', component: CheckemailComponent },
	{
		path: 'myclaims', component: UserComponent,
		canActivate: [IsAuthenticatedGuard, HasRoleGuard],
		data: {
			role:
				[
					'Scooter Owner'
				]
		}
	},


];
