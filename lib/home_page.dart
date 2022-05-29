import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_photo_app/bloc/photo_bloc.dart';
import 'package:profile_photo_app/edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _showSelectionDialog();
                },
                child: BlocBuilder<PhotoBloc, PhotoState>(
                  bloc: BlocProvider.of<PhotoBloc>(context), // provide the local bloc instance
                  builder: (context, state) {
                    return SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: state is PhotoInitial
                                ? Image.asset('assets/images/user.png') // set a placeholder image when no photo is set
                                : Image.file((state as PhotoSet).photo),
                          ),
                        ));
                  },
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Please select your profile photo',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Method for sending a selected or taken photo to the EditPage
  Future selectOrTakePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => EditPhotoPage(image: _image!),
          ),
        );
      } else
        print('No photo was selected or taken');
    });
  }

  /// Selection dialog that prompts the user to select an existing photo or take a new one
  Future _showSelectionDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Select photo'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('From gallery'),
                onPressed: () {
                  selectOrTakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('Take a photo'),
                onPressed: () {
                  selectOrTakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
