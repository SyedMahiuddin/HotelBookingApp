import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hoteljadu/pages/bookingmodel.dart';
import 'package:hoteljadu/pages/detailpage.dart';
import 'package:hoteljadu/pages/discoverpage.dart';
import 'package:hoteljadu/providers/bookprovider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dbhelper/auth.dart';

class BookPage extends StatefulWidget {
  static const String routename="/bookingpage";
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late BookProvider bookProvider;
  int adult=0,child=0;
  String selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 3)),
  ];
  List<DateTime?> Dates=[];
  final String title='';
  int total=0;
  @override
  void didChangeDependencies() {
    bookProvider = Provider.of(context, listen: false);
    super.didChangeDependencies();
  }
  final config = CalendarDatePicker2WithActionButtonsConfig(
    calendarType: CalendarDatePicker2Type.range,
    disableYearPicker: true,
  );
  @override
  Widget build(BuildContext context) {
    List<DateTime?> _dialogCalendarPickerValue = [
      DateTime(2021, 8, 10),
      DateTime(2021, 8, 13),
    ];
    List<DateTime?> _singleDatePickerValueWithDefaultValue = [
      DateTime.now(),
    ];
    List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
      DateTime(1999, 5, 6),
      DateTime(1999, 5, 21),
    ];
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
          Positioned(
            top: 50,
              child: Column(
            children: [
              Text('${selectedhotel!.hotelname}',style: TextStyle(fontSize:20,color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text('${selectedDate!=null?selectedDate:''}November 12-16 ${adult+child} Guests',style: TextStyle(color: Colors.white))
            ],
          )),
          Positioned(
            top: 120,
              child: Container(
                height: MediaQuery.of(context).size.height-120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft:  const  Radius.circular(40.0),
                      topRight: const  Radius.circular(40.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dates',style: TextStyle(fontWeight: FontWeight.bold),),
                          TextButton(onPressed: (){

                          }, child: Text('Clear'))
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: CalendarDatePicker2(
                          config: config,
                          initialValue: _rangeDatePickerWithActionButtonsWithValue,
                          onValueChanged: (values) => setState(
                                  () => _rangeDatePickerWithActionButtonsWithValue = values),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.2,
                              blurRadius: 0.2,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Guests $selectedDate',style: TextStyle(fontWeight: FontWeight.bold),),
                            TextButton(onPressed: (){
                              setState(() {
                                adult=0;
                                child=0;
                                total=0;
                              });
                            }, child: Text('Clear'))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 0.2,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Adults',style: TextStyle(fontWeight: FontWeight.w500),),
                                            Text('Offer 12',style: TextStyle(fontWeight: FontWeight.w200),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){
                                              setState(() {
                                                if(adult>0)
                                                  {
                                                    total=total-int.parse(selectedhotel!.price!);
                                                    adult--;
                                                  }
                                              });
                                            }, icon: Icon(Icons.remove)),
                                            Text('$adult'),
                                            IconButton(onPressed: (){
                                              setState(() {
                                                if(adult<12)
                                                  {
                                                    total=total+int.parse(selectedhotel!.price!);
                                                    adult++;
                                                  }
                                              });
                                            }, icon: Icon(Icons.add)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 0.2,
                                        blurRadius: 0.2,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Children',style: TextStyle(fontWeight: FontWeight.w500),),
                                            Text('0 to 12 years',style: TextStyle(fontWeight: FontWeight.w200),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){
                                              setState(() {
                                                if(child>0)
                                                  total=total-(int.parse(selectedhotel!.price!)/2).round();
                                                child--;
                                              });
                                            }, icon: Icon(Icons.remove)),
                                            Text('$child'),
                                            IconButton(onPressed: (){
                                              setState(() {
                                                total=total+(int.parse(selectedhotel!.price!)/2).round();
                                                child++;
                                              });
                                            }, icon: Icon(Icons.add)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ),
              ),
          Positioned(
              top: MediaQuery.of(context).size.height-100,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width-60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Preliminary Cost',style: TextStyle(fontWeight: FontWeight.w200,fontSize: 15),),
                          Text('\$${total}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                                ),
                              ),
                              onPressed: ()
                              {
                                setState(() {
                                  booknow();
                                });
                                },
                              child: Text('Book Now',style: TextStyle(fontSize: 17),)),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
  void booknow() {
    try {
          bookProvider.addBooking(BookingModel(
        bookId: DateTime.now().millisecondsSinceEpoch.toString(),
        usermail: 'h@gmail.com',
        hotelname: '${selectedhotel!.hotelname}',
        hotelImage1: '${selectedhotel!.hotelImage1}',
        adult: adult.toString(),
        child: child.toString(),
        location: '${selectedhotel!.location}',
        category: '${selectedhotel!.category}',
        price: '${selectedhotel!.price}',
        rating: '${selectedhotel!.rating}',
        datestart: '${_getValueText(
          config.calendarType,
          _rangeDatePickerWithActionButtonsWithValue,
        ).toString()}',
              dateend: '3',
            bookingdate: DateTime.now().toString().substring(0,19),
      ))
          .then(
            (value) {
          Navigator.pushNamed(context, DetailPage.routename);

          EasyLoading.dismiss();
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(
            () {

        },
      );
    }
  }
  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
