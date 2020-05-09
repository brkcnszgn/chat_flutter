

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem{Users,Profile,Home,Search}

class TabItemData{
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTabs  = {

    TabItem.Users : TabItemData("User", Icons.supervised_user_circle),
    TabItem.Search : TabItemData('Search', Icons.search),
    TabItem.Home : TabItemData('Home', Icons.home),
    TabItem.Profile : TabItemData('Profile', Icons.verified_user)

  };
}

