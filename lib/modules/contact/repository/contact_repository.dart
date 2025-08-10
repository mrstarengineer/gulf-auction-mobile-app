import 'dart:convert';

import 'package:gulf_car_auction/network/api/api.dart';
import 'package:http/http.dart' as http;

class ContactRepository {
  ContactRepository({required ApiClient apiClient});

  Future<http.Response> fetchContactData() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate delay

    final Map<String, dynamic> data = {
      "address": "Al Sajaa, Sharjah\nUnited Arab Emirates",
      "mobiles": ["+971 558 800 800", "+971 568 900 900"],
      "landlines": ["(06) 532 5882", "(06) 523 0668"],
      "email": "info@gulfcarauction.com",
      "tollFree": "800 900 900",
      "lat": "25.343339949423303",
      "lon": "55.64407000283466",
      "openingHours": {
        "Sunday": "Close",
        "Monday": "9.00 am - 9.00 pm",
        "Tuesday": "9.00 am - 9.00 pm",
        "Wednesday": "9.00 am - 9.00 pm",
        "Thursday": "9.00 am - 9.00 pm",
        "Friday": "9.00 am - 9.00 pm",
        "Saturday": "9.00 am - 9.00 pm"
      }
    };

    return http.Response(jsonEncode(data), 200);
  }
}
