import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import './methods/simpsons_method.dart';
import './methods/trapezoidal_method.dart';
import './methods/methods.dart';
import './methods/midpoint_method.dart';
import './formulas.dart';
import './help.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Integration Methods',
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
  final numFocusa = new FocusNode();
  final numFocusb = new FocusNode();
  final numFocusint = new FocusNode();

  final eqcontroller = TextEditingController();
  final acontroller = TextEditingController();
  final bcontroller = TextEditingController();
  final varcontroller = TextEditingController();
  final intcontroller = TextEditingController();
  double valueSimp;
  double valueCompSimp;
  double valueTrapezoial;
  double valueMidpoint;
  Method mode = Method.All;
  final _formKey = GlobalKey<FormState>();

  Widget methodType(Method mode){
    double fontSize = 24;
    if(mode == Method.All){
      return (
        Column(
          children: <Widget>[
            Text((valueSimp != null) ? "Simpson's: " + (valueSimp.toStringAsPrecision(4)) : "", style: TextStyle(fontSize: fontSize),),
            Text((valueCompSimp != null) ? "C. Simpson's: " + valueCompSimp.toStringAsPrecision(4) : "", style: TextStyle(fontSize: fontSize),),
            Text((valueTrapezoial != null) ? "Trapezoidal: " + valueTrapezoial.toStringAsPrecision(4) : "", style: TextStyle(fontSize: fontSize),),
            Text((valueMidpoint != null) ? "Midpoint: " + valueMidpoint.toStringAsPrecision(4) : "", style: TextStyle(fontSize: fontSize),)
          ],
        )
      );
    }
    else if(mode == Method.Simpsons){
      return (
            Text((valueSimp != null) ? "Simpson's: " + (valueSimp.toStringAsPrecision(4)) : "", style: TextStyle(fontSize: fontSize),)
      );
    }
    else if(mode == Method.CompositeSimpsons){
      return (
            Text((valueSimp != null) ? "C. Simpson's: " + (valueSimp.toStringAsPrecision(4)) : "", style: TextStyle(fontSize: fontSize),)
      );
    }
    else if(mode == Method.Trapezoidal){
      return (
            Text((valueSimp != null) ? "Trapezoidal: " + (valueTrapezoial.toStringAsPrecision(4)) : "", style: TextStyle(fontSize: fontSize),)
      );
    }
    else if(mode == Method.Midpoint){
      return (
            Text((valueSimp != null) ? "Midpoint: " + (valueMidpoint.toStringAsPrecision(4)) : "", style: TextStyle(fontSize: fontSize),)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Integration Methods"),
        elevation: 1,
      ),
      drawer: Drawer(
        child: Container(
          child:ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image(image: AssetImage("assets/icon.png")),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.functions, color: Color.fromRGBO(120, 120, 120, 1),),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Formulas', style: TextStyle(fontSize: 16),)
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Formulas()),
                  );
                },
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.help_outline, color: Color.fromRGBO(120, 120, 120, 1),),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Help', style: TextStyle(fontSize: 16),)
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Help()),
                  );
                },
              ),
              if(!kIsWeb)
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.language, color: Color.fromRGBO(120, 120, 120, 1),),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('Website', style: TextStyle(fontSize: 16),)
                      )
                    ],
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                      const url = 'https://iberatkaya.github.io/integration_methods/#/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                  },
                ),

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: Text(
                    'Welcome to Integration Methods!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, ),
                  ),
              ),
              Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1)),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    DropdownButton(
                      value: mode,                      
                      items: [
                        DropdownMenuItem(child: Text("All"), value: Method.All),
                        DropdownMenuItem(child: Text("Simpson's Method"), value: Method.Simpsons),
                        DropdownMenuItem(child: Text("Composite Simpson's Method"), value: Method.CompositeSimpsons),
                        DropdownMenuItem(child: Text("Trapezoidal Method"), value: Method.Trapezoidal),
                        DropdownMenuItem(child: Text("Midpoint Method"), value: Method.Midpoint)
                      ],
                      onChanged: (val){
                        setState(() {
                          mode = val; 
                          valueSimp = null;
                          valueCompSimp = null;
                          valueTrapezoial = null;
                          valueMidpoint = null;
                        });
                      },
                    ),
                    TextFormField(
                      controller: eqcontroller,
                      validator: (val) {
                        if(val.isEmpty)
                          return "Cannot be empty!";
                        return null;
                      },
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
                            child: TextFormField(
                              controller: varcontroller,
                              validator: (val) {
                                if(val.isEmpty)
                                  return "Cannot be empty!";
                                if(!eqcontroller.text.contains(val))
                                  return "Variable does not exist in equation!";
                                return null;
                              },
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
                            child: TextFormField(
                              controller: acontroller,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              focusNode: numFocusa,
                              validator: (val) {
                                try {
                                  double.parse(val);
                                } catch(e) {
                                  return "Not a number!";
                                }
                                return null;
                              },
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
                            child: TextFormField(
                              controller: bcontroller,
                              focusNode: numFocusb,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                try {
                                  double.parse(val);
                                } catch(e) {
                                  return "Not a number!";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "End (b)",
                                hintText: "From a to b"
                              ),
                            ),
                          )
                        ),
                        if(mode != Method.Simpsons)
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 12, 12, 12),
                              child: TextFormField(
                                controller: intcontroller,
                                focusNode: numFocusint,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  try {
                                    double.parse(val);
                                  } catch(e) {
                                    return "Not a number!";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Interval",
                                  hintText: "Ex. 8"
                                ),
                              ),
                            )
                          ),
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        try{
                          numFocusa.unfocus();
                          numFocusb.unfocus();
                          numFocusint.unfocus();
                          if(!_formKey.currentState.validate())
                            return;
                          String eq = eqcontroller.text;
                          double a = double.parse(acontroller.text);
                          double b = double.parse(bcontroller.text);
                          int interval = int.parse(intcontroller.text);
                          String variable = varcontroller.text;
                          double simp = simpsonsMethod(eq, variable: variable, a: a, b: b);
                          double compSimp = compositeSimpsonsMethod(eq, variable: variable, a: a, b: b, interval: interval);
                          double trapezodial = trapezoidalMethod(eq, variable: variable, a: a, b: b, interval: interval);
                          double midpoint = midpointMethod(eq, variable: variable, a: a, b: b, interval: interval);
                          setState(() {
                            valueSimp = simp;                            
                            valueCompSimp = compSimp;    
                            valueTrapezoial = trapezodial;                        
                            valueMidpoint = midpoint;                        
                          });
                        } catch(e){
                          Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
                          print(e);
                        }
                      },
                      color: Colors.greenAccent,
                      child: Text("Calculate", style: TextStyle(color: Colors.black87),),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02)),
                    if(valueSimp != null || valueCompSimp != null || valueTrapezoial != null)
                      Container(
                        decoration: BoxDecoration(color: Color.fromRGBO(235, 235, 235, 1)),
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: methodType(mode)
                      )
                  ]
                ),
              )
            ],
          ),
        )
       ),
    );
  }
}
