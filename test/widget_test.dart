import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_ic/main.dart';

void main() {
  testWidgets('Can add and display a todo', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    await tester.enterText(find.byKey(const Key('todoField')), 'Buy milk');
    await tester.tap(find.byKey(const Key('addButton')));
    await tester.pump();

    expect(find.text('Buy milk'), findsOneWidget);
  });
}
