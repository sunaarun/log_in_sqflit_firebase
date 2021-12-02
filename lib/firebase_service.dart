import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_info.dart';
import 'navigationClass.dart';
import 'sqfliteDBHelper.dart';
import 'userInApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class userServices {
  // DocumentReference documentReference ;
  final CollectionReference userCollection = Firestore.instance.collection(
      'user_table');
  static userModel user;

  SQFliteDBHelper dbHelper = new SQFliteDBHelper();
  navigationsClass nav = new navigationsClass();

  Future<bool> checkEmailDuplicated(String email) async {
    final QuerySnapshot querySnapshot = await userCollection.where(
        'user_email', isEqualTo: email).limit(1).getDocuments();
    if (querySnapshot.documents.length == 0) {
      print('no user with this email');
      return true;
    }
    print('found user with this email');
    return false;
  }

  Future checkUserDuplicated(String name, String email, String gender_type,
      double weight, double height, GeoPoint cityPoint,
      BuildContext buildContext,) async
  {
    // to check if the user is already exists in our system
    final QuerySnapshot querySnapshot = await userCollection.where(
        'user_email', isEqualTo: email).limit(1).getDocuments();
    final List<DocumentSnapshot> documents = querySnapshot.documents;
    if (documents.length == 0) {
      Map<String, dynamic> map = new Map();
      map['user_name'] = name;
      map['user_email'] = email;
      map['user_gender'] = gender_type;
      map['user_weight'] = weight;
      map['user_height'] = height;
      map['cityPoint'] = cityPoint;
      map['checkLogIn'] = true;
      user = userModel.fromMap(map);
      // new userModel(uid,name, email, weight, height, cityPoint, true);
      saveLogInInfo(user);
      nav.HOMEnavigate(buildContext, email);
    }
    else {
      String msg = 'This Email Address is already exist';
      nav.showSnackBar(buildContext, msg);
    }
  }


  Future<bool> saveLogInInfo(userModel user) async
  {
    sendDataToFireStore(user);
    saveToSQFLiteDB(user);
  }


  Future<userModel> sendDataToFireStore(userModel user) async
  {
    final TransactionHandler transactionHandler = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document());
      Map<String, dynamic> data = user.toMap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(transactionHandler).then((
        mapData) {
      return userModel.fromMap(mapData);
    }).catchError((onError) {
      print('Error is $onError');
      return null;
    });
  }


  Future<void> saveToSQFLiteDB(userModel user) async {
    userInApp u = new userInApp(
        null,
        user.user_name,
        user.user_email,
        user.user_weight,
        user.user_height,
        user.cityPoint.latitude,
        user.cityPoint.longitude,
        user.checkLogIN);
    dbHelper.SAVE_USER(u);
  }


  Future logInCheck(String name, String email, BuildContext buildContext) async
  {
    userModel user;
    final QuerySnapshot result = await userCollection.where(
        'user_email', isEqualTo: email)
        .where('user_name', isEqualTo: name)
        .limit(1)
        .getDocuments(); // searching for a particular user

    if (result.documents.length > 0) {
      final List<DocumentSnapshot> ds = result.documents;
      for (int i = 0; i < 1; i++) {
        user = new userModel(
            ds[i].documentID,
            ds[i]['user_name'],
            ds[i]['user_email'],
            ds[i]['user_gender'],
            ds[i]['user_weight'],
            ds[i]['user_height'],
            ds[i]['cityPoint'],
            ds[i]['checkLogIn']);
        //print(user.user_email + '  :  ' + user.user_id);
        saveToSQFLiteDB(user);
        //print('Added');
      }
      nav.HOMEnavigate(buildContext, email );
    } // if

    else {
      String msg = 'Couldnt find user with email \n fill with correct info';
      nav.showSnackBar(buildContext, msg);
    }
  }
}