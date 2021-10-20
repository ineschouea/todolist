import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_ines_chouea/api/firebase_api.dart';
import 'package:todo_list_ines_chouea/model/todo.dart';
import 'package:todo_list_ines_chouea/provider/todos.dart';
import 'package:todo_list_ines_chouea/widget/add_todo_dialog_widget.dart';
import 'package:todo_list_ines_chouea/widget/completed_list_widget.dart';
import 'package:todo_list_ines_chouea/widget/todo_list_widget.dart';
import 'package:todo_list_ines_chouea/helpers/drawer_navigation.dart';


import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      drawer: DrawerNavigaton(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Todos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            title: Text('Completed'),
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final todos = snapshot.data;

                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos);

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
