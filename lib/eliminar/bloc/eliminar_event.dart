part of 'eliminar_bloc.dart';

abstract class EliminarEvent extends Equatable {
  const EliminarEvent();

  @override
  List<Object> get props => [];
}

class EliminarSong extends EliminarEvent {
  String cancion;
  String artista;
  String foto;
  String urlAPI;

  EliminarSong({this.cancion, this.artista, this.foto, this.urlAPI});

  @override
  List<Object> get props => [cancion, artista, foto, urlAPI];
}
