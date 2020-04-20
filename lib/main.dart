import 'package:flutter/material.dart';
import './methods/simpsons_method.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(simpsons_method("a*sin(cos(a))", variable: "a", a: 0, b: 2));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final eqcontroller = TextEditingController();
  final acontroller = TextEditingController();
  final bcontroller = TextEditingController();
  final varcontroller = TextEditingController();
  double value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Integration Methods"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                  child: Text(
                      'Welcome to Integration Methods!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, ),
                    ),
                  ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: eqcontroller,
                      decoration: InputDecoration(
                        labelText: "Equation",
                        hintText: "Ex: x^2 + 5 * sin(x)"
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
                            child: TextField(
                              controller: varcontroller,
                              decoration: InputDecoration(
                                labelText: "Variable",
                                hintText: "Ex. x"
                              ),
                            ),
                          )
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
                            child: TextField(
                              controller: acontroller,
                              decoration: InputDecoration(
                                labelText: "Start (a)",
                                hintText: "From a to b"
                              ),
                            ),
                          )
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
                            child: TextField(
                              controller: bcontroller,
                              decoration: InputDecoration(
                                labelText: "End (b)",
                                hintText: "From a to b"
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        try{
                          if(eqcontroller.text == "")
                            return;
                          double a = double.tryParse(acontroller.text);
                          double b = double.tryParse(bcontroller.text);
                          String variable = varcontroller.text;
                          if(eqcontroller.text.contains(variable))
                          setState(() {
                            value = (simpsons_method(eqcontroller.text, variable: variable, a: a, b: b));
                            
                          });
                        } catch(e){
                          print(e);
                        }
                      },
                      color: Colors.greenAccent,
                      child: Text("Calculate", style: TextStyle(color: Colors.black87),),
                    ),
                      Text((value != null) ? value.toString() : "", style: TextStyle(fontSize: 28),)
                    
                  ]
                )
              )
            ],
          ),
        )
       ),
    );
  }
}
