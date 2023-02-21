import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../dbhelper/Databasehelper.dart';
import '../pages/usermodel.dart';


class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  List<UserModel> userList = [];
  List<UserModel> currentUser = [];
  bool hasData = false;
  List<UserModel> user = [];
  List<UserModel> userData = [];
  List<UserModel> allUserList = [];

  hasDataLoaded() {
    if (currentUser.length > 0) {
      hasData = true;
      notifyListeners();
    } else {
      hasData = false;
      notifyListeners();
    }
  }


  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      DatabaseHelper.getUserById(uid);

  getCurrentUserData(String uid) {
    DatabaseHelper.getCurrentUserData(uid: uid).listen((event) {
      currentUser = List.generate(event.docs.length,
          (index) => UserModel.fromMap(event.docs[index].data()));
      notifyListeners();
      if (currentUser.isNotEmpty) {
        hasData = true;
        notifyListeners();
      } else {
        hasData = false;
        notifyListeners();
      }
    });
  }

  void updateUser(String uid, Map<String, dynamic> map) async {
    await DatabaseHelper.updateUser(uid, map);
  }

  suggestions (){

  }


  getAllUser(String uid) {
    DatabaseHelper.getAllUsers()
        .listen((event) {
      allUserList = List.generate(event.docs.length,
              (index) => UserModel.fromMap(event.docs[index].data()));


      // for (var i = 0; i < allUserList.length; i++) {
      //   if (allUserList[i].uid == uid) {
      //     allUserList.removeAt(i);
      //   }
      // }
      // for (var i = 0; i < allUserList.length; i++) {
      //   for (var j = 0; j < connectionsList.length; j++) {
      //
      //     if (connectionsList[j].toId == uid || connectionsList[j].fromId == uid) {
      //
      //       allUserList.removeAt(i);
      //       break;
      //     } else {
      //       continue;
      //     }
      //   }
      // }
      allUserList.shuffle();
      notifyListeners();
    });
  }


  getAllUsers() {
    DatabaseHelper.getAllUsers().listen((event) {
      userList = List.generate(event.docs.length,
          (index) => UserModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }




}
