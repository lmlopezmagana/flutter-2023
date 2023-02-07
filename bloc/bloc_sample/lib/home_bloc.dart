import 'dart:math';
import 'package:bloc_sample/food.dart';
import 'package:bloc_sample/food_generator.dart';
import 'package:bloc_sample/home_event.dart';
import 'package:bloc_sample/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(const HomeInitialState()) {
  //HomeBloc() : super(const HomeLoadingState()) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  void _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(const HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    bool isSucceed = Random().nextBool();
    if (isSucceed) {
        List<Food> _dummyFoods = FoodGenerator.generateDummyFoods();
        emitter(HomeSuccessFetchDataState(foods: _dummyFoods));
    } else {
      emitter(const HomeErrorFetchDataState(errorMessage: "something went very wrong :("));
    }


  }

}