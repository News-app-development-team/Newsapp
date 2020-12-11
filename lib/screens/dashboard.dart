import 'package:flutter/material.dart';
import 'package:phnauthnew/services/authservice.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool got = false;
  final _firestore = Firestore.instance;
  String city='city';
  String state='state';
   void getLocation() async{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);
      List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark=placemarks[0];
      setState(() {
        city=placemark.locality;
        state=placemark.administrativeArea;
      });
      print(placemark.locality);
      print(placemark.subAdministrativeArea);
      print(placemark.administrativeArea);
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('Signout',style: TextStyle(
                  color: Colors.white,),),
                  onPressed: () {
                    AuthService().signOut();
                  },
                )
            ),
          ),
//           Container(child :Text('click on location to get current location')),
//           Container(
//             child: Center(
//                 child: RaisedButton(
//                   color: Colors.blue,
//                   child: Text('location',style: TextStyle(
//                     color: Colors.white,),),
//                   onPressed: () {
//                     getLocation();
//                   },
//                 )
//             ),
//           ),
//           Container(child: Text(city)),
//           Container(child: Text(state)),
//           Container(child: Text('click submit when city and state changes to your current location'),),
//           Container(
//             child: Center(
//                 child: RaisedButton(
//                   color: Colors.blue,
//                   child: Text('submit',style: TextStyle(
//                     color: Colors.white,),),
//                   onPressed: () {
//
//                     _firestore.collection('location').document().setData({
//
//                             'address': {
//                               'city': city,
//                               'state': state,
//                           }
//                       }
//                     );
//
// //                    _firestore.collection('location').add(
// //                      {
// //                        'city' : city,
// //                        'state' : state,
// //                      }
// //                    );
//                   setState(() {
//                     got=true;
//                   });
//                   },
//                 )
//             ),
//           ),
//           got ? Text('submitted succesfully'):Container(),
        ],
      )
    );
  }
}
