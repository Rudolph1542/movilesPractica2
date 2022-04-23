part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

class FavInitial extends FavState {}

class FavSuccess extends FavState {
  final List<dynamic> list;
  FavSuccess({this.list});
  @override
  List<Object> get props => [list];
}

class FavError extends FavState {}

class FavLoading extends FavState {}
