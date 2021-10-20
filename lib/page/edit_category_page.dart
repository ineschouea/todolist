import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_ines_chouea/model/category.dart';
import 'package:todo_list_ines_chouea/provider/categories.dart';
import 'package:todo_list_ines_chouea/widget/category_form_widget.dart';

class EditCategoryPage extends StatefulWidget {
  final Category category;

  const EditCategoryPage({Key key, @required this.category}) : super(key: key);

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String description;

  @override
  void initState() {
    super.initState();

    title = widget.category.title;
    description = widget.category.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Category'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<CategoriesProvider>(context, listen: false);
                provider.removeCategory(widget.category);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: CategoryFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedCategory: saveCategory,
            ),
          ),
        ),
      );

  void saveCategory() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<CategoriesProvider>(context, listen: false);

      provider.updateCategory(widget.category, title, description);

      Navigator.of(context).pop();
    }
  }
}
