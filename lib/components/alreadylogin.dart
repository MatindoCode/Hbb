
import 'package:flutter/material.dart';

class AlreadyNoAccount extends StatelessWidget {
  final String text1;
  final String text2;
  final void Function()? onTap;
  const AlreadyNoAccount({super.key, required this.text1, required this.text2, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
           Text(text1,
              style: const TextStyle(color: Colors.white)),
          GestureDetector(
              onTap: onTap,
              child: Text(text2, style: const TextStyle(color: Colors.black)))
        ]),
      ),
    );
  }
}
