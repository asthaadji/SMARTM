import 'package:flutter/material.dart';
import 'package:smartm/page/main_nav_page.dart';
import 'package:smartm/services/auth/auth_service.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  // for password obscure mode
  bool _isObscure = true;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void showSnackBar(String message) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  void _login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      if (email.isEmpty || password.isEmpty) {
        throw ('Silahkan isi email dan password');
      }
      setState(() {
        isLoading = true;
      });
      final user = await _authService.login(email, password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainNavPage(user: user)),
          (route) => false);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.0), // Space for the logo
                      Image.asset(
                        'assets/LogoHorizontal.png', // Replace with your logo asset
                        height: 50.0,
                      ),
                      SizedBox(height: 50.0),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText: 'Kata Sandi',
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Lupa password?',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple, // Background color
                          minimumSize:
                              Size(double.infinity, 50), // Full width button
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          // Handle sign up
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()),
                          );
                        },
                        child: const Text(
                          'Belum memiliki akun? Daftar Disini',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
