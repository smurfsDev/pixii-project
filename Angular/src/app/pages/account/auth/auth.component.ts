import { AfterViewInit, Component, OnInit } from '@angular/core';
import { AbstractControl, AsyncValidatorFn, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ErrorStateMatcher } from '@angular/material/core';
import { checkPassword } from '../form-validators';
import { RegisterService } from 'src/app/service/account/register.service';
import { Router } from '@angular/router';
import { LoginService } from 'src/app/service/account/login.service';
import { Store } from '@ngxs/store';
import { User } from 'src/app/models/user';
import { SetIsAuthenticated, SetToken, SetUser } from 'src/app/store/auth/actions';
import { validator } from './validator';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
	selector: 'app-auth',
	templateUrl: './auth.component.html',
	styleUrls: ['./auth.component.scss'],
})
export class AuthComponent implements OnInit, AfterViewInit {

	constructor(private _snackBar: MatSnackBar, private myValid: validator, private formBuilder: FormBuilder, private RegisterService: RegisterService, private router: Router, private LoginService: LoginService, private store: Store) {

		this.registerForm = this.formBuilder.group({
			email: this.emailRegister,
			name: this.userNameRegister,
			nameRegister: this.nameRegister,
			passwordRegister: this.passwordRegister,
			role: this.roleInputRegister,
			confirmPasswordRegister: this.ConfirmPasswordRegister,
			bikeIdRegister: this.bikeIdRegister
		});

		this.loginForm = this.formBuilder.group({
			username: this.username,
			password: this.password,
		});


	}

	registerLoading = false;
	loginLoading = false;
	ngOnInit(): void {
		this.ngOnInitRegister();
		this.ngOnInitLogin();
	}

	ngAfterViewInit(): void {
		this.showLogin();
	}

	registerForm: FormGroup;
	hideRegister = true;
	hideConfirmRegister = true;
	roles: any = [];

	emailRegister = new FormControl('', [Validators.required,
	Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$'),
	],
		this.myValid.userValidator()
	);
	userNameRegister = new FormControl('', [Validators.required, Validators.minLength(3), Validators.maxLength(20)], this.myValid.userNameValidator());
	nameRegister = new FormControl('', [Validators.required, Validators.minLength(3), Validators.maxLength(50),
	Validators.pattern('^(?=.*[ ])[a-zA-Z ]*$')
	]);
	passwordRegister = new FormControl('', [Validators.required, Validators.minLength(8),
	Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$')
		, checkPassword('ConfirmPasswordRegister', true)]);
	ConfirmPasswordRegister = new FormControl('', [Validators.required, checkPassword('passwordRegister')]);
	roleInputRegister = new FormControl('', [Validators.required]);
	bikeIdRegister = new FormControl('',
		this.roleInputRegister.value == "Scooter Owner" ?
			[Validators.required]
			: [],
		this.myValid.bikeValidator(this.roleInputRegister.value)
	);
	getBikeIdErrorMessageRegister() {
		if (this.bikeIdRegister.touched) {
			if (this.bikeIdRegister.hasError('required')) {
				return 'You must enter a value';
			} else if (this.bikeIdRegister.hasError('bikeDoesntExists')) {
				return 'Bike Id isn\'t valid';
			}
		}
		return '';
	}

	getNameErrorMessageRegister() {
		if (this.nameRegister.touched) {
			if (this.nameRegister.hasError('required')) {
				return 'You must enter a value';
			}
			else if (this.nameRegister.hasError('minlength')) {
				return 'Username must be at least 3 characters';
			}
			else if (this.nameRegister.hasError('maxlength')) {
				return 'Username must be at most 20 characters';
			}
			return 'Username must contain at least one space';
		}
		return '';
	}
	getEmailErrorMessageRegister() {
		if (this.emailRegister.touched) {
			if (this.emailRegister.hasError('required')) {
				return 'You must enter a value';
			} else if (this.emailRegister.hasError('emailExist')) {
				return 'Email already exists';
			}
			return 'Not a valid email';
		}
		return '';
	}
	getUserNameErrorMessageRegister() {
		if (this.userNameRegister.touched) {
			if (this.userNameRegister.hasError('required')) {
				return 'You must enter a value';
			}
			else if (this.userNameRegister.hasError('minlength')) {
				return 'Username must be at least 3 characters';
			}
			else if (this.userNameRegister.hasError('maxlength')) {
				return 'Username must be at most 20 characters';
			}
			else if (this.userNameRegister.hasError('userNameExists')) {
				return 'Username already exists';
			}
		}
		return '';
	}
	getPasswordErrorMessageRegister() {
		if (this.passwordRegister.touched) {
			if (this.passwordRegister.hasError('required')) {
				return 'You must enter a value';
			}
			else if (this.passwordRegister.hasError('minlength')) {
				return 'Password must be at least 8 characters';
			}
			else if (this.passwordRegister.hasError('matching')) {
				return 'Passwords do not match';
			}
			return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
		}
		return '';
	}
	getConfirmPasswordRegisterErrorMessage() {
		if (this.ConfirmPasswordRegister.touched) {
			if (this.ConfirmPasswordRegister.hasError('required')) {
				return 'You must enter a value';
			}
			else if (this.ConfirmPasswordRegister.hasError('minlength')) {
				return 'Password must be at least 8 characters';
			}
			else if (this.ConfirmPasswordRegister.hasError('matching')) {
				return 'Passwords do not match';
			}
			return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
		}
		return '';
	}
	getRoleErrorMessageRegister() {
		if (this.roleInputRegister.touched) {
			if (this.roleInputRegister.hasError('required')) {
				return 'You must enter a value';
			}
			return 'Not a valid role';
		}
		return '';
	}


