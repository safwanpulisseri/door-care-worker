import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../theme/color/app_color.dart';

class ImageContainerWidget extends StatefulWidget {
  const ImageContainerWidget({super.key});

  @override
  State<ImageContainerWidget> createState() => _ImageContainerWidgetState();
}

class _ImageContainerWidgetState extends State<ImageContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondary.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 155,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showImagePickerDialog('profile'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 100,
                      child: IconButton(
                        onPressed: null,
                        icon: profileImage != null
                            ? Image.file(File(profileImage!.path))
                            : const FaIcon(FontAwesomeIcons.plus),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showImagePickerDialog('idCard'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 100,
                      child: IconButton(
                        onPressed: null,
                        icon: idCardImage != null
                            ? Image.file(File(idCardImage!.path))
                            : const FaIcon(FontAwesomeIcons.plus),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Profile Image',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.toneThree,
                  ),
                ),
                Text(
                  'Id Card',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.toneThree,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  XFile? profileImage;

  XFile? idCardImage;

  void _pickImage(String type, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (type == 'profile') {
        profileImage = pickedFile;
      } else {
        idCardImage = pickedFile;
      }
    });
  }

  void _showImagePickerDialog(String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Image',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColor.secondary,
                ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    _pickImage(type, ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.image,
                    color: AppColor.secondary,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    _pickImage(type, ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColor.secondary,
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
