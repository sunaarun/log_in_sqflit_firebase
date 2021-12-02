import 'package:flutter/material.dart';
import 'package:health_calorie_db/ui_classes/gym_pages/gyms.dart';
import 'package:health_calorie_db/ui_classes/restauran_pages/restaurant_map.dart';
import 'package:health_calorie_db/ui_classes/user_settings/settings_page.dart';
import 'package:health_calorie_db/ui_classes/shareContactRate_packages/contactScreen.dart';
import 'package:health_calorie_db/ui_classes/food_categories_screen/food_calories_tabs.dart';
import 'package:health_calorie_db/ui_classes/home_pages/home_page_with_drawer.dart';
import 'package:health_calorie_db/ui_classes/log_in_up_pages/log_up_page.dart';
import 'package:health_calorie_db/ui_classes/shareContactRate_packages/rate_us.dart';
import 'package:health_calorie_db/ui_classes/my_calories_pages/myCalories_page.dart';
import 'package:health_calorie_db/ui_classes/shareContactRate_packages/share_screen.dart';

class navigationsClass {

  void HOMEnavigate(BuildContext context, String email){ // to navigate to Home page whenever called thi method
    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
        builder: (context)=> new homepageDRAWER(email )
    ),(Route<dynamic> route) => false
    );
  }

  void LOGUPnavigate(BuildContext context){ // to navigate log up page
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new logUp()));
  }

  void foodNAVIGATION(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> food_categories_page()));
  }

  void RestaurantNavigation(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new restMapScreen()));
  }
  void GYMnavigation(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new gymPage()));
  }

  void myCaloriesNavigation(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new myCalories()));
  }

  void shareScreen(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new share_screen()));
  }
  void CONTACTScreen(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new contactScreen()));
  }

  void mycalories2(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new RateClass()));
  }

  void settingScreen(BuildContext context)
  {
    Navigator.push(context, new MaterialPageRoute(builder: (context)=> new settingPage()));
  }


  void showSnackBar(BuildContext buildContext, String msg) {
    final snackbar = SnackBar(content:  Text(msg,
      style:  TextStyle(color: Colors.red),),
      backgroundColor: Colors.white,);
    Scaffold.of(buildContext).showSnackBar(snackbar);
  }

  showAlertDailogForMBI(double bmi , BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Body Mass Index (BMI) ',
              style: TextStyle(fontSize: 20,color: Colors.lightBlue[700],fontWeight: FontWeight.bold),),
            content: Container(
              height: 300,
              child: ListView(
                children: <Widget>[
                  ListTile(title :textStyle('U : Under Weight ', Colors.amber ,),
                    subtitle: Text('BMI under 18.5'),),
                  ListTile(title :textStyle('N : Normal Weight ', Colors.green),
                    subtitle: Text('BMI between 18.5 to 24.9'),),
                  ListTile(title :textStyle('O :  Overweight ', Colors.orange),
                    subtitle: Text('BMI between 25 to 30'),),
                  ListTile(title: textStyle('OB :  Obese ', Colors.red),
                    subtitle: Text('BMI is over 30'),),
                ],
              ),
            ),
          );

        });
  }

  textStyle(String string,Color color)
  {
    return Text(string , style:  TextStyle(color: color , fontWeight: FontWeight.bold),);
  }
}