class NotificationSetting {
  String title;
  bool value;
  int index;


  NotificationSetting({
    required this.title,
    this.value = false,
    required this.index
  });
}