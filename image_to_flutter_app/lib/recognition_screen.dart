import 'package:flutter/material.dart';
import 'package:image_to_flutter_app/utils.dart';

class RecognitionScreen extends StatefulWidget {
  const RecognitionScreen({Key? key}) : super(key: key);

  @override
  State<RecognitionScreen> createState() => _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 55 + MediaQuery.of(context).viewInsets.top,
              ),
              Text(
                "Text Recognition",
                style: textStyle(
                  30,
                  Color.fromARGB(255, 105, 186, 253),
                  FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
