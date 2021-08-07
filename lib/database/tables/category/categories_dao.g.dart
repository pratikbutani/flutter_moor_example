// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$CategoriesDaoMixin on DatabaseAccessor<MyDatabase> {
  $CategoriesTable get categories => attachedDatabase.categories;
  Selectable<int> totalCategories() {
    return customSelect('SELECT COUNT(*) FROM categories;',
        variables: [],
        readsFrom: {
          categories,
        }).map((QueryRow row) => row.read<int>('COUNT(*)'));
  }
}
