import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/agregar/bloc/agregar_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Actual extends StatefulWidget {
  Actual(
      {Key key,
      this.cancion,
      this.album,
      this.foto,
      this.artista,
      this.urlAPI,
      this.spotifyURL,
      this.appleURL,
      this.fecha})
      : super(key: key);

  String cancion;
  String album;
  String foto;
  String artista;
  String urlAPI;
  String spotifyURL;
  String appleURL;
  String fecha;

  @override
  State<Actual> createState() => _ActualState();
}

class _ActualState extends State<Actual> {
  void favvDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Agragar a favoritos",
            style: TextStyle(color: Colors.red),
          ),
          content:
              new Text("Se agregará esta canción a tu lista de favoritos."),
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
                  BlocProvider.of<AgregarBloc>(context).add(AgregarFavorito(
                      cancion: widget.cancion,
                      artista: widget.artista,
                      foto: widget.foto,
                      urlAPI: widget.urlAPI));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ya se agregó a favoritos'),
                    ),
                  );
                },
                child: Text('Agregar'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Aquí está'),
          actions: [
            IconButton(
                onPressed: () {
                  favvDialog();
                },
                icon: Icon(Icons.favorite))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image(
                  // Como queremos traer una imagen desde un url usamos NetworkImage
                  image: NetworkImage(widget.foto), height: 340,
                ),
              ),
              Text(widget.cancion,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text(widget.album,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                widget.artista,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(widget.fecha),
              SizedBox(
                height: 20,
              ),
              Text(
                'Abrir con:',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      launch(widget.spotifyURL);
                    },
                    child: Image.asset(
                      'assets/spotify.png',
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(55, 55),
                        shape: CircleBorder(),
                        primary: Colors.transparent,
                        onPrimary: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      launch(widget.urlAPI);
                    },
                    child: Image.asset(
                      'assets/signal.png',
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(55, 55),
                        shape: CircleBorder(),
                        primary: Colors.transparent,
                        onPrimary: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      launch(widget.appleURL);
                    },
                    child: Image.asset(
                      'assets/apple.png',
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(55, 55),
                        shape: CircleBorder(),
                        primary: Colors.transparent,
                        onPrimary: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
