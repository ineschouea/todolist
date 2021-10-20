import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_ines_chouea/model/todo.dart';
import 'package:todo_list_ines_chouea/model/category.dart';
import 'package:todo_list_ines_chouea/utils.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }

  ////////////////
  static Future<String> createCategory(Category category) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc();

    category.id = docCategory.id;
    await docCategory.set(category.toJson());

    return docCategory.id;
  }

  static Stream<List<Category>> readCategories() => FirebaseFirestore.instance
      .collection('category')
      .snapshots()
      .transform(Utils.transformer(Category.fromJson));

  static Future updateCategory(Category category) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc(category.id);

    await docCategory.update(category.toJson());
  }

  static Future deleteCategory(Category category) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc(category.id);

    await docCategory.delete();
  }
}



