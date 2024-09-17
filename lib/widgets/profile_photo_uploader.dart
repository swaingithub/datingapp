import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePhotoUploader extends StatefulWidget {
  final int maxImages;

  ProfilePhotoUploader({required this.maxImages});

  @override
  _ProfilePhotoUploaderState createState() => _ProfilePhotoUploaderState();
}

class _ProfilePhotoUploaderState extends State<ProfilePhotoUploader> {
  late List<File?> _images;
  bool _isFirstImageUploaded = false;

  @override
  void initState() {
    super.initState();
    _images = List<File?>.filled(widget.maxImages, null, growable: false);
  }

  Future<void> _pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
        if (index == 0)
          _isFirstImageUploaded = true; // Mark the first image as uploaded
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First image upload (mandatory)
        GestureDetector(
          onTap: () => _pickImage(0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                  image: _images[0] != null
                      ? DecorationImage(
                          image: FileImage(_images[0]!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _images[0] == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.white)
                    : null,
              ),
              if (_images[0] != null)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => _pickImage(0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.edit, color: Colors.pinkAccent),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 20),

        // Additional image uploads (optional)
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(widget.maxImages - 1, (index) {
            int actualIndex = index + 1;
            return GestureDetector(
              onTap: () => _pickImage(actualIndex),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade500],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      image: _images[actualIndex] != null
                          ? DecorationImage(
                              image: FileImage(_images[actualIndex]!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _images[actualIndex] == null
                        ? Icon(Icons.add_a_photo, size: 40, color: Colors.white)
                        : null,
                  ),
                  if (_images[actualIndex] != null)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => _pickImage(actualIndex),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.edit, color: Colors.pinkAccent),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
