import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfiretest/models/user.dart';
import 'package:flutterfiretest/models/category_model.dart';

class HomePageCategoriesSection_1 extends StatelessWidget {
  HomePageCategoriesSection_1({super.key});

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Add', iconPath: 'Assets/Icons/plus.svg', boxColor: Color(0xff92A3FD)),
    CategoryModel(name: 'Info', iconPath: 'Assets/Icons/user-4.svg', boxColor: Color(0xffC58BF2)),
    CategoryModel(name: 'Change', iconPath: 'Assets/Icons/refresh-user-1.svg', boxColor: Color(0xff92A3FD)),
    CategoryModel(name: 'Delete', iconPath: 'Assets/Icons/trash-3.svg', boxColor: Color(0xffC58BF2)),
  ];

  final db = FirebaseFirestore.instance;
  
  Map<dynamic, dynamic> firebaseDataUsers = {};

  void getUserValues(){
      final usersRef = db.collection("users");
      usersRef.get().then((snapshot) {
        for (var doc in snapshot.docs) {
          final data = doc.data();
          firebaseDataUsers[doc.id] = data.values.first;
        }
      });
  }

  void onCategoryTap(CategoryModel category, BuildContext context) {
    switch (category.name) {
      case 'Add':
        print(firebaseDataUsers.entries.map((entry) {
          final noe = entry.value;
          print(noe);
        }));
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
                  print("User created");
                  final Name = <String, String> {"name": name};
                  db.collection("users").doc(newUser.userId).set(Name);
                  firebaseDataUsers[newUser.userId] = name;
                } else {
                  print("User not created");
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
                  firebaseDataUsers.entries.map((entry) {
                    return ListTile(
                      title: Text(entry.value),
                      subtitle: Text(entry.key),
                    );
                  }).toList()
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
                  firebaseDataUsers.entries.map((entry) {
                    return ListTile(
                      title: Text(entry.value),
                      onTap: () {
                        Navigator.of(context).pop();
                        showRenameDialog(context, entry);
                      },
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }

  void showRenameDialog(BuildContext context, MapEntry entry) {
    final TextEditingController newNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename ${entry.value}'),
          content: TextField(controller: newNameController, decoration: InputDecoration(hintText: 'New name')),
          actions: [
            TextButton(
              onPressed: () {
                final newName = newNameController.text;
                if (newName.isNotEmpty) {
                  final updated = <String, String>{"name": newName};
                  db.collection("users").doc(entry.key).set(updated);
                  firebaseDataUsers[entry.key] = newName;
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
                  firebaseDataUsers.entries.map((user) {
                    return ListTile(
                      title: Text(user.value),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop();
                          print('Deleted user ${user.value}');
                          db.collection("users").doc(user.key).delete();
                          firebaseDataUsers.remove(user.key);
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
    getUserValues();
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
