import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Integration Methods"),
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: <Widget>[
            Text("Select a method you would like to calculate the integral with. Enter the integral. Supported operands: +, -, *, /, e, sin, cos, tan, ^. Any of these may be nested in each other. Select a single variable such as x or a. Enter the equation and enter the variable name. Select the starting and ending point a and b where the integral would be the equation from a to b. Enter the intervals if the input is required. The larger the interval, the more accurate the methods are. Select all to compare all methods which each other.", style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    ); 
  } 
}