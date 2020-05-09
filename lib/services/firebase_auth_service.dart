import 'package:chatflutter/model/user.dart';
import 'package:chatflutter/services/auth_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> currenUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    } catch (e) {
      print('Hata Current User' + e.toString());
      return null;
    }
  }

//Firebase user'i kendi user modelimize çevirdik
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) return null;
    return User(userID: user.uid, email: user.email);
  }

  @override
  Future<User> signInAnanymously() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(result.user);
    } catch (e) {
      print('Anonim login hata : ' + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _gooleSignIn = GoogleSignIn();
//     final _facebookSignIn = FacebookLogin();
//      await _facebookSignIn.logOut();
      await _gooleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print('Sign out hata' + e.toString());
      return false;
    }
  }

  @override
  Future<User> signInGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    );


    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);
    print(user.email);
    return _userFromFirebase(currentUser);
    }


//  @override
//  Future<User> signInFacebook() async{
//   final _facebookSignIn = FacebookLogin();
//   FacebookLoginResult _faceResult =await _facebookSignIn.logIn(['public_profile','email']);
//
//   switch(_faceResult.status){
//     case FacebookLoginStatus.loggedIn:
//       AuthResult _firebaseResult =await _firebaseAuth.signInWithCredential(FacebookAuthProvider.getCredential(accessToken: _faceResult.accessToken.token));
//       FirebaseUser _user = _firebaseResult.user;
//       return _userFromFirebase(_user); // Local usermodele bastık
//
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       print('Kullanıcı facebook girişi iptal');
//       break;
//     case FacebookLoginStatus.error:
//       print('Facebook hata ' + _faceResult.errorMessage.toString() );
//       break;
//   }
//   return null;
//  }

  @override
  Future<User> createUserWithEmail(String email, String password) async {
    try {
      AuthResult result = await
      _firebaseAuth.createUserWithEmailAndPassword(email: email,
          password: password);
      return _userFromFirebase(result.user);
    } catch (e) {
      print('Email create hata : ' + e.toString());
      return null;
    }
  }

  @override
  Future<User> signInWithEmail(String email, String password)async {
    try {
      AuthResult result = await
      _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);
    } catch (e) {
      print('Email login hata : ' + e.toString());
      return null;
    }
  }

 
}
