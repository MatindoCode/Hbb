
import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  final String text1;
  final String text2;
  final void Function()? onTap;
  const AlreadyHaveAccount({super.key, required this.text1, required this.text2, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
           Text(text1,
              style: const TextStyle(color: Colors.white)),
          GestureDetector(
              onTap: onTap,
              child: Text(text2, style: const TextStyle(color: Colors.black)))
        ]),
    );
  }
}
