import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:gulf_car_auction/utils/skeleton/app_skeletons.dart';

class DownloadsWidgets {
  DownloadsWidgets._();

  static Widget body ({required List<DownloadsInfo> downloadsData, Function(String, String?)? onTapDownload}){
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: downloadsData.length,
        separatorBuilder: (context, index) => SizedBox(height: Dimensions.getHeight(10),),
        itemBuilder: (context, index){
        final info = downloadsData[index];
      return _downloadCard(
          thumbnailUrl: info.photo,
        title: info.title,
        description: info.description,
        onTapDownload: (){
         if(info.attachment != null){
           onTapDownload?.call(info.attachment!, info.title);
         }
        }
      );
    });
  }
}

Widget _downloadCard ({String? title, String? description, String? thumbnailUrl, VoidCallback? onTapDownload}){
  return   Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.getHeight(10)),
      border: Border.all(color: AppColors.primaryColorLight, width: 2)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: thumbnailUrl ?? '',
          imageBuilder: (context, imageProvider) => Container(
            height: Dimensions.getHeight(113),
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider,fit: BoxFit.cover),
              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.getHeight(10))),
            ),
          ),
          placeholder: (context, url) => AppSkeletons.shimmerContainer(
            height: Dimensions.getHeight(113),
          ),
          errorWidget: (context, url, error) => Container(
            height: Dimensions.getHeight(113),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppPngIcons.placeholder),fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(Dimensions.getHeight(10)),
            ),
          )
        ),

        SizedBox(height: Dimensions.getHeight(10),),
        
        Padding(
          padding: EdgeInsets.all(Dimensions.getHeight(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title == null || title.isEmpty ? const SizedBox.shrink() : AppTexts.mediumText(text: title, fontWeight: FontWeight.bold),
              SizedBox(height:title == null || title.isEmpty ? 0 : Dimensions.getHeight(10),),
              description == null || description.isEmpty ? const SizedBox.shrink() : AppTexts.htmlText(text: description, color: AppColors.lightFontColor),
              SizedBox(height:  description == null || description.isEmpty ? 0 : Dimensions.getHeight(10),),
              AppButtons.svgIconButtonWithText(text: 'Download',
                  onTap: onTapDownload,
                  bgColor: AppColors.primaryColor,
                  color: AppColors.white,
                  iconPath: AppSvgIcons.download)
            ],
          ),
        )
      ],
    ),
  );
}
