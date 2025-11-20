import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class FileHelper {
  static Future<List<String>> getAllAssetFiles(String folder) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    return manifestMap.keys
        .where((path) => path.startsWith(folder))
        .toList();
  }
}
