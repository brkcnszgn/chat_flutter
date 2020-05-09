import 'package:chatflutter/app/landing_page.dart';
import 'package:chatflutter/locator.dart';
import 'package:chatflutter/viewmodels/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: LandingPage(),
      ),
    );
  }
}
