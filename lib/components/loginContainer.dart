import 'package:flutter/material.dart';

class SignInLogin extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword; 
  const SignInLogin({super.key, required this.hintText, required this.controller, required this.isPassword,});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
       width: MediaQuery.of(context).size.width * 3 / 4,
       height: 60,
      child: TextField(
        controller: controller,
         obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))        ,      
      )       
      ),
    );
  }
}