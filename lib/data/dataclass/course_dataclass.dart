class Course {
  final int id;
  final String secret;
  final int emScore;
  final String username;
  final DateTime timestamp;

  Course({
    required this.id,
    required this.secret,
    required this.emScore,
    required this.username,
    required this.timestamp,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    String timestampString = json['timestamp'];
    // Replace " utc" with "Z" to make it ISO 8601 compliant
    timestampString = timestampString.replaceAll(' utc', 'Z');
    return Course(
      id: json['id'],
      secret: json['secret'],
      emScore: json['emScore'],
      username: json['username'],
      timestamp: DateTime.parse(timestampString),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'secret': secret,
      'emScore': emScore,
      'username': username,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}