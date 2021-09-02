import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('daisy', () {
    final transitionAddButtonFinder = find.byValueKey('add');
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
      await driver.tap(transitionAddButtonFinder);
      await _screenshot(driver, 'CreateTodoPage0.png');
    });

    test('Create Todo', () async {
      final titleTextFieldFinder = find.byValueKey('titleTextField');
      final detailTextFieldFinder = find.byValueKey('detailTextField');
      final deadlineButtonFinder = find.byValueKey('deadlineButton');
      final addButtonFinder = find.byValueKey('addButton');

      await driver.tap(titleTextFieldFinder);
      await driver.enterText('Test1');
      await driver.tap(detailTextFieldFinder);
      await driver.enterText('Detail test1');
      await driver.tap(deadlineButtonFinder);
      await driver.tap(find.text('1'));
      await driver.tap(find.text('OK'));

      await _screenshot(driver, 'CreateTodoPage1.png');

      await driver.tap(addButtonFinder);
      await _screenshot(driver, 'TodoListPage1.png');
      final tileFinder = find.byValueKey('todoTitle');
      expect(await driver.getText(tileFinder), 'Test1');
    });
  });
}

Future<void> _screenshot(FlutterDriver driver, String fileName) async {
  await driver.waitUntilNoTransientCallbacks();
  final pixels = await driver.screenshot();
  final file = File('./test_driver/screenshots/$fileName');
  await file.writeAsBytes(pixels);
}
