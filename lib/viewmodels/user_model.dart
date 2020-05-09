import 'package:chatflutter/locator.dart';
import 'package:chatflutter/model/user.dart';
import 'package:chatflutter/repository/user_repository.dart';
import 'package:chatflutter/services/auth_base.dart';
import 'package:flutter/material.dart';

enum ViewState{Idle,Busy}

class UserModel with ChangeNotifier implements AuthBase{

  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  User _user;
  String emailError;
  String passwordError;
  String createUserPasswordError;


  User get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel(){
    currenUser();
  }

  @override
  Future<User> currenUser() async{
   try{
     state = ViewState.Busy;
     _user =  await _userRepository.currenUser();
     return _user;
   }catch(e){
     print('ViewModel deki current userda hata' + e.toString());
     return null;
   }finally{
     state = ViewState.Idle;
   }
  }

  @override
  Future<User> signInAnanymously() async{
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInAnanymously();
      return _user;
    }catch(e){
      print('ViewModel deki current userda hata' + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async{
    try{
      state = ViewState.Busy;
     bool result =  await _userRepository.signOut();
     _user = null;
     return result;
    }catch(e){
      print('ViewModel deki signOut userda hata' + e.toString());
      return false;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInGoogle()async {
    try{
      state = ViewState.Busy;
      _user = await _userRepository.signInGoogle();
      return _user;
    }catch(e){
      print('ViewModel deki Google current userda hata' + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }
//
//  @override
//  Future<User> signInFacebook()async {
//    try{
//      state = ViewState.Busy;
//      _user = await _userRepository.signInFacebook();
//      return _user;
//    }catch(e){
//      //Aynı mail gmail ile kullanıldıysa hatayı buraya da yakalarsın
//      print('ViewModel deki facebook current userda hata = ' + e.toString());
//      return null;
//    }finally{
//      state = ViewState.Idle;
//    }
//  }

  @override
  Future<User> createUserWithEmail(String email, String password) async{
    try{

      if(_emailPasswordControl(email, password)){
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmail(email,password);
        return _user;
      }else return null;
    }catch(e){
      print('ViewModel deki createUserWithEmail  hata' + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithEmail(String email, String password) async{
    try{
      if(_emailPasswordControl(email, password)){
        state = ViewState.Busy;
        _user = await _userRepository.signInWithEmail(email,password);
        return _user;
      }else return null;

    }catch(e){
      print('ViewModel deki signInWithEmail userda hata' + e.toString());
      return null;
    }finally{
      state = ViewState.Idle;
    }
  }


  bool _emailPasswordControl(String email,String password){

    var result = true;
    if(password.length < 6){
      passwordError = 'En az 6 karakter olmalı';
      result = false;
    }else passwordError = null;
    if(!email.contains('@')){
      emailError = 'Geçersiz email adresi';
      result = false;
    }else emailError = null;
    return result;


  }



}