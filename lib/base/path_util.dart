import 'dart:io';

import 'package:path_provider/path_provider.dart';


class PathUtil {
  static final PathUtil _instance = PathUtil();

  static PathUtil get instance => _instance;

  String rootName = 'zzfiction';
  String documentsPath = '';
  String externalStoragePath = '';

  Future<void> init() async {
    this.documentsPath = (await getApplicationDocumentsDirectory()).path;
    if (Platform.isAndroid) {
      this.externalStoragePath = (await getExternalStorageDirectory()).path;
    } else {
      this.externalStoragePath = this.documentsPath;
    }
    await getTemporaryDirectory();
    // await this.initFileDirectory();
  }

  // Future<bool> initFileDirectory() async {
  //   List defaultDirectory = [getAppFilePath(), getAppImagePath(), getAppVideoPath(), getAppRecordPath()];
  //   if (await PermissionUtil.checkStoragePermission()) {
  //     for (String path in defaultDirectory) {
  //       checkFilePathExists(path);
  //     }
  //     return true;
  //   }
  //   return false;
  // }

  String checkFilePathExists(String path) {
    if (!Directory(path).existsSync()) {
      Directory(path).createSync(recursive: true);
    }
    return path;
  }

  //
  String getAppStoragePath() {
    return Platform.isAndroid ? externalStoragePath : documentsPath;
  }

  String getAppFilePath({bool rootPath = true}) {
    String filePath = (rootPath ? getAppStoragePath() : '') + '/$rootName/file/';
    return filePath;
  }

  // String getAppImagePath({bool rootPath = true}) {
  //   String filePath = (rootPath ? getAppStoragePath() : '') + '/$rootName/image/';
  //   return filePath;
  // }
  //
  // String getAppVideoPath({bool rootPath = true}) {
  //   String filePath = (rootPath ? getAppStoragePath() : '') + '/$rootName/video/';
  //   return filePath;
  // }
  //
  // String getAppRecordPath({bool rootPath = true}) {
  //   String filePath = (rootPath ? getAppStoragePath() : '') + '/$rootName/record/';
  //   return filePath;
  // }
}
