import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_app/class/Value.dart';
import 'package:flutter_app/dbHelper.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NG Values',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'NG Values'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;   

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var dbHelper = DbHelper();
  List <Value> values;
  List <String> valuesStrings = [
    "Exceed clients' and colleagues' expectations",
    "Take ownership and question the status quo in a constructive manner",
    "Be brave, curious and experiment. Learn from all successes and failures",
    "Act in a way that makes all of us proud",
    "Build an inclusive, transparent and socially responsible culture",
    "Be ambitious, grow yourself and the people around you",
    "Recognize excellence and engagement"
  ];


  void _listValues(List<String> valuesStrings){
    for(int i = 0; i<valuesStrings.length;i++) {
      values[i] = new Value(id: i,text: valuesStrings[i]);
    }
  }

  void _addValuesToDb(List<Value> values) {
    for (int i = 0; i < values.length; i++) {
      dbHelper.insertEntry(values[i], "values");
    }
  }
    void _updateValues(){
      dbHelper.open().then((_) => dbHelper.getEntries().then((value) => {
        setState(() {
          values = value;
        })
      }));

  }

  @override
  Widget build(BuildContext context) {

    _listValues(valuesStrings);
    _addValuesToDb(values);
    _updateValues();

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.favorite), onPressed: (){

        })
      ],
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
            width: 250.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.black
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                      values[0].text,
                  speed: const Duration(milliseconds: 100),
                    textStyle: const TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 48.0,
                    )
                  ),
                  TyperAnimatedText(
                      valuesStrings[1],
                    speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                        fontFamily: 'Satisfy',
                        fontSize: 48.0,
                      )
                  ),

                ],

                pause: const Duration(milliseconds: 5000),
              ),
            ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(


        tooltip: 'Increment',
        foregroundColor: Colors.black,
        hoverColor: Colors.white,
        backgroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
      color: Colors.green,
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote_sharp,
            size: 39,
            color: Colors.white),
            label: "Values",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: Colors.white),
            label: "Favourites",
          ),
        ],
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
