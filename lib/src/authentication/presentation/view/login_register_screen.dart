import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextFormField(),
            TextFormField(),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {},
              child: const Text('Login'),
            )
          ],
        ),
      )),
    );
  }
}
