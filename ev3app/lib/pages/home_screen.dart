// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;


class Kit {
  final String name;
  List<Map<String, dynamic>> bricks;

  Kit({
    required this.name,
    required this.bricks,
  });
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, Key? home_key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ['Item 0'];
  File? _selectedImage;
  bool _showDeleteIcon = false; // New state variable to track delete icon visibility
  List<Kit> kits = [];
  List<Map<String, dynamic>> hardcodedBrickList = [

    // Group 1
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32449/0.webp", "label": "32449", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/33299/0.webp", "label": "33299", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/41678/0.webp", "label": "41678", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/99773/0.webp", "label": "99773", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/87082/0.webp", "label": "87082", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/48989/0.webp", "label": "48989", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/55615/0.webp", "label": "55615", "count": "4"},

    // Group 2
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/6538c/0.webp", "label": "6538c", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/6536/0.webp", "label": "6536", "count": "8"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/57585/0.webp", "label": "57585", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/44809/0.webp", "label": "44809", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/63869/0.webp", "label": "63869", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32291/0.webp", "label": "32291", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/42003/0.webp", "label": "42003", "count": "8"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32184/0.webp", "label": "32184", "count": "8"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32014/0.webp", "label": "32014", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32013/0.webp", "label": "32013", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32034/0.webp", "label": "32034", "count": "4"},

    // Group 3
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32523/0.webp", "label": "32523", "count": "18"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/60483/0.webp", "label": "60483", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/45590/0.webp", "label": "45590", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/x346/0.webp", "label": "x346", "count": "4"},

