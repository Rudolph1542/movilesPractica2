import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/actual/actualPage.dart';
import 'package:practica2/home/homepage.dart';
import 'package:practica2/song/bloc/song_bloc.dart';

class DecActualPage extends StatefulWidget {
  DecActualPage({Key key}) : super(key: key);

  @override
  State<DecActualPage> createState() => _DecActualPageState();
}

class _DecActualPageState extends State<DecActualPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SongBloc, SongState>(
      listener: (context, state) {
        if (state is SongErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Canción no detectada'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SongSuccess) {
          return Actual(
              cancion: state.mapa['title'],
              album: state.mapa['album'],
              foto: state.mapa['spotify']['album']['images'][0]['url'],
              artista: state.mapa['artist'],
              urlAPI: state.mapa['song_link'],
              spotifyURL: state.mapa['spotify']['external_urls']['spotify'],
              appleURL: state.mapa['apple_music']['url'],
              fecha: state.mapa['release_date']);
        }
        if (state is SongErrorState) {
          return HomePage();
        } else if (state is SongLoading) {
          return Scaffold(
            body: Center(
              child: Text('ESCUCHANDO'),
            ),
          );
        } else {
          return HomePage();
        }
      },
    );
  }
}
