import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:driver_cold_storage/screens/pengiriman.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'preview_page.dart';
import 'package:http/http.dart' as http;
import 'package:driver_cold_storage/models/pengantaranModel.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras, required this.id})
      : super(key: key);

  final List<CameraDescription>? cameras;
  final List<PengantaranModel> id;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  String _message = '';
  Future uploadPicture(XFile data) async {
    setState(() {
      _message = '';
    });

    final apiurl = "http://116.68.252.201:1945/uploadFoto/${widget.id[0].Id}";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiurl));

      // Add the photo file to the request
      request.files.add(await http.MultipartFile.fromPath('photo', data.path));

      // Add other fields as needed
      request.fields['folder'] = 'Distribute';
      request.fields['id'] = widget.id[0].Id;

      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        // Image upload was successful
        setState(() {
          _message = "Image uploaded successfully";
          _showSuccessSnackbar(_message);
        });
      } else {
        // Handle other HTTP status codes if needed
        _message = "Error: ${streamedResponse.reasonPhrase}";
        _showErrorSnackbar(_message);
      }
    } catch (e) {
      // Handle exceptions.
      _message = "Error: $e";
      _showErrorSnackbar(_message);
    }
  }

  // Future uploadPicture(XFile data) async {
  //   setState(() {
  //     _message = '';
  //   });

  //   final apiurl = "http://116.68.252.201:1945/uploadFoto/${widget.id[0].Id}";

  //   try {
  //     // Define the data to be posted as a JSON object.
  //     Map<String, dynamic> postData = {
  //       "photo": data,
  //       "folder": "Distribute",
  //       "id": widget.id[0].Id, // You can include your data here.
  //     };

  //     // Convert the data to JSON.
  //     String jsonData = jsonEncode(postData);

  //     var response = await http.post(
  //       Uri.parse(apiurl),
  //       body: jsonData, // Send the JSON data in the request body.
  //     );

  //     if (response.statusCode == 200) {
  //       // Request was successful.
  //       setState(() {
  //         _message = "Data posted successfully";
  //         _showSuccessSnackbar(_message);
  //       });
  //     } else {
  //       // Handle other HTTP status codes if needed.
  //       _message = "Error: ${response.reasonPhrase}";
  //       _showErrorSnackbar(_message);
  //     }
  //   } catch (e) {
  //     // Handle exceptions.
  //     _message = "Error: $e";
  //     _showErrorSnackbar(_message);
  //   }
  // }

  // Future uploadPicture(XFile data) async {
  //   setState(() {
  //     _message = '';
  //   });

  //   final apiurl =
  //       "http://116.68.252.201:1945/uploadFoto/${widget.id[0].Id}"; // Replace with the actual API endpoint.

  //   try {
  //     // Define the data to be posted as a JSON object.
  //     Map<String, dynamic> postData = {
  //       "photo": data.path,
  //       "folder": "cobaFoto",
  //       "id": widget.id[0].Id, // You can include your data here.
  //     };

  //     // Convert the data to JSON.
  //     String jsonData = jsonEncode(postData);

  //     var response = await http.post(
  //       Uri.parse(apiurl),
  //       headers: {
  //         "Content-Type": "application/json", // Set the content type to JSON.
  //       },
  //       body: jsonData, // Send the JSON data in the request body.
  //     );

  //     if (response.statusCode == 200) {
  //       // Request was successful.
  //       setState(() {
  //         _message = "Data posted successfully";
  //         _showSuccessSnackbar(_message);
  //       });
  //     } else {
  //       // Handle other HTTP status codes if needed.
  //       _message = "Error: ${response.reasonPhrase}";
  //       _showErrorSnackbar(_message);
  //     }
  //   } catch (e) {
  //     // Handle exceptions.
  //     _message = "Error: $e";
  //     _showErrorSnackbar(_message);
  //   }
  // }

  // Future uploadPicture(XFile picture) async {
  //   setState(() {
  //     _message = '';
  //   });

  //   final apiurl = "http://116.68.252.201:1945/uploadFoto/${widget.id[0].Id}";

  //   int maxRetries = 3;
  //   int retryCount = 0;

  //   while (retryCount < maxRetries) {
  //     try {
  //       var request = http.MultipartRequest('POST', Uri.parse(apiurl));
  //       request.files
  //           .add(await http.MultipartFile.fromPath('picture', picture.path));

  //       final streamedResponse = await request.send();

  //       if (streamedResponse.statusCode == 200) {
  //         // Image upload was successful
  //         setState(() {
  //           _message = "Image uploaded successfully";
  //           _showSuccessSnackbar(_message);
  //         });
  //         return;
  //       } else {
  //         _message = "Error: ${streamedResponse.reasonPhrase}";
  //         _showErrorSnackbar(_message);
  //         return;
  //       }
  //     } catch (e) {
  //       _message = "Error: $e";
  //       _showErrorSnackbar(_message);
  //     }

  //     // Increment the retry count and try again
  //     retryCount++;
  //   }

  //   if (retryCount >= maxRetries) {
  //     // Handle the case where the maximum number of retries is reached
  //     _showErrorSnackbar("Max retries reached");
  //   }
  // }

  // Future uploadPicture(XFile picture) async {
  //   setState(() {
  //     _message = '';
  //   });

  //   final apiurl = "http://116.68.252.201:1945/uploadFoto/${widget.id[0].Id}";

  //   try {
  //     var request = http.MultipartRequest('POST', Uri.parse(apiurl));
  //     request.files
  //         .add(await http.MultipartFile.fromPath('picture', picture.path));

  //     final streamedResponse = await request.send();

  //     if (streamedResponse.statusCode == 200) {
  //       // Image upload was successful
  //       setState(() {
  //         _message = "Image uploaded successfully";
  //         _showSuccessSnackbar(_message);
  //       });
  //     } else {
  //       // Handle other HTTP status codes if needed
  //       _message = "Error: ${streamedResponse.reasonPhrase}";
  //       _showErrorSnackbar(_message);
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     _message = "Error: $e";
  //     _showErrorSnackbar(_message);
  //   }
  // }

  // Future uploadPicture(picture) async {
  //   setState(() {
  //     _message = '';
  //   });
  //   final apiurl = "116.68.252.201:1945/uploadFoto/${widget.id[0].Id}";

  //   // final id = widget.id;

  //   // final folder = "buktiSampai";

  //   var request = http.MultipartRequest('POST', Uri.parse(apiurl));
  //   request.files
  //       .add(await http.MultipartFile.fromPath('picture', picture.path));
  //   var res = await request.send();
  //   return res.reasonPhrase;
  //   // try {
  //   //   final response = await http.post(Uri.parse(apiurl),
  //   //       body: {'photo': picture, 'folder': folder, 'id': id[0].Id});

  //   //   if (response.statusCode == 200) {
  //   //     setState(() {
  //   //       _message = "Gambar berhasil diupload";
  //   //       _showSuccessSnackbar(_message);
  //   //     });
  //   //   } else if (response.statusCode == 401) {
  //   //     _message = "error 401";
  //   //     _showErrorSnackbar(_message);
  //   //   } else {
  //   //     _message = "error lain";
  //   //     _showErrorSnackbar(_message);
  //   //   }
  //   // } catch (e) {
  //   //   setState(() {});
  //   // }
  // }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green, // Use a success color
      ),
    );
  }

  void _showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      uploadPicture(picture);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => PreviewPage(
      //               picture: picture,
      //             )));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => pengirimanScreen(
                    pengantaran: widget.id,
                  )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        (_cameraController.value.isInitialized)
            ? CameraPreview(_cameraController)
            : Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator())),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  color: Colors.black),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 30,
                  icon: Icon(
                      _isRearCameraSelected
                          ? CupertinoIcons.switch_camera
                          : CupertinoIcons.switch_camera_solid,
                      color: Colors.white),
                  onPressed: () {
                    setState(
                        () => _isRearCameraSelected = !_isRearCameraSelected);
                    initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                  },
                )),
                Expanded(
                    child: IconButton(
                  onPressed: takePicture,
                  iconSize: 50,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.circle, color: Colors.white),
                )),
                const Spacer(),
              ]),
            )),
      ]),
    ));
  }
}
