const emailRegex =
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';
const phoneRegex = r'^\d{9}$';
// const passwordRegexUpperCase = r'^(?=.*[A-Z])';
// const passwordRegexLowerCase = r'^(?=.*[a-z])';
// const passwordRegexDigit = r'^(?=.*[0-9])';
// const passwordRegexSpecialCharacter = r'^(?=.*?[!@#\$&*~])';
const passwordRegex8CharactersInLength = r'^.{8,}';
const nameRegex = r'^[\u0600-\u06FFa-zA-Z\s]+$';

String? validateEmail(String? inputEmail) {
  if (inputEmail == null || inputEmail.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(emailRegex).hasMatch(inputEmail)) {
    return 'Email is invalid';
  }
  return null;
}

String? validateName(String? inputName) {
  if (inputName == null || inputName.isEmpty) {
    return 'Name is required';
  } else if (!RegExp(nameRegex).hasMatch(inputName)) {
    return 'Name is invalid';
  }
  return null;
}

String? validatePhone(String? inputNumber) {
  if (inputNumber == null || inputNumber.isEmpty) {
    return 'Phone Number is required';
  } else if (inputNumber.length != 9) {
    return 'Phone Number should be 9 digits';
  } else if (!RegExp(phoneRegex).hasMatch(inputNumber)) {
    return 'Phone Number is invalid';
  }
  return null;
}

String? validatePassword(String? inputPassword) {
  if (inputPassword == null || inputPassword.isEmpty) {
    return 'Password is required';
  } else if (!RegExp(passwordRegex8CharactersInLength)
      .hasMatch(inputPassword)) {
    return 'Must be at least 6 characters in length';
  }
  return null;
}
