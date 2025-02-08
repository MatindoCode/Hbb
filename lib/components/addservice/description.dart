//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
        Container(
          width: MediaQuery.of(context).size.width ,
          height: 200,
          child: TextField(
            expands: true,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
                filled: true,
              fillColor: Colors.white,
              hintText: "nil",
            
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)) 
        
          )
        )),
      ],
    );
  }
}