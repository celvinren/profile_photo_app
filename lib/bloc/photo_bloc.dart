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

  // @override
  // Stream<PhotoState> mapEventToState(
  //   PhotoEvent event,
  // ) async* {
  //   if (event is GetPhoto) {
  //     final photo = event.photo;
  //     yield PhotoSet(photo);
  //   }
  // }

  void _onGetPhoto(
    GetPhoto event,
    Emitter<PhotoState> emit,
  ) {
    final photo = event.photo;
    emit(PhotoSet(photo));
  }
}
