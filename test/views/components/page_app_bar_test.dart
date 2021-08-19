import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:daisy/views/components/page_app_bar.dart';

void main() {
  testWidgets('PageAppbar has an title text', (WidgetTester tester) async {
    // await tester.pumpWidget(PageAppBar('Test'));
    await tester.pumpWidget(MaterialApp(
      title: 'TestApp',
      home: Scaffold(
        appBar: PageAppBar('Test'),
        body: Container(),
      ),
    ));

    final titleFinder = find.text('Test');
    expect(titleFinder, findsOneWidget);
  });
}
