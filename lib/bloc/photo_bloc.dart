import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial()) {
    on<GetPhotoEvent>(_onGetPhoto);
  }

  void _onGetPhoto(
    GetPhotoEvent event,
    Emitter<PhotoState> emit,
  ) {
    final photo = event.photo;
    emit(GetPhotoState(photo));
  }
}
