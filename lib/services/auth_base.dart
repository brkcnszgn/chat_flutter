import 'package:chatflutter/model/user.dart';


abstract class AuthBase{

  Future<User> currenUser();
  Future<User> signInAnanymously();
  Future<bool> signOut();
  Future<User> signInGoogle();
// Future<User> signInFacebook();
 Future<User> signInWithEmail(String email, String password);
 Future<User> createUserWithEmail(String email, String password);
  //Sahte Auth

}