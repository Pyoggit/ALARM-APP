import 'package:flutter/material.dart';

// 'ExampleAlarmTile' 클래스는 StatelessWidget을 상속받아 알람 타일을 나타냅니다.
class ExampleAlarmTile extends StatelessWidget {
  final String title; // 알람 타일의 제목
  final void Function() onPressed; // 탭되었을 때 실행할 함수
  final void Function()? onDismissed; // 제스처로 제거될 때 실행할 함수 (선택적)

  // 생성자
  const ExampleAlarmTile({
    Key? key,
    required this.title,
    required this.onPressed,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dismissible 위젯은 사용자 제스처에 응답하여 특정 방향으로 스와이프하여 제거할 수 있는 위젯입니다.
    return Dismissible(
      key: key!, // Dismissible 위젯의 고유 키
      direction: onDismissed != null
          ? DismissDirection.endToStart // 스와이프 방향 설정 (제거 기능이 있는 경우 오른쪽에서 왼쪽으로)
          : DismissDirection.none, // 제거 기능이 없는 경우 스와이프 방향 없음
      background: Container(
        color: Colors.white, // 스와이프 배경의 색상
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.red,
        ),
      ),
      onDismissed: (_) => onDismissed?.call(), // 제거되었을 때 콜백 함수 호출
      child: RawMaterialButton(
        onPressed: onPressed, // 버튼이 눌렸을 때 실행할 함수 설정
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title, // 알람 타일의 제목 텍스트
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.keyboard_arrow_right_rounded, size: 35),
            ],
          ),
        ),
      ),
    );
  }
}
