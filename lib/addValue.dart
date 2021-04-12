import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dbHelper.dart';
import 'package:flutter_app/class/Value.dart';

class AddValueScreen extends StatefulWidget {
  @override
  _AddValueScreenState createState() => _AddValueScreenState();
}

class _AddValueScreenState extends State<AddValueScreen> {

  TextEditingController valueController = new TextEditingController();
  String tableName = "NGValues";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New value"),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          TextField(
            controller: valueController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Value',
            )
          ),
          MaterialButton(onPressed: (){
            var helper = DbHelper();
            helper.insertEntry(
              new Value(
                id:0,
                text: valueController.text
                ),
                tableName
            );
            Navigator.pop(context);
          },
          child: Text("Add"),)
        ],
      )
    );
  }
}
