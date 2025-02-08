import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
//import 'package:flutter_application_1/components/bottom_navigate.dart';
import 'package:flutter_application_1/components/category.dart';
import 'package:flutter_application_1/components/searchbar.dart';
import 'package:flutter_application_1/ui/profile/profile.dart';
//import 'glowing_search_field.dart'; // Import the reusable component

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:() {final authService = AuthService(); authService.signOut(); }, icon: const Icon(Icons.vertical_align_bottom)),
        title: const Text("DISCOVER"),
        centerTitle: true,
        actions:  [IconButton(onPressed:() {}, icon: const Icon(Icons.heat_pump_rounded)), IconButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  },
  icon: const Icon(Icons.face),
),]
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlowingSearchField(
              hintText: "Search here...",
              controller: searchController,
              onChanged: (value) {
                // Handle the search query
                print("Search query: $value");
              },
            ),
            const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Category(categoryText: "TOP PICKS", onPressed: () {}),
                
                Category(categoryText: "Tech", onPressed: () {}),
                 
                Category(categoryText: "Services", onPressed: () {},),
                 
                Category(categoryText: "Food", onPressed: () {}),
                     
          ])

          ),
          Expanded(child: GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 2,
  children: <Widget>[
   GestureDetector(
  onTap: () async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: Row(
             
              children: <Widget>[
                // Corrected Image Widget
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "images/cat.png",
                    width: 200, // Optional: Adjust width if needed
                    height: 200, // Optional: Adjust height if needed
                    fit: BoxFit.cover, // Optional: Adjust the fit
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Image.asset(
                    "images/cat.png",
                    width: 200, // Optional: Adjust width if needed
                    height: 200, // Optional: Adjust height if needed
                    fit: BoxFit.cover, // Optional: Adjust the fit
                                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Image.asset(
                    "images/cat.png",
                    width: 200, // Optional: Adjust width if needed
                    height: 200, // Optional: Adjust height if needed
                    fit: BoxFit.cover, // Optional: Adjust the fit
                                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Image.asset(
                    "images/cat.png",
                    width: 200, // Optional: Adjust width if needed
                    height: 200, // Optional: Adjust height if needed
                    fit: BoxFit.cover, // Optional: Adjust the fit
                                   ),
                 ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  },
  child:  Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.teal[100],),
      padding: const EdgeInsets.all(8),
     
      child: const Text("He'd have you all unravel at the"),
    ),
  
  ],
))

       

          ],
        ),

       
      ),
    );
  }
}
