class Log {
  DateTime dateTime;
  String log;
  String employee;

  Log({this.dateTime, this.log, this.employee});

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      dateTime: json['dateTime'],
      log: json['log'],
      employee: json['employee'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'log': log,
      'employee': employee,
    };
  }
}
