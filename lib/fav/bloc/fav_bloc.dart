import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial()) {
    on<FavEvent>(getList);
  }

  Future<void> getList(event, emit) async {
    try {
      var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()["favoritos"] ?? [];
      print(listIds);
      emit(FavSuccess(list: listIds));
    } catch (e) {
      print("Error al obtener todos los items");
      emit(FavError());
    }
  }
}
