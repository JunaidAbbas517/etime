
class CustomDateUtils {
 final  selectedYear = DateTime.now().year;
  static final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String getMonthName(int month) {
    if (month >= 1 && month <= 12) {
      return monthNames[month - 1];
    } else {
      throw ArgumentError('Invalid month value. Month must be between 1 and 12.');
    }
  }


  List<String> getMonthRange() {
    final now = DateTime.now();
    if (selectedYear < now.year) {
      return monthNames;
    } else {
      return monthNames.sublist(0, now.month);
    }
  }
}
