import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword(
      {
  required String email,
  required String password,
}) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print("Sign in Sucess");
      
      return response; 
    } catch (e) {
      // Handle potential errors during sign-in
      print('Sign-in failed: $e'); 
      // Re-throw the exception to be handled by the caller
      rethrow; 
    }
  }

 Future<AuthResponse> signUpWithEmailPassword(
      {
  required String email,
  required String password,
}) async {
     final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
       if (response.session == null || response.user == null) {
      throw Exception('Signup failed');
    }
      return response; 

  }

Future<void> signOut() async {
  await _supabase.auth.signOut();
}

String? getCurrentUserEmail() {
  final session = _supabase.auth.currentSession;
  final user = session?.user;
  return user?.email;  
}



}