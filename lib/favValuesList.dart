import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dbHelper.dart';
import 'package:flutter_app/class/Value.dart';

List favValues;



class FavValuesListScreen extends StatelessWidget {

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Favourite Net guru values")),
        body: FutureBuilder<List>(
          future: dbHelper.getFavouriteEntries(),
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
    return new ListTile(
        title: new Text(value.text)
    );
  }

}