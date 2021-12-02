import 'dart:io' as io;
import 'dart:async';
import 'user_info.dart';
import "daily_meal_row_model.dart";
import 'userInApp.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';




class SQFliteDBHelper{
  static Database db ;

  static const String user_id ='user_id';
  static const String u_name ='user_name' ;
  static const String u_email = 'user_email';
  static const String u_weight = 'user_weight' ;
  static const String u_height ='user_height' ;
  static const String user_lat ='user_lat';
  static const String user_long  = 'user_long';
  static  const String checkLogIn ='checkLogIN';
  static const String userTable = 'userTable';

  // calorei table

  static const String f_id = 'f_id';
  static const String f_name ='food_name';
  static const String f_calorie = 'ate_calories';
  static const String grams = 'grams';
  static const String meal_at = 'meal_at';
  static const String time_at = 'time_at';
  static const String minute = 'minute';
  static const String hour ='hour';
  static const String day = 'day';
  static const String month ='month';
  static const String calorie_table = 'calories';
  // static  double TotalCalories =0.0;
  // db name
  static const String DB_NAME = 'user.db' ;
  static String path ;

  Future<bool> isLoggedIn() async{
    var dbClient = await datebase;
    var res =await dbClient.query(userTable);
    if(res.length >0) {
      print('users in our db system is : '+ res.length.toString());
      return true ;
    }
    else {
      print('first time log in ');
      return false;
    }

  }
  Future<Database> get datebase async {
    if(db != null){
      return db ;
    }
    db = await initDatabase();
    return db ;
  }

  initDatabase()async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    path = join(documentDirectory.path , DB_NAME);
    var db = await openDatabase(path , version: 1 , onCreate: onCreate);
    return db;
  }

  onCreate(Database db , int version) async{
    // create user table
    await db.execute("CREATE TABLE $userTable ($user_id INTEGER PRIMARY KEY , $u_name TEXT , $u_email TEXT ,$u_weight REAL , "
        "$u_height REAL ,$user_lat REAL , $user_long REAL , $checkLogIn INTEGER)");

    //create daily meal table
    await db.execute("CREATE TABLE $calorie_table ( $f_id INTEGER PRIMARY KEY ,$f_name TEXT ,"
        " $f_calorie REAL ,$grams REAL , $meal_at TEXT , $minute INTEGER , $hour INTEGER , $day INTEGER ,$month INTEGER )");

  }

  Future<userInApp> SAVE_USER (userInApp user) async{
    var dbClient = await datebase;
    user.user_id = await dbClient.insert(userTable, user.toMap());
    //print('user has been saved' + '   ${user.user_id}');
    return user;

  }

  Future<daily_meal_row_model> save_meal_row (daily_meal_row_model meal_row) async{
    var dbClient = await datebase;
    meal_row.f_id = await dbClient.insert(calorie_table, meal_row.toMap());
    return meal_row;

  }

  Future<userInApp>  getUSERDetails(String email) async{
    var dbClient = await datebase ;
    List<Map> maps_tow = await  dbClient.rawQuery("SELECT * FROM $userTable") ;
    List<userInApp> users =[];
    if
    (maps_tow.length >0) {
      print(maps_tow.length.toString());
      for(int i = 0; i<maps_tow.length ;i++){
        users.add(userInApp.fromMap(maps_tow[i]));
        // print(users[i].user_email + users[i].user_name);
      }
    } //
    return users[0] ;
  }
  Future<int> updateUser( userInApp user) async {
    var dbClient = await datebase ;
    // return await dbClient.rawUpdate('UPDATE $userTable SET $u_name = ?  WHERE $user_id = $uid' , ['$new_name']);
    return await dbClient.update(userTable, user.toMap(), where: '$user_id= ?', whereArgs: [user.user_id]);
  }



  Future<List<daily_meal_row_model>>  getALL_meals_for_month(int month) async{
    var dbClient = await datebase ;
    List<Map> maps = await  dbClient.rawQuery("SELECT * FROM $calorie_table") ;
    List<daily_meal_row_model> meals =[];
    if
    (maps.length >0) {
      for(int i = 0; i<maps.length ;i++) {
        if (maps[i]['month'] == month) {
          meals.add(daily_meal_row_model.fromMap(maps[i]));
        }
      }
    } // if
    return meals ;
  }

  Future<double> getTotalCaloriesForMonth(int month) async {
    double total = 0.0 ;
    var dbClient = await datebase;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $calorie_table");
    if(maps.length>0) {
      for (int i = 0; i < maps.length; i++) {
        if (maps[i]['month'] == month) {
          total = total + maps[i]['ate_calories'];
        }
      }
    }
    return total;
  }

  Future<double> getTotalAverageForMonth(int month)async {
    double total =0.0;
    double average =0.0;
    var dbClient = await datebase;
    List<Map> foodList = await dbClient.rawQuery("SELECT *FROM $calorie_table");
    List<int> days = new List<int>();
    if(foodList.length>0 ){
      for(int i=0; i<foodList.length ; i++){
        if(foodList[i]['month'] == month)
        {
          total = total+ foodList[i]['ate_calories'];
          if(!days.contains(foodList[i]['day'])) {
            days.add(foodList[i]['day']);
          }
        }
      }
      average = total/days.length;
    }
    return average ;
  }
  Future<List<int>> listOfDays(int month) async{
    var dbClient = await datebase;
    List<Map> foodList = await dbClient.rawQuery("SELECT *FROM $calorie_table");
    List<int> days = new List<int>();
    days=[];
    if(foodList.length>0)
    {
      for(int i=0; i<foodList.length ; i++)
      {
        if(foodList[i]['month'] ==month)
        {
          if(!days.contains(foodList[i]['day'])){
            days.add(foodList[i]['day']);
          }
        }
      }
    }
    return days;
  }

  Future<List<daily_meal_row_model>>  get_one_type_meal_list(String meal_name, int d , int m ) async{
    var dbClient = await datebase ;
    List<Map> maps = await  dbClient.rawQuery("SELECT * FROM $calorie_table WHERE $meal_at = '$meal_name' AND $day = '$d'"
        "AND $month ='$m'") ;
    List<daily_meal_row_model> meals =[];
    if (maps.length >0) {
      for(int i = 0; i<maps.length ;i++){
        meals.add(daily_meal_row_model.fromMap(maps[i]));
        print(meals[i].food_name +' '+ meals[i].meal_at+'\n' );
      }
    } // if
    return meals ;
  }

  // to delete
  Future<int> delete_felement (int id) async {
    var dbClient = await datebase;
    return await dbClient.delete(calorie_table , where: '$f_id = ?', whereArgs: [id]);

  }

  Future<void> deleteDB() async {
    try{

      print('deleting db');
      db=null;
      deleteDatabase(path);
    }catch( e){
      print(e.toString());
    }

    print('db is deleted');
  }

}
