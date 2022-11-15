import 'package:flutter_test/flutter_test.dart';
import 'package:owwn_flutter_test/core/helpers/formatters.dart';

void main() {
  test(
    'should shorten long name to just first Letters',
    () {
      String result = nameShortener('Long Name');
      expect(result, 'LN');

      result = nameShortener('very long-Name');
      expect(result, 'VL');

      result = nameShortener('Not long Name');
      expect(result, 'NLN');
    },
  );
}
