import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite =false});

  void _setFavorite(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }
  Future<void> toggleFavoriteStatus( String token , String userId) async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =  'https://shop-dfece-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try{
      final res =await http.put(Uri.parse(url),body: json.encode(isFavorite));
      if( res.statusCode >= 400){
        _setFavorite(oldStatus);

      }
    }catch(error){ _setFavorite(oldStatus);}
  }
}
