import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hoteljadu/pages/detailpage.dart';
import 'package:hoteljadu/pages/hotelmodel.dart';
import 'package:hoteljadu/pages/launcherpage.dart';
import 'package:hoteljadu/providers/hotelprovider.dart';
import 'package:hoteljadu/utils/colors.dart';
import 'package:provider/provider.dart';

import '../dbhelper/auth.dart';
import '../utils/custom_snack_bar.dart';

class DiscoverPage extends StatefulWidget {
  static const String routename='/discoverpage';
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}
List<String> cat=['All','Apartment','Hotel','Rooms','House','Floors'];
String Scat='';
HotelModel? selectedhotel;
class _DiscoverPageState extends State<DiscoverPage> {
  HotelProvider? hotelProvider;
  int count=0;
  @override
  void didChangeDependencies() {
    hotelProvider = Provider.of<HotelProvider>(context);
    hotelProvider!.getAllHotel();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    //hotelProvider!.changethelist('All');
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(toolbarHeight: 0.1,backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
logOut();
              }, icon: Icon(Icons.subdirectory_arrow_left_sharp)),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discover',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w500),),
                  Icon(Icons.search,size: 30,)
                ],
              ),
              SizedBox(height: 15,),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cat.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: DarkBlue,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                          onPressed: (){
                            setState(() {
                              Scat=cat[index];
                              hotelProvider!.HotelListbycat=[];
                              hotelProvider!.changethelist(cat[index]);
                            });
                          },
                          child: Text(cat[index]),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                  TextButton(onPressed: (){},
                      child: Text('See All'))
                ],
              ),
              SizedBox(height: 15,),
    Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      child:Consumer<HotelProvider>(
          builder: (context, provider, _) => ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: Scat==''?provider.HotelList.length:provider.HotelListbycat.length,
              itemBuilder: (context, index) {
                final hotel =Scat==''? provider.HotelList[index]: provider.HotelListbycat[index];
                return
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        selectedhotel= hotel;
                        Navigator.pushNamed(context, DetailPage.routename);
                      },
                      child: Container(

                        width: 240,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(


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
                                child: Image.network("${hotel.hotelImage1}",fit: BoxFit.cover,width: 250,),
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
                                      Text('${hotel.hotelname}',style: TextStyle(fontSize: 20),),
                                      Row(
                                        children: [
                                          Icon(Icons.star,color: Colors.yellow,),
                                          Text('${hotel.rating}')
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 6,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_pin),
                                      Text('${hotel.location}')
                                    ],
                                  ),
                                  Text('${hotel.description}',overflow: TextOverflow.ellipsis),
                                  SizedBox(height: 6,),
                                  Row(
                                    children: [
                                      Text('\$${hotel.price}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                      Text('/Person',style: TextStyle(fontSize: 15),)
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

              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('New Offer',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                  TextButton(onPressed: (){},
                      child: Text('See All'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void logOut() async {
    try {
      AuthService.logout().then((value) {
        Navigator.pushReplacementNamed(context, LauncherPage.routeName);
        CustomSnackBar().showSnackBar(
            context: context,
            content: 'Log out Successful',
            backgroundColor: Colors.green);
      });
    } on FirebaseAuthException catch (e) {
    }
  }
}
