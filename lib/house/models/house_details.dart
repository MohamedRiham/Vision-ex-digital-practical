class HouseDetails {
  String? title;
  String? imageUrl;
  String? location;
  int? price;
  int? numberOfBeds;
  int? numberOfBathRooms;

  HouseDetails({
     this.title,
     this.imageUrl,
     this.location,
     this.price,
     this.numberOfBeds,
     this.numberOfBathRooms,
  });

  factory HouseDetails.fromMap(Map<String, dynamic> map) {
    return HouseDetails(
      title: map['title'],
      imageUrl: map['image_url'],
      location: map['location'],
      price: map['price'],
      numberOfBeds: map['number_of_beds'],
      numberOfBathRooms: map['number_of_bathrooms'],
    );
  }
}
