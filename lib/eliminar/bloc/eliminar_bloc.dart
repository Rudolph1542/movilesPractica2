import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'eliminar_event.dart';
part 'eliminar_state.dart';

class EliminarBloc extends Bloc<EliminarEvent, EliminarState> {
  EliminarBloc() : super(EliminarInitial()) {
    on<EliminarSong>(eliminarC);
  }

  void eliminarC(EliminarSong event, Emitter emit) async {
    var resultado = await eliminarCancion(
        event.cancion, event.artista, event.foto, event.urlAPI);
    if (resultado != null) {
      print('2bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
      print(event.cancion);
      emit(EliminarSuccess());
    } else {
      print('2ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
      emit(EliminarError());
    }
  }

  Future<List<Map<String, dynamic>>> eliminarCancion(
      String cancion, String artista, String foto, String urlAPI) async {
    Map mapa = {
      'cancion': cancion,
      'artista': artista,
      'foto': foto,
      'urlAPI': urlAPI
    };
    try {
      var qUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}");

      var docsRef = await qUser.get();
      List<dynamic> listIds = docsRef.data()["favoritos"];

      List<Map<String, dynamic>> nList = [];

      for (var song in listIds) {
        if (!mapEquals(song, mapa)) {
          nList.add(song);
        }
      }
      print(nList);
      var qdelete = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}")
          .update({'favoritos': nList});
      return (nList);
    } catch (e) {
      print("Error: $e");
      return (null);
    }
  }
}
