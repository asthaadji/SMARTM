import 'package:flutter/material.dart';
import 'package:smartm/page/user_auth/login_page.dart';
import 'package:smartm/services/auth/auth_model.dart';
import 'package:smartm/services/auth/auth_service.dart';

// ignore: must_be_immutable
class UserPage extends StatefulWidget {
  final UserLogin userLogin;
  final Function(String) onShowSnackBar;
  const UserPage(
      {super.key, required this.userLogin, required this.onShowSnackBar});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLoading = false;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
  }

  void _logout() async {
    try {
      setState(() {
        isLoading = true;
      });
      await authService.logoutUser(widget.userLogin.token);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      final errorMessage = e.toString();
      if (mounted) {
        if (errorMessage.contains('Success Logout User!')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          widget.onShowSnackBar('Failed to logout. $errorMessage');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ]),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama Pengguna',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.userLogin.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Email Pengguna',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.userLogin.email,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child:
                    ElevatedButton(onPressed: _logout, child: Text('Logout')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
