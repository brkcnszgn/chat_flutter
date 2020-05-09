
import 'package:chatflutter/app/pages_tab/tab_user/page_one.dart';
import 'package:flutter/material.dart';

class UserHomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.title), onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PageOne()));
          }),
        ],
        title: Text(
          'UserHome'
        ),
      ),
      body: Center(
        child: Text('User tab'),
      ),
    );
  }
}
