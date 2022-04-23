part of 'song_bloc.dart';

abstract class SongState extends Equatable {
  const SongState();

  @override
  List<Object> get props => [];
}

class SongInitial extends SongState {}

class SongErrorState extends SongState {
  final String errorMsg;

  SongErrorState({this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class SongSuccess extends SongState {
  /*
  final String foto;
  final String cancion;
  final String artista;
  final String urlAPI;
  final String album;
  final String spotifyURL;
  final String appleURL;
  final String fecha;*/

  Map mapa;

  SongSuccess({this.mapa});

  @override
  List<Object> get props => [mapa];
}

class SongLoading extends SongState {}
