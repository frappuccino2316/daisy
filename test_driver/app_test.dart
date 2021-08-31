import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('daisy', () {
    final addButtonFinder = find.byValueKey('add');
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();

      final health = await driver.checkHealth();
      if (health.status == HealthStatus.bad) {
        fail('Flutter Driver extension disabled');
      }
      await Directory('./test_driver/screenshots').create();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('Transition create Todo page', () async {
      await _screenshot(driver, 'TodoListPage.png');
      await driver.tap(addButtonFinder);
      await _screenshot(driver, 'CreateTpdoPage0.png');
    });
  });
}

Future<void> _screenshot(FlutterDriver driver, String fileName) async {
  await driver.waitUntilNoTransientCallbacks();
  final pixels = await driver.screenshot();
  final file = File('./test_driver/screenshots/$fileName');
  await file.writeAsBytes(pixels);
}
