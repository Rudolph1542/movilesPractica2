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
    emit(FavLoading());
    try {
      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser.uid}");

      var docsRef = await user.get();
      List<dynamic> list = docsRef.data()["favoritos"] ?? [];
      print(list);
      emit(FavSuccess(list: list));
    } catch (e) {
      print("Error al obtener los items");
      emit(FavError());
    }
  }
}
