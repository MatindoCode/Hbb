//import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/addservice/addlocation.dart';
import 'package:flutter_application_1/components/addservice/description.dart';
import 'package:flutter_application_1/components/addservice/name.dart';
import 'package:flutter_application_1/components/addservice/pic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Addservice extends StatelessWidget {
  final textController = TextEditingController();
   final Completer<GoogleMapController> _mapController = Completer();
  Addservice({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(height: 30,),
            Row(children: [ 
              Pic(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NameOfService(controller: textController,),
              )


            ],),  
          SizedBox(height: 40,),
          Description(),
          SizedBox(height: 30),
          Addlocation(controller: _mapController,onPressed: () {},)
          ],),
        ),
      )
    );
  }
}