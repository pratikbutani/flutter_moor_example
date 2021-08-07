import 'package:moor_flutter/moor_flutter.dart';

import '../../moor_database.dart';
import 'categories_table.dart';

part 'categories_dao.g.dart';

@UseDao(tables: [Categories], queries: {'totalCategories': 'SELECT COUNT(*) FROM categories;'})
class CategoriesDao extends DatabaseAccessor<MyDatabase> with _$CategoriesDaoMixin {
  final MyDatabase database;

  CategoriesDao(this.database) : super(database);

  Future<int> getTotalRecords() {
    return totalCategories().getSingle();
  }

  Future<List<Category>> getAllTasks() => select(categories).get();

  Stream<List<Category>> watchAllTasks() => select(categories).watch();

  Future insertTask(Category task) => into(categories).insert(task);

  Future bulkInsertTask(List<CategoriesCompanion> task) => batch((batch) {
        batch.insertAll(categories, task);
      });

  Future doUpdate(Category task) => update(categories).replace(task);

  Future doDelete(Category task) => delete(categories).go(); //Delete all

  Future doDeleteAll(Category task) => delete(categories).go(); //Delete all
}
