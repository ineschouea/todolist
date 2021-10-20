import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_ines_chouea/model/category.dart';
import 'package:todo_list_ines_chouea/provider/categories.dart';
import 'package:todo_list_ines_chouea/widget/category_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              CategoryFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedCategory: addCategory,
              ),
            ],
          ),
        ),
      );

  void addCategory() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final category = Category(
        title: title,
        description: description,
      );

      final provider = Provider.of<CategoriesProvider>(context, listen: false);
      provider.addCategory(category);

      Navigator.of(context).pop();
    }
  }
}
