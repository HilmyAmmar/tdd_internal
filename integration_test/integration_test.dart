import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_ic/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-end todo flow', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Add todo
    await tester.enterText(find.byKey(const Key('todoField')), 'Go jogging');
    await tester.tap(find.byKey(const Key('addButton')));
    await tester.pumpAndSettle();

    expect(find.text('Go jogging'), findsOneWidget);

    // Complete todo
    await tester.tap(find.byKey(const Key('todo_0')));
    await tester.pumpAndSettle();

    // Check whether the todo is completed or not
    final textWidget = tester.widget<Text>(find.text('Go jogging'));
    expect(textWidget.style?.decoration, TextDecoration.lineThrough);
  });
}
