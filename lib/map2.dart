// start date 28/9/2021
// finish date 2/12/2021
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_locales/flutter_locales.dart';// for language
import 'package:geolocator/geolocator.dart'; // my location
import 'package:awesome_dialog/awesome_dialog.dart'; // hint with animation
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // for phone call

import 'check_connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import 'myProvider.dart';

// google maps

class Map2 extends StatefulWidget {
  @override
  _Map2State createState() => _Map2State();
}

class _Map2State extends State<Map2> {

  // google controller
  late GoogleMapController _controller;
  // position for user current location
  late Position cl ;
  bool isLoad=false;
  bool details=false;
  var selectedHospital;
  var near;
  var numHospital;
  var floatPressed=false;
  // late StreamSubscription<Position> positionStream;


  // create all markers for all hospital
  Set<Marker> _markers = {};
  createMarkers() async {
    for (var i = 0; i < hospitalPlaces.length; i++) {
      var beach = hospitalPlaces[i];

      _markers.add(Marker(markerId: MarkerId("$i")
          ,
          position: LatLng(
              (beach[1] as num).toDouble(), (beach[2] as num).toDouble())
          ,
          infoWindow: InfoWindow(title: beach[0].toString(),snippet: beach[3].toString(),),
          // if press on the marker change the variables because these variables used
          // to show the details of the hospital selected
          onTap: () {
            if (i != numHospital) {
              floatPressed=false;
            }
            // details = true to show the container widget that contains all details
            details=true;
            // selected hospital
            selectedHospital=beach;
            // calculate the distance between the marker and the current location
            calculateDistance();
           setState(() {
           });
          },
          // this is the icon of the marker
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration.empty, "assets/hospital_map.png")
      ));
    }
  }

  /* google maps permission */
  Future getPosition() async {
    bool services;
    LocationPermission permission = await Geolocator.requestPermission();
    services = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) getLatAndLong();
    }
    // if the user not open the Gps location show this dialog
    if (services == false) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        headerAnimationLoop: false,
        title: 'Services',
        desc: 'Services not Enabled\nYou have to turn on the GPS location',
        buttonsTextStyle: TextStyle(color: Colors.black),
        showCloseIcon: true,
      )..show();
    }
  }

  // lat and long for current location
  Future<void> getLatAndLong() async {
    // marker for current location
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    _markers.add(
        Marker(markerId: MarkerId("3"),position: LatLng(cl.latitude,cl.longitude),
            icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration.empty, "assets/current_marker.png")
        ));
    findNearestHospital();
    setState(() {
      isLoad =true;
    });

  }

  // find the nearest hospital from the current location
  findNearestHospital(){
    near = Geolocator.distanceBetween(cl.latitude, cl.longitude, (hospitalPlaces[0][1] as num).toDouble(), (hospitalPlaces[0][2] as num).toDouble());
    var distanceBetween;
    numHospital=0;
    // loops for all hospital and find the nearest one
    for(int i = 1;i<hospitalPlaces.length;i++){
      distanceBetween  = Geolocator.distanceBetween(cl.latitude, cl.longitude, (hospitalPlaces[i][1] as num).toDouble(), (hospitalPlaces[i][2] as num).toDouble());
      if (distanceBetween<near){
        near = distanceBetween;
        numHospital=i;
      }
    }
    setState(() {

    });
    // find the distance in KM
    var distanceKm = near /1000;
    print("distance between current location and ${hospitalPlaces[numHospital][0]} in km : $distanceKm");
  }

  @override
  void initState() {
    // this is for follow your location
    // positionStream = Geolocator.getPositionStream().listen((Position position) {
    //   changeMarker(position.latitude,position.longitude);
    // });
    super.initState();
    setPlaces(context.read<MyProvider>().language);
    getPosition();
    getLatAndLong();
    createMarkers();
    getConnection(context);
  }

  // update the location of the current location
  // changeMarker(newlat,newlong){
  //   _markers.remove(Marker(markerId: MarkerId("3")));
  //   _markers.add(Marker(markerId: MarkerId("3"),position: LatLng(newlat,newlong)));
  //   _controller.animateCamera(CameraUpdate.newLatLng(LatLng(newlat,newlong)));
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: LocaleText("Map"),
      ),
      body: Center(
        child: Column(
            children: [
              isLoad == false
                  ? Center(child: CircularProgressIndicator(strokeWidth: 4,))
                  : Expanded(
                    // width: double.infinity,
                    // height: 600,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[

                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: GoogleMap(
                              markers: _markers,
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(cl.latitude, cl.longitude),
                                zoom: 13,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                              },
                              //make circle for current location with the hospital selected
                              circles: Set.from([Circle(
                                circleId: CircleId("1"),
                                center: LatLng(cl.latitude, cl.longitude),
                                radius: near+100,
                                fillColor: Colors.blue.shade100.withOpacity(0.5),
                                strokeColor:  Colors.blue.shade100.withOpacity(0.1),
                              )]),
                            ),
                          ),

                          // if the user click on the marker show the distance between current location and hospital in KM
                          if(details==true)
                          Positioned(
                            top: 5,
                            child: Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).splashColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                      offset: Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Text(Locales.string(context, 'Distance')+(near /1000).toStringAsFixed(2)+ Locales.string(context, 'KM'),
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).backgroundColor),)),),
                          // if the user click on the marker show the details of the hospital
                          if(details==true)
                            buildStackDetails(floatPressed?numHospital:-1)
                          else
                              Container(),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
      ),

      //find the nearest hospital and move to it and calculate the distance
      floatingActionButtonLocation:
          // change the location of button depend on the language
          context.read<MyProvider>().language == "English"
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
      floatingActionButton: (details==false)
          ?FloatingActionButton(
        tooltip: 'Go to nearest hospital',
        backgroundColor: Theme.of(context).splashColor,
        // on press it show the nearest hospital and move the camera to it
        onPressed: () async{
            near =Geolocator.distanceBetween(cl.latitude, cl.longitude, (hospitalPlaces[0][1] as num).toDouble(), (hospitalPlaces[0][2] as num).toDouble());
            var distanceBetween;
            numHospital=0;
            for(int i = 1;i<hospitalPlaces.length;i++){
              distanceBetween  = Geolocator.distanceBetween(cl.latitude, cl.longitude, (hospitalPlaces[i][1] as num).toDouble(), (hospitalPlaces[i][2] as num).toDouble());
              if (distanceBetween<near){
                setState(() {
                  near = distanceBetween;
                  numHospital=i;
                });
              }
            }
            // find the distance between two points at map
            var distanceKm = near /1000;
            print("distance between current location and ${hospitalPlaces[numHospital][0]} in km : $distanceKm");
            LatLng _latLng = LatLng((hospitalPlaces[numHospital][1] as num).toDouble(), (hospitalPlaces[numHospital][2] as num).toDouble());
            _controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: _latLng, zoom: 15, bearing:220, tilt: 70)));

            setState(() {
              floatPressed=true;
              details=true;
            });

        },
        child: Icon(Icons.my_location),
      ):null,
    );
  }

  calculateDistance(){
    near =Geolocator.distanceBetween(cl.latitude, cl.longitude, (selectedHospital[1] as num).toDouble(), (selectedHospital[2] as num).toDouble());
    setState(() {});
  }

  // create widget contains the details of the hospital
  Stack buildStackDetails(int num) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(193, 193, 193, 1.0),
            borderRadius: BorderRadius.circular(10)),
        width: 400,
        height: 220,
        padding: EdgeInsets.fromLTRB(15, 25, 15, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/loader.gif',
              image: num>0?hospitalPlaces[num][5]:selectedHospital[5],
              height: 80,
              width: 400,
              fit: BoxFit.cover,
            ),
            Text(
              num>0?hospitalPlaces[num][0]:selectedHospital[0],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              overflow: TextOverflow.ellipsis,
            ),
            LocaleText(
              "24 hours",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: ElevatedButton(
                    onPressed: () {
                      launch("tel://${num>0?hospitalPlaces[num][4]:selectedHospital[4].toString()}");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        LocaleText(
                          "Call",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      child: ElevatedButton(
                    onPressed: () {
                      // move the camera to the marker
                      LatLng _latLng =
                          LatLng(num>0?hospitalPlaces[num][1]:selectedHospital[1], num>0?hospitalPlaces[num][2]:selectedHospital[2]);
                      _controller.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: _latLng, zoom: 16, bearing: 240, tilt: 90)));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        LocaleText(
                          "See location on map",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),

      // this is for close the container
      Positioned(
        right: -10,
        top: -10,
        child: TextButton(
            onPressed: () {
              details = false;
              setState(() {});
            },
            child: Icon(
              Icons.close_rounded,
              size: 30,
              color: Colors.black,
            )),
      ),
    ]);
  }


}
// hospitals details : name, address, phone number, image url , latitude, longitude
var hospitalPlaces;
setPlaces(String language) {
  var isEnglish = language=="English";
  hospitalPlaces = [
    [
      isEnglish ? 'Prince Hamza Hospital' : 'مستشفى الأمير حمزة',
      31.9843,
      35.9382,
      "Fakhr Ad Din Ar Razi 12, Amman, Jordan",
      "+96265053826",
      "https://lh5.googleusercontent.com/p/AF1QipMaIj0LN8Kbq2wHCT1Dic8Qn1a2-_fP3alPa8SF=w426-h240-k-no"
    ],
    [
      isEnglish ? 'Abdali Hospital ' : 'مستشفى العبدلي',
      31.9640,
      35.9099,
      "Al-Istethmar St 25, Amman, Jordan",
      "+96265109999",
      "https://lh5.googleusercontent.com/p/AF1QipNi0NZMShD-Vv_DNnjKIC_wK1YCVBe-Lo-l9nIu=w408-h306-k-no"
    ],
    [
      isEnglish ? 'King Hussein Medical Center ' : 'مدينة الحسين الطبية',
      31.9794,
      35.8311,
      "King Abdullah II St 23, Amman, Jordan",
      "+96265804804",
      "https://lh5.googleusercontent.com/p/AF1QipOeubxYE2QtWRY7Vj8GfWahwDjOKzuu5J76gIs5=w408-h369-k-no"
    ],
    [
      isEnglish ? 'South Shouna Hospital' : ' مستشفى الشونة الجنوبية',
      31.9018,
      35.6281,
      "WJ2H+P72، الشونة الجنوبية",
      "+96253581051",
      "https://lh5.googleusercontent.com/p/AF1QipN1KnyUa9Xx7-VmFc_Gb2j_UZapEWFjQAnj3mD5=w408-h248-k-no"
    ],
    [
      isEnglish ? 'South Shouna Hospital' : ' مستشفى الشونة الجنوبية',
      31.9019,
      35.6282,
      "WJ2H+P72، الشونة الجنوبية",
      "+96253581051",
      "https://lh5.googleusercontent.com/p/AF1QipN1KnyUa9Xx7-VmFc_Gb2j_UZapEWFjQAnj3mD5=w408-h248-k-no"
    ],
    [
      isEnglish ? 'Gardens Hospital ' : 'مستشفى الجاردنز',
      31.9856,
      35.8779,
      "Al Sab Bin Jathamah St 20",
      "+96265777111",
      "https://lh5.googleusercontent.com/p/AF1QipN2MAuvrcDYRrgvAxp50_CT7HXoZXUIgqCyR9J-=w408-h306-k-no"
    ],
    [
      isEnglish ? 'Shmaisani Hospital' : ' مستشفى الشميساني',
      31.9701,
      35.8938,
      "Obadah Bin Al Samet St 20, Amman, Jordan",
      "+96265607431",
      "https://lh5.googleusercontent.com/p/AF1QipMEEqe0_jhxqvZQ8aZDdOzFZdb8Cz7VrlFj7YnB=w408-h544-k-no"
    ],
    [
      isEnglish ? 'Istiklal Hospital ' : 'مستشفى الإستقلال',
      31.9795,
      35.9161,
      "ش. الإستقلال 55، عمّان",
      "+96265652600",
      "https://lh5.googleusercontent.com/p/AF1QipMPaoMpIZC4t_uPtD0m3UxNYj409POAST9kqdiA=w408-h261-k-no"
    ],
    [
      isEnglish
          ? 'Al Khalidi Hospital and Medical Center'
          : ' مستشفى ومركز الخالدي الطبي',
      31.9507,
      35.9038,
      " ش. إبن خلدون 39، عمّان 11183",
      "+96264644281",
      "https://lh5.googleusercontent.com/p/AF1QipOwQVOzSfxkB0Z8UgRH9pNxGMtJ7BX5gYKRyZks=w426-h240-k-no"
    ],
    [
      isEnglish ? 'The Specialty Hospital ' : 'المستشفى التخصصي',
      31.9788,
      35.9004,
      "ش. حنين بن إسحاق، عمّان",
      "+96265001111",
      "https://lh5.googleusercontent.com/p/AF1QipMu7JTbXwGvI0xB_radp25ZmteJ1hEOi0twi74=w408-h272-k-no"
    ],
    [
      isEnglish ? 'Jordan University Hospital ' : 'مستشفى الجامعة الأردنية',
      32.0076,
      35.8748,
      "ش. الملكة رانيا، عمّان",
      "+96265353444",
      "https://lh5.googleusercontent.com/p/AF1QipPdhu1PeT9q3J8zmkGckuyqtUf7aJ9lEo_1pnkV=w408-h306-k-no"
    ],
    [
      isEnglish ? 'Istishari Hospital ' : 'المستشفى الإستشاري',
      31.9655,
      35.8860,
      "44 Al Kindi Street, King Abdallah Gardens Intersection",
      "+96265001000",
      "https://lh5.googleusercontent.com/p/AF1QipNB8i5n48QpOLtkoc1uqq6sD_z5ejskqCBMzn1f=w408-h273-k-no"
    ],
    [
      isEnglish ? 'Royal Hospital ' : 'مستشفى رويال',
      31.9887,
      35.9170,
      "شارع الأردن، عمّان",
      "+96265009000",
      "https://lh5.googleusercontent.com/p/AF1QipOf-e-Gez8f5HAN8jBJrnuyMVMnWg-k-s1BffsL=w466-h240-k-no"
    ],
    [
      isEnglish
          ? 'Queen Alia Military Hospital '
          : 'مستشفى الملكة علياء العسكري',
      32.0013,
      35.9188,
      "شارع الخزنة, Al-Urdon St عمّان",
      "+96265804804",
      "https://lh5.googleusercontent.com/p/AF1QipNDJAjmyULK6h1539f2H5b7X30db3N9AF5QdDwn=w408-h306-k-no"
    ],
    [
      isEnglish ? 'Al Bashir Hospital ' : 'مستشفى البشير',
      31.9376,
      35.9413,
      " ش. أسامة بن زيد 261، عمّان",
      "+96264791000",
      "https://lh5.googleusercontent.com/p/AF1QipNiZ2JpAR8nt2wqY_j6PJ5gXnBCRXy6oIAkCR2L=w408-h306-k-no"
    ],
    [
      isEnglish
          ? 'New Zarqa Governmental Hospital'
          : ' مستشفى الزرقاء الحكومي الجديد',
      32.0752,
      36.1301,
      " ش. أسامة بن زيد 261، عمّان",
      "+96253758200",
      "https://lh5.googleusercontent.com/p/AF1QipNJRLd9SEyfpTaKV6yOPz9HVc_f27bvgDT0epvY=w426-h240-k-no"
    ],
    [
      isEnglish ? 'Prince Faisal Hospital' : ' مستشفى الأمير فيصل',
      32.0337,
      36.0471,
      "مسجد صالح الرشيدي، الرصيفة ضاحية القدس , الزرقاء",
      "+96253740251",
      "https://cdnimgen.royanews.tv/imageserv/Size728Q40/news/20210731/30115.JPG"
    ],
    [
      isEnglish ? 'Salt General Hospital' : ' مستشفى السلط الحكومي',
      32.0358,
      35.7345,
      "As-Salt",
      "+96253552957",
      "https://lh5.googleusercontent.com/p/AF1QipOHYCsD7XhPPBZzOLFiuxPYHTAdP2rlMu9mGwN1=w408-h306-k-no"
    ],
    [
      isEnglish ? 'AlMafraq Government Hospital' : ' مستشفى المفرق الحكومي',
      32.3440,
      36.1979,
      "85VX+J52، المفرق",
      "+96226232761",
      "https://lh5.googleusercontent.com/p/AF1QipOn9p4AzNSln_HpGDbNagWsD235sNSsgmi_aXl-=w426-h240-k-no"
    ],
    [
      isEnglish ? 'Jarash Governmental Hospital' : ' مستشفى جرش الحكومي',
      32.2838,
      35.8973,
      "Ibn Sina, جرش",
      "+96226340265",
      "https://lh5.googleusercontent.com/p/AF1QipO8pWzLq00RVWmW_gYqOSgUFNDJOr0qoIgguXY=w408-h306-k-no"
    ],
    [
      isEnglish ? 'Al Iman Hospital' : ' مستشفى الايمان الحكومي',
      32.3215,
      35.7544,
      "Shari Ali Bin Abi Talib, عجلون",
      "+96226422129",
      "https://lh5.googleusercontent.com/p/AF1QipOdT8IhooWCDAXAsLlnnM_wahAeUb0GCRjGNEa8=w408-h306-k-no"
    ],
    [
      isEnglish ? 'AlNadeem Hospital' : ' مستشفى النديم',
      31.7161,
      35.7775,
      "ش. الإمام الغزالي 27، مأدبا",
      "+96253241700",
      "https://lh5.googleusercontent.com/p/AF1QipO5g7jO2hvgqL--eIaWH8fJjA7X3-hZmE4lKxOU=w426-h240-k-no"
    ],
    [
      isEnglish
          ? 'King Abdullah University Hospital'
          : ' مستشفى الملك المؤسس عبدالله الجامعي',
      32.5016,
      35.9941,
      "الرمثا",
      "+96227200600",
      "https://lh5.googleusercontent.com/p/AF1QipOTC6IazlP1hCEcIqOmM58Ajcct8p58DSw6bkgs=w426-h240-k-no"
    ],
    [
      isEnglish
          ? 'Prince Rashid Ben Al-Hasan Military Hospital'
          : ' مستشفى الأمير راشد العسكري',
      32.5036,
      35.8651,
      "إيدون",
      "+96227100890",
      "https://lh5.googleusercontent.com/p/AF1QipOsWI5meOIiuxI04tRi0eNpLJIEL8GTs54IGj5z=w408-h544-k-no"
    ],
    [
      isEnglish
          ? 'King Talal Military Hospital'
          : 'مستشفى الملك طلال العسكري',
      32.3310,
      36.2243,
      "86JF+9PV، المفرق",
      "+96226297220",
      "https://lh5.googleusercontent.com/p/AF1QipPZZ0bORgLbHISNlXlNsfMjQPYj_lau725rJcDv=w408-h283-k-no"
    ],
    [
      isEnglish
          ? 'Princess Haya Military Hospital'
          : ' مستشفى الاميرة هيا العسكري',
      32.3440,
      35.8193,
      "8RV9+JP7، عجلون",
      "+96226442100",
      "https://lh5.googleusercontent.com/p/AF1QipPEotmftWKCEWSp3PpGEVnlgITjHd3AOdSyZKQM=w426-h240-k-no"
    ],
    [
      isEnglish
          ? 'Prince Zeid Al-Hussein Military Hospital'
          : ' مستشفى الأمير زيد العسكري',
      30.8258,
      35.5879,
      "الطفيلة وادي زيد",
      "+96232242992",
      "https://lh5.googleusercontent.com/p/AF1QipPPh561IJlOBOEyUSgnGNhlLlTZ4md9ORrOZOQV=w408-h725-k-no"
    ],
    [
      isEnglish
          ? 'Prince Hashem bin Abdullah Military Hospital'
          : ' مستشفى الأمير هاشم بن عبدالله العسكري',
      29.5721,
      35.0180,
      "العقبة",
      "+96232092030",
      "https://lh5.googleusercontent.com/p/AF1QipNlHs4HvnaFl92n1AJV9nXo5jZzOWE5k7olBRpO=w408-h306-k-no"
    ],
    [
      isEnglish ? 'Karak Military Hospital' : ' مستشفى الكرك العسكري',
      31.1778,
      35.7347,
      "5PHM+4VG، الكرك",
      "+96232386677",
      "https://lh5.googleusercontent.com/p/AF1QipNzsWW-C1AEC34CtmqSPMLq4R8rZOt7O2qx1W9p=w408-h306-k-no"
    ],
    [
      isEnglish ? 'AlMahabba Private Hospital' : ' مسشفى المحبة',
      31.7216,
      35.8081,
      "PRC5+J6H، مأدبا",
      "+96253245541",
      "https://lh5.googleusercontent.com/p/AF1QipOlSssroiM9PgpcRPyokzImmCxibO9bFKLIEx2f=w408-h700-k-no"
    ],
    [
      isEnglish ? 'Jordan Hospital' : ' مستشفى الأردن',
      31.9607,
      35.9000,
      "ش. النزهة 9، عمّان",
      "+96265608080",
      "https://lh5.googleusercontent.com/p/AF1QipOOKwMY5nw70UGXOEP5xY2z3bF0quRmwXgukopU=w426-h240-k-no"
    ],
    [
      isEnglish ? 'Ma\'an Governmental Hospital' : ' مستشفى معان الحكومي',
      30.1914,
      35.7283,
      "العباس بن عبد المطلب، معان",
      "+96232131565",
      "https://lh5.googleusercontent.com/p/AF1QipOtm_Y-fxArKCB_2IrJTkO68zpvP9r_GL37Vm-q=w408-h544-k-no"
    ],
  ];
}


