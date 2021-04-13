import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dbHelper.dart';
import 'package:flutter_app/class/Value.dart';

List values;



class ValuesListScreen extends StatelessWidget {

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Net guru values")),
        body: FutureBuilder<List>(
            future: dbHelper.getEntries(),
            initialData: [],
            builder: (context, snapshot) {
    return snapshot.hasData ?
    new ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (context, i) {
    return _buildRow(snapshot.data[i]);
    }
    ): Center(
      child: CircularProgressIndicator(),
    );
    },
    )
    );
  }
    Widget _buildRow(Value value) {
    return new
    Card (
      child:ListTile(
          leading: new Icon(Icons.format_quote, color:Colors.white,size: 33.0),
          title: new Text(value.text, style: TextStyle(color: Colors.white, fontFamily: 'Satisfy', fontSize: 25.0),)
      ),
      color: Colors.green,
      elevation: 3.0,
    );
    }

}