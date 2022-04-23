import 'package:flutter/material.dart';
import 'package:practica2/agregar/bloc/agregar_bloc.dart';
import 'package:practica2/auth/bloc/auth_bloc.dart';
import 'package:practica2/eliminar/bloc/eliminar_bloc.dart';
import 'package:practica2/fav/bloc/fav_bloc.dart';
import 'package:practica2/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica2/login/loginPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/song/bloc/song_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => SongBloc(),
        ),
        BlocProvider(
          create: (context) => AgregarBloc(),
        ),
        BlocProvider(
          create: (context) => FavBloc()..add(getListaFav()),
        ),
        BlocProvider(
          create: (context) => EliminarBloc()..add(EliminarSong()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.indigo),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState || state is AuthErrorState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
