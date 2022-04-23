import 'package:flutter/material.dart';
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
                },
                child: Text('Eliminar'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        GestureDetector(
            onTap: () {
              linkDialog();
            },
            child: Image.network(widget.listt['foto'], cacheHeight: 340)),
        Text(widget.listt['cancion']),
        Text(widget.listt['artista'])
      ],
    ));
  }
}
