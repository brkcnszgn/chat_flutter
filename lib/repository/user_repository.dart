import 'package:chatflutter/locator.dart';
import 'package:chatflutter/model/user.dart';
import 'package:chatflutter/services/auth_base.dart';
import 'package:chatflutter/services/fake_auth_service.dart';
import 'package:chatflutter/services/firebase_auth_service.dart';
import 'package:chatflutter/services/firestore_db_service.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();

  FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  FirestoreDbService _firestoreDbService = locator<FirestoreDbService>();

  //Firestore yazmak istediğimiz de aynı locator sistemini yazıp AuthBase
  // üzerinde birde kayıt işlemi yapılark tüm projeye eklenebilir.

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<User> currenUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.currenUser();
    } else {
      return await _firebaseAuthService.currenUser();
    }
  }

  @override
  Future<User> signInAnanymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInAnanymously();
    } else {
      return await _firebaseAuthService.signInAnanymously();
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

//  @override
//  Future<User> signInGoogle() async{
//    if (appMode == AppMode.DEBUG) {
//      return await _fakeAuthService.signInGoogle();
//    } else {
//      User user = await _firebaseAuthService.signInGoogle();
//      bool result = await _firestoreDbService.saveUser(user);
//      if(result){
//        return user;
//      }else return null;
//    }
//  }
//
//  @override
//  Future<User> signInFacebook() async{
//    if (appMode == AppMode.DEBUG) {
//      return await _fakeAuthService.signInFacebook();
//    } else {
//      User user = await _firebaseAuthService.signInFacebook();
//      bool result = await _firestoreDbService.saveUser(user);
//      if(result){
//        return user;
//      }else return null;
//    }
//  }

//  @override
//  Future<User> createUserWithEmail(String email, String password)async {
//    if (appMode == AppMode.DEBUG) {
//      return await _fakeAuthService.createUserWithEmail(email, password);
//    } else {
//      //Hem kullaıcı oluştur hem firestore kaydet
//      User user = await _firebaseAuthService.createUserWithEmail(email, password);
//      bool result = await _firestoreDbService.saveUser(user);
//      if(result){
//        return user;
//      }else return null;
//
//    }
//  }
//
//  @override
//  Future<User> signInWithEmail(String email, String password) async{
//    if (appMode == AppMode.DEBUG) {
//      return await _fakeAuthService.signInWithEmail(email, password);
//    } else {
//      return await _firebaseAuthService.signInWithEmail(email, password);
//    }
//  }

  @override
  Future<User> createUserWithEmail(String email, String password)async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.createUserWithEmail(email, password);
    } else {
      //Hem kullaıcı oluştur hem firestore kaydet
      User user = await _firebaseAuthService.createUserWithEmail(email, password);
      bool result = await _firestoreDbService.saveUser(user);
      if(result){
        return  await _firestoreDbService.readUser(user.userID); //veritabnındaki useri döndürdük
      }else return null;

    }
  }

  @override
  Future<User> signInWithEmail(String email, String password) async{
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithEmail(email, password);
    } else {
      User user = await _firebaseAuthService.signInWithEmail(email, password);

      return await _firestoreDbService.readUser(user.userID); //veritabanından getirildi.
    }
  }

  @override
  Future<User> signInGoogle() async{
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInGoogle();
    } else {
      User user = await _firebaseAuthService.signInGoogle();
      bool result = await _firestoreDbService.saveUser(user);
      if(result){
        return await _firestoreDbService.readUser(user.userID);
      }else return null;
    }
  }

//  @override
//  Future<User> signInFacebook() async{
//    if (appMode == AppMode.DEBUG) {
//      return await _fakeAuthService.signInFacebook();
//    } else {
//      User user = await _firebaseAuthService.signInFacebook();
//      bool result = await _firestoreDbService.saveUser(user);
//      if(result){
//        return await _firestoreDbService.readUser(user.userID);
//      }else return null;
//    }
//  }

 
}
