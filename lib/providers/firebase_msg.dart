import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseMsg extends ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging();
  String onMessageString = 'null';
  String onLaunchString = 'null';
  String onBackgroundString = 'null';
  String onResumeMsg = 'null';

  Future<String> getToken(){
    return messaging.getToken();
  }

  configure() {
    messaging.configure(
      onMessage: (Map<String, dynamic> data) {
      this.onMessageString = getPrettyJSONString(data);
      notifyListeners();
    }, 
    onLaunch: (Map<String, dynamic> data) {
      this.onLaunchString = getPrettyJSONString(data);
      notifyListeners();
    },
    //  onBackgroundMessage: (Map<String, dynamic> data) {
    //   this.onBackgroundString = getPrettyJSONString(data);
    //   notifyListeners();
    // }, 
    onResume: (Map<String, dynamic> data) {
      this.onResumeMsg = getPrettyJSONString(data);
      notifyListeners();
    });
  }

  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }
}
