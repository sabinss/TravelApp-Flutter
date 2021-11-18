import 'package:flutter/material.dart';
import '../model/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesProvider with ChangeNotifier {
  List<Place> placesList = [];

  Future<List<Place>> getPlaces() async {
    try {
      final response = await http.get(Uri.parse(
          'https://21sabin.github.io/TravelApp-Json-API/places.json'));
      List<dynamic> places = jsonDecode(response.body)['data'];
      placesList =
          List<Place>.from(places.map((e) => Place.fromJson(e)).toList());
      notifyListeners();
    } catch (e) {
      print('error in fetching places $e');
    }
  }

  Place findPlaceById(int id) {
    return placesList.firstWhere((element) => element.id == id);
  }
}
