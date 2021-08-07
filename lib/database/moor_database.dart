import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_moor_example/database/tables/category/categories_table.dart';
import 'package:moor/ffi.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../database/tables/todo/todo_dao.dart';

import 'tables/todo/todo_table.dart';

// assuming that your file is called filename.dart. This will give an error at first,
// but it's needed for moor to know about the generated code
part 'moor_database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mydb.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

clearDatabase() {}

@UseMoor(
  tables: [
    Todos,
    Categories
  ],
  daos: [
    TodoDao,

  ],
)
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}
