import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CameraPage2 extends StatefulWidget {
  const CameraPage2({Key? key, required this.cameras, required this.id})
      : super(key: key);

  final List<CameraDescription>? cameras;
  final String id;

  @override
  State<CameraPage2> createState() => _CameraPage2State();
}

class _CameraPage2State extends State<CameraPage2> {
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

    final apiurl = "http://116.68.252.201:1945/uploadFoto/${widget.id}";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiurl));

      // Add the photo file to the request
      request.files.add(await http.MultipartFile.fromPath('photo', data.path));

      // Add other fields as needed
      request.fields['folder'] = 'order_item';
      request.fields['id'] = widget.id;

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
      Navigator.pop(context);
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