    // Group 4
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32062/0.webp", "label": "32062", "count": "10"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/4519/0.webp", "label": "4519", "count": "14"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3705/0.webp", "label": "3705", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32073/0.webp", "label": "32073", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3706/0.webp", "label": "3706", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/44294/0.webp", "label": "44294", "count": "5"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3707/0.webp", "label": "3707", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/60485/0.webp", "label": "60485", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3737/0.webp", "label": "3737", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3708/0.webp", "label": "3708", "count": "2"},

    // Group 5
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/6558/0.webp", "label": "6558", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32556/0.webp", "label": "32556", "count": "30"},

    // Group 6
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/2780/0.webp", "label": "2780", "count": "60"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3673/0.webp", "label": "3673", "count": "10"},

    // Group 7
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32054/0.webp", "label": "32054", "count": "22"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/62462/0.webp", "label": "62462", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/87083/0.webp", "label": "87083", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/55013/0.webp", "label": "55013", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/6587/0.webp", "label": "6587", "count": "2"},

    // Group 8
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3749/0.webp", "label": "3749", "count": "8"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/43093/0.webp", "label": "43093", "count": "20"},

    // Group 9
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/4265c/0.webp", "label": "4265c", "count": "10"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3713/0.webp", "label": "3713", "count": "10"},

    // Group 10
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32316/0.webp", "label": "32316", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32524/0.webp", "label": "32524", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/40490/0.webp", "label": "40490", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32525/0.webp", "label": "32525", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/41239/0.webp", "label": "41239", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32278/0.webp", "label": "32278", "count": "6"},

    // Group 11
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32140/0.webp", "label": "32140", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/60484/0.webp", "label": "60484", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32526/0.webp", "label": "32526", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32348/0.webp", "label": "32348", "count": "6"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32271/0.webp", "label": "32271", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/6629/0.webp", "label": "6629", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32009/0.webp", "label": "32009", "count": "4"},

    // Group 12
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/64179/0.webp", "label": "64179", "count": "3"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/64178/0.webp", "label": "64178", "count": "1"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/92911/0.webp", "label": "92911", "count": "1"},

    // Group 13
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/10928/0.webp", "label": "10928", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/6589/0.webp", "label": "6589", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/94925/0.webp", "label": "94925", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3648/0.webp", "label": "3648", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/3649/0.webp", "label": "3649", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32270/0.webp", "label": "32270", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32269/0.webp", "label": "32269", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32498/0.webp", "label": "32498", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/99010/0.webp", "label": "99010", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/4716/0.webp", "label": "4716", "count": "2"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/32072/0.webp", "label": "32072", "count": "4"},
    {"image_url": "https://storage.googleapis.com/brickognize-static/thumbnails-v2.4/part/4185c01/0.webp", "label": "4185c01", "count": "4"},


  ];
  String endpoint = "https://penguin-gorgeous-vaguely.ngrok-free.app/predict";

  void _addItem(BuildContext context) {
    String kitName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Kit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Kit Name:'),
              TextField(
                onChanged: (value) {
                  kitName = value;
                },
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    kits.add(
                      Kit(
                        name: kitName.isNotEmpty ? kitName : 'Kit ${kits
                            .length}',
                        bricks: [],
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Text('Save'),
              ),
            ),
          ],
        );
      },
    );
  }


  // void _clearAllKits() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Clear all kits?'),
  //         content: Text('Are you sure you want to clear all kits?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 items.removeRange(1, items.length);
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Clear'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _clearAllKits() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear all kits?'),
          content: Text('Are you sure you want to clear all kits?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  kits.clear();
                  // Clear the items list to match kits list
                  items.clear();
                  // Add a default value to items list if needed
                  items.add(""); // For example, if items is a list of strings
                });
                Navigator.of(context).pop();
              },
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }


  // Future<void> _pickImageFromCamera(BuildContext context) async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Camera Instructions'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Instructions:'),
  //             SizedBox(height: 8),
  //             Text('1. Lay bricks out'),
  //             Text('2. Align camera'),
  //             Text('3. Submit'),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _openCamera();
  //             },
  //             child: Text('Start Camera'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _pickImageFromCamera(BuildContext context) async {
    if (kits.isEmpty) {
      // If there are no kits, prompt the user to create a kit first
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create Kit'),
            content: Text('You need to create a kit before scanning.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _addItem(context); // Open the add item dialog to create a kit
                },
                child: Text('Create Kit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      // Proceed with scanning process
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Camera Instructions'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Instructions:'),
                SizedBox(height: 8),
                Text('1. Lay bricks out very evenly on standard, white printer paper\n'),
                Text('2. Align camera from a direct, top down view\n'),
                Text('3. Capture image and submit\n'),
                Text('4. Scroll to bottom of the results list and select which kits to add bricks to\n'),
                Text('5. Click on a kit in order to view it\'s current contents as well as the bricks it is missing\n'),
                Text('6. Note: The "scan" function within the kits will immediately append to that kit. In order to prevent mistaken additions, it is recommended you use the "scan" function on the home screen\n')
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _openCamera();
                },
                child: Text('Start Camera'),
              ),
            ],
          );
        },
      );
    }
  }


  void _pickImageForKit(Kit kit) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (returnedImage == null) return;

    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Processing'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Processing image...'),
                ],
              ),
            );
          },
        );
      },
    );

    // Send image and get response
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(endpoint),
    );

    request.files.add(
      await http.MultipartFile.fromPath('image', returnedImage.path),
    );

    var response = await request.send();

    // Process response
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        List<Map<String, dynamic>> bricks = List<Map<String, dynamic>>.from(jsonResponse);
        //kit.bricks.addAll(List<Map<String, dynamic>>.from(jsonResponse)); //= List<Map<String, dynamic>>.from(jsonResponse);
        if(kit.bricks.isEmpty){
          kit.bricks.addAll(bricks);
        }
        else{
          for (Map<String, dynamic> newBrick in bricks) {
            bool found = false;
            for (Map<String, dynamic> existingBrick in kit.bricks){
              if(existingBrick["label"] == newBrick["label"]) {
                existingBrick["count"] = (int.parse(existingBrick["count"]) + int.parse(newBrick["count"])).toString();

                found = true;
              }
            }
            if (!found) {
              kit.bricks.add(newBrick);
            }
          }
        }
      });
      Navigator.of(context).pop(); // Close processing dialog
    } else {
      //print('Failed to send image: ${response.reasonPhrase}');
      Navigator.of(context).pop(); // Close processing dialog

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send image: ${response.reasonPhrase}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }


  // void _openCamera() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //
  //   if (returnedImage == null) return;
  //   setState(() {
  //     _selectedImage = File(returnedImage.path);
  //   });
  //
  //
  // }

  void _openCameraForKit(Kit kit) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (returnedImage == null) return;

    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Processing'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Processing image...'),
            ],
          ),
        );
      },
    );

    // Send image and get response
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(endpoint),
    );

    request.files.add(
      await http.MultipartFile.fromPath('image', returnedImage.path),
    );

    var response = await request.send();

    // Process response
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      kit.bricks.addAll(List<Map<String, dynamic>>.from(jsonResponse)); //= List<Map<String, dynamic>>.from(jsonResponse);
      Navigator.of(context).pop(); // Close processing dialog
    } else {
      //print('Failed to send image: ${response.reasonPhrase}');
      Navigator.of(context).pop(); // Close processing dialog

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send image: ${response.reasonPhrase}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }


  void _openCamera() async {
    final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.camera);

    if (returnedImage == null) return;

    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Processing'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(), // Display a buffering circle
              SizedBox(height: 16),
              Text('Processing image...'), // Display processing message
            ],
          ),
        );
      },
    );

    // Check image size
    File imageFile = File(returnedImage.path);
    // int fileSizeInBytes = await imageFile.length();
    // double fileSizeInMB = fileSizeInBytes /
    //     (1024 * 1024); // Convert bytes to MB
    // if (fileSizeInMB > 4) {
    //   // Resize the image if it exceeds 4.5MB
    //   imageFile = await _resizeImage(imageFile);
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Error'),
    //         content: Text('Image Too Large, decreasing size'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('Close'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    //imageFile = await _resizeImage(imageFile);

    // Create multipart request
    var request = http.MultipartRequest(
        'POST', Uri.parse(endpoint));

    // Attach image file to the request
    request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path));

    // Send the request
    var response = await request.send();

    // Dismiss processing dialog
    Navigator.of(context).pop();

    // Handle response
    if (response.statusCode == 200) {
      // Parse JSON response
      final jsonResponse = jsonDecode(await response.stream.bytesToString());

      // Call _showStringsDialog with parsed data
      _showStringsDialog(List<Map<String, dynamic>>.from(jsonResponse));
    } else {
      // Handle errors
      //print('Failed to send image: ${response.reasonPhrase}');

      // Show alert dialog for error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send image: ${response.reasonPhrase}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

// Function to resize image
  Future<File> _resizeImage(File imageFile) async {
    // Decode image
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

    // Calculate new dimensions to reduce size to 4.5MB
    double ratio = 4 /
        (imageFile.lengthSync() / (1024 * 1024)); // Target size / Current size
    int newWidth = (image.width * ratio).round();
    int newHeight = (image.height * ratio).round();

    // Resize image
    img.Image resizedImage = img.copyResize(
        image, width: newWidth, height: newHeight);

    // Save resized image to temporary file
    File resizedImageFile = File(
        imageFile.path.replaceAll('.png', '_resized.png'));
    resizedImageFile.writeAsBytesSync(img.encodePng(resizedImage));

    return resizedImageFile;
  }


  // void _showStringsDialog(List<Map<String, dynamic>> bricks) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Text('Bricks Identified'),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: bricks.map((brick) {
  //                       return Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Image.network(brick['image_url']),
  //                           Text('Label: ${brick['label']}'),
  //                           Text('Name: ${brick['name']}'),
  //                           Text('Count: ${brick['count']}'),
  //                           Divider(), // Add a divider between bricks
  //                         ],
  //                       );
  //                     }).toList(),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Add to Kit:', style: TextStyle(fontSize: 18)),
  //                   SizedBox(height: 8),
  //                   ...kits.map((kit) =>
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             kit.bricks = bricks;
  //                           });
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: Text(kit.name),
  //                       )),
  //                 ],
  //               ),
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('Close'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  void _showStringsDialog(List<Map<String, dynamic>> bricks) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Bricks Identified'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: bricks.map((brick) {
                        // Check if brick matches hardcoded brick list
                        MaterialColor isMatch = _isBrickMatch(brick);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(brick['image_url']),
                            Text(
                              'Label: ${brick['label']}',
                              style: TextStyle(
                                  color: isMatch),//isMatch ? Colors.green : Colors.red),
                            ),
                            Text(
                              'Name: ${brick['name']}',
                              style: TextStyle(
                                  color: isMatch), // ? Colors.green : Colors.red),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Count: ${brick['count']}',
                                  style: TextStyle(
                                      color: isMatch), // ? Colors.green : Colors.red),
                                ),
                                if (isMatch != Colors.green)
                                  Text(
                                    ' ${_getExpectedCount(brick)}',
                                    //style: TextStyle(color: Colors.green),
                                  ),
                              ],
                            ),
                            Divider(), // Add a divider between bricks
                          ],
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Add to Kit:', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    ...kits.map((kit) =>
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if(kit.bricks.isEmpty){
                                kit.bricks.addAll(bricks);
                              }
                              else{
                                for (Map<String, dynamic> newBrick in bricks) {
                                  bool found = false;
                                  for (Map<String, dynamic> existingBrick in kit.bricks){
                                    if(existingBrick["label"] == newBrick["label"]) {
                                      existingBrick["count"] = (int.parse(existingBrick["count"]) + int.parse(newBrick["count"])).toString();

                                      found = true;
                                    }
                                  }
                                  if (!found) {
                                    kit.bricks.add(newBrick);
                                  }
                                }
                              }
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(kit.name),
                        )),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }





