class Item {
  final DateTime date;
  final DateTime inTime;
  final DateTime outTime;
  final String shiftType;
  late final String status;

  Item  (this.date, this.inTime,this.outTime, this.shiftType, this.status);
}
