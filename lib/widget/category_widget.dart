import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_ines_chouea/model/category.dart';
import 'package:todo_list_ines_chouea/page/edit_category_page.dart';
import 'package:todo_list_ines_chouea/provider/categories.dart';
import 'package:todo_list_ines_chouea/utils.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({
    @required this.category,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(category.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editCategory(context, category),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteCategory(context, category),
              icon: Icons.delete,
            )
          ],
          child: buildCategory(context),
        ),
      );

  Widget buildCategory(BuildContext context) => GestureDetector(
        onTap: () => editCategory(context, category),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [

              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (category.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          category.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteCategory(BuildContext context, Category category) {
    final provider = Provider.of<CategoriesProvider>(context, listen: false);
    provider.removeCategory(category);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editCategory(BuildContext context, Category category) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditCategoryPage(category: category),
        ),
      );
}
