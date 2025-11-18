import 'package:flutter_test/flutter_test.dart';
import 'package:residents_app/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateEmail', () {
      test('returns error when email is empty', () {
        expect(Validators.validateEmail(''), 'El email es requerido');
        expect(Validators.validateEmail(null), 'El email es requerido');
      });

      test('returns error for invalid email format', () {
        expect(Validators.validateEmail('invalidemail'), isNotNull);
        expect(Validators.validateEmail('test@'), isNotNull);
        expect(Validators.validateEmail('@example.com'), isNotNull);
      });

      test('returns null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), isNull);
        expect(Validators.validateEmail('user.name@domain.co'), isNull);
      });
    });

    group('validatePassword', () {
      test('returns error when password is empty', () {
        expect(Validators.validatePassword(''), 'La contraseña es requerida');
        expect(Validators.validatePassword(null), 'La contraseña es requerida');
      });

      test('returns error when password is too short', () {
        expect(Validators.validatePassword('123'), isNotNull);
        expect(Validators.validatePassword('12345'), isNotNull);
      });

      test('returns null for valid password', () {
        expect(Validators.validatePassword('123456'), isNull);
        expect(Validators.validatePassword('strongPassword123'), isNull);
      });
    });

    group('validateRequired', () {
      test('returns error when value is empty', () {
        expect(Validators.validateRequired(''), 'Este campo es requerido');
        expect(Validators.validateRequired(null), 'Este campo es requerido');
      });

      test('returns custom error message', () {
        expect(Validators.validateRequired('', fieldName: 'Nombre'), 'Nombre es requerido');
      });

      test('returns null for valid value', () {
        expect(Validators.validateRequired('Some value'), isNull);
      });
    });

    group('areFieldsEmpty', () {
      test('returns true when any field is empty', () {
        expect(Validators.areFieldsEmpty(['text', '', 'another']), isTrue);
        expect(Validators.areFieldsEmpty(['', 'text']), isTrue);
      });

      test('returns false when all fields have values', () {
        expect(Validators.areFieldsEmpty(['text1', 'text2', 'text3']), isFalse);
      });
    });
  });
}
