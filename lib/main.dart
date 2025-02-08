import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navigate.dart';
import 'package:flutter_application_1/ui/addserviceitems/bloc/map_bloc.dart';
//import 'package:flutter_application_1/ui/home/home.dart';
import 'package:flutter_application_1/ui/login/login.dart';
import 'package:flutter_application_1/ui/profile/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InloeXZrZmJ1bmhuZWphYWxsYnl1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NzU4NTMsImV4cCI6MjA1MzA1MTg1M30.HoIkPGlJRo30qZaxBUre8DrIf9BZ8BbMsiiUXuoAldw",
    url: "https://yhyvkfbunhnejaallbyu.supabase.co",
    
    
  );

  runApp(
    MultiBlocProvider(
      providers: [
  BlocProvider(
    create: (context) => ProfileBloc(),
  ),
  BlocProvider(
    create: (context) => GoogleMapsBloc(),
  ),
],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Show an error widget
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        } else {
          // Determine if the user is logged in or not
          final session = snapshot.data?.session;
          final user = session?.user;
            print("🔍 Current session in StreamBuilder: $user");

          return MaterialApp(
            home: user == null ? Login() : const NaviBar(),
          );
        }
      },
    );
  }
}