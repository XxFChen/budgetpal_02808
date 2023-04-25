import 'package:budgetpal/database/database_provider.dart';
import 'package:budgetpal/model/category.dart';

class CategoryRepository {
  final List<Category> _categories = [];

  CategoryRepository(DatabaseProvider databaseProvider);

  List<Category> getAllCategories() => _categories;

  void addCategory(Category category) {
    _categories.add(category);
  }

  void updateCategory(Category updatedCategory) {
    int index = _categories.indexWhere((category) => category.id == updatedCategory.id);
    _categories[index] = updatedCategory;
  }

  void deleteCategory(String id) {
    _categories.removeWhere((category) => category.id == id);
  }
}
