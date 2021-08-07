import 'package:moor_flutter/moor_flutter.dart';

import '../../moor_database.dart';
import 'todo_table.dart';

part 'todo_dao.g.dart';

@UseDao(tables: [Todos], queries: {'totalTodos': 'SELECT COUNT(*) FROM todos;'})
class TodoDao extends DatabaseAccessor<MyDatabase> with _$TodoDaoMixin {
  final MyDatabase database;

  TodoDao(this.database) : super(database);

  Future<int> getTotalRecords() {
    return totalTodos().getSingle();
  }

  Future<List<Todo>> getAllTasks() => select(todos).get();

  Stream<List<Todo>> watchAllTasks() => select(todos).watch();

  Future insertTask(Todo task) => into(todos).insert(task);

  Future bulkInsertTask(List<TodosCompanion> task) => batch((batch) {
        batch.insertAll(todos, task);
      });

  Future updateTask(Todo task) => update(todos).replace(task);

  Future deleteTask(Todo task) => (delete(todos)..where((tbl) => tbl.id.equals(task.id))).go();
  
  Future deleteAll() => delete(todos).go();
}
