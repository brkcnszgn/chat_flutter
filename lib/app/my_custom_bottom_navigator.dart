import 'package:chatflutter/app/tab_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomNavigation extends StatelessWidget {
  const MyCustomNavigation(
      {Key key,
      @required this.currentTab,
      @required this.onSelectedTab,
      @required this.createTab,
      @required this.navigatorKeys})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> createTab;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;


  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _navItemCreate(TabItem.Users),
          _navItemCreate(TabItem.Profile),
          _navItemCreate(TabItem.Home),
          _navItemCreate(TabItem.Search),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[gosterilecekItem],
          builder: (context) {
            return createTab[gosterilecekItem];
          },
        );
      },
    );
  }

  BottomNavigationBarItem _navItemCreate(TabItem tabItem) {
    final olusturulacakTab = TabItemData.allTabs[tabItem];

    return BottomNavigationBarItem(
      icon: Icon(olusturulacakTab.icon),
      title: Text(olusturulacakTab.title),
    );
  }
}
