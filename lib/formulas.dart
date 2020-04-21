import 'package:flutter/material.dart';


class Formulas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const textstyle= TextStyle(fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulas"),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 0, 6),
                child: Text("Simpson's Method: ", style: textstyle, ),
              ),
              Image(image: AssetImage('assets/simps.png')),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 6),
                child: Text("Composite Simpson's Method: ", style: textstyle),
              ),
              Image(image: AssetImage('assets/comps.png')),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 6),
                child: Text("Midpoint Method: ", style: textstyle),
              ),
              Image(image: AssetImage('assets/midpoint.png')),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 6),
                child: Text("Trapezoid Method: ", style: textstyle),
              ),
              Image(image: AssetImage('assets/trape.png')),
            ],
          ),
        ),
      ),
    );
  }
}