import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hoteljadu/pages/bookedpage.dart';
import 'package:hoteljadu/pages/bookingpage.dart';
import 'package:hoteljadu/pages/detailpage.dart';
import 'package:hoteljadu/pages/discoverpage.dart';
import 'package:hoteljadu/pages/first_page.dart';
import 'package:hoteljadu/pages/launcherpage.dart';
import 'package:hoteljadu/pages/loginpage.dart';
import 'package:hoteljadu/pages/signuppage.dart';
import 'package:hoteljadu/providers/bookprovider.dart';
import 'package:hoteljadu/providers/hotelprovider.dart';
import 'package:hoteljadu/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HotelProvider()..getAllHotel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookProvider()..getAllBookings(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
        initialRoute: LauncherPage.routeName,
        routes: {
          FirstPage.routeName: (context)=>FirstPage(),
          DiscoverPage.routename: (context)=>DiscoverPage(),
          DetailPage.routename: (context)=>DetailPage(),
          BookPage.routename: (context)=>BookPage(),
          BookedPage.routename:(context)=>BookedPage(),
          LoginPage.routeName:(context)=>LoginPage(),
          SignUpPage.routeName:(context)=>SignUpPage(),
          LauncherPage.routeName:(context)=>LauncherPage()
        },
      ),
    );
  }
}

