import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AppComponent } from './app.component';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { ClaimsComponent } from './pages/claims/claims.component';
import { RouterModule } from '@angular/router';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from './material/material.module';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavbarComponent } from './layout/navbar/navbar.component';
import { AppRoutes } from './app.routes';
import { HomeComponent } from './pages/home/home.component';
import { DetailsComponent } from './pages/claims/details/details.component';
import { RegisterComponent } from './pages/account/register/register.component';
import { LoginComponent } from './pages/account/login/login.component';
import { NgxsModule } from '@ngxs/store';
import { NgxsReduxDevtoolsPluginModule } from '@ngxs/devtools-plugin';
import { NgxsStoragePluginModule } from '@ngxs/storage-plugin';
import { AuthState } from './store/auth/stase';
import { AuthComponent } from './pages/account/auth/auth.component';
import { VerifyEmailComponent } from './pages/account/verify-email/verify-email.component';
import { ResetPasswordComponent } from './pages/account/reset-password/reset-password.component';
import { CheckemailComponent } from './pages/account/reset-password/checkemail/checkemail.component';
import { TopbarComponent } from './layout/topbar/topbar.component';
import { BatteryPercentageComponent } from './pages/home/percentage-bar/percentage-bar.component';
import { NgxEchartsModule } from 'ngx-echarts';
import { ChartBatteryUsageComponent } from './pages/home/chart-battery-usage/chart-battery-usage.component';
import { BatteryComponent } from './pages/home/battery/battery.component';

import { HttpInterceptorService } from './http-interceptor.service';
import { ChefComponent } from './pages/claims/chef/chef.component';

import { MgUsersComponent } from './pages/users/superAdmin/mg-users/mg-users.component';

import { ResendVerificationComponent } from './pages/account/resend-verification/resend-verification.component';
import { UserComponent } from './pages/claims/user/user.component';
import { MapDashboardComponent } from './pages/home/map-dashboard/map-dashboard.component';
import { ControlPannelComponent } from './pages/home/control-pannel/control-pannel.component';
import { Geolocation } from '@ionic-native/geolocation/ngx';
import { DashSuperAdminComponent } from './pages/home/dash-super-admin/dash-super-admin.component';
import { DashAdminComponent } from './pages/home/dash-admin/dash-admin.component';
import { DashSaVManagerComponent } from './pages/home/dash-sa-vmanager/dash-sa-vmanager.component';
import { DashSaVTechnicienComponent } from './pages/home/dash-sa-vtechnicien/dash-sa-vtechnicien.component';
import { DashScooterOwnerComponent } from './pages/home/dash-scooter-owner/dash-scooter-owner.component';

@NgModule({
	imports: [
    NgxsModule.forRoot([AuthState]),
		NgxsStoragePluginModule.forRoot(),
		BrowserModule,
		RouterModule.forRoot(AppRoutes),
		NgxsReduxDevtoolsPluginModule.forRoot(),
		FormsModule, DragDropModule, HttpClientModule,
		BrowserAnimationsModule,
		MaterialModule,
		ReactiveFormsModule,
		NgxEchartsModule.forRoot({
      echarts: () => import('echarts')
    }),
	],

	declarations: [AppComponent, ClaimsComponent, NavbarComponent, HomeComponent, DetailsComponent, RegisterComponent, LoginComponent, AuthComponent, VerifyEmailComponent, ChefComponent, ResendVerificationComponent, TopbarComponent, BatteryPercentageComponent, ChartBatteryUsageComponent, BatteryComponent,ResetPasswordComponent, CheckemailComponent, UserComponent, MgUsersComponent, MapDashboardComponent, ControlPannelComponent, DashSuperAdminComponent, DashAdminComponent, DashSaVManagerComponent, DashSaVTechnicienComponent, DashScooterOwnerComponent],
	providers: [
		{
			provide: HTTP_INTERCEPTORS,
			useClass: HttpInterceptorService,
			multi: true
		},
    Geolocation
	],
	bootstrap: [AppComponent],
})
export class AppModule { }
