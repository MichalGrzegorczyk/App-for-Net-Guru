import 'package:flutter/material.dart';
import 'package:flutter_app/addValue.dart';
import 'package:flutter_app/class/Value.dart';
import 'package:flutter_app/dbHelper.dart';
import 'class/FavValue.dart';
import 'valuesList.dart';
import 'favValuesList.dart';


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
      darkTheme: ThemeData.dark(),
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
  List <Value> values =  [];
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
      _currentValueIndex = _currentValueIndex < values.length -1
          ? _currentValueIndex +1
          : 0;

    });
  }

    void _insertDefaultValues(){
      String tableName = "NGValues";
      var helper = DbHelper();
      for(int i = 0; i<valuesStrings.length;i++){
        helper.insertEntry(
            new Value(
                id:0,
                text: valuesStrings[i]
            ),
            tableName
        );
    }


    }
    



    void _updateValues() async{
     await dbHelper.open().then((_) => dbHelper.getEntries().then((value) => {
        setState(() {
          values = value;
          }
        )
      }));
  }




  @override
  Widget build(BuildContext context) {
    if(values.isEmpty){
      _insertDefaultValues();
    }
    _updateValues();

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.favorite), onPressed: (){
          var helper = DbHelper();
          helper.insertEntry(
              new FavValue(
                  id:0,
                  valueId: values[_currentValueIndex].id
              ),
              'favouriteValues'
          );

        })
      ],
      ),
      body: FutureBuilder<List>(
        future: dbHelper.getEntries(),
        initialData:[],
        builder:(context,snapshot){
          return snapshot.hasData ?


     new   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Typewriter(
                  text: values[_currentValueIndex].text,
                  textStyle: const TextStyle(
                    fontFamily: 'Satisfy',
                    fontSize: 48.0,
                  ),
                  onComplete: _nextValue,
                )

              ],

            )
        ): Center();
        }
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => AddValueScreen()
              )),

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
                icon: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ValuesListScreen()),
                  ),
                  color: Colors.white, icon: Icon(Icons.format_quote_sharp),),
                label: "Values",
              ),

              BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavValuesListScreen()),
                    ),
                    color: Colors.white,
                    icon: Icon(  Icons.favorite),),

                  label: "Favourites"
              )

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

