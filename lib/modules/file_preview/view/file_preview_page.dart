import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../global/global.dart';
import '../../../settings/settings.dart';

class FilesPreviewPage extends StatelessWidget {
  const FilesPreviewPage({super.key});

  Future<void> _shareFile(String url) async {
    try {
      final fileName = url.split('/').last;
      const prefix = 'gulf_auction_sharable_file_';
      final dir = await getTemporaryDirectory();

      // Delete any existing files with the prefix
      final allFiles = dir.listSync();
      for (var file in allFiles) {
        if (file is File && file.path.contains(prefix)) {
          await file.delete();
        }
      }

      // Save new file with prefixed name
      final savedFilePath = '${dir.path}/$prefix$fileName';
      final savedFile = File(savedFilePath);

      if (!savedFile.existsSync()) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          await savedFile.writeAsBytes(response.bodyBytes);
        } else {
          AppToasts.longToast('Download Failed, Unable to fetch the file');
          return;
        }
      }
      await SharePlus.instance.share(
        ShareParams(files: [XFile(savedFilePath)], text: fileName),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to share file');
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = Get.arguments;
    final isPdf = getFileExtension(url) == 'pdf';

    return Scaffold(
      appBar: AppBars.appBarWithAction(
        title: 'Preview',
        action: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
          child: AppButtons.circleButtonStrokeOnly(
            color: AppColors.white,
            svgIconPath: AppSvgIcons.share,
            onTap: () {
              _shareFile(url);
            },
            iconSize: Dimensions.getHeight(18),
          ),
        ),
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: isPdf
            ? SfPdfViewer.network(
                url,
                pageLayoutMode: PdfPageLayoutMode.continuous,
              )
            : PhotoView(
                imageProvider: NetworkImage(url),
              ),
      ),
    );
  }
}

