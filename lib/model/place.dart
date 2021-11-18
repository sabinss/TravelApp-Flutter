class Place {
  int id;
  String name;
  double rating;
  bool isFavourite;
  String location;
  List<String> features;
  String description;
  String imageUrl;
  Place(
      {this.name,
      this.id,
      this.imageUrl,
      this.rating,
      this.location,
      this.features,
      this.description,
      this.isFavourite = false});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        id: int.tryParse(json['id'].toString()),
        name: json['name'],
        imageUrl: json['imageUrl'],
        location: json['location'],
        description: json['description'],
        rating: double.tryParse(json['rating'].toString()),
        features: json['features']?.cast<String>());
  }
}
