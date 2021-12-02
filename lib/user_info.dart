

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:health_calorie_db/data_models/countries_and_cities/city_model.dart';

class userModel {
  String user_id ;
  String user_name ;
  String user_email;
  String user_gender;
  double user_weight ;
  double user_height ;
  double user_current_lat ;
  double user_current_long ;
  GeoPoint cityPoint ;
  bool checkLogIN =false;


  userModel(this.user_id ,this.user_name , this.user_email ,this.user_gender, this.user_weight , this.user_height, this.cityPoint , this.checkLogIN);

  userModel.map(dynamic obj){
    this.user_name = obj['user_name'];
    this.user_email = obj['user_email'];
    this.user_gender = obj['user_gender'];
    this.user_weight = obj['user_weight'];
    this.user_height = obj['user_height'];
    this.cityPoint= obj['cityPoint'];
    this.checkLogIN =obj['checkLogIn'];
  }
  Map<String , dynamic> toMap(){ // to send data to Firestore
    var map = new Map<String ,dynamic>();
    map['user_name'] = user_name ;
    map['user_email'] = user_email;
    map['user_gender'] = user_gender;
    map['user_weight'] = user_weight ;
    map['user_height'] = user_height;
    map['cityPoint'] = cityPoint;
    map['checkLogIn']=checkLogIN;
    return map ;
  }

  userModel.fromMap(Map<String , dynamic> map){ // to unpacked data that's coming from Firestore
    this.user_name = map['user_name'] ;
    this.user_email = map['user_email'];
    this.user_gender= map['user_gender'];
    this.user_weight = map['user_weight'] ;
    this.user_height = map['user_height'];
    this.cityPoint= map['cityPoint'];
    this.checkLogIN= map['checkLogIn'];
  }
  void setUserLatlong( double lat , double lon)  {

  }


}

