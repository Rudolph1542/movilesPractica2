part of 'eliminar_bloc.dart';

abstract class EliminarState extends Equatable {
  const EliminarState();

  @override
  List<Object> get props => [];
}

class EliminarInitial extends EliminarState {}

class EliminarSuccess extends EliminarState {}

class EliminarError extends EliminarState {}

class EliminarLoading extends EliminarState {}
