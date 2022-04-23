import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/fav/bloc/fav_bloc.dart';
import 'package:practica2/favoritos/favPage.dart';

class DecFavPAge extends StatefulWidget {
  DecFavPAge({Key key}) : super(key: key);

  @override
  State<DecFavPAge> createState() => _DecFavPAgeState();
}

class _DecFavPAgeState extends State<DecFavPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temas favoritos'),
      ),
      body: BlocConsumer<FavBloc, FavState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavSuccess) {
            return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Favoritos(listt: state.list[index]);
                });
          } else if (state is FavError) {
            return Center(
              child: Text('error'),
            );
          } else {
            return Center(
              child: Text('cargando'),
            );
          }
        },
      ),
    );
  }
}
