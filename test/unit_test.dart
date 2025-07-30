import 'package:flutter_test/flutter_test.dart';
import 'package:todo_ic/model/todo.dart';

void main() {
  test('Todo should toggle isDone correctly', () {
    final todo = Todo(title: 'Learn Flutter');
    expect(todo.isDone, false);
    todo.isDone = true;
    expect(todo.isDone, true);
  });
}
