import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/eliminar/bloc/eliminar_bloc.dart';
import 'package:practica2/fav/bloc/fav_bloc.dart';
import 'package:practica2/favoritos/decfavPage.dart';

import 'package:url_launcher/url_launcher.dart';

class Favoritos extends StatefulWidget {
  Map<String, dynamic> listt;
  Favoritos({Key key, this.listt}) : super(key: key);

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  void linkDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Abrir canción",
            style: TextStyle(color: Colors.red),
          ),
          content: new Text(
              "Se mostrarán opciones de la canción en una página web externa."),
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
                  launch(widget.listt['urlAPI']);
                },
                child: Text('Aceptar'))
          ],
        );
      },
    );
  }

  void favDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Eliminar de favoritos",
            style: TextStyle(color: Colors.red),
          ),
          content:
              new Text("Se eiminará esta cancion de tu lista de favoritos."),
          actions: [
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<EliminarBloc>(context).add(EliminarSong(
                      cancion: widget.listt['cancion'],
                      artista: widget.listt['artista'],
                      foto: widget.listt['foto'],
                      urlAPI: widget.listt['urlAPI']));
                  BlocProvider.of<FavBloc>(context).add(getListaFav());
                },
                child: Text('Eliminar'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
          child: Column(
        children: [
          IconButton(
              onPressed: () {
                favDialog();
              },
              icon: Icon(Icons.cancel_sharp)),
          GestureDetector(
              onTap: () {
                linkDialog();
              },
              child: Image.network(widget.listt['foto'], cacheHeight: 240)),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.listt['cancion'],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(widget.listt['artista']),
          SizedBox(
            height: 5,
          ),
        ],
      )),
    );
  }
}
