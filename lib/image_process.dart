import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageProccess extends StatefulWidget {
  @override
  _ImageProccessState createState() => _ImageProccessState();
}

class _ImageProccessState extends State<ImageProccess> {
  File _img;

  getImageFile(ImageSource src) async {
    var image = await ImagePicker.pickImage(source: src);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 50,
    );

    setState(() {
      _img = result;
      print(_img.lengthSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_img?.lengthSync());
    return Scaffold(
      appBar: AppBar(
        title: Text("UImage"),
      ),
      body: Center(
        child: _img == null
            ? Text("Pick an Image From Gallery")
            : Image.file(
                _img,
                height: 200,
                width: 200,
              ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            label: Text("Camera"),
            onPressed: () => getImageFile(ImageSource.camera),
            heroTag: UniqueKey(),
            icon: Icon(Icons.camera),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
            label: Text("Gallery"),
            onPressed: () => getImageFile(ImageSource.gallery),
            heroTag: UniqueKey(),
            icon: Icon(Icons.photo_library),
          )
        ],
      ),
    );
  }
}