	ngOnInitRegister(): void {
		this.fetchRoles();
	}
	onSubmitRegister() {
		setTimeout(() => {
			this.transistionFromSideToSide("");
		}, 1);
		if (this.registerForm.valid) {
			this.register();
		}
		else {
			this.emailRegister.markAsTouched();
			this.userNameRegister.markAsTouched();
			this.passwordRegister.markAsTouched();
			this.ConfirmPasswordRegister.markAsTouched();
			this.roleInputRegister.markAsTouched();
			this.nameRegister.markAsTouched();
			if (this.roleInputRegister.value == "Scooter Owner") {
				this.bikeIdRegister.markAsTouched();
			} else {
				this.bikeIdRegister.reset();
			}

			// get invalid controls
			const invalid = [];
			const controls = this.registerForm.controls;
			for (const name in controls) {
				if (controls[name].invalid) {
					invalid.push(name);
				}
			}
			if (this.roleInputRegister.value != "Scooter Owner" && invalid.length == 0) {
				this.register();
			}
		}
	}

	register(){
		this.registerLoading = true;
				this.RegisterService.register(
					{
						name: this.registerForm.value.nameRegister,
						email: this.registerForm.value.email,
						username: this.registerForm.value.name,
						password: this.registerForm.value.passwordRegister,
						role: this.registerForm.value.role,
						confirmPassword: this.registerForm.value.confirmPasswordRegister,
						scooterId: this.registerForm.value.bikeIdRegister

					}
				).subscribe((data: any) => {
					// this.showLogin();
					this.router.navigate(['/verify']);
					this.registerLoading = false;
				});
				this.ConfirmPasswordRegister.reset();
	}
	fetchRoles() {
		this.RegisterService.fetchRoles().subscribe((data: any) => {
			this.roles = data.roles;
		}
		);
	}


	// Login
	hide = true;
	loginForm: FormGroup;
	unauthenticated = false;
	user: User = new User('', '', '', '', null,null);
	username = new FormControl('', [Validators.required, Validators.pattern('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,10}$')]);
	password = new FormControl('', [Validators.required,
	Validators.minLength(8),
	Validators.pattern('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]+)$')
	]);
	getEmailErrorMessage() {
		if (this.username.touched) {
			if (this.username.hasError('required')) {
				return 'You must enter a value';
			}
			return 'Not a valid email';
		}
		return '';
	}
	getPasswordErrorMessage() {
		if (this.password.touched) {
			if (this.password.hasError('required')) {
				return 'You must enter a value';
			}
			else if (this.password.hasError('minlength')) {
				return 'Password must be at least 8 characters';
			}
			return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
		}
		return '';
	}
	getAuthErrorMessage() {
		if (this.unauthenticated) {
			return 'Invalid username or password';
		}
		return '';
	}


	ngOnInitLogin(): void {
		localStorage.clear();
	}
	loginError = "";
	onSubmit() {
		if (this.loginForm.valid) {
			this.loginLoading = true;
			this.LoginService.login(this.loginForm.value).subscribe((data: any) => {
				this.user = data;
				this.store.dispatch([
					new SetToken(data.token),
					new SetUser(
						new User(data.user.id, data.user.username, data.user.name, data.user.email, data.user.roles,data.user.image)
					),
					new SetIsAuthenticated(true)
				]);
				this.loginLoading = false;
				this.router.navigate(['/']);
			}, (error: any) => {
				this.loginLoading = false;
				this.unauthenticated = true;
				if (error.error.error == "USER_DISABLED") {
					this.loginError = "User is disabled";
				} else if (error.error.error == "USER_NOT_FOUND") {
					this.loginError = "User not found";
				} else if (error.error.error == "INVALID_CREDENTIALS") {
					this.loginError = "Invalid credentials";
				} else {
					this.loginError = "Unknown error";
				}
				this._snackBar.open(this.loginError, this.loginError == "User is disabled" ? "Navigate to verify" : "Close", {
					duration: 5000,
				}).onAction().subscribe(() => {
					if (this.loginError == "User is disabled") {
						this.router.navigate(['/verify']);
					}
				});
			}, () => {
				this.loginLoading = false;
			}
			)
		}
		else {
			this.username.markAsTouched();
			this.password.markAsTouched();
		}
	}
	showRegister = true;
	showLoginF = false;

	showLogin() {
		this.showRegister = false;
		this.showLoginF = true;
		this.transistionFromSideToSide("left");
	}
	ShowRegister() {
		this.showRegister = true;
		this.showLoginF = false;
		this.transistionFromSideToSide("right");
	}
	height = 0;
	oldHeight = 0;
	async transistionFromSideToSide(direction: string) {
		const toShow = document.querySelector("#tosh") as HTMLElement;
		const width = window.innerWidth;
		if (direction == "left") {
			toShow.style.left = '0';
		} else {
			const toShowWidth = toShow.offsetWidth;
			toShow.style.left = (width - toShowWidth) + 'px';
		}
		const otherPart = document.querySelector("#other-part") as HTMLElement;
		this.oldHeight = this.oldHeight < toShow.offsetHeight ? toShow.offsetHeight : this.oldHeight;;
		if (this.showLoginF) {
			await this.timeout(0.1);
			this.height = toShow.offsetHeight;
		} else {
			this.height = this.oldHeight;
		}

		otherPart.style.height = this.height + "px";


	}
	timeout(ms: number) {
		return new Promise(resolve => setTimeout(resolve, ms));
	}
}
