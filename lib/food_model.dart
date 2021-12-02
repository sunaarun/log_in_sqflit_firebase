
class food_model
{
  String food_name ;
  String food_calorie ;
  String category ;
  String food_image ;
  var food_calorie_per_gram =new Map();

  food_model(this.food_name , this.food_calorie , this.category, this.food_calorie_per_gram , this.food_image);

  food_model.map(dynamic obj){ // to dens data to firestore
    this.food_name = obj['food_name'];
    this.food_calorie = obj['food_calorie'];
    this.category = obj['category'];
    this.food_calorie_per_gram['food_calorie']= obj['food_calorie_per_gram']['food_calorie'];
    this.food_calorie_per_gram['per_gram'] = obj['food_calorie_per_gram']['per_gram'] ;
    this.food_image = obj['food_image'];

  }

  Map<String, dynamic> toMap() // to send data from app to Firestore
  {
    var map = new Map<String, dynamic>();
    map['food_name'] = food_name ;
    map['food_calorie'] = food_calorie;
    map['category'] = category ;
    map['food_calorie_per_gram'] = food_calorie_per_gram.values ;
    return map ;
  }

  food_model.fromMap(Map<String ,dynamic> map)
  {  // to unpack the data that coming from firestore
    this.food_name = map['food_name'];
    this.food_calorie = map['food_calorie'];
    this.category = map['category'];
    this.food_calorie_per_gram['food_calorie']= map['food_calorie_per_gram']['food_calorie'];
    this.food_calorie_per_gram['per_gram'] = map['food_calorie_per_gram']['per_gram'] ;


  }
}

