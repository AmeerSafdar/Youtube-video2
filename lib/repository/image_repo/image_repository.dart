// ignore_for_file: unused_local_variable, use_rethrow_when_possible

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:task009/repository/image_repo/image_rep_interface.dart';

class ImageRepository implements ImageInterface {
  @override
  Future<File?> pickImage(ImageSource imageType) async {
    File? pickedImage;
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      final tempImage = File(photo!.path);
      pickedImage = tempImage;
    } catch (error) {
      throw error;
    }
    return pickedImage;
  }
}
