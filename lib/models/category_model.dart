import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel ({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: 'Add', 
        iconPath: 'Assets/Icons/plus.svg', 
        boxColor: Color(0xff92A3FD),
        ),
    );
    
    categories.add(
      CategoryModel(
        name: 'Info', 
        iconPath: 'Assets/Icons/user-4.svg', 
        boxColor: Color(0xffC58BF2),
        ),
    );
    
    categories.add(
      CategoryModel(
        name: 'Change', 
        iconPath: 'Assets/Icons/refresh-user-1.svg', 
        boxColor: Color(0xff92A3FD),
        ),
    );

    categories.add(
      CategoryModel(
        name: 'Delete', 
        iconPath: 'Assets/Icons/trash-3.svg', 
        boxColor: Color(0xffC58BF2),
        ),
    );

    return categories;
  }
}