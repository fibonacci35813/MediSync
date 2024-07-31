class Reminder {
  final int id;
  final String text;
  final String time;

  Reminder({
    required this.id,
    required this.text,
    required this.time,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      text: json['text'],
      time: json['time'],
    );
  }
}