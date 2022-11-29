import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
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
import { TopbarComponent } from './layout/topbar/topbar.component';
// import { BatteryPercentageComponent } from './percentage-bar/percentage-bar.component';
import { BatteryPercentageComponent } from './pages/home/percentage-bar/percentage-bar.component';
import { NgxEchartsModule } from 'ngx-echarts';
// import { NgApexchartsModule } from "ng-apexcharts";

// import { ChartBatteryUsageComponent } from './chart-battery-usage/chart-battery-usage.component';
import { ChartBatteryUsageComponent } from './pages/home/chart-battery-usage/chart-battery-usage.component';

@NgModule({
  imports: [
    BrowserModule,
    RouterModule.forRoot(AppRoutes),
    NgxsModule.forRoot([AuthState]),
    NgxsReduxDevtoolsPluginModule.forRoot(),
    NgxsStoragePluginModule.forRoot(),
    FormsModule, DragDropModule, HttpClientModule,
    BrowserAnimationsModule,
    MaterialModule,
    ReactiveFormsModule,
    // NgApexchartsModule,
    NgxEchartsModule.forRoot({
      echarts: () => import('echarts')
    })
  ],

  declarations: [AppComponent, ClaimsComponent, NavbarComponent, HomeComponent, DetailsComponent, RegisterComponent, LoginComponent, AuthComponent, VerifyEmailComponent, TopbarComponent, BatteryPercentageComponent, ChartBatteryUsageComponent],
  bootstrap: [AppComponent],
})
export class AppModule { }
