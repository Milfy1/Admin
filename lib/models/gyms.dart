import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Gyms with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String location;
  final String facilites;

  Gyms({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.location,
    required this.facilites,
  });

  Map<String, Gyms> _items = {};
  Map<String, Gyms> get items {
    return {..._items};
  }
  //  Future<void> FavoiritStatus() async {
  //   final oldstates = isFavorite;
  //   // isFavorite = !isFavorite;
  //   // notifyListeners();
  //   final url = 'https://gymshome-ce96b-default-rtdb.firebaseio.com/gyms.json';
  //   try {
  //     await http.patch(
  //       Uri.parse(url),
  //       body: json.encode({'isFavorite': isFavorite}),
  //     );
  //   } catch (error) {
  //     isFavorite = oldstates;
  //   }

  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }
  //  void CompareStatus() {
  //   final oldstates = iscompared;
  //   iscompared = !iscompared;
  //   notifyListeners();
  //   // final url = 'https://shop-app-664ca-default-rtdb.firebaseio.com/prod.json';
  //   // try {
  //   //   await http.patch(
  //   //     Uri.parse(url),
  //   //     body: json.encode({'isFavorite': isFavorite}),
  //   //   );
  //   // } catch (error) {
  //   //   isFavorite = oldstates;
  //   // }

  //   // isFavorite = !isFavorite;
  //   // notifyListeners();
  // }

  // void favoriteproducts() {
  //   final oldstates = isadd;
  //   isadd = !isadd;

  //   notifyListeners();
  // }
  void additem(String productId, String title, double price, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exe) => Gyms(
                id: exe.id,
                title: exe.title,
                description: exe.description,
                price: exe.price,
                imageUrl: exe.imageUrl,
                location: exe.location,
                facilites: exe.facilites,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => Gyms(
                id: DateTime.now().toString(),
                title: title,
                description: description,
                price: price,
                imageUrl: imageUrl,
                location: location,
                facilites: facilites,
              ));
    }
    notifyListeners();
  }
}
