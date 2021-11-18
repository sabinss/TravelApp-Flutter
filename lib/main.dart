import 'package:flutter/material.dart';
import 'package:travel_app/provider/places.dart';
import './screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PlacesProvider(),
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
