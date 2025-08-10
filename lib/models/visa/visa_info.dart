class VisaInfo {
  final int id;
  final String title;

  VisaInfo({required this.id, required this.title});

  @override
  String toString() {
    return title;
  }

  static List<VisaInfo> availableOptions = [
    VisaInfo(id: 1, title: 'Citizen'),
    VisaInfo(id: 2, title: 'Permanent Resident'),
    VisaInfo(id: 3, title: 'Work Visa'),
    VisaInfo(id: 4, title: 'Student Visa'),
    VisaInfo(id: 5, title: 'Other'),
  ];
}