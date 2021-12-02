
class userInApp{
  int user_id;
  String user_name;
  String user_email ;
  double user_weight;
  double user_height  ;
  double user_lat ;
  double user_long;
  bool checkLogIn ;

  userInApp(this.user_id,this.user_name, this.user_email, this.user_weight ,this.user_height, this.user_lat, this.user_long, this.checkLogIn);

  userInApp.fromMap(Map<String, dynamic> obj){

    user_id =obj['user_id'];
    user_name = obj['user_name'];
    user_email =obj['user_email'];
    user_weight= obj['user_weight'];
    user_height=obj['user_height'];
    user_lat= obj['user_lat'];
    user_long= obj['user_long'];
    checkLogIn = obj['checkLogIn'];

  }

  Map<String ,dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['user_id']=user_id;
    map['user_name']= user_name;
    map['user_email'] = user_email;
    map['user_weight']= user_weight;
    map['user_height']=user_height;
    map['user_lat']=user_lat;
    map['user_long']=user_long;
    map['checkLogIn']= checkLogIn;
    return map;


  }
}