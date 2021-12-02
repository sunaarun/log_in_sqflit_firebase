

import 'food_model.dart';

import 'daily_meal_row_model.dart';
import 'sqfliteDBHelper.dart';


class db_query{
  SQFliteDBHelper _fliteDBHelper = new SQFliteDBHelper();

  static const String calorie_table = 'calories';

  // Do query that return the total calories for a particular meal in a particular day
  double get_total_one_meal_calories(String meal_name ,List<daily_meal_row_model> list_of_food, int day, int month ) {

    double cal =0.0;
    for(int i=0 ; i< list_of_food.length ; i++ )
    {
      if(list_of_food[i].meal_at == meal_name && list_of_food[i].day == day  && list_of_food[i].month == month){
        cal =cal +list_of_food[i].ate_calories ; // to calculate how many calories ate for one meal
      } // if
    }// for*/
    return cal;
  }

  // Do query that return a list of food has been eaten by user for a particular meal

  List<daily_meal_row_model> get_all_food_list_for_a_meal(String meal_name, List<daily_meal_row_model> list_of_food, int day, int month) {

    List<daily_meal_row_model> c = new List<daily_meal_row_model>() ;
    daily_meal_row_model daily_meal ;

    for(int i =0 ;i<list_of_food.length ; i++){
      if(list_of_food[i].meal_at == meal_name && list_of_food[i].day == day && list_of_food[i].month == month){

        daily_meal = new daily_meal_row_model(list_of_food[i].f_id,list_of_food[i].food_name,
            list_of_food[i].ate_calories,list_of_food[i].grams, list_of_food[i].meal_at, list_of_food[i].minute,
            list_of_food[i].hour, list_of_food[i].day,list_of_food[i].month);

        c.add(daily_meal);
      } // if
    } // for

    return c ;
  }

  String displayList(String meal_name ,List<daily_meal_row_model> list_of_food, int day , int month){
    List<daily_meal_row_model> listTOdisplay = new List<daily_meal_row_model>() ;
    String foodList ="";
    listTOdisplay = get_all_food_list_for_a_meal(meal_name, list_of_food, day, month);
    for(int i =0 ; i<listTOdisplay.length; i++){
      foodList = foodList + listTOdisplay[i].food_name +',';
    }

    return foodList;
  }

  // To calculate for a whole one day calories
  double total_calories_for_whole_day(List<daily_meal_row_model> list_of_food, int day, int month){
    double total =0.0 ;
    for(int i=0 ;i<list_of_food.length ; i++) {
      if(list_of_food[i].day == day  && list_of_food[i].month == month)
        total = total +list_of_food[i].ate_calories ;
    }
    return total ;
  }

  Future<daily_meal_row_model> save_meal_row (food_model food_element,
      double total_cal, double quantity , String meal , DateTime time) async{
    int minute = time.minute ;
    int hour = time.hour ;
    int day = time.day;
    int month = time.month ;
    daily_meal_row_model daiyl_meal =
     daily_meal_row_model(null, food_element.food_name, total_cal, quantity, meal, minute , hour , day , month);

    var dbClient = await _fliteDBHelper.datebase;
    daiyl_meal.f_id = await dbClient.insert(calorie_table, daiyl_meal.toMap());
    return daiyl_meal;

  }
}