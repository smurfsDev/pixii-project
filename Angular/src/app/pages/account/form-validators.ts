import { AbstractControl, ValidationErrors, ValidatorFn } from '@angular/forms';

export function checkPassword(matchTo: string, reverse?: boolean): ValidatorFn {
  return (control: AbstractControl): ValidationErrors | null => {
    if (control.parent && reverse) {
      const c = (control.parent?.controls as any)[matchTo] as AbstractControl;
      if (c) {
        c.updateValueAndValidity();
      }
      return null;
    }
    return !!control.parent &&
      !!control.parent.value &&
      control.value === (control.parent?.controls as any)[matchTo].value
      ? null
      : { matching: true };
  };
}
export function checkOldPassword(
  matchTo: string,
  reverse?: boolean
): ValidatorFn {
  return (control: AbstractControl): ValidationErrors | null => {
    if (control.parent && reverse) {
      const c = (control.parent?.controls as any)[matchTo] as AbstractControl;
      if (c) {
        c.updateValueAndValidity();
      }
      return null;
    }
    return !!control.parent &&
      !!control.parent.value &&
      control.value !== (control.parent?.controls as any)[matchTo].value
      ? null
      : { matching: true };
  };
}

export function checkPasswordPattern(
  matchTo: string,
  reverse?: boolean
): ValidatorFn {
  return (control: AbstractControl): ValidationErrors | null => {
    if (control.parent && reverse) {
      const c = (control.parent?.controls as any)[matchTo] as AbstractControl;
      if (c) {
        c.updateValueAndValidity();
      }
      return null;
    }
    return !!control.parent &&
      !!control.parent.value &&
      control.value.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]+$/)
      ? null
      : { matching: true };
  };
}

export function checkOldPasswordPattern(
  matchTo: string,
  reverse?: boolean
): ValidatorFn {
  return (control: AbstractControl): ValidationErrors | null => {
    if (control.parent && reverse) {
      const c = (control.parent?.controls as any)[matchTo] as AbstractControl;
      if (c) {
        c.updateValueAndValidity();
      }
      return null;
    }
    return !!control.parent &&
      !!control.parent.value &&
      control.value !== (control.parent?.controls as any)[matchTo].value
      ? null
      : { matching: true };
  };
}
