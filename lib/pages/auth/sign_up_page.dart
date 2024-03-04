import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/image/logo part 1.png"),
              radius: 80,
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
