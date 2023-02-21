class BookingModel {
  String? bookId;
  String? hotelname;
  String? hotelImage1;
  String? adult;
  String? child;
  String? location;
  String? category;
  String? price;
  String? rating;
  String? datestart;
  String? dateend;
  String? bookingdate;
  String? usermail;


  BookingModel(
      {this.bookId,
      this.hotelname,
      this.hotelImage1,
      this.adult,
      this.child,
      this.location,
      this.category,
      this.price,
      this.rating,
      this.datestart,
      this.dateend,
      this.bookingdate,
      this.usermail});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookId': bookId,
      'hotelname': hotelname,
      'usermail': usermail,
      'hotelImage1': hotelImage1,
      'adult': adult,
      'child': child,
      'location': location,
      'category': category,
      'price': price,
      'rating': rating,
      'datestart': datestart,
      'dateend':dateend,
      'bookingdate':bookingdate
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) => BookingModel(
    bookId: map['bookId'],
    hotelname: map['hotelname'],
    usermail: map['usermail'],
    hotelImage1: map['hotelImage1'],
    adult: map['adult'],
    child: map['child'],
    location: map['location'],
    category: map['category'],
    rating: map['rating'],
    price: map['price'],
    datestart: map['datestart'],
    dateend: map['dateend'],
    bookingdate: map['bookingdate'],
  );
}