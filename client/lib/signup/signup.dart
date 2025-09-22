import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nicknameController = TextEditingController();

  void _signup() async {
    final email = emailController.text;
    final password = passwordController.text;
    final nickname = nicknameController.text;

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/signup/signup'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'email': email,
        'password': password,
        'nickname': nickname,
      },
    );

    if (response.statusCode == 200) {
      print('회원가입 성공: ${response.body}');
      // Navigator.pop(context); // 회원가입 후 로그인 화면으로 돌아가기
    } else {
      print('회원가입 실패: ${response.statusCode}, ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            TextField(
              controller: nicknameController,
              decoration: const InputDecoration(labelText: '닉네임'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _signup, child: const Text('회원가입')),
          ],
        ),
      ),
    );
  }
}
