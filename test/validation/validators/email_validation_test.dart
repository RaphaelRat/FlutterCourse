import 'package:test/test.dart';

import 'package:fordev/presentation/protocols/protocols.dart';

import 'package:fordev/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    final error = sut.validate('');

    expect(error, null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null); //Aqui de forma abreviada
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('nome.sobrenome@gmail.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('raphael'), ValidationError.invalidField);
    expect(sut.validate('raphael@gmail'), ValidationError.invalidField);
  });
}
