// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
import 'package:moor/moor.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 32)();

  TextColumn get content => text().named('body')();

  IntColumn get category => integer().nullable()();
}
