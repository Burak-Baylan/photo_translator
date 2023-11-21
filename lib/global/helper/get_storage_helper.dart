import 'package:get_storage/get_storage.dart';

class GetStorageHelper {
  static var shared = GetStorageHelper();

  static GetStorage box = GetStorage('box');

  Future<void> init() async => await GetStorage.init();

  T? read<T>(String key) => box.read<T>(key);

  Future<void> write({required String key, dynamic value}) {
    return box.write(key, value);
  }

  Future<void> remove(String key) async => box.remove(key);
}
