import 'dart:io';
import 'package:gulf_car_auction/models/models.dart';
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

class FilesGalleryPreviewPage extends StatefulWidget {
  final List<VehicleImages> vehicleList;
  final int selectedIndex;

  const FilesGalleryPreviewPage({
    super.key,
    required this.vehicleList,
    required this.selectedIndex,
  });

  @override
  State<FilesGalleryPreviewPage> createState() =>
      _FilesGalleryPreviewPageState();
}

class _FilesGalleryPreviewPageState extends State<FilesGalleryPreviewPage> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
    return Scaffold(
      appBar: AppBars.appBarWithAction(
        title: 'Preview',
        action: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(15)),
          child: AppButtons.circleButtonStrokeOnly(
            color: AppColors.white,
            svgIconPath: AppSvgIcons.share,
            onTap: () {
              // Share the URL of the currently displayed item
              final currentUrl = widget.vehicleList[_currentIndex].url ?? '';
              _shareFile(currentUrl);
            },
            iconSize: Dimensions.getHeight(18),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.vehicleList.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final url = widget.vehicleList[index].url ?? '';
                final isPdf = getFileExtension(url) == 'pdf';
                return isPdf
                    ? SfPdfViewer.network(
                        url,
                        pageLayoutMode: PdfPageLayoutMode.continuous,
                      )
                    : PhotoView(
                        imageProvider: NetworkImage(url),
                      );
              },
            ),
          ),

          // Left Arrow for navigation
          if (_currentIndex > 0)
            Positioned(
              left: 20,
              bottom: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),

          // Right Arrow for navigation
          if (_currentIndex < widget.vehicleList.length - 1)
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),

          // Photo Counter at the bottom
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Text(
              '${_currentIndex + 1}/${widget.vehicleList.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
