import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void uploadImage(BuildContext context, String path, Function setValid) async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  print('Ankesh $path');

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TakePictureScreen(
                camera: firstCamera,
                storePath: path,
                setValidImage: setValid,
              )));

  print('Ankesh $path');
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final storePath;
  final setValidImage;

  const TakePictureScreen(
      {Key key,
      @required this.camera,
      @required this.storePath,
      this.setValidImage})
      : super(key: key);

  @override
  TakePictureScreenState createState() =>
      TakePictureScreenState(path: storePath);
}

class TakePictureScreenState extends State<TakePictureScreen> {
  final String path;

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  double queryWidth;

  TakePictureScreenState({this.path});

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    queryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: Stack(children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Color.fromRGBO(25, 39, 45, 1)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              backgroundColor: Color.fromRGBO(25, 39, 45, 1),
              // Provide an onPressed callback.
              onPressed: () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Ensure that the camera is initialized.
                  await _initializeControllerFuture;

                  // Attempt to take a picture and log where it's been saved.
                  await _controller.takePicture(widget.storePath);

                  print(widget.storePath);

                  // If the image was taken then set validImage and exit camera screen.
                  widget.setValidImage();
                  Navigator.pop(context);
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}
