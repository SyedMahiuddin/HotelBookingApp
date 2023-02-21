import 'package:flutter/material.dart';
import 'package:hoteljadu/pages/bookingmodel.dart';

import '../dbhelper/Databasehelper.dart';

class BookProvider extends ChangeNotifier {
  List<BookingModel> booklist = [];
  List<BookingModel> singleuserbooklist = [];

  Future<void> addBooking(BookingModel bookingModel) async {
    return DatabaseHelper.addBooking(bookingModel);
  }

  getAllBookings() {
    DatabaseHelper.getAllBookings().listen((event) {
      booklist = List.generate(event.docs.length,
              (index) => BookingModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
    notifyListeners();
  }

  void getsingleuserbookings(String mail){
    singleuserbooklist.clear();
    for(int i=0;i<booklist.length;i++)
      {
        if(booklist[i].usermail==mail)
          {
            singleuserbooklist.add(booklist[i]);
          }
      }
  }

}


