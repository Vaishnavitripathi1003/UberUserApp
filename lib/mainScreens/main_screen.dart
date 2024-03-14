import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/widgets/my_drawer.dart';

import '../authentication/login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;
  GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  double searchLocationContainerHeight = 220;


  blackThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      /* appBar: AppBar(
          title:const Text("Main Screen"),
          backgroundColor: Colors.grey,

      ),*/
      drawer: Container(
        width: 260,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black87,
          ),
          child: MyDrawer(
            name: userModelCurrentInfo?.name,
            email: userModelCurrentInfo?.email,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              newGoogleMapController = controller;
              //for dark mode
              blackThemeGoogleMap();
            },
          ),
          //custom humberger button
          Positioned(
            top: 30,
            left: 18,
            child: GestureDetector(
              onTap: () {
                skey.currentState!.openDrawer();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          //ui for searching location
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              curve: Curves.easeIn,
              duration:const  Duration(milliseconds: 120),
              child: Container(
                height: searchLocationContainerHeight,
                decoration:const  BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                  child: Column(

                    children: [
                      //from location
                      Row(
                         children: [
                           Icon(Icons.add_location_alt_outlined,color: Colors.grey,),
                           const SizedBox(height: 12.0),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("from",style: TextStyle(
                                color: Colors.grey,fontSize:12
                              ),

                              ),
                              Text("Your Current Location",style: TextStyle(
                                  color: Colors.grey,fontSize:12
                              )),
                            ],
                          ),

                         ],
                      ),
                      const SizedBox(height: 10.0,),
                      Divider(
                        height: 1,
                        thickness: 1,
                          color: Colors.grey,
                      ),
                      const SizedBox(height: 16.0,),
                      Row(
                        children: [
                          Icon(Icons.add_location_alt_outlined,color: Colors.grey,),
                          const SizedBox(height: 12.0),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("To",style: TextStyle(
                                  color: Colors.grey,fontSize:12
                              ),

                              ),
                              Text("Where to go ",style: TextStyle(
                                  color: Colors.grey,fontSize:12
                              )),
                            ],
                          ),

                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16.0,),
                      ElevatedButton(
                        child: Text(
                          "Request a ride",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        onPressed: ()
                        {



                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
