import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pdf_download_controller.dart';

class PdfDownloadScreen extends StatelessWidget {
  PdfDownloadScreen({super.key});

  final PdfDownloadController controller = Get.put(PdfDownloadController());

  final String linkDetails = 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Download')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (!controller.isDownloading.value) {
                return const SizedBox();
              }
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: controller.progress.value,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(controller.progress.value * 100).toStringAsFixed(0)}%',
                  ),
                ],
              );
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                controller.downloadPdf(
                  linkDetails: linkDetails,
                  fileName: 'network_pdf.pdf',
                );
              },
              child: const Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
