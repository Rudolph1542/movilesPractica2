part of 'fav_bloc.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();

  @override
  List<Object> get props => [];
}

class getListaFav extends FavEvent {}
