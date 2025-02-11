import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Hello World widget test', (WidgetTester tester) async {
    const testWidget = MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );

    await tester.pumpWidget(testWidget);

    expect(find.text('Hello World'), findsOneWidget);
  });
}
