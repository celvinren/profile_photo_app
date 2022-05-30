import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:profile_photo_app/bloc/photo_bloc.dart';

class EditPhotoPage extends StatefulWidget {
  final File image;

  const EditPhotoPage({required this.image});

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  CroppedFile? imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = CroppedFile(widget.image.path);

    if (imageFile != null) _cropImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<Null> _cropImage() async {
    if (imageFile == null) {
      throw (Exception("image file is null"));
    }

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit',
          toolbarColor: Colors.white,
          hideBottomControls: true,
          toolbarWidgetColor: Color(0xffFB7C23),
          // initAspectRatio: CropAspectRatioPreset.original,
          // lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      context.read<PhotoBloc>().add(GetPhotoEvent(File(imageFile!.path)));
    }
    Navigator.pop(context);
  }
}
