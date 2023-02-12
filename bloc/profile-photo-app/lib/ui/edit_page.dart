import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_app/bloc/photo_bloc.dart';
import 'package:photo_app/route/route_names.dart';

class EditPhotoPage extends StatefulWidget {
  final File image;

  const EditPhotoPage({required this.image});

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  late File imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = widget.image;

    if (imageFile != null) _cropImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<Null> _cropImage() async {
    //File croppedFile = await ImageCropper.cropImage(
    CroppedFile? croppedFile = await ImageCropper().cropImage(  
        sourcePath: imageFile.path,
        //aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            hideBottomControls: true,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
          title: 'Cropper',
        )  
        ],
        );
    if (croppedFile != null) {
      //imageFile = croppedFile;
      imageFile = File(croppedFile.path);
      //context.bloc<PhotoBloc>().add(GetPhoto(imageFile));
      BlocProvider.of<PhotoBloc>(context).add(GetPhoto(imageFile));
      Navigator.pop(context, routeHome);
    }
  }
}
