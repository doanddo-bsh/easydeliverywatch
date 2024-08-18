import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void logScreenView(String screenName, String screenClassOverride) async {
  await FirebaseAnalytics.instance.logEvent(
    name: 'screen_view',
    parameters: {
      'screen_name': screenName,
      'screen_class': screenClassOverride,
    },
  );
}