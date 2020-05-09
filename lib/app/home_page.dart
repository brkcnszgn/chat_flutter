import 'package:chatflutter/app/my_custom_bottom_navigator.dart';
import 'package:chatflutter/app/pages_tab/home_tab.dart';
import 'package:chatflutter/app/pages_tab/profile_tab.dart';
import 'package:chatflutter/app/pages_tab/search_tab.dart';
import 'package:chatflutter/app/pages_tab/user_tab.dart';
import 'package:chatflutter/app/tab_items.dart';
import 'package:chatflutter/model/user.dart';
import 'package:flutter/material.dart';


/// Hangi sayfanın gösterileceği durumuna karar veren sayfa
///
/// */

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final User user;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Users;

  Map<TabItem, Widget> allpages() {
    return {
      TabItem.Users: UserHomeTab(),
      TabItem.Profile: ProfileTab(),
      TabItem.Search: SearchTab(),
      TabItem.Home: HomeTab()
    };
  }

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Users: GlobalKey<NavigatorState>(),
    TabItem.Profile: GlobalKey<NavigatorState>(),
    TabItem.Search: GlobalKey<NavigatorState>(),
    TabItem.Home: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: () async =>
            !await navigatorKeys[_currentTab].currentState.maybePop(),
        child: MyCustomNavigation(
          currentTab: _currentTab,
          onSelectedTab: (selectedTab) {
            print('Selected tab Item' + selectedTab.toString());

            if(selectedTab == _currentTab){
            navigatorKeys[selectedTab].currentState.popUntil((route) => route.isFirst);
            }else{
              setState(() {
                _currentTab = selectedTab;
              });
            }

          },
          createTab: allpages(),
          navigatorKeys: navigatorKeys,
        ),
      ),
    );
  }
}
