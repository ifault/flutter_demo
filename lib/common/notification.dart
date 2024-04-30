import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class MyNotificaiton {
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  MyNotificaiton() {
    init();
  }

  Future<void> init() async {
    await awesomeNotifications.initialize(
        // 'resource://drawable/res_app_icon',
        null,
        [
          NotificationChannel(
            channelGroupKey: "basic_channel_group",
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
          )
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: "basic_channel_group",
            channelGroupName: "Basic channel group",
          )
        ]);
    bool isNotificationAllowed =
        await awesomeNotifications.isNotificationAllowed();
    if (!isNotificationAllowed) {
      await awesomeNotifications.requestPermissionToSendNotifications();
    }
  }

  void notity(title, content) {
    awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: content,
      ),
    );
  }
}
