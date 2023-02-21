import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoteljadu/dbhelper/auth.dart';
import 'package:hoteljadu/pages/bookingmodel.dart';
import 'package:hoteljadu/providers/bookprovider.dart';
import 'package:provider/provider.dart';

import 'detailpage.dart';
import 'discoverpage.dart';

class BookedPage extends StatefulWidget {
  static const String routename='/bookedpage';
  const BookedPage({Key? key}) : super(key: key);

  @override
  State<BookedPage> createState() => _BookedPageState();
}
class _BookedPageState extends State<BookedPage> {
  BookProvider? bookProvider;
  int count=0;
  List<BookingModel>? userbookedlist;
  @override
  void didChangeDependencies() {
    bookProvider = Provider.of<BookProvider>(context);
    bookProvider!.getAllBookings();
    bookProvider!.getsingleuserbookings(AuthService.user!.email!);
    userbookedlist=bookProvider!.singleuserbooklist;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
          style: const TextStyle(
          fontSize: 30.0,
            fontFamily: 'Bobbers',
            color: Colors.black
          ),
      child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText('Your Hotels'),
          ],
          onTap: () {
            print("Tap Event");
          },
      ),
    ),
        ),
            Container(
              height: MediaQuery.of(context).size.height-65,
              width: MediaQuery.of(context).size.width-20,
              child:Consumer<BookProvider>(
                  builder: (context, provider, _) => ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: bookProvider!.singleuserbooklist.length,
                      itemBuilder: (context, index) {
                        final booking =bookProvider!.singleuserbooklist[index];
                        return
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                              },
                              child: Container(

                                width: MediaQuery.of(context).size.width-20,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 0.4,
                                        blurRadius: 1.2,
                                        offset: Offset(3, 3),

                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network("${booking.hotelImage1}",fit: BoxFit.cover,width: MediaQuery.of(context).size.width-20,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 6,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${booking.hotelname}',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,color: Colors.yellow,),
                                                  Text('${booking.rating}')
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 6,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.location_pin),
                                              Text('${booking.location}')
                                            ],
                                          ),
                                          SizedBox(height: 6,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('\$${booking.price}/Person   '
                                                  'Total:\$${(int.parse(booking.price!)*(int.parse(booking.adult!))+int.parse(booking.price!)*(int.parse(booking.child!)/2)).round()}'),
                                              Text('Booked For: ${booking.datestart} ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                              Text('${booking.adult} Adult and ${booking.child} Child',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                              Text('Booking Date: ${booking.bookingdate}',style: TextStyle(fontSize: 15),)
                                            ],
                                          )
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          );})),
            ),
          ],
        )
    );
  }
}
