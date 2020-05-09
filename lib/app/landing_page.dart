import 'package:chatflutter/app/home_page.dart';
import 'package:chatflutter/app/sign_in/sign_in_page.dart';
import 'package:chatflutter/viewmodels/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserModel>(context);

    if(_userViewModel.state == ViewState.Idle){
      if(_userViewModel.user == null){
        return SignInPage();
      }else{
        return HomePage(user: _userViewModel.user,);
      }
    }else{
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

  }
}
