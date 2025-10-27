class NotificationModel {
  final String message;

  NotificationModel({required this.message});

  factory NotificationModel.fromJson(dynamic json) {
    if (json is Map && json['message'] != null) {
      return NotificationModel(message: json['message']);
    }
    throw const FormatException("Invalid notification data");
  }
}
