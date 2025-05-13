import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('User Data', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Color(0xffF7F8F8), borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset('Assets/Icons/Arrow - Left 2.svg', height: 20, width: 20),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(color: Color(0xffF7F8F8), borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset('Assets/Icons/dots.svg', height: 5, width: 5),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
