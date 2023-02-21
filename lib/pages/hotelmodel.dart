class HotelModel {
  String? hotelId;
  String? hotelname;
  String? hotelImage1;
  String? hotelImage2;
  String? hotelImage3;
  String? location;
  String? category;
  String? price;
  String? rating;
  String? description;
  String? favourite;
  String? lat;
  String? long;


  HotelModel(
      {this.hotelId,
      this.hotelname,
      this.hotelImage1,
      this.hotelImage2,
      this.hotelImage3,
      this.location,
      this.category,
      this.price,
      this.rating,
      this.description,
      this.favourite,
      this.lat,
      this.long});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelId': hotelId,
      'hotelname': hotelname,
      'hotelImage1': hotelImage1,
      'hotelImage2': hotelImage2,
      'hotelImage3': hotelImage3,
      'location': location,
      'category': category,
      'price': price,
      'rating': rating,
      'description': description,
      'favourite': favourite,
      'lat':lat,
      'long':long
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) => HotelModel(
    hotelId: map['hotelId'],
    hotelname: map['hotelname'],
    hotelImage1: map['hotelImage1'],
    hotelImage2: map['hotelImage2'],
    hotelImage3: map['hotelImage3'],
    location: map['location'],
    category: map['category'],
    price: map['price'],
    rating: map['rating'],
    description: map['description'],
    favourite: map['favourite'],
    lat: map['lat'],
    long: map['long'],
  );
}