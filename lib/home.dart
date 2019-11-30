import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizer/quizpage.dart';
import 'package:quizer/resultpage.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> pics = [
    "images/avg.jpg",
    "images/hp.jpg",
    //"images/sw.jpg",
    "images/pok.jpg",
    "images/nar.jpg",
  ];
  List<String> description = [
    "How Well Do You Know The Avengers?\nTests for the real fan",
    "Only True Fans Can Complete This Harry Potter Quiz\nTests both Book and Movie knowledge",
    "Who's That Pokemon?\nCan you name all the Pokemon? Well here are 10 different Pokemon, and I will give you hints, so you can have an idea of which Pokemon it is. See how well you know about the Pokemon. Good luck!",
    "The Ultimate Naruto Quiz!\nDo you think you know everything about Naruto? From Naruto to Naruto Shippuden to all its movies and everything in between? Then this quiz will be perfect for you!",
  ];

  Widget customcard(String qname, String im, String des){
    return Padding(
      
      padding: EdgeInsets.all(20.0),
      
      child: InkWell(
        
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getjson(qname),
          ));
        },
        child: Material(
          color: Colors.indigoAccent,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage(
                            im,
                          ),
                        ),
                      )
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    qname,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,

                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    maxLines: 8,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )
          )
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      //backgroundColor: Colors.white,
    
      appBar: AppBar(
        title: Text(
          "Quizer",
        ),
      ),
      
      body: 
       
      ListView(
        children: <Widget>[
          
          customcard("Avengers", pics[0], description[0]),
          customcard("Harry Potter", pics[1], description[1]),
          //customcard("Star Wars", pics[2], description[2]),
          customcard("Pokemon", pics[2], description[2]),
          customcard("Naruto", pics[3], description[3]),
        ],
      ),
      
    );
  }
}