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
import { environment } from 'src/environments/environment';
import { toInteger } from '@ng-bootstrap/ng-bootstrap/util/util';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  imageUrl = "env + '/user-photos/' + profile?.image";
  defaultImageUrl: string =
    'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg';

  env = environment.apiUrl;

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
    this.GetScooterName();
    this.GetProfile(true);
  }

  onFileChanged(event: any) {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      this.image = reader.result as string;
    };
  }

  GetProfile(update:boolean) {
    this.ProfileService.getProfile().subscribe((data: any) => {
      this.profile = data;
	  if(update == true){
      this.profilemod.patchValue({
        name: this.profile.name,
        email: this.profile.email,
        confirmemail: this.profile.email,
        username: this.profile.username,
        image: this.profile.image,
        created_at: this.profile.created_at,
      });
	  }else{
		this.profilemod.patchValue({
			name: this.profile.name,
			email: this.profile.email,
			confirmemail: this.profile.email,
			username: this.profile.username,
			created_at: this.profile.created_at,
		  });
	  }
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
    this.submitted = true;
    if (this.profilemod.invalid) {
      return;
    }
    if (
      this.email.value == this.profile.email &&
      this.name.value == this.profile.name
    ) {
      this._snackBar.open(' Nothing Changed', 'close', {
        duration: 2000,
      });
    } else if (
      this.email.value == this.profile.email &&
      this.name.value != this.profile.name
    ) {
      this.loading = true;
      console.log(this.profilemod.value);
      this.ProfileService.updateProfile(this.profilemod.value).subscribe(
        (data: any) => {
          this.profile = data;
          this._snackBar.open('Profile Updated', 'close', {
            duration: 2000,
          });
          this.GetProfile(false);
        },
        (error) => {
          this.loading = false;
          this._snackBar.open(error.error.message ?? 'Error', 'close', {
            duration: 2000,
          });
        }
      );
    } else if (
      this.email.value != this.profile.email &&
      this.confirmemail.value == this.email.value
    ) {
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
    } else if (
      this.email.value != this.profile.email &&
      this.confirmemail.value != this.email.value
    ) {
      this._snackBar.open("Confirm email doesn't match", 'close', {
        duration: 2000,
      });
    }
  }

  async uploadProfilePicture(event: any) {
    console.log('uploading');
    const file:File = event.target.files[0];
    console.log((file.size/ (1024*1024)).toFixed(2));
    if (file.type == 'image/jpeg' || file.type == 'image/png') {
      const formData = new FormData();
      formData.append('file', file);
      if((file.size/ (1024*1024))<2){
        try {
          console.log('sending');

        const response = await this.ProfileService.uploadProfilePicture(
          formData
          ).toPromise();
          console.log('sent');
          this._snackBar.open('Profile Picture Updated', 'close', {
            duration: 2000,
          });
          this.GetProfile(true);
        } catch (error) {
          this._snackBar.open(
            'Error uploading file, Please try another file',
            'close',
          {
            duration: 2000,
          }
          );
          this.GetProfile(false);
        }
      }else{
        this._snackBar.open(
          'File size too large',
          'close',
          {
            duration: 2000,
          }
        );
      }
    }
    else{
      this._snackBar.open(
        'Only .jpg and .png files are allowed',
        'close',
        {
          duration: 2000,
        }
      );
    }

  }

  updateScooterName() {
    this.submitted = true;
    if (this.scooterform.invalid) {
      return;
    }
    this.loading = true;
    if (this.scootername.value != this.profile.scootername) {
      this.ProfileService.updateScooterName(this.scooterform.value).subscribe(
        (data: any) => {
          this.profile = data;
          this._snackBar.open('Scooter name Chnaged', 'close', {
            duration: 2000,
          });
          console.log(this.profile);
          this.getProfilePicture();
          this.GetProfile(false);
        },
        (error) => {
          this.loading = false;
          this._snackBar.open(error.error.message ?? 'Error', 'close', {
            duration: 2000,
          });
        }
      );
    } else {
      this._snackBar.open('Nothing Changed', 'close', {
        duration: 2000,
      });
    }
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
        this.GetProfile(false);
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
