import 'package:flutter_app/class/DbTable.dart';

class FavValue implements DbTable{
  final int id;
  final int valueId;

  FavValue({this.id, this.valueId});

  Map<String, dynamic> toMapWithoutId(){
    return {
      'valueId': valueId
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valueId': valueId
    };
  }
  static FavValue fromMap(Map<String, dynamic> map){
    return new FavValue(
        id: map['id'],
        valueId: map['valueId']
    );

  }
}