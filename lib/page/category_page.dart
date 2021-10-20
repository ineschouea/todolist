import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_ines_chouea/api/firebase_api.dart';
import 'package:todo_list_ines_chouea/model/category.dart';
import 'package:todo_list_ines_chouea/provider/categories.dart';
import 'package:todo_list_ines_chouea/widget/add_category_dialog_widget.dart';
import 'package:todo_list_ines_chouea/widget/category_list_widget.dart';
import 'package:todo_list_ines_chouea/widget/category_widget.dart';


import '../main.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}
List<Category> _categoryList = List<Category>();

class _CategoriesPageState extends State<CategoriesPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      CategoryListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Category list'),
      ),

      body: StreamBuilder<List<Category>>(
        stream: FirebaseApi.readCategories(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final categories = snapshot.data;

                final provider = Provider.of<CategoriesProvider>(context);
                provider.setCategories(categories);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
