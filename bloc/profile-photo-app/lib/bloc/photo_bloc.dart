import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial()) {
    on<GetPhoto>(_onGetPhoto);
  }


  _onGetPhoto(
    GetPhoto event,
    Emitter<PhotoState> emit,
  ) {
    final photo = event.photo;
    // TODO aquí se puede incluir la lógica para subir la foto al servidor
    emit(PhotoSet(photo));
  }

  
}
