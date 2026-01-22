import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfDownloadController extends GetxController {
  final Dio _dio = Dio();
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  RxDouble progress = 0.0.obs;
  RxBool isDownloading = false.obs;

  /// Call this from UI
  Future<void> downloadPdf({
    required String linkDetails, // 🔗 network PDF url
    required String fileName,
  }) async {
    try {
      isDownloading.value = true;
      progress.value = 0;

      if (Platform.isIOS) {
        await _downloadIOS(linkDetails, fileName);
        progress.value = 1;
      } else if (Platform.isAndroid) {
        await _downloadAndroid(linkDetails, fileName);
      }

      Get.snackbar('Success', 'PDF downloaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Download failed');
    } finally {
      isDownloading.value = false;
    }
  }

  // 🍎 iOS → File Saver
  Future<void> _downloadIOS(String url, String fileName) async {
    await FileSaver.instance.saveFile(
      name: fileName,
      link: LinkDetails(link: url),
      fileExtension: 'pdf',
      includeExtension: false,
      mimeType: MimeType.pdf,
    );
  }

  // 🤖 Android → Version aware
  Future<void> _downloadAndroid(String url, String fileName) async {
    final androidInfo = await _deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    // 🔹 Android 13+ → No permission
    if (sdkInt >= 33) {
      await _startDownload(url, fileName);
      return;
    }

    // 🔹 Android ≤12 → Permission needed
    final status = await Permission.storage.status;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return;
    }

    if (status.isDenied) {
      final result = await Permission.storage.request();
      if (!result.isGranted) {
        Get.snackbar('Permission', 'Storage permission required');
        return;
      }
    }

    await _startDownload(url, fileName);
  }

  // ⬇️ Download function
  Future<void> _startDownload(String url, String fileName) async {
    final path = '/storage/emulated/0/Download/$fileName';

    await _dio.download(
      url,
      path,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          progress.value = received / total;
        }
      },
    );
  }
}
