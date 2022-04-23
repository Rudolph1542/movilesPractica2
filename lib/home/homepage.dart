import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/actual/actualPage.dart';
import 'package:practica2/fav/bloc/fav_bloc.dart';
import 'package:practica2/favoritos/decfavPage.dart';
import 'package:practica2/favoritos/favPage.dart';
import 'package:practica2/song/bloc/song_bloc.dart';
import '../auth/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void exitDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Cerrar sesión",
            style: TextStyle(color: Colors.red),
          ),
          content: new Text(
              "Al cerrar sesión se redirigirá a la pantalla de Login."),
          actions: [
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                },
                child: Text('Cerrar sesion'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Presiona para escuchar',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 100,
          ),
          BlocConsumer<SongBloc, SongState>(
            listener: (context, state) {
              if (state is SongSuccess) {
                print(state.mapa['title']);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Actual(
                        cancion: state.mapa['title'],
                        album: state.mapa['album'],
                        foto: state.mapa['spotify']['album']['images'][0]
                            ['url'],
                        artista: state.mapa['artist'],
                        urlAPI: state.mapa['song_link'],
                        spotifyURL: state.mapa['spotify']['external_urls']
                            ['spotify'],
                        appleURL: state.mapa['apple_music']['url'],
                        fecha: state.mapa['release_date'])));
              } else if (state is SongErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Canción no detectada'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SongBloc>(context).add(SongListen());
                },
                child: Image.asset('assets/musica.png', height: 145),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(165, 165),
                    shape: CircleBorder(),
                    primary: Colors.white,
                    onPrimary: Colors.black),
              );
            },
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<FavBloc>(context).add(getListaFav());
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DecFavPAge()));
                },
                child: Icon(Icons.favorite, color: Colors.black),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(45, 45),
                    shape: CircleBorder(),
                    primary: Colors.white,
                    onPrimary: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  exitDialog();
                },
                child: Icon(Icons.logout, color: Colors.black),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(45, 45),
                    shape: CircleBorder(),
                    primary: Colors.white,
                    onPrimary: Colors.black),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
