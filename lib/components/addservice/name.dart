import 'package:flutter/material.dart';


class NameOfService extends StatelessWidget {
  final TextEditingController controller; 

  const NameOfService({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      Text('Name of Service/Product', style: TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(height: 20,),
      Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Match the TextField's border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // How far the shadow spreads
            blurRadius: 5, // How blurry the shadow is
            offset: const Offset(0, 3), // Shadow position (x, y)
          ),
        ],
      ),
       width: MediaQuery.of(context).size.width * 2 / 4,
       height: 80,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "hi",
        
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))        ,      
      )     
    
      ),
    )]);
  }
}
  