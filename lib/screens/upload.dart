import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

import '../current_user.dart';

class DemoUploadImage extends StatefulWidget {
  @override
  _DemoUploadImageState createState() => _DemoUploadImageState();
}

class _DemoUploadImageState extends State<DemoUploadImage> {
  Uint8List? _image;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String? img64;
  Future choiceImage() async {
    Object? pickedImage =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    if (pickedImage == null) return null;

    setState(() {
      _image = pickedImage as Uint8List?;
    });
    //final bytes = pickedImage.path).readAsBytesSync();

    img64 = base64Encode(_image!);
  }

  Future uploadImage(BuildContext context) async {
    var url =
        "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/upload_product.php";
    var response = await http.post(Uri.parse(url), body: {
      "productName": nameController.text,
      "productPrice": priceController.text,
      "category": categoryController.text,
      "image": img64,
      "seller": CurrentUser.email,
    });
    var data = response.body;
    if (data.toString() == "success") {
      Fluttertoast.showToast(
        msg: "Successefully uploaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AllPersonData(),
      //   ),
      // );
    } else {
      Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AllPersonData(),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Add'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'CATEGORY'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                choiceImage();
              },
            ),
            Container(
              child: _image == null
                  ? Text('No Image Selected')
                  : Image.memory(_image!),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Upload Image'),
              onPressed: () {
                uploadImage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
