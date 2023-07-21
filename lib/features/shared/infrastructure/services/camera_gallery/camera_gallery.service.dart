part of'../../infrastructure.dart';

abstract class CameraGalleryService {

  Future<String?> takePhoto();
  Future<String?> selectPhoto();
  Future<List<String>?> selectMultiPhotos();

}