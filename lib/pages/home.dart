import 'package:flutter/foundation.dart';
import 'package:flutterfiretest/models/User.dart';
import 'package:flutterfiretest/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  void _onCategoryTap(CategoryModel category, BuildContext context) {
  switch (category.name) {
    case 'Add':
      _showAddUserDialog(context);
      break;
    case 'Info':
      _showUserListDialog(context);
      break;
    case 'Change':
      _showChangeUserDialog(context);
      break;
    case 'Delete':
      _showDeleteUserDialog(context);
      break;
    default:
      break;
  }
}


  List<User> users = [];

  void _showAddUserDialog(BuildContext context) {
  final TextEditingController _nameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter your name'),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(hintText: "Name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              String name = _nameController.text;
              if (name.isNotEmpty) {
                final newUser = User(name: name);
                users.add(newUser);
                print('User created: $newUser');
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showUserListDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Users'),
        content: SingleChildScrollView(
          child: Column(
            children: users.map((user) {
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.userId),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

void _showChangeUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select user to rename'),
        content: SingleChildScrollView(
          child: Column(
            children: users.map((user) {
              return ListTile(
                title: Text(user.name),
                onTap: () {
                  Navigator.of(context).pop();
                  _showRenameDialog(context, user);
                },
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}

void _showRenameDialog(BuildContext context, User user) {
  final TextEditingController _newNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Rename ${user.name}'),
        content: TextField(
          controller: _newNameController,
          decoration: InputDecoration(hintText: 'New name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newName = _newNameController.text;
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

void _showDeleteUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Delete User'),
        content: SingleChildScrollView(
          child: Column(
            children: users.map((user) {
              return ListTile(
                title: Text(user.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    users.remove(user);
                    Navigator.of(context).pop();
                    print('Deleted user ${user.name}');
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
    _getCategories();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          SizedBox(height: 40,),
          _categoriesSection(),
        ],
      ),
    );
  }

  Column _categoriesSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Category',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 120,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                separatorBuilder: (context, index) => SizedBox(width: 25,),
                 itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _onCategoryTap(categories[index], context);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: categories[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(categories[index].iconPath),
                            ), 
                          ),
                          Text(
                            categories[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
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

  Container _searchField() {
    return Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search for user ID',
              hintStyle: TextStyle(
                color: Color(0xffDDDADA),
                fontSize: 14,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('Assets/Icons/Search.svg'),
              ),
              suffixIcon: Container(
                width: 100,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VerticalDivider(
                        color: Colors.black,
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('Assets/Icons/Filter.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'User Data',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          
        },
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'Assets/Icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
            'Assets/Icons/dots.svg',
            height: 5,
            width: 5,
            ),
          ),
        ),
      ],
    );
  }
}