import 'package:flutter/material.dart';

class ThemeUtil {
  static ThemeData getlitghTheme() {
    return ThemeData(

      primaryColor: Colors.grey[200],
      backgroundColor: Colors.grey[50],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: IconThemeData(color: Colors.blue),

      tabBarTheme: TabBarTheme(
        labelColor: Colors.lightBlue,
         unselectedLabelColor:  Colors.grey[600],


      ),
      sliderTheme: SliderThemeData(
          trackHeight:1,

      ),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor:Colors.transparent,modalBackgroundColor: Colors.transparent),
      dialogBackgroundColor: Colors.transparent,

    );
  }
}
