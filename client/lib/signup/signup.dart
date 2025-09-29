import 'package:flutter/material.dart';
import 'package:client/signup/widget/input.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController(text: "Unknown");

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? nicknameError;

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
  bool validateInputs() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final nickname = nicknameController.text.trim();
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
      nicknameError = null;

      final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
      final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,16}$');
      final nicknameRegex = RegExp(r'^[a-zA-Z0-9]{2,}$');


      if (!emailRegex.hasMatch(email)) {
        emailError = "이메일 주소가 정확한지 확인해 주세요.";
      }

      if (!passwordRegex.hasMatch(password)) {
        passwordError = "8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.";
      }

      if (password != confirmPassword) {
        confirmPasswordError = "비밀번호가 일치하지 않습니다.";
      }
      if (!nicknameRegex.hasMatch(nickname)) {
        nicknameError = "닉네임은 2글자 이상, 특수문자 없이 입력해 주세요.";
      }
    });

    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        nicknameError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4B39EF),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset('assets/main2.jpg').image,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 530,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    color: Color(0x4D090F13),
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 56, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Dive Meet You",
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 9),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create your account",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      InputField(
                        controller: emailController,
                        labelText: "Email",
                        hintText: "Enter your email...",
                        errorText: emailError,
                      ),
                      InputField(
                        controller: passwordController,
                        labelText: "Password",
                        hintText: "Enter your password...",
                        errorText: passwordError,
                      ),
                      InputField(
                        controller: confirmPasswordController,
                        labelText: "Confirm Password",
                        hintText: "Re-enter your password...",
                        errorText: confirmPasswordError,
                      ),
                      InputField(
                        controller: nicknameController,
                        labelText: "Nickname",
                        hintText: "Enter your nickname...",
                        errorText: nicknameError,
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 24),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Back to Login", style: TextStyle(color: Colors.green)),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (validateInputs()) {
                                    _signup();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  textStyle: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                child: Text("Sign Up"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
