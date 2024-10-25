import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

// 'ExampleAlarmHomeShortcutButton' 클래스는 홈 화면에 표시되는 단축 버튼을 나타냅니다.
class ExampleAlarmHomeShortcutButton extends StatefulWidget {
  final void Function() refreshAlarms; // 알람 갱신을 위한 함수

  // 생성자
  const ExampleAlarmHomeShortcutButton({Key? key, required this.refreshAlarms})
      : super(key: key);

  @override
  State<ExampleAlarmHomeShortcutButton> createState() =>
      _ExampleAlarmHomeShortcutButtonState();
}

class _ExampleAlarmHomeShortcutButtonState
    extends State<ExampleAlarmHomeShortcutButton> {
  bool showMenu = false; // 메뉴를 표시할지 여부를 나타내는 상태 변수

  // 버튼이 눌렸을 때 호출되는 비동기 함수
  Future<void> onPressButton(int delayInHours) async {
    DateTime dateTime = DateTime.now().add(Duration(hours: delayInHours));
    double? volume;

    // 0시간이 아닌 경우, 초와 밀리초를 0으로 설정하고 볼륨을 0.5로 설정
    if (delayInHours != 0) {
      dateTime = dateTime.copyWith(second: 0, millisecond: 0);
      volume = 0.5;
    }

    // 메뉴를 닫음
    setState(() => showMenu = false);

    // 알람 설정
    final alarmSettings = AlarmSettings(
      id: DateTime.now().millisecondsSinceEpoch % 10000,
      dateTime: dateTime,
      assetAudioPath: 'assets/marimba.mp3',
      volume: volume,
      notificationTitle: 'Alarm example',
      notificationBody:
          'Shortcut button alarm with delay of $delayInHours hours',
    );

    // 알람 설정 적용
    await Alarm.set(alarmSettings: alarmSettings);

    // 알람 갱신 함수 호출
    widget.refreshAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onLongPress: () {
            setState(() => showMenu = true); // 버튼을 길게 누를 때 메뉴를 표시
          },
          child: FloatingActionButton(
            onPressed: () => onPressButton(0), // 버튼이 눌렸을 때 0시간 딜레이로 알람 설정
            backgroundColor: Colors.red,
            heroTag: null,
            child: const Text("RING NOW", textAlign: TextAlign.center),
          ),
        ),
        if (showMenu)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => onPressButton(24), // 24시간 딜레이로 알람 설정
                child: const Text("+24h"),
              ),
              TextButton(
                onPressed: () => onPressButton(36), // 36시간 딜레이로 알람 설정
                child: const Text("+36h"),
              ),
              TextButton(
                onPressed: () => onPressButton(48), // 48시간 딜레이로 알람 설정
                child: const Text("+48h"),
              ),
            ],
          ),
      ],
    );
  }
}
