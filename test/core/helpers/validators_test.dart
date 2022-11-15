import 'package:flutter_test/flutter_test.dart';
import 'package:owwn_flutter_test/core/helpers/validators.dart';

void main() {
  test(
    'should validate an email is correct',
    () {
      bool result = stringIsEmail('test@gmail.com');
      expect(result, isTrue);
      result = stringIsEmail('test@gmail');
      expect(result, isFalse);
      result = stringIsEmail('+2349069184604');
      expect(result, isFalse);
      result = stringIsEmail('alternate-23@tests.co');
      expect(result, isTrue);
    },
  );
}
