
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hoteljadu/pages/bookedpage.dart';
import 'package:hoteljadu/pages/discoverpage.dart';
import '../utils/colors.dart';

class FirstPage extends StatefulWidget {
  static const String routeName='/bottomnavipage';
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {
  int pageIndex = 0;

  List<Widget> widgetList =  [
    DiscoverPage(),
    BookedPage(),
    BookedPage()
  ];

  @override
  Widget build(BuildContext context) {
    double scheight= MediaQuery.of(context).size.height;
    double scwidth= MediaQuery.of(context).size.width;
    Connectivity connectivity=Connectivity();
    return Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },

          currentIndex: pageIndex,

          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,size: 32,),
                activeIcon: Icon(
                    Icons.home,
                    size: 32,
                    color: DarkBlue
                ),
                label: ''
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border,size: 32,),
                activeIcon: Icon(
                    Icons.favorite,
                    size: 32,
                    color: Color(0xFF565d91)
                ),
                label: ''
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_hotel_outlined,size: 32,),
                activeIcon: Icon(
                    Icons.hotel,
                    size: 32,
                    color: Color(0xFF565d91)
                ),
                label: ''
            ),


          ],
        ),

        body:StreamBuilder(
          stream: connectivity.onConnectivityChanged,
          builder: (_, snapshot){
            return snapshot.connectionState==ConnectionState.active? snapshot.data!=ConnectivityResult.none?
            Center(
              child: widgetList[pageIndex],
            ): Center(
              child: Icon(Icons.wifi_off_sharp,size: 100,),
            ):Center(
              child: widgetList[pageIndex],
            );
          },)
    );
  }
}
