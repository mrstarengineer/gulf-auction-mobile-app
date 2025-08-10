
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gulf_car_auction/global/global.dart';
import 'package:gulf_car_auction/models/models.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../map/map_preview.dart';

class ContactWidgets {
  ContactWidgets._();

  static Widget header() {
    return Column(
      children: [
        _header('We’d Love to Hear From You'),
        SizedBox(
          height: Dimensions.getWidth(4),
        ),
        _subtext('Find Us'),
      ],
    );
  }

  static Widget contactDetailsBody(ContactModel contact) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(
            Icons.location_on,
            contact.address ?? '',
            trailing: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => MapPreviewPage(
                      lat: contact.lat ?? '', lon: contact.lon ?? ''),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(30, 30),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.map, color: Colors.white, size: 18),
            ),
          ),
          _sectionTitle('Mobile'),
          ...contact.mobiles!.map((m) => _infoRow(Icons.phone_android, m)),
          _sectionTitle('Landline'),
          ...contact.landlines!.map((l) => _infoRow(Icons.phone, l)),
          _sectionTitle('Mail Us'),
          _infoRow(Icons.email, contact.email ?? ''),
          _sectionTitle('TOLL-FREE'),
          _infoRow(Icons.support_agent, contact.tollFree ?? ''),
          _sectionTitle('Opening Hours'),
          ...contact.openingHours!.entries.map((entry) =>
              _infoRow(Icons.access_time, '${entry.key}: ${entry.value}')),
        ],
      ),
    );
  }

  static Widget _header(String text) => AppTexts.mediumText(
      text: text, overflow: TextOverflow.visible, color: AppColors.grey);

  static Widget _subtext(String text) => AppTexts.smallText(
      text: text, overflow: TextOverflow.visible, color: AppColors.grey);

  static Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54)),
      );

  static Widget _infoRow(IconData icon, String text, {Widget? trailing}) =>
      InkWell(
        onTap: () async {
          if (text.contains('@')) {
            final emailUri = Uri(scheme: 'mailto', path: text);
            if (await canLaunchUrl(emailUri)) {
              await launchUrl(emailUri);
            }
          } else if (text.contains('+971') || text.contains('(06)')) {
            final phoneUri = Uri(scheme: 'tel', path: text.replaceAll(' ', ''));
            if (await canLaunchUrl(phoneUri)) {
              await launchUrl(phoneUri);
            }
          } else if (text.contains('http')) {
            final url = Uri.parse(text);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.red),
              SizedBox(width: Dimensions.getWidth(10)),
              Expanded(
                child: AppTexts.mediumText(text: text),
              ),
              if (trailing != null) ...[
                SizedBox(width: Dimensions.getWidth(8)),
                trailing,
              ]
            ],
          ),
        ),
      );
}
