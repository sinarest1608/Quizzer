import 'dart:async';
import 'dart:convert';
import'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:quizer/resultpage.dart';

class getjson extends StatelessWidget {

  String qname;
  getjson(this.qname);
  String assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    if (qname == "Avengers") {
      assettoload = "assets/avengers.json";
    }else if(qname == "Harry Potter") {
      assettoload = "assets/harry.json";
    }else if(qname == "Pokemon") {
      assettoload = "assets/pokemon.json";
    }else if(qname == "Naruto") {
      assettoload = "assets/naruto.json";
    }
    assettoload = assettoload.toString();
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assettoload),
      builder: (context, snapshot){
        List mydata = json.decode(snapshot.data.toString());
        if(mydata == null){
          return Scaffold(
            body: Center(
              child: Text("Loading"),
            )
          );
        }
        else{
          return quizpage(mydata: mydata);
        }
      },  
    );
  }
} 

class quizpage extends StatefulWidget {

  var mydata;
  quizpage({Key key, @required this.mydata}) : super(key : key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {

  var mydata;
  int q=0;
  _quizpageState(this.mydata);

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.greenAccent;
  Color wrong = Colors.redAccent;
  int marks = 0, i=1, timer = 30;
  String showtimer = "30";


  Map<String, Color> btncolor = {
    "a" : Colors.indigoAccent,
    "b" : Colors.indigoAccent,
    "c" : Colors.indigoAccent,
    "d" : Colors.indigoAccent,
  };
  bool canceltimer = false;
  @override
  void initState() {
    starttimer();
    super.initState();
  }

  void starttimer() async {
    const onesec = Duration(seconds : 1);
    Timer.periodic(onesec, (Timer t){
      setState(() {
        if(timer < 1){
          t.cancel();
        }
        else if(canceltimer == true){
          t.cancel();
        }
        else{
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (i < 10) {
        i++;
      } 
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }

      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
    });
    starttimer();
  }

  void checkanswer(String k){
    if(mydata[2][i.toString()] == mydata[1][i.toString()][k]){
      marks = marks + 5;
      colortoshow = right;
    }
    else{
      colortoshow = wrong;
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
    });

    Timer(Duration(seconds : 1), nextquestion);
  }

  Widget choicebutton(String k){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          maxLines: 5,
        ),
        color: btncolor[k],
        splashColor: Colors.indigoAccent[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Alert",
            ),
            content: Text(
              "You can't quit at this moment. Contact administrator."
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3, 
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.centerLeft,
              child: Text(
                mydata[0][i.toString()],
                style: TextStyle(
                  fontSize: 28.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6, 
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  choicebutton('a'),
                  choicebutton('b'),
                  choicebutton('c'),
                  choicebutton('d'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1, 
            child: Container(
              alignment: Alignment.topCenter,
              child: Center(
                child: Text(
                  showtimer,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    )
    );
  }
}