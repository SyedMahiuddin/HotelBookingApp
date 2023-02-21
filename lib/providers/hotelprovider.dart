import 'package:flutter/material.dart';
import 'package:hoteljadu/pages/hotelmodel.dart';
import '../dbhelper/Databasehelper.dart';
import '../pages/usermodel.dart';

class HotelProvider extends ChangeNotifier {
  List<HotelModel> HotelList = [];
  List<HotelModel> HotelListbycat = [];
  List<UserModel> user = [];
  List<HotelModel> Hotel = [];

  getAllHotel() {
    DatabaseHelper.getAllHotels().listen((event) {
      HotelList = List.generate(event.docs.length,
              (index) => HotelModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
    notifyListeners();
  }

  getSingleHotel(String hotelId) {
    DatabaseHelper.getSingleHotel(hotelId: hotelId).listen((event) {
      Hotel = List.generate(event.docs.length,
              (index) => HotelModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
 void changethelist(String cat)
 { bool already=false;
   for(int i=0;i<HotelList.length;i++)
     {
        if(HotelList[i].category==cat)
         {
           HotelListbycat.add(HotelList[i]);
         }
   else if(cat=='All')
   {
   for(int j=0;j<HotelListbycat.length;j++)
   {
   if(HotelListbycat[j].hotelname==HotelList[i].hotelname)
   {
   already=true;
   }
   }
   if(already==false)
   {
   HotelListbycat.add(HotelList[i]);
   }
   }
       else
         {
           HotelListbycat.remove(HotelList[i]);
         }
     }
 }

}


