import 'dart:io';
import 'package:demo_firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _file;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No Image Picked');
      }
    });
  }

  Future pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result != null) {
        _file = File(result.files.single.path!);
      } else {
        print('No Document Picked');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text('Document'),
                onTap: () {
                  pickDocument();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget displaySelectedFile() {
    if (_file != null) {
      if (_file!.path.endsWith('.jpg') || _file!.path.endsWith('.jpeg') || _file!.path.endsWith('.png')) {
        return Image.file(_file!.absolute);
      } else {
        return Center(child: Icon(Icons.insert_drive_file, size: 100));
      }
    } else {
      return Center(child: Icon(Icons.image, size: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image or Document"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                _showPicker(context);
              },
              child: Container(
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: displaySelectedFile(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RoundButton(
              title: 'Upload',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
