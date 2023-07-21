part of'../../infrastructure.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {


  final ImagePicker _picker = ImagePicker();

  @override
  Future<List<String>?> selectMultiPhotos() async {
     final photo = await _picker.pickMultiImage(
      imageQuality: 100,
      );

      if( photo.isEmpty ) return null;

      return photo.map((e) => e.path ).toList();
  }

  @override
  Future<String?> selectPhoto() async {
      final photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      );

      if( photo ==  null ) return null;

      return photo.path;

  }
  
  @override
  Future<String?> takePhoto() async {
    final photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.rear
      );

      if( photo ==  null ) return null;

      return photo.path;
   }

  }



 

