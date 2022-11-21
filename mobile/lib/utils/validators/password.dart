String? validatePassword(value) {
  if (value!.isEmpty) {
    return 'Please enter your password';
  } else if (!RegExp(
    // check if is at least 8 characters long
    r"(?=.{8,})",
  ).hasMatch(value)) {
    return "Password must be at least 8 characters long";
  } else if (!RegExp(
    // check if has at least one uppercase letter
    r"(?=.*[A-Z])",
  ).hasMatch(value)) {
    return "Password must contain at least one uppercase letter";
  } else if (!RegExp(
    // check if has at least one lowercase letter
    r"(?=.*[a-z])",
  ).hasMatch(value)) {
    return "Password must contain at least one lowercase letter";
  } else if (!RegExp(
    // check if has at least one number
    r"(?=.*\d)",
  ).hasMatch(value)) {
    return "Password must contain at least one number";
    // } else if (!RegExp(
    //   // check if has at least one special character
    //   r"(?=.*[!@#\$%\^&\*])",
    // ).hasMatch(value)) {
    //   return "Password must contain at least one special character";
    // }
  }
  return null;
}
