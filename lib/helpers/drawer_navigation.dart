
import 'package:flutter/material.dart';
//import 'package:todo_list_ines_chouea/screens/categories_screen.dart';
import 'package:todo_list_ines_chouea/page/home_page.dart';
import 'package:todo_list_ines_chouea/page/category_page.dart';

//import 'package:todo_list_ines_chouea/screens/todos_by_category.dart';
//import 'package:todo_list_ines_chouea/services/category_service.dart';

class DrawerNavigaton extends StatefulWidget {
  @override
  _DrawerNavigatonState createState() => _DrawerNavigatonState();
}

class _DrawerNavigatonState extends State<DrawerNavigaton> {
  List<Widget> _categoryList = List<Widget>();

  //CategoryService _categoryService = CategoryService();

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
   /*var categories = await _categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>new TodosByCategory(category: category['name'],))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://static.mediapart.fr/etmagine/default/files/media_398794/femmebrascroises_Small.jpg?width=317&height=343&width_format=pixel&height_format=pixel'),
              ),
              accountName: Text('Ines Chouea'),
              accountEmail: Text('ines.chouia@etudiant-enit.tn'),
              decoration: BoxDecoration(color: Colors.pink),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) =>HomePage())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesPage())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
