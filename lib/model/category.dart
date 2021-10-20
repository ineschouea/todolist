import 'package:flutter/cupertino.dart';
import 'package:todo_list_ines_chouea/utils.dart';


/*class TodoField {
  static const createdTime = 'createdTime';
}*/

class Category {
  String title;
  String id;
  String description;
  bool isDone;


  Category({
    @required this.title,
    this.description = '',
    this.id,
    this.isDone = false,

  });

  static Category fromJson(Map<String, dynamic> json) => Category(
    title: json['title'],
    description: json['description'],
    id: json['id'],
    isDone: json['isDone'],

  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'id': id,
    'isDone': isDone,

  };
}
