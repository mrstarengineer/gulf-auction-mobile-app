import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/settings/settings.dart';

import '../../../../../models/models.dart';

class MyDocumentsWidgets {
  MyDocumentsWidgets._();

  static Widget myDocuments(
      {List<Document>? documents, ValueChanged<String>? onTapAttachment}) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.getHeight(10)),
        child: Wrap(
          spacing: Dimensions.getWidth(10),
          runSpacing: Dimensions.getHeight(10), // Vertical spacing between rows
          children: List.generate((documents?.length ?? 0), (index) {
            final info = documents![index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Column(
                    children: [
                      _documentCard(
                          typeName: info.typeName,
                          countryName: info.countryName,
                          uploadedDate: info.uploadedOn,
                          status: info.statusName,
                          url: info.url,
                          onTapAttachment: onTapAttachment),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Widget _documentCard(
    {String? typeName,
    String? countryName,
    String? uploadedDate,
    String? status,
    String? url,
    ValueChanged<String>? onTapAttachment}) {
  return Container(
    padding: EdgeInsets.all(Dimensions.getHeight(10)),
    decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: AppShadow.cardShadow,
        borderRadius: BorderRadius.circular(Dimensions.getHeight(6))),
    child: Column(
      children: [
        Row(
          children: [
            typeName == null
                ? const SizedBox.shrink()
                : AppTexts.smallText(
                    text: '$typeName: ', fontWeight: FontWeight.bold),
            countryName == null
                ? const SizedBox.shrink()
                : Expanded(child: AppTexts.smallText(text: countryName)),
          ],
        ),
        SizedBox(
          height: Dimensions.getHeight(10),
        ),
        uploadedDate == null
            ? const SizedBox.shrink()
            : Row(
                children: [
                  AppTexts.smallText(
                      text: 'Uploaded Date: ', fontWeight: FontWeight.bold),
                  Expanded(child: AppTexts.smallText(text: uploadedDate)),
                ],
              ),
        SizedBox(
          height: Dimensions.getHeight(10),
        ),
        status == null
            ? const SizedBox.shrink()
            : Row(
                children: [
                  AppTexts.smallText(
                      text: 'Status: ', fontWeight: FontWeight.bold),
                  Expanded(child: AppTexts.smallText(text: status)),
                ],
              ),
        SizedBox(
          height: Dimensions.getHeight(10),
        ),
        url == null
            ? const SizedBox.shrink()
            : Row(
                children: [
                  AppTexts.smallText(
                      text: 'Attachments: ', fontWeight: FontWeight.bold),
                  Expanded(
                      child: AppButtons.textButton(
                          text: 'Click to preview',
                          onTap: () {
                            onTapAttachment?.call(url);
                          })),
                ],
              ),
      ],
    ),
  );
}
