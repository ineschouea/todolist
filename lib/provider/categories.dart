import 'package:flutter/cupertino.dart';
import 'package:todo_list_ines_chouea/api/firebase_api.dart';
import 'package:todo_list_ines_chouea/model/category.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> _categories = [];


  List<Category> get categories => _categories.where((category) => category.isDone == false).toList();


  void setCategories(List<Category> categories) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _categories = categories;
        notifyListeners();
      });

  void addCategory(Category category) => FirebaseApi.createCategory(category);

  void removeCategory(Category category) => FirebaseApi.deleteCategory(category);


  void updateCategory(Category category, String title, String description) {
    category.title = title;
    category.description = description;

    FirebaseApi.updateCategory(category);
  }
}
