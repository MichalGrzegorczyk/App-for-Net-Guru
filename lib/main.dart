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

  int _currentValueIndex = 0;

  void _nextValue(){
    setState(() {
      _currentValueIndex = _currentValueIndex < valuesStrings.length -1
          ? _currentValueIndex +1
          : 0;

    });
  }

    



    void _updateValues(){
      dbHelper.open().then((_) => dbHelper.getEntries().then((value) => {
        setState(() {
          values = value;
          for(int i = 0;i<values.length;i++){
            valuesStrings[i] =values[i].text;
          }
        })
      }));
  }




  @override
  Widget build(BuildContext context) {

    // _updateValues();

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
           children:[
           Typewriter(
            text: valuesStrings[_currentValueIndex],
            textStyle: const TextStyle(
              fontFamily: 'Satisfy',
              fontSize: 48.0,
            ),
             onComplete: _nextValue,
          )
            //_valuesAnimations(valuesStrings)
     /*    SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 30.0,
                color: Colors.black
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                    valuesStrings[0],
                    speed: const Duration(milliseconds: 100),
                    textStyle: const TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 48.0,
                    )
                )


              ],

              pause: const Duration(milliseconds: 5000),
            ),
          ),
        )*/
          ],

        )
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
class _TypewriterState extends State<Typewriter> {
  String _textToType;
  int _nextToTypeIndex;
  String _typedText;

  @override
  void initState() {

    super.initState();

    _textToType = widget.text;
    _nextToTypeIndex = 0;
    _typedText = '';

    _typeNewText();

  }


  @override
  void didUpdateWidget(Typewriter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.text != oldWidget.text){
      _textToType = widget.text;
      _nextToTypeIndex = 0;
      _typedText ='';
      _typeNewText();
    }
    
  }

  Future<void> _typeNewText() async {
    await Future.delayed(const Duration(seconds:1));

    if(!mounted){
      return;
    }
    for(int i = _nextToTypeIndex; i< _textToType.length;i++){
      await Future.delayed(const Duration(milliseconds: 110));
      if(!mounted){
        return;
      }

      setState(() {
        _typedText = _textToType.substring(0,i+1);
      });

    }

    await Future.delayed(const Duration(seconds: 5));
    if(mounted){
      widget.onComplete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _typedText,
          style: widget.textStyle
        )
      ],
    );
  }
}
class Typewriter extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onComplete;

  const Typewriter({Key key, this.text, this.textStyle, this.onComplete}) : super(key: key);

  @override
  _TypewriterState createState() => _TypewriterState();
}


