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
import { HttpInterceptorService } from './http-interceptor.service';
import { ChefComponent } from './pages/claims/chef/chef.component';
import { MgUsersComponent } from './pages/users/superAdmin/mg-users/mg-users.component';
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
	],

	declarations: [AppComponent, ClaimsComponent, NavbarComponent, HomeComponent, DetailsComponent, RegisterComponent, LoginComponent, AuthComponent, VerifyEmailComponent, ChefComponent, MgUsersComponent],
	providers: [
		{
			provide: HTTP_INTERCEPTORS,
			useClass: HttpInterceptorService,
			multi: true
		}
	],
	bootstrap: [AppComponent],
})
export class AppModule { }
