import 'package:gulf_car_auction/models/models.dart';
import 'package:intl/intl.dart';

class AppConversions {
  AppConversions._();


  /// DATE
   static String formatDateToISO8601(String date) {
    List<String> parts = date.split('-');
    String year = parts[0];
    String month = parts[1].padLeft(2, '0'); // Ensure 2-digit month
    String day = parts[2].padLeft(2, '0');   // Ensure 2-digit day
    return "$year-$month-$day";
  }


 static String formatDateTimeToMonthDayYear(DateTime dateTime) {
    // Extract month, day, and year
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    String year = dateTime.year.toString();

    // Format as mm/dd/yy
    return '$month/$day/$year';
  }

  static String formatDateTime20241230(DateTime dateTime){

    String formattedDate = DateFormat('yyyy-M-d').format(dateTime);
    return formattedDate;// Example output: 2024-9-28
  }

  static String formatDateTimeToYearMonthDay(DateTime dateTime) {
    // Extract year, month, and day
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    // Format as yyyy-MM-dd
    return '$year-$month-$day';
  }


  // static DateTime parseDateTime(String dateString) {
  //   // Split the string by '/'
  //   List<String> parts = dateString.split('/');
  //
  //   // Extract month, day, and year
  //   int month = int.parse(parts[0]);
  //   int day = int.parse(parts[1]);
  //   int year = int.parse(parts[2]);
  //
  //   // Handle 2-digit year by adding 2000 (assuming dates in 2000s)
  //   if (year < 100) {
  //     year += 2000;
  //   }
  //
  //   // Return the DateTime object
  //   return DateTime(year, month, day);
  // }

  /// AUCTION
  static String upcomingAuctionHighlightText(List<UpcomingAuctionInfo> upcomingAuctions) {
    // Map through the list of UpcomingAuctionInfo and generate the text for each one
    String auctionInfo = upcomingAuctions.map((auction) {
      String location = auction.auctionYardName ?? 'Unknown Location';
      String auctionDate = auction.auctionAtFormatted ?? 'Unknown Date';
      int totalVehicles = auction.totalVehicles ?? 0;

      return '$location at $auctionDate. Total Vehicles $totalVehicles';
    }).join(' | '); // Join each auction info with ' | ' separator

    // Append spaces at the end
    return auctionInfo;
  }


}