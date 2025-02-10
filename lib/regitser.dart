import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_auth/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _signInWithGoogle() async {
    // Implement Google Sign-In
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "420697396088-3qu7jmjk7b5hena0nbtmn3ov806o46t9.apps.googleusercontent.com", // Add your client ID here
      scopes: ['email'],
    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = FirebaseAuth.instance.currentUser;
      String? token = await user?.getIdToken(true); // Force refresh

      // ignore: avoid_print
      print("ID Token: $token");

      if (mounted) {
        // ignore: avoid_print
        print("Token: ${credential.idToken}");
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'Google auth Practice',
                  )),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      debugPrint("Google Sign-In Error: $e");
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign In",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Name Input
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Email Input
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Password Input
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              ElevatedButton(
                onPressed: () async {
                  // Implement Sign Up with Email
                  setState(
                    () {
                      // ignore: avoid_print
                      print(
                          "${_nameController.text} ${_emailController.text} ${_passwordController.text}");
                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                    },
                  );
                },
                child: const Text("Sign Up with Email"),
              ),
              const SizedBox(height: 10),

              // Google Sign-In Button
              ElevatedButton(
                onPressed: () async {
                  _signInWithGoogle();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("google.png", height: 24),
                    const SizedBox(width: 10),
                    const Text("Sign in with Google",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
