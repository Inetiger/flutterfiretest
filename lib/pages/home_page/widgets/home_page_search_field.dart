import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePageSearchField extends StatelessWidget {
  const HomePageSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Color(0xff1D1617).withOpacity(0.11), blurRadius: 40, spreadRadius: 0.0)]),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Search for user ID',
          hintStyle: TextStyle(color: Color(0xffDDDADA), fontSize: 14),
          prefixIcon: Padding(padding: const EdgeInsets.all(12), child: SvgPicture.asset('Assets/Icons/Search.svg')),
          suffixIcon: SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(color: Colors.black, indent: 10, endIndent: 10, thickness: 0.1),
                  Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('Assets/Icons/Filter.svg')),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
