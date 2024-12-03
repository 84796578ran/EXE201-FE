import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:roomspot/Models/user.dart';
import 'package:roomspot/repositories/user_repository.dart';
import 'package:roomspot/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic>? _userInfo;
  final UserRepository _userRepository = UserRepository.instance;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
   final String ? userEmail = await SharedPrefs.getUserEmail();

    if (userEmail != null) {
      setState(() {
        _userInfo = json.decode(userEmail);
      });

    }
    final User? user = await _userRepository.getUserByEmail(userEmail!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
      ),
      body: _userInfo == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(_userInfo!['avatar'] ?? 'default_avatar.png'),
            ),
            const SizedBox(height: 16),
            Text('Họ và tên: ${_userInfo!['name']}', style: const TextStyle(fontSize: 18)),
            Text('Email: ${_userInfo!['email']}', style: const TextStyle(fontSize: 18)),
            Text('Số điện thoại: ${_userInfo!['phone'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
            Text('Địa chỉ: ${_userInfo!['address'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}