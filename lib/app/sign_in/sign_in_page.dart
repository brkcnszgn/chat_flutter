import 'package:chatflutter/app/sign_in/email_login_page.dart';
import 'package:chatflutter/common_widget/CustomSoocialRaisedButton.dart';
import 'package:chatflutter/viewmodels/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user.dart';

class SignInPage extends StatelessWidget {

  void _guestLogin(BuildContext context) async {
    final _userViewModel = Provider.of<UserModel>(context,listen: false);
    User _user = await _userViewModel.signInAnanymously();
    print('Oturum açan kullanıcı ıd'+ _user.userID.toString());
  }
  void _googleSignIn(BuildContext context) async{
    final _userViewModel = Provider.of<UserModel>(context,listen: false);
    User _user = await _userViewModel.signInGoogle();
    if(_user != null) print('Oturum açan kullanıcı ıd'+ _user.userID.toString());

  }

//  void _facebookSignIn(BuildContext context) async{
//    final _userViewModel = Provider.of<UserModel>(context,listen: false);
//    User _user = await _userViewModel.signInFacebook();
//    if(_user != null) print('Oturum açan kullanıcı ıd'+ _user.userID.toString());
//
//  }

  void _emailLogin(BuildContext context) {

  Navigator.of(context).push(CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context)=>EmailLogin()));

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Lovers'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oturum Aç',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            SoocialLoginButton(
              buttonHegiht: 40,
              buttonText : 'Facebok ile Oturum aç',
              buttonColor: Color(0xFF334D92),
              buttonRadius: 16,
              onPressed: (){},
              textFontSize: 16,
              textColor: Colors.white,
            ),
            SoocialLoginButton(
              buttonText : 'Email ile Oturum aç',
              buttonColor: Colors.purple,
              buttonRadius: 16,
              onPressed: (){
                _emailLogin(context);
              },
              textFontSize: 16,
              buttonIcon: Icon(Icons.alternate_email),
              textColor: Colors.white,
            ),
            SoocialLoginButton(
              buttonText : 'Gmail ile Oturum aç',
              buttonColor: Colors.red.withOpacity(0.6),
              buttonRadius: 16,
              onPressed: ()=>_googleSignIn(context),
              textFontSize: 16,
              buttonIcon: Icon(Icons.account_box),
              textColor: Colors.white,
            ),
            SoocialLoginButton(
              buttonText : 'Misafir Girişi ile Oturum aç',
              buttonColor: Colors.green[400],
              buttonRadius: 16,
              onPressed: ()=> _guestLogin(context),
              textFontSize: 16,
              buttonIcon: Icon(Icons.ac_unit),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }




}
