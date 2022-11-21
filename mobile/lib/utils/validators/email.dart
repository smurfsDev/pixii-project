String? validateEmail(value) {
  if (value!.isEmpty) {
    return 'Please enter your email';
  } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Please enter a valid email";
  }
  return null;
}
