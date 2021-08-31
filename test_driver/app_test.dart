import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('daisy', () {
    final todoTileFinder = find.byValueKey('tile');
    final addButtonFinder = find.byValueKey('add');
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('Not exist Todo tile', () async {
      expect(await driver.getText(todoTileFinder), null);
    });
  });
}
