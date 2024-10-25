import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:test1/screens/edit_alarm.dart';
import 'package:test1/screens/ring.dart';
import 'package:test1/screens/shortcut_button.dart';
import 'package:test1/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// 상태관리
// 'ExampleAlarmHomeScreen' 클래스는 애플리케이션의 홈 화면을 나타냅니다.
class ExampleAlarmHomeScreen extends StatefulWidget {
  const ExampleAlarmHomeScreen({Key? key}) : super(key: key);

  @override
  State<ExampleAlarmHomeScreen> createState() => _ExampleAlarmHomeScreenState();
}

class _ExampleAlarmHomeScreenState extends State<ExampleAlarmHomeScreen> {
  late List<AlarmSettings> alarms; // 알람 설정 목록을 저장하는 변수

  static StreamSubscription<AlarmSettings>? subscription; // 알람 이벤트 구독을 위한 변수

  @override
  void initState() {
    super.initState();
    if (Alarm.android) {
      checkAndroidNotificationPermission(); // Android 알림 권한 확인
    }
    loadAlarms(); // 알람 목록 로드
    // 알람 이벤트를 구독하고, 알람이 울릴 때마다 'navigateToRingScreen' 함수 호출
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  // 알람 목록을 로드하는 함수
  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms(); // 알람 목록 가져오기
      alarms.sort(
          (a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1); // 알람 시간 기준으로 정렬
    });
  }

  // 알람이 울릴 때 'ExampleAlarmRingScreen'으로 이동하는 함수
  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms(); // 알람 울린 후 목록 갱신
  }

  // 알람 추가 또는 수정 화면으로 이동하는 함수
  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.75,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms(); // 알람 추가 또는 수정 후 목록 갱신
  }

  // Android 알림 권한 확인 및 요청
  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  // Android 외부 저장소 권한 확인 및 요청
  Future<void> checkAndroidExternalStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      alarmPrint('Requesting external storage permission...');
      final res = await Permission.storage.request();
      alarmPrint(
        'External storage permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  @override
  void dispose() {
    subscription?.cancel(); // 화면이 dispose될 때 알람 이벤트 구독 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('성공알람시계'),
        backgroundColor: Colors.black,
      ), // 앱 바 설정
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ExampleAlarmTile(
                    key: Key(alarms[index].id.toString()), // 각 타일에 고유한 키 부여
                    title: TimeOfDay(
                      hour: alarms[index].dateTime.hour,
                      minute: alarms[index].dateTime.minute,
                    ).format(context),
                    onPressed: () => navigateToAlarmScreen(alarms[index]),
                    onDismissed: () {
                      // 타일을 스와이프하여 제거할 때 알람 중지 및 목록 갱신
                      Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                    },
                  );
                },
              )
            : Center(
                child: Text(
                  "설정된 알람이 없습니다.",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 단축 버튼과 알람 추가 버튼을 포함한 FAB 설정
            ExampleAlarmHomeShortcutButton(refreshAlarms: loadAlarms),
            FloatingActionButton(
              onPressed: () => navigateToAlarmScreen(null),
              child: const Icon(Icons.alarm_add_rounded, size: 33),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
