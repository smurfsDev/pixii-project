import { Component, AfterViewInit, OnInit } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Geolocation } from '@ionic-native/geolocation/ngx';
import { Store } from '@ngxs/store';

import * as L from 'leaflet';
import { Bike } from 'src/app/models/bike.model';
import { BikeDataService } from 'src/app/service/bike/bike-data.service';
import { ClaimsService } from 'src/app/service/claims/claims.service';

@Component({
	selector: 'app-map-dashboard',
	templateUrl: './map-dashboard.component.html',
	styleUrls: ['./map-dashboard.component.scss']
})
export class MapDashboardComponent implements AfterViewInit {
	private map!: L.Map;
	constructor(private geolocation: Geolocation, private claimService: ClaimsService, private _snackBar: MatSnackBar, private bikeService: BikeDataService, private store: Store) { }
	myPositionIcon = L.icon({
		iconUrl: '../../../assets/location.png',
		iconSize: [40, 40],
	});
	myIcon = L.icon({
		iconUrl: '../../../assets/moto.png',
		iconSize: [40, 40],
	});

	myPosition!: L.LatLng;
	myBike!: L.LatLng;
	private initMap(): void {

		this.map = L.map('map', {
			center: [39.8282, 20],
			zoom: 3
		});

		const tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
			maxZoom: 18,
			minZoom: 3,
			attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
		});
		tiles.addTo(this.map);
		var authState = this.store.selectSnapshot(state => state.AuthState);

		this.bikeService.getMyBikeData(
			authState["isScooterOwner"].scooterId
		).subscribe((data: Bike) => {
			this.BikeData = data;
			this.BikePosition();
		});
	}

	MyPosition() {
		if (!this.myPosition) {
		this.map?.locate({ setView: true, maxZoom: 16 });
		this.geolocation.getCurrentPosition().then((resp) => {
			this.myPosition = L.latLng(resp.coords.latitude, resp.coords.longitude);
			const marker = L.marker([resp.coords.latitude, resp.coords.longitude], { icon: this.myPositionIcon }).addTo(this.map);
			marker.bindPopup("You are here").openPopup();
		}).catch((error) => {
		});
		}else{
			this.map?.setView(this.myPosition, 16);
		}

	}
	BikePosition() {
		if (this.BikeData) {
			var bikePosition = L.latLng(
				this.BikeData.location.latitude,
				this.BikeData.location.longitude
			);
			this.myBike = bikePosition;
			this.map?.setView(bikePosition, 16);
			const marker = L.marker(bikePosition, { icon: this.myIcon }).addTo(this.map);
			marker.bindPopup("Bike is here").openPopup();
		}
	}
	CenterMap() {
		if (this.myPosition && this.myBike) {
			var bounds = L.latLngBounds(this.myPosition, this.myBike);
			this.map?.fitBounds(bounds, { maxZoom: 16 });
		} else {

			this.geolocation.getCurrentPosition().then((resp) => {
				this.myPosition = L.latLng(resp.coords.latitude, resp.coords.longitude);
				L.marker(this.myPosition, { icon: this.myPositionIcon }).addTo(this.map);
				var bikePosition = L.latLng(
					this.BikeData?.location.latitude ?? 0,
					this.BikeData?.location.longitude ?? 0
				);
				L.marker(bikePosition, { icon: this.myIcon }).addTo(this.map);
				var bounds = L.latLngBounds(this.myPosition, bikePosition);
				this.map?.fitBounds(bounds, { maxZoom: 16 });
			}
			).catch((error) => {
			});
		}

	}
	BikeData: Bike | undefined;

	ngAfterViewInit(): void {
		this.initMap();
	}

}
