import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AppComponent } from './app.component';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { ClaimsComponent } from './pages/claims/claims.component';
import { RouterModule } from '@angular/router';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from './material/material.module';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavbarComponent } from './layout/navbar/navbar.component';
@NgModule({
	imports: [BrowserModule, FormsModule, DragDropModule, HttpClientModule,
		RouterModule.forRoot([
			{ path: 'claims', component: ClaimsComponent },
		]),
  BrowserAnimationsModule,
  MaterialModule,
  
	],
	declarations: [AppComponent, ClaimsComponent, NavbarComponent],
	bootstrap: [AppComponent]
})
export class AppModule { }
