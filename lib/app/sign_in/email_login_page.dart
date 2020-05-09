
import 'package:chatflutter/common_widget/CustomSoocialRaisedButton.dart';
import 'package:chatflutter/model/user.dart';
import 'package:chatflutter/viewmodels/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FormType{Register, Login}

class EmailLogin extends StatefulWidget {
  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  String _email, _password;
  String _buttonText, _linkText;
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit(BuildContext context) async{
    _formKey.currentState.save();
    print('email : ' + _email + ' _password' + _password);
   //Validate eklenecek
    final _userViewModel = Provider.of<UserModel>(context,listen: false);

    if(_formType == FormType.Login){

      User _loginUser = await  _userViewModel.signInWithEmail(_email, _password);
      if(_loginUser!= null) print( 'Giriş yapan user ' + _loginUser.userID);
    }else{

      User _createUser = await  _userViewModel.createUserWithEmail(_email, _password);
      if(_createUser!= null) print( 'Giriş yapan user ' + _createUser.userID);

    }

  }



  _changeUI(BuildContext context) {
    setState(() {
      _formType=  _formType == FormType.Login ? FormType.Register: FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {

    _buttonText = _formType ==FormType.Login? 'Login' : 'Create Account';
    _linkText = _formType == FormType.Login? 'Create Account' : 'Do you have account ? Sign In';
    final _userViewModel = Provider.of<UserModel>(context);
    if(_userViewModel.user != null){

      Future.delayed(Duration(milliseconds: 10), (){
        Navigator.of(context).pop();
      });

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('login Email'),
      ),
      body: _userViewModel.state == ViewState.Idle ?
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(

                  onSaved: (String value) {
                    _email = value;
                  },
                  initialValue: 'brkcnszgn@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorText: _userViewModel.emailError!= null ? _userViewModel.emailError : null,
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Email',
                      labelText: 'Email',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(

                  onSaved: (String value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  initialValue: '123',
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _userViewModel.passwordError != null ? _userViewModel.passwordError : null,
                      prefixIcon: Icon(Icons.security),
                      hintText: 'Password',
                      labelText: 'Password',
                      border: OutlineInputBorder()),
                ),
                _formType == FormType.Register ? Column(
                  children: [
                    SizedBox(height: 10),

                  ],
                ): SizedBox(height: 0,),
                SizedBox(
                  height: 10,
                ),
                SoocialLoginButton(
                  buttonText: _buttonText,
                  onPressed: () => _formSubmit(context),
                  buttonColor: Theme.of(context).primaryColor,
                  buttonRadius: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () => _changeUI(context),
                  child: Text('$_linkText'),
                ),
              ],
            ),
          ),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


}
