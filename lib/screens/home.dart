import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/provider/places.dart';
import 'package:provider/provider.dart';
import './place_detail.dart';

const kHeaderTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> getPlacesData() async {
    await Provider.of<PlacesProvider>(context, listen: false).getPlaces();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPlacesData();
  }

  int index = 0;
  List<String> listOptions = ['Places', 'Inspiration', 'Emotions'];

  void updateIndex(int i) {
    setState(() {
      index = i;
    });
  }

  List<Widget> widgets = [Places(), Emotions(), Inspiration()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Hey! Zillur Mia',
          style: TextStyle(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Travel is never', style: kHeaderTextStyle),
                const Text('a matter of money', style: kHeaderTextStyle)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: listOptions
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      var i = listOptions.indexOf(e);
                                      updateIndex(i);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(e),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          if (listOptions.indexOf(e) == index)
                                            dotIndicator()
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList())),
                  Expanded(flex: 1, child: const Icon(Icons.list))
                ],
              ),
            ),
            Container(child: Expanded(child: widgets[index]))
          ],
        ),
      ),
    );
  }
}

Widget dotIndicator() {
  return Container(
    width: 5,
    height: 5,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.deepPurpleAccent,
    ),
  );
}

class Places extends StatelessWidget {
  const Places({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<PlacesProvider>(context).placesList;
    print(places);
    return places.length > 0
        ? StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => PlaceDetail(
                            id: places[index].id,
                          )));
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(places[index].imageUrl, fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          places[index].name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            staggeredTileBuilder: (int index) {
              return StaggeredTile.count(2, index.isEven ? 2 : 1);
            },
            mainAxisSpacing: 9.0,
            crossAxisSpacing: 4.0,
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class Emotions extends StatelessWidget {
  const Emotions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Emotions comming soon'));
  }
}

class Inspiration extends StatelessWidget {
  const Inspiration({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Inspiration comming soon'));
  }
}