// Function to check if brick matches a hardcoded list
  MaterialColor _isBrickMatch(Map<String, dynamic> brick) {
    for (var hardcodedBrick in hardcodedBrickList) {
      if (hardcodedBrick['label'] == brick['label'] && (hardcodedBrick['count'] == brick['count'])) {
        return Colors.green; // Brick matches a hardcoded brick
      }
      else if (hardcodedBrick['label'] == brick['label'] && (int.parse(hardcodedBrick['count']) < int.parse(brick['count']))){
        return Colors.amber;
      }
    }
    return Colors.red; // Brick doesn't match any hardcoded brick
  }

// Function to get expected count from hardcoded list
  String _getExpectedCount(Map<String, dynamic> brick) {
    for (var hardcodedBrick in hardcodedBrickList) {
      if (hardcodedBrick['label'] == brick['label']) {
          //hardcodedBrick['name'] == brick['name']) {
        return ' Should be: ${hardcodedBrick['count']}';
      }
    }
    return ' Brick is not in the expected list'; // Return empty string if no matching brick found
  }

  int _getExpectedCountInt(Map<String, dynamic> brick) {
    for (var hardcodedBrick in hardcodedBrickList) {
      if (hardcodedBrick['label'] == brick['label']) {
        //hardcodedBrick['name'] == brick['name']) {
        return int.parse(hardcodedBrick['count']);
      }
    }
    return -1; // Return empty string if no matching brick found
  }



  // void _showBricksList(Kit kit) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       List<Map<String, dynamic>> missingBricks = [];
  //
  //       // Iterate through the bricks in the kit
  //       for (var brick in kit.bricks) {
  //         // Check if the count of the brick is less than the expected count
  //         int expectedCount = _getExpectedCountInt(brick);
  //         int actualCount = int.parse(brick['count']);
  //         if (actualCount < expectedCount) {
  //           missingBricks.add({'name': brick['name'], 'count': expectedCount - actualCount, 'image_url': brick['image_url']});
  //         }
  //       }
  //
  //       // Iterate through the expected bricks
  //       for (var expectedBrick in hardcodedBrickList) {
  //         // Check if the expected brick is missing from the new list
  //         bool found = kit.bricks.any((brick) => brick['label'] == expectedBrick['label']);
  //         if (!found) {
  //           missingBricks.add({'name': expectedBrick['name'], 'count': expectedBrick['count'], 'image_url': expectedBrick['image_url']});
  //         }
  //       }
  //
  //       return AlertDialog(
  //         title: Text('${kit.name} Bricks'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Display the list of bricks
  //               SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: kit.bricks.map((brick) {
  //                     MaterialColor isMatch = _isBrickMatch(brick);
  //                     return Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Image.network(brick['image_url']),
  //                         Text(
  //                           'Label: ${brick['label']}',
  //                           style: TextStyle(color: isMatch),
  //                         ),
  //                         Text(
  //                           'Name: ${brick['name']}',
  //                           style: TextStyle(color: isMatch),
  //                         ),
  //                         Row(
  //                           children: [
  //                             Text(
  //                               'Count: ${brick['count']}',
  //                               style: TextStyle(color: isMatch),
  //                             ),
  //                             if (isMatch != Colors.green)
  //                               Text(
  //                                 ' ${_getExpectedCount(brick)}',
  //                               ),
  //                           ],
  //                         ),
  //                         Divider(),
  //                       ],
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //               // Display the "Missing" section
  //               if (missingBricks.isNotEmpty) ...[
  //                 SizedBox(height: 16),
  //                 Text(
  //                   'Missing:',
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: missingBricks.map((brick) {
  //                     return Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         if (brick['image_url'] != null) Image.network(brick['image_url']),
  //                         Text(
  //                           '${brick['count']} missing\n\n',
  //                           style: TextStyle(color: Colors.red),
  //                         ),
  //                       ],
  //                     );
  //                   }).toList(),
  //                 ),
  //               ],
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Close'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               _pickImageForKit(kit);
  //             },
  //             child: Text('Scan'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _showBricksList(Kit kit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<Map<String, dynamic>> missingBricks = [];
        List<Map<String, dynamic>> extraBricks = [];

        // Iterate through the bricks in the kit
        for (var brick in kit.bricks) {
          // Check if the count of the brick is less than the expected count
          int expectedCount = _getExpectedCountInt(brick);
          int actualCount = int.parse(brick['count']);
          if (actualCount < expectedCount) {
            missingBricks.add({'name': brick['name'], 'count': expectedCount - actualCount, 'image_url': brick['image_url']});
          } else if (actualCount > expectedCount) {
            extraBricks.add({'name': brick['name'], 'count': actualCount - expectedCount, 'image_url': brick['image_url']});
          }
        }

        // Iterate through the expected bricks
        for (var expectedBrick in hardcodedBrickList) {
          // Check if the expected brick is missing from the new list
          bool found = kit.bricks.any((brick) => brick['label'] == expectedBrick['label']);
          if (!found) {
            missingBricks.add({'name': expectedBrick['name'], 'count': expectedBrick['count'], 'image_url': expectedBrick['image_url']});
          }
        }

        return AlertDialog(
          title: Text('${kit.name} Bricks'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the list of bricks
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: kit.bricks.map((brick) {
                      MaterialColor isMatch = _isBrickMatch(brick);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(brick['image_url']),
                          Text(
                            'Label: ${brick['label']}',
                            style: TextStyle(color: isMatch),
                          ),
                          Text(
                            'Name: ${brick['name']}',
                            style: TextStyle(color: isMatch),
                          ),
                          Row(
                            children: [
                              Text(
                                'Count: ${brick['count']}',
                                style: TextStyle(color: isMatch),
                              ),
                              if (isMatch != Colors.green)
                                Text(
                                  ' ${_getExpectedCount(brick)}',
                                ),
                            ],
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                // Display the "Extra" section
                if (extraBricks.isNotEmpty) ...[
                  SizedBox(height: 16),
                  Text(
                    'Extra:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: extraBricks.map((brick) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (brick['image_url'] != null) Image.network(brick['image_url']),
                          Text(
                            '${brick['count']} extra\n\n',
                            style: TextStyle(color: Colors.amber),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
                // Display the "Missing" section
                if (missingBricks.isNotEmpty) ...[
                  SizedBox(height: 16),
                  Text(
                    'Missing:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: missingBricks.map((brick) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (brick['image_url'] != null) Image.network(brick['image_url']),
                          Text(
                            '${brick['count']} missing\n\n',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                _pickImageForKit(kit);
              },
              child: Text('Scan'),
            ),
          ],
        );
      },
    );
  }








// Function to handle generating the report
//   void _makeReport(BuildContext context) {
//     // Create a list of selected kit names
//     List<String> selectedKits = [];
//
//     // Create a dialog to select kits for the report
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text('Select Kits for Report'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Display a checkbox for each kit
//                   ...kits.map((kit) =>
//                       CheckboxListTile(
//                         title: Text(kit.name),
//                         value: selectedKits.contains(kit.name),
//                         onChanged: (bool? value) {
//                           setState(() {
//                             if (value != null && value) {
//                               selectedKits.add(kit.name);
//                             } else {
//                               selectedKits.remove(kit.name);
//                             }
//                           });
//                         },
//                       )),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     // Close the dialog
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Generate and copy the report message
//                     String reportMessage = '';
//                     for (String kitName in selectedKits) {
//                       Kit kit = kits.firstWhere(
//                             (kit) => kit.name == kitName,
//                         orElse: () => Kit(name: '', bricks: []),
//                       );
//                       reportMessage += '${kit.name}:\n';
//                       for (Map<String, dynamic> brick in kit.bricks) {
//                         reportMessage +=
//                         'Label: ${brick['label']}, Name: ${brick['name']}, Count: ${brick['count']}\n';
//                       }
//                       reportMessage += '\n';
//                     }
//                     Clipboard.setData(ClipboardData(text: reportMessage));
//
//                     // Close the dialog
//                     Navigator.of(context).pop();
//
//                     // Show a toast or message indicating report creation
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Report created and copied to clipboard'),
//                       ),
//                     );
//                   },
//                   child: Text('Generate Report'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
  void _makeReport(BuildContext context) {
    // Create a list of selected kit names
    List<String> selectedKits = [];

    // Create a dialog to select kits for the report
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Kits for Report'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Display a checkbox for each kit
                  ...kits.map((kit) =>
                      CheckboxListTile(
                        title: Text(kit.name),
                        value: selectedKits.contains(kit.name),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              selectedKits.add(kit.name);
                            } else {
                              selectedKits.remove(kit.name);
                            }
                          });
                        },
                      )),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();

                    // Generate and copy the report message
                    String reportMessage = '';
                    for (String kitName in selectedKits) {
                      Kit kit = kits.firstWhere(
                            (kit) => kit.name == kitName,
                        orElse: () => Kit(name: '', bricks: []),
                      );
                      reportMessage += '${kit.name}:\n';

                      // Variables to store counts of missing and extra bricks
                      int totalMissing = 0;
                      int totalExtra = 0;

                      for (Map<String, dynamic> brick in kit.bricks) {
                        reportMessage +=
                        'Label: ${brick['label']}, Name: ${brick['name']}, Count: ${brick['count']}\n';

                        // Calculate missing and extra bricks
                        int expectedCount = _getExpectedCountInt(brick);
                        int actualCount = int.parse(brick['count']);
                        if (actualCount < expectedCount) {
                          totalMissing += expectedCount - actualCount;
                        } else if (actualCount > expectedCount) {
                          totalExtra += actualCount - expectedCount;
                        }
                      }
                      // Include missing and extra counts in the report
                      reportMessage += 'Total Missing Bricks: $totalMissing\n';
                      reportMessage += 'Total Extra Bricks: $totalExtra\n\n';
                    }
                    Clipboard.setData(ClipboardData(text: reportMessage));

                    // Show a toast or message indicating report creation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Report created and copied to clipboard'),
                      ),
                    );
                  },
                  child: Text('Generate Report'),
                ),
              ],
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Kits 📦',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: kits.length + 1, // Include an extra item for the "+"
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () {
                        _addItem(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  } else {
                    final kit = kits[index - 1];
                    return GestureDetector(
                      onTap: () {
                        _showBricksList(kit);
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                kit.name,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          if (_showDeleteIcon && index != 0)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    kits.removeAt(index - 1);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _pickImageFromCamera(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(
                      'Scan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showDeleteIcon = !_showDeleteIcon;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(
                      'Delete Kit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _makeReport(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(
                      'Make Report',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _clearAllKits();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(
                      'Clear All Kits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
