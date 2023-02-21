import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hoteljadu/pages/bookingmodel.dart';

import '../pages/usermodel.dart';

class DatabaseHelper {
  static const String collectionBooking = 'Booking';
  static const String collectionHotel = 'Hotel';
  static const String collectionUser = 'User';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;


  static Future<void> addBooking(BookingModel bookingModel) {
    return _db.collection(collectionBooking)
        .doc(bookingModel.bookId).set(bookingModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSingleHotel(
      {required String hotelId}) =>
      _db.collection(collectionHotel).where('hotelId', isEqualTo: hotelId).snapshots();



  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllHotels() =>
      _db.collection(collectionHotel).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBookings() =>
      _db.collection(collectionBooking).snapshots();


  static Future<void> addUser(UserModel userModel) {
    return _db.collection(collectionUser)
        .doc(userModel.uid).set(userModel.toMap());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSingleUserData(
      {required String uid}) =>
      _db.collection(collectionUser).where('uid', isEqualTo: uid).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserData(
      {required String uid}) =>
      _db.collection(collectionUser).where('uid', isEqualTo: uid).snapshots();

  static Future<void> updateUser(String uid, Map<String, dynamic> map) async {
    return await _db.collection(collectionUser)
        .doc(uid)
        .update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      _db.collection(collectionUser).snapshots();
}