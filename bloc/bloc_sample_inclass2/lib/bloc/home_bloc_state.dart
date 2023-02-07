part of 'home_bloc_bloc.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();
  
  @override
  List<Object> get props => [];
}

class HomeBlocInitial extends HomeBlocState {}
