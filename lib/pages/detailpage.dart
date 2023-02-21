import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoteljadu/pages/bookingpage.dart';
import 'package:hoteljadu/pages/discoverpage.dart';
import 'package:hoteljadu/pages/first_page.dart';
import 'package:location/location.dart';
const LatLng SOURCE_LOCATION = LatLng(42.7477863,-71.1699932);
const LatLng DEST_LOCATION = LatLng(24.372160,88.587103);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;
class DetailPage extends StatefulWidget {
  static const String routename='/detailpage';
  static const initialcamerapossition  = CameraPosition(
    target: LatLng(23.777176, 90.399452),
    zoom: 10,
    tilt: 80,
    bearing: 30,
  );
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  LatLng sourceLocation = LatLng(double.parse(selectedhotel!.lat!), double.parse(selectedhotel!.long!));
  LatLng destinationLatlng = LatLng(double.parse(selectedhotel!.lat!), double.parse(selectedhotel!.long!));
  Uint8List? markerimages;
  List<String> images = ['images/bg.png','images/map.png'];
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _marker = Set<Marker>();

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  late StreamSubscription<LocationData> subscription;

  LocationData? currentLocation;
  late LocationData destinationLocation;
  late Location location;


  void setSourceAndDesMarkIc() async{}
  void setInitialLocation(){}
  @override
  void initState() {
    super.initState();

    location = Location();
    polylinePoints = PolylinePoints();

    subscription = location.onLocationChanged.listen((clocation) async {
      currentLocation = clocation;
      updatePinsOnMap();
    });

    setInitLocation();
  }
  void setInitLocation() async {
    await location.getLocation().then((value) {
      currentLocation = value;
      setState(() {});
    });

    destinationLocation = LocationData.fromMap({
      "latitude": destinationLatlng.latitude,
      "longitude": destinationLatlng.longitude,
    });
  }
  void showLocationPins() {
    var sourceposition = LatLng(
        double.parse(selectedhotel!.lat!) ?? 0.0, double.parse(selectedhotel!.lat!) ?? 0.0);

    var destinationPosition =
    LatLng(destinationLatlng.latitude, destinationLatlng.longitude);

    _marker.add(Marker(
      markerId: MarkerId('sourcePosition'),
      infoWindow: InfoWindow(title: selectedhotel!.hotelname),
      position: sourceposition,
    ));

    _marker.add(
      Marker(
        markerId: MarkerId('destinationPosition'),
        infoWindow: InfoWindow(title: selectedhotel!.hotelname),
        position: destinationPosition,
      ),
    );

  }

  void updatePinsOnMap() async {
    CameraPosition cameraPosition = CameraPosition(
      zoom: 16,
      tilt: 40,
      bearing: 30,
      target: LatLng(
          double.parse(selectedhotel!.lat!) ?? 0.0, double.parse(selectedhotel!.long!) ?? 0.0),
    );

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    var sourcePosition = LatLng(
        double.parse(selectedhotel!.lat!) ?? 0.0, double.parse(selectedhotel!.lat!) ?? 0.0);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 450,
                      child: ClipRRect(
                        child: ImageSlideshow(
                          width: double.infinity,
                          height: 400,
                          initialPage: 0,
                          indicatorColor: Colors.blue,
                          indicatorBackgroundColor: Colors.grey,
                          children: [
                            Image.network(
                              '${selectedhotel!.hotelImage1}',
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              '${selectedhotel!.hotelImage2}',
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              '${selectedhotel!.hotelImage3}',
                              fit: BoxFit.cover,
                            ),
                          ],
                          onPageChanged: (value) {
                            print('Page changed: $value');
                          },
                          autoPlayInterval: 5000,
                          isLoop: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${selectedhotel!.hotelname}',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400),),
                              Row(
                                children: [
                                  Icon(Icons.star,color: Colors.yellow,),
                                  Text('${selectedhotel!.rating}')
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_pin),
                              Text('${selectedhotel!.location}')
                            ],
                          ),
                          SizedBox(height: 12,),
                          Text('${selectedhotel!.description}',style: TextStyle(fontSize: 18),),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text('\$${selectedhotel!.price}',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                              Text('/Person',style: TextStyle(fontSize: 18),)
                            ],
                          ),
                          SizedBox(height: 12,),
                          Text('Location',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Container(
                              height: 500,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  GoogleMap(
                                    myLocationButtonEnabled: true,
                                    compassEnabled: true,
                                    markers: _marker,
                                    polylines: _polylines,
                                    mapType: MapType.hybrid,
                                    initialCameraPosition: DetailPage.initialcamerapossition,
                                    onMapCreated: (GoogleMapController controller) {
                                      _controller.complete(controller);
                                      showLocationPins();
                                    },
                                  ),
                                ],
                              )
                          ),
                          SizedBox(height: 70,)
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          Positioned(
              top: 50,
              child: SizedBox(
                width: MediaQuery.of(context).size.width-20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child:IconButton(
                          onPressed: (){Navigator.pushReplacementNamed(context, FirstPage.routeName);},
                          icon: Icon(Icons.keyboard_backspace_outlined,color: Colors.white,),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child:IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.share,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height-100,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width-60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.favorite_border),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-100,
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
                              {Navigator.pushNamed(context, BookPage.routename);},
                              child: Text('Book Now',style: TextStyle(fontSize: 17),)),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
