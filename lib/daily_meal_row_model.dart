


class daily_meal_row_model{
  int? f_id;
  String food_name ;
  double ate_calories ;
  double grams ;
  String meal_at;
  int minute ;
  int hour ;
  int day ;
  int month ;

  daily_meal_row_model(this.f_id,this.food_name, this.ate_calories ,this.grams ,
      this.meal_at ,this.minute ,this.hour , this.day , this.month);

  daily_meal_row_model.fromMap(Map<String , dynamic> obj) {
    f_id =obj['f_id'];
    food_name = obj['food_name'];
    ate_calories = obj['ate_calories'];
    grams = obj['grams'];
    meal_at = obj['meal_at'];
    minute = obj['minute'];
    hour = obj['hour'];
    day = obj['day'];
    month = obj['month'];


  }
  Map<String ,dynamic> toMap(){

    var map = new Map<String, dynamic>();
    map['f_id'] = f_id;
    map['food_name'] = food_name ;
    map['ate_calories'] = ate_calories ;
    map['grams'] = grams;
    map['meal_at'] = meal_at ;
    map['minute'] = minute;
    map['hour'] = hour ;
    map['day'] = day ;
    map['month'] = month;

    return map ;
  }
}