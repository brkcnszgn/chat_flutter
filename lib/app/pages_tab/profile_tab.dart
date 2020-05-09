import 'package:chatflutter/viewmodels/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Profile'
        ),
        actions: [
          FlatButton(onPressed:()=>  _logOut(context), child: Text('Çıkış',style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Center(
        child: Text('Profile tab'),
      ),
    );
  }
  Future<bool> _logOut(BuildContext context) async {
    final _userViewModel = Provider.of<UserModel>(context, listen: false);
    bool result = await _userViewModel.signOut();
    return result;
  }
}
