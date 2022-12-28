import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import {
  FormGroup,
  FormControl,
  Validators,
  FormBuilder,
} from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Title } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { checkPassword, checkPasswordPattern } from '../form-validators';
import { ProfileService } from '../../../service/account/profile.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  title = 'Profile';
  image!: string;
  imageform: FormGroup;
  profile: any;
  scooterform: FormGroup;
  profilemod: FormGroup;
  resetpassword: FormGroup;
  phoneform = new FormGroup({});
  isAddMode: boolean | undefined;
  loading = false;
  submitted = false;
  pdp = new FormControl();
  scootername = new FormControl('', [Validators.required]);
  name = new FormControl('', []);
  email = new FormControl('', [
    Validators.required,
    Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$'),
  ]);
  confirmemail = new FormControl('', [
    Validators.required,
    checkPassword('email'),
  ]);
  username = new FormControl('', []);

  oldpassword = new FormControl('', [
    Validators.required,
    Validators.minLength(8),
    Validators.maxLength(20),
    checkPasswordPattern('oldpassword'),
  ]);
  password = new FormControl('', [
    Validators.required,
    Validators.minLength(8),
    Validators.maxLength(20),
    Validators.pattern('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+$'),
    checkPassword('confirmpassword'),
  ]);
  confirmpassword = new FormControl('', [
    Validators.required,
    checkPassword('password'),
  ]);

  constructor(
    private router: Router,
    private http: HttpClient,
    private titleService: Title,
    private fb: FormBuilder,
    private ProfileService: ProfileService,
    private _snackBar: MatSnackBar
  ) {
    this.profilemod = this.fb.group({
      name: this.name,
      email: this.email,
      confirmemail: this.confirmemail,
      username: this.username,
    });
    this.resetpassword = this.fb.group({
      oldpassword: ['', Validators.required],
      password: ['', Validators.required],
      confirmpassword: ['', Validators.required],
    });
    this.scooterform = this.fb.group({
      scootername: this.scootername,
    });
    this.imageform = this.fb.group({
      pdp: this.pdp,
    });
  }

  ngOnInit() {
    this.titleService.setTitle(this.title);
    this.GetProfile();

    this.GetScooterName();
    this.getProfilePicture();
    this.GetProfile();
  }

  onFileChanged(event: any) {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      this.image = reader.result as string;
    };
  }

  uploadProfilePicture(event: any) {
    const file = event.target.files[0];
    const formData = new FormData();
    formData.append('file', file);
    this.ProfileService.uploadProfilePicture(formData).subscribe((response) => {
      console.log(response);
      this._snackBar.open('Profile Picture Updated', 'close', {
        duration: 2000,
      });
       this.getProfilePicture();
       this.GetProfile();
    });
  }

  GetProfile() {
    this.ProfileService.getProfile().subscribe((data: any) => {
      this.profile = data;
      this.profilemod.patchValue({
        name: this.profile.name,
        email: this.profile.email,
        username: this.profile.username,
        image: this.profile.image,
        created_at: this.profile.created_at,
      });
      console.log(this.profile);
    });
  }

  getProfilePicture() {
    this.ProfileService.getProfilePicture().subscribe((data: any) => {
      this.profile = data;
    });
  }

  GetScooterName() {
    this.ProfileService.getScooterName().subscribe((data: any) => {
      this.profile = data;
      this.scooterform.patchValue({
        scootername: this.profile.scootername,
      });
    });
  }

  updateProfile() {
    if (this.email.value == this.profile.email) {
      this.submitted = true;
      if (this.profilemod.invalid) {
        return;
      }
      this.loading = true;
      console.log(this.profilemod.value);
      this.ProfileService.updateProfile(this.profilemod.value).subscribe(
        (data: any) => {
          this.profile = data;
          this._snackBar.open('Profile Updated', 'close', {
            duration: 2000,
          });
          console.log(this.profile);
          this.getProfilePicture();
          this.GetProfile();
          this.getProfilePicture();
        },
        (error) => {
          this.loading = false;
          this._snackBar.open(error.error.message ?? 'Error', 'close', {
            duration: 2000,
          });
        }
      );
    } else {
      this.submitted = true;
      if (this.profilemod.invalid) {
        return;
      }
      this.loading = true;
      console.log(this.profilemod.value);
      this.ProfileService.updateProfile(this.profilemod.value).subscribe(
        (data: any) => {
          this.profile = data;
          this._snackBar.open('Profile Updated', 'close', {
            duration: 2000,
          });
          console.log(this.profile);
        },
        (error) => {
          this.loading = false;
          this._snackBar.open(error.error.message ?? 'Error', 'close', {
            duration: 2000,
          });
        }
      );
      this.router.navigate(['/verify']);
    }
  }

  updateScooterName() {
    this.submitted = true;
    if (this.scooterform.invalid) {
      return;
    }
    this.loading = true;
    console.log(this.scooterform.value);
    this.ProfileService.updateScooterName(this.scooterform.value).subscribe(
      (data: any) => {
        this.profile = data;
        this._snackBar.open('Scooter name Chnaged', 'close', {
          duration: 2000,
        });
        console.log(this.profile);
        this.getProfilePicture();
        this.GetProfile();
      },
      (error) => {
        this.loading = false;
        this._snackBar.open(error.error.message ?? 'Error', 'close', {
          duration: 2000,
        });
      }
    );
  }

  updatePassword() {
    this.submitted = true;
    if (this.resetpassword.invalid) {
      return;
    }
    this.loading = true;
    console.log(this.resetpassword.value);
    this.ProfileService.updatePassword(this.resetpassword.value).subscribe(
      (data: any) => {
        this.profile = data;
        this._snackBar.open('Password changed', 'close', {
          duration: 2000,
        });
        console.log(this.profile);
        this.getProfilePicture();
        this.GetProfile();
      },
      (error) => {
        this._snackBar.open(error.error.message ?? 'Error', 'close', {
          duration: 2000,
        });
        this.loading = false;
      }
    );
  }

  showedit() {
    this.isAddMode = true;
  }

  showcancel() {
    return (this.isAddMode = false);
  }
}
