class Validators {
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email field cannot be empty!';
    }
    // Regex for email validation
    String p = r'(^(?:[+0][1-9])?[0-9]{8,13}$)';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email provided isn\'t valid.Try another email address';
  }

  String? validateDesignation(String? value) {
    if (value!.isEmpty) {
      return 'Designation Field cannot be empty';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'Username field cannot be empty!';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password field cannot be empty';
    }
    // Use any password length of your choice here
    if (value.length < 6) {
      return 'Password length must be greater than 6';
    }
  }

  String? validateField(String? value) {
    if (value!.isEmpty) {
      return 'Field should not be empty';
    }
    return null;
  }

  String? validePin(String? value) {
    if (value!.isEmpty) {
      return 'Pin cannot be empty';
    }
    if (value.length < 4) {
      return 'Please enter 4 digit pin';
    }
    return null;
  }

  String? validateName(String? value) {
    var emptyNameError = 'Name field cannot be empty';
    var shortNameError = 'Name is too short!';
    var invalidNameError = 'Name is not appropriate!';

    print(value.toString());

    if (value!.isEmpty) {
      return emptyNameError;
    } else if (value.length < 3) {
      return shortNameError;
    } else {
      final nameValidate = RegExp(r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$").hasMatch(value);
      if (!nameValidate) {
        return invalidNameError;
      } else {
        return null;
      }
    }
  }

  String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    }
    // else if (!regExp.hasMatch(value)) {
    //   return 'Please enter valid mobile number';
    // }
    return null;
  }
}
