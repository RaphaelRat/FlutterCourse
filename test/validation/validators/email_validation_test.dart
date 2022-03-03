import 'package:fordev/validation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : 'Campo inválido';
  }
}

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
    expect(sut.validate('raphael'), 'Campo inválido');
    expect(sut.validate('raphael@gmail'), 'Campo inválido');
  });
}
