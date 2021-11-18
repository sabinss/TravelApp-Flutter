import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/model/place.dart';
import 'package:travel_app/provider/places.dart';
import 'dart:math';

class PlaceDetail extends StatefulWidget {
  int id;
  PlaceDetail({Key key, this.id}) : super(key: key);

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  Widget build(BuildContext context) {
    Place place = Provider.of<PlacesProvider>(context).findPlaceById(widget.id);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: Colors.grey[300].withOpacity(0.4),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const CircleAvatar(
              radius: 16.0,
              backgroundImage: NetworkImage(
                  "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"),
              backgroundColor: Colors.transparent,
            ),
          )
        ],
      ),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Container(
                height: size.height * 0.5,
                child: Image.network(place.imageUrl, fit: BoxFit.cover)),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.44),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: size.height * 0.7,
              child: Column(
                children: [
                  setPadding(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                place.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Chip(
                                  backgroundColor: Colors.green,
                                  label: Row(
                                    children: [
                                      Icon(Icons.star,
                                          size: 16, color: Colors.white),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${place.rating}/5',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                            ),
                            Text(place.location)
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  setPadding(
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Features',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Wrap(
                            children: [
                              for (var i = 0; i < place.features.length; i++)
                                featureItem(place.features[i])
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    flex: 2,
                    child: setPadding(Container(
                      child: Wrap(
                        children: [Text(place.description)],
                      ),
                    )),
                  ),
                  Expanded(
                    child: Container(color: Colors.green),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Color getRandomColor() {
  Random random = new Random();
  List<Color> colors = [
    Color(0xfcba03),
    Color(0xFF2f8fde),
    Color(0xFF8f2f17),
    Color(0xFFffd503),
  ];
  int randomNumber = random.nextInt(colors.length);
  print(colors[randomNumber]);
  return colors[randomNumber];
}

Widget featureItem(String title) {
  double width = 50;
  return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.bottomLeft,
      width: width,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: width,
            decoration: BoxDecoration(
              color: getRandomColor(),
              borderRadius: BorderRadius.circular(6),
            ),
            child: iconUtility(title),
          ),
          SizedBox(
            height: 4,
          ),
          Text(title),
        ],
      ));
}

Widget setPadding(child) {
  return Padding(
    padding: EdgeInsets.only(left: 25, top: 10, right: 1),
    child: child,
  );
}

Widget iconUtility(String feature) {
  switch (feature.toLowerCase()) {
    case 'wifi':
      return Icon(Icons.wifi);
      break;
    case 'parking':
      return Icon(Icons.local_parking_outlined);
      break;
    case 'bar':
      return Icon(Icons.view_week_outlined);
      break;
    case 'gmy':
      return Icon(Icons.fitness_center_outlined);
      break;
    case 'heater':
      return Icon(Icons.microwave_outlined);
      break;
    case 'food':
      return Icon(Icons.fastfood_outlined);
      break;
    default:
      return Icon(Icons.wifi);
  }
}
