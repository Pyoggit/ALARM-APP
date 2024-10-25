import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

// 'ExampleAlarmRingScreen' 클래스는 알람이 울릴 때 표시되는 화면을 나타냅니다.
class ExampleAlarmRingScreen extends StatelessWidget {
  final AlarmSettings alarmSettings; // 울리는 알람의 설정

  // 생성자
  const ExampleAlarmRingScreen({Key? key, required this.alarmSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 알람 울림을 알리는 텍스트 표시
            Text("알람", style: TextStyle(fontSize: 50)), // 알람 아이콘 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Snooze 버튼 - 알람을 1분 뒤에 다시 설정하고 현재 화면 닫기
                RawMaterialButton(
                  onPressed: () {
                    final now = DateTime.now();
                    Alarm.set(
                      alarmSettings: alarmSettings.copyWith(
                        dateTime: DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                          now.minute,
                          0,
                          0,
                        ).add(const Duration(minutes: 1)),
                      ),
                    ).then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "1분 뒤 다시 알림",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                // Stop 버튼 - 알람 중지 및 현재 화면 닫기
                RawMaterialButton(
                  onPressed: () {
                    Alarm.stop(alarmSettings.id)
                        .then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "중지",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
