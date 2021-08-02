// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TodoDaoMixin on DatabaseAccessor<MyDatabase> {
  $TodosTable get todos => attachedDatabase.todos;
  Selectable<int> totalTodos() {
    return customSelect('SELECT COUNT(*) FROM todos;',
        variables: [],
        readsFrom: {
          todos,
        }).map((QueryRow row) => row.read<int>('COUNT(*)'));
  }
}
