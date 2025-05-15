import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfiretest/models/User.dart';
import 'package:flutterfiretest/models/category_model.dart';

class HomePageCategoriesSection extends StatelessWidget {
  HomePageCategoriesSection({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Add', iconPath: 'Assets/Icons/plus.svg', boxColor: Color(0xff92A3FD)),
    CategoryModel(name: 'Info', iconPath: 'Assets/Icons/user-4.svg', boxColor: Color(0xffC58BF2)),
    CategoryModel(name: 'Change', iconPath: 'Assets/Icons/refresh-user-1.svg', boxColor: Color(0xff92A3FD)),
    CategoryModel(name: 'Delete', iconPath: 'Assets/Icons/trash-3.svg', boxColor: Color(0xffC58BF2)),
  ];

  final List<User> users = [];

  final DatabaseReference database = FirebaseDatabase.instance.ref();
  // Map<String, dynamic> UserList = {};

  void onCategoryTap(CategoryModel category, BuildContext context) {
    switch (category.name) {
      case 'Add':
        showAddUserDialog(context);
        break;
      case 'Info':
        showUserListDialog(context);
        break;
      case 'Change':
        showChangeUserDialog(context);
        break;
      case 'Delete':
        showDeleteUserDialog(context);
        break;
      default:
        break;
    }
  }

  void showAddUserDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter your name'),
          content: TextField(controller: nameController, decoration: InputDecoration(hintText: "Name")),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                String name = nameController.text;
                if (name.isNotEmpty) {
                  final newUser = User(name: name);
                  users.add(newUser);
                  print('User created: $newUser');
                  database.child("users/$name").set({'name': name, 'ID': newUser.userId});
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showUserListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Users'),
          content: SingleChildScrollView(
            child: Column(
              children:
                  users.map((user) {
                    return ListTile(title: Text(user.name), subtitle: Text(user.userId));
                  }).toList(),
            ),
          ),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Close'))],
        );
      },
    );
  }

  void showChangeUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select user to rename'),
          content: SingleChildScrollView(
            child: Column(
              children:
                  users.map((user) {
                    return ListTile(
                      title: Text(user.name),
                      onTap: () {
                        Navigator.of(context).pop();
                        showRenameDialog(context, user);
                      },
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }

  void showRenameDialog(BuildContext context, User user) {
    final TextEditingController newNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename ${user.name}'),
          content: TextField(controller: newNameController, decoration: InputDecoration(hintText: 'New name')),
          actions: [
            TextButton(
              onPressed: () {
                final newName = newNameController.text;
                if (newName.isNotEmpty) {
                  user.name = newName; // Only works if name is not final
                  print('User renamed to $newName');
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: SingleChildScrollView(
            child: Column(
              children:
                  users.map((user) {
                    return ListTile(
                      title: Text(user.name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          users.remove(user);
                          Navigator.of(context).pop();
                          print('Deleted user ${user.name}');
                          database.child("users/${user.name}").remove();
                        },
                      ),
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 120,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => SizedBox(width: 25),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onCategoryTap(categories[index], context);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(color: categories[index].boxColor.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset(categories[index].iconPath)),
                      ),
                      Text(categories[index].name, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
