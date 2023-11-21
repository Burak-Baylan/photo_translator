import 'package:image_picker/image_picker.dart';

class GalleryImagePicker {
  static final ImagePicker picker = ImagePicker();

  static Future<XFile?> getImageFromGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}
