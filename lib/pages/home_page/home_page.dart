import 'package:flutter/material.dart';
import 'package:flutterfiretest/pages/home_page/widgets/home_page_app_bar.dart';
//import 'package:flutterfiretest/pages/home_page/widgets/home_page_categories_section_cloud_firestore.dart';
import 'package:flutterfiretest/pages/home_page/widgets/home_page_categories_section_realtime_database.dart';
import 'package:flutterfiretest/pages/home_page/widgets/home_page_search_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomePageSearchField(),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: 
              Text(
                'Category', 
                style: 
                  TextStyle(
                    color: 
                    Colors.black, 
                    fontSize: 18, 
                    fontWeight: FontWeight.w600
                  )
                ),
          ),
          SizedBox(height: 15),
          HomePageCategoriesSectionRealtimeDatabase(),
        ],
      ),
    );
  }
}
