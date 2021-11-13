import 'package:awesome_notifications/awesome_notifications.dart';
int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}


Future<void> createLocalNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
      'أشتري PS5 بخصم 50% من زوكا استيشن',
      body: 'بسرعة يا ساذج يا مجنون',
      bigPicture: 'asset://assets/images/500x500 Png.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> createWaterReminderNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.wheater_droplet} تعالي احبيب اخوك!',
      body: 'Water your plant regularly to keep it healthy.',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: 6,
      hour: 18,
      minute: 44,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );


}
