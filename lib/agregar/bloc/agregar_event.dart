part of 'agregar_bloc.dart';

abstract class AgregarEvent extends Equatable {
  const AgregarEvent();

  @override
  List<Object> get props => [];
}

class AgregarF extends AgregarEvent {}

class AgregarFavorito extends AgregarEvent {
  String cancion;
  String artista;
  String foto;
  String urlAPI;

  AgregarFavorito({this.cancion, this.artista, this.foto, this.urlAPI});
  @override
  List<Object> get props => [cancion, artista, foto, urlAPI];
}
