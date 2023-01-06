import { Component, AfterViewInit ,OnInit } from '@angular/core';
import { Geolocation } from '@ionic-native/geolocation/ngx';

import * as L from 'leaflet';

@Component({
  selector: 'app-map-dashboard',
  templateUrl: './map-dashboard.component.html',
  styleUrls: ['./map-dashboard.component.scss']
})
export class MapDashboardComponent implements AfterViewInit{
  private map!: L.Map;
  constructor(private geolocation: Geolocation) { }
  myPositionIcon = L.icon({
    iconUrl: '../../../assets/location.png',
    iconSize: [40, 40],
  });
  myIcon = L.icon({
    iconUrl: '../../../assets/moto.png',
    iconSize: [40, 40],
  });

  private initMap(): void {

    this.map = L.map('map', {
      center: [ 39.8282, 20 ],
      zoom: 3
    });

    const tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18,
      minZoom: 3,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    });

    // const circle = L.circle([ 39.8282, -98.5795 ], {
    //   color: 'red',
    //   fillColor: '#f03',
    //   fillOpacity: 0.5,
    //   radius: 500
    // }).addTo(this.map);
    tiles.addTo(this.map);
  }

  MyPosition() {
    this.map?.locate({setView: true, maxZoom: 16});
    //   navigator.geolocation.getCurrentPosition((position) => {
    //     const marker = L.marker([position.coords.latitude, position.coords.longitude], {icon: this.myPositionIcon}).addTo(this.map);
    //     marker.bindPopup("You are here").openPopup();
    //   }
    // );
    this.geolocation.getCurrentPosition().then((resp) => {
      const marker = L.marker([resp.coords.latitude, resp.coords.longitude], {icon: this.myPositionIcon}).addTo(this.map);
      marker.bindPopup("You are here").openPopup();
    }).catch((error) => {
    });

  }
  BikePosition() {
    var bikePosition = L.latLng(36.23412, 9);
    this.map?.setView(bikePosition, 16);
    const marker = L.marker(bikePosition, {icon: this.myIcon}).addTo(this.map);
    marker.bindPopup("Bike is here").openPopup();
  }
  CenterMap() {
    // navigator.geolocation.getCurrentPosition((position) => {
    //    var myPosition = L.latLng(position.coords.latitude, position.coords.longitude);
    //    L.marker(myPosition, {icon: this.myPositionIcon}).addTo(this.map);
    //    var bikePosition = L.latLng(36.23412, 9);
    //     L.marker(bikePosition, {icon: this.myIcon}).addTo(this.map);
    //    var bounds = L.latLngBounds(myPosition, bikePosition);
    //    this.map?.fitBounds(bounds,{maxZoom:16});
    // });
    this.geolocation.getCurrentPosition().then((resp) => {
      var myPosition = L.latLng(resp.coords.latitude, resp.coords.longitude);
      L.marker(myPosition, {icon: this.myPositionIcon}).addTo(this.map);
      var bikePosition = L.latLng(36.23412, 9);
      L.marker(bikePosition, {icon: this.myIcon}).addTo(this.map);
      var bounds = L.latLngBounds(myPosition, bikePosition);
      this.map?.fitBounds(bounds,{maxZoom:16});
    }
    ).catch((error) => {
    });
  }

  ngAfterViewInit(): void {
    this.initMap();
  }

}
