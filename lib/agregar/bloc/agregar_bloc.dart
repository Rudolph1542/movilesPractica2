import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'agregar_event.dart';
part 'agregar_state.dart';

class AgregarBloc extends Bloc<AgregarEvent, AgregarState> {
  AgregarBloc() : super(AgregarInitial()) {
    on<AgregarFavorito>(agregarF);
  }
  void agregarF(AgregarFavorito event, Emitter emit) async {
    bool resultado = await saveFavorito(
        event.cancion, event.artista, event.foto, event.urlAPI);
    if (resultado) {
      print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
      emit(AgregarrSuccess());
    } else {
      print('ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
      emit(AgregarrError());
    }
  }

  Future<bool> saveFavorito(
      String cancion, String artista, String foto, String urlAPI) async {
    Map mapa = {
      'cancion': cancion,
      'artista': artista,
      'foto': foto,
      'urlAPI': urlAPI
    };
    try {
      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}");

      var ref = await user.get();
      List<dynamic> listIds = ref.data()["favoritos"];

      for (var song in listIds) {
        if (mapEquals(song, mapa)) {
          return false;
        }
      }

      listIds.add(mapa);

      await user.update({"favoritos": listIds});
      print(
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
