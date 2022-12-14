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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
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
            onPressed: () {},
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
              Image(
                width: 256,
                height: 256,
                image: AssetImage('images/add_file.png'),
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Lorem Ipsum tipsum",
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
