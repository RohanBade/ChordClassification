import 'custom_validators.dart';


final emailValidator = MultiValidator([
  requiredValidator('Email'),
  EmailValidator(errorText: 'enter valid email')
]);

final passwordValidator = MultiValidator([
  requiredValidator('Password'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

TextFieldValidator requiredValidator(String fieldName) =>
    RequiredValidator(errorText: "$fieldName is required".toLowerCase());
