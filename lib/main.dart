import 'dart:async';
import 'package:test1/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';

// "main"
Future<void> main() async {
  // 위젯이 초기화되도록 보장합니다.
  WidgetsFlutterBinding.ensureInitialized();

  // 기기의 선호하는 방향을 세로로 설정합니다.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 'alarm' 패키지를 초기화하고 디버그 로그를 표시합니다.
  await Alarm.init(showDebugLogs: true);

  // MaterialApp을 실행하여 애플리케이션을 시작합니다.
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: false), // 테마 설정, Material Design을 사용하도록 설정
      home:
          const ExampleAlarmHomeScreen(), // 애플리케이션의 첫 화면으로 'ExampleAlarmHomeScreen'을 사용
      debugShowCheckedModeBanner: false,
    ),
  );
}
