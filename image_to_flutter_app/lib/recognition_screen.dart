// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_flutter_app/apikey.dart';
import 'package:image_to_flutter_app/utils.dart';
import 'dart:io';
import 'dart:io' as Io;
import 'package:http/http.dart' as http;

class RecognitionScreen extends StatefulWidget {
  const RecognitionScreen({Key? key}) : super(key: key);

  @override
  State<RecognitionScreen> createState() => _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  dynamic pickedImage = null;
  String ocrResult = "";
  bool scanning = true;
  optionsDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text(
                  "Gallary",
                  style: textStyle(
                    20,
                    Colors.black,
                    FontWeight.w400,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text(
                  "Camera",
                  style: textStyle(
                    20,
                    Colors.black,
                    FontWeight.w400,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: textStyle(
                    20,
                    Colors.black,
                    FontWeight.w400,
                  ),
                ),
              )
            ],
          );
        });
  }

  pickImage(ImageSource imageSource) async {
    final image = await ImagePicker().getImage(source: imageSource);
    print("path: " + File(image.path).toString());
    setState(() {
      pickedImage = File(image.path);
      scanning = true;
    });
    Navigator.pop(context);

    Uint8List bytes = Io.File(pickedImage.path).readAsBytesSync();
    String img64 = base64Encode(bytes);

    String url = "https://api.ocr.space/parse/image";

    var data = {"base64Image": "data:image/jpg;base64,$img64"};
    var header = {"apikey": key};

    http.Response response = await http.post(url, body: data, headers: header);

    Map result = jsonDecode(response.body);
    print(result["ParsedResults"][0]["ParsedText"]);
    setState(() {
      ocrResult = result["ParsedResults"][0]["ParsedText"];
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              // SnackBar snack;
              FlutterClipboard.copy(ocrResult).then((value) {
                SnackBar snack = SnackBar(
                  content: Text(
                    "Copied to clipboard",
                    style: textStyle(18, Colors.white, FontWeight.w700),
                  ),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
              });
            },
            child: Icon(
              Icons.copy,
              size: 28,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            backgroundColor: Color(0xffec360e),
            heroTag: null,
            onPressed: () =>
                Share.text("Flutter OCR App", ocrResult, "text/plaintex"),
            child: Icon(
              Icons.share,
              size: 28,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 60 + MediaQuery.of(context).viewInsets.top,
              ),
              Text(
                "Text Recognition",
                style: textStyle(
                  30,
                  Color.fromARGB(255, 105, 186, 253),
                  FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => optionsDialogue(context),
                child: pickedImage == null
                    ? Image(
                        width: 256,
                        height: 256,
                        image: AssetImage('images/add_file.png'),
                        fit: BoxFit.fill,
                      )
                    : Image(
                        image: FileImage(pickedImage),
                        width: 256,
                        height: 256,
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                !scanning ? ocrResult : "Scanning...",
                style: textStyle(
                  30,
                  Color.fromARGB(255, 105, 186, 253),
                  FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
