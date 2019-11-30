import 'package:flutter/material.dart';

import 'home.dart';

class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key key, @required this.marks}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {

  List<String> images = [
    "images/good.jpg",
    "images/hap.jpg",
    "images/bad.jpg",
  ];

  String image;
  String msg;
  @override
  void  initState(){
    if(marks < 20){
      image = images[2];
      msg = "You Scored $marks/50";
    }
    else if(marks < 35){
      image = images[1];
      msg = "You Scored $marks/50";
    }
    else{
      image = images[0];
      msg = "You Scored $marks/50 ";
    }
    super.initState();
  }
  int marks;
  _resultpageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result page",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                      child: Center(
                        child: Text(
                          msg,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  borderSide: BorderSide(width: 2.0, color: Colors.indigoAccent),
                  splashColor: Colors.indigoAccent,
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}