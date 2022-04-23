import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/originals/5c/4a/1c/5c4a1cef8a1ebd3584fac99c817b173c.gif'),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/musica.png',
                    height: 155,
                    color: Colors.pink[300],
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                    },
                    color: Colors.indigo,
                    child: Text("Login con Google"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
