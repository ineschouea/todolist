import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_ines_chouea/provider/categories.dart';
import 'package:todo_list_ines_chouea/widget/category_widget.dart';

class CategoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoriesProvider>(context);
    final categories = provider.categories;

    return categories.isEmpty
        ? Center(
            child: Text(
              'No categories.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return CategoryWidget(category: category);
            },
          );
  }
}
