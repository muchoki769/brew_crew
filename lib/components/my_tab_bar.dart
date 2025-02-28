import 'package:brew_crew/models/food.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {

  final TabController tabController;
  const MyTabBar({
    super.key,
  required this.tabController,
  });
  
  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 25.0),
      // margin: const EdgeInsets.only(top: 25.0),

      child: TabBar(
        controller: tabController,
        // indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        // labelColor: Theme.of(context).colorScheme.inversePrimary,
        // unselectedLabelColor: Theme.of(context).colorScheme.primary,
        tabs: _buildCategoryTabs(),
          // [
        //   //1st tab
        //   Tab(
        //     icon: Icon(Icons.home),
        //   ),
        //   //2nd tab
        //   Tab(
        //     icon: Icon(Icons.settings),
        //   ),
        //   //3rd tab
        //   Tab(
        //     icon: Icon(Icons.person),
        //   ),
        // ],

      ),
    );
  }
}
