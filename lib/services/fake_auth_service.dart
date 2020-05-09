import 'package:chatflutter/model/user.dart';
import 'package:chatflutter/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  String userID = "FakeUser Id 123123";
  String email = "brkcnszgn@gmail.com";
  //Fake Loginler
  @override
  Future<User> currenUser() async {
    return await Future.value(User(userID: '$userID', email: email));
  }

  @override
  Future<User> signInAnanymously() async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: userID,email: email));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> signInGoogle() async{
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: "google_signInid_ 123123123123",email: email));

  }

  @override
  Future<User> signInFacebook() async{
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: "Facebook userıd_asdasd2323123",email: email));

  }

  @override
  Future<User> createUserWithEmail(String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: 'Create fake id 12332',email: email));

  }

  @override
  Future<User> signInWithEmail(String email, String password) async{
    return await Future.delayed(
        Duration(seconds: 2), () => User(userID: 'Login fake id 5555',email: email));

  }

  
}
