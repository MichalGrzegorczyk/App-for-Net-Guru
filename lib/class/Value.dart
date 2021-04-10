import 'package:flutter_app/class/DbTable.dart';

class Value implements DbTable{
  final int id;
  final String text;

  Value({this.id, this.text});

  Map<String, dynamic> toMapWithoutId(){
    return {
      'text': text
    };
  }

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'text': text
      };
    }
  static Value fromMap(Map<String, dynamic> map){
    return new Value(
      id: map['id'],
      text: map['text']
    );

      }
}
