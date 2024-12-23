# Alarm-App

Flutter로 구현된 알람 앱

## 프로젝트 소개
이 프로젝트는 사용자가 지정한 시간에 알람을 설정하고 이를 통해 알림을 받을 수 있도록 하는 Flutter 기반의 간단한 알람 애플리케이션입니다. 다양한 알람 기능을 제공하며, 사용자 경험을 고려한 인터페이스를 구현하였습니다.


## 기술 스택
### Language
- **Dart**: SDK Version 3.2.3

### Framework
- **Flutter**: Version 3.13.6

### IDE
- **Visual Studio Code**: Version 1.83.1

### Database
- **Firebase Realtime Database**: 최신 버전 사용

### Packages
  - [alarm](https://pub.dev/packages/alarm): 알람 설정 및 관리
  - [shared_preferences](https://pub.dev/packages/shared_preferences): 로컬 데이터 저장
  - [permission_handler](https://pub.dev/packages/permission_handler): 권한 관리
  - [android_alarm_manager_plus](https://pub.dev/packages/android_alarm_manager_plus): 알람 매니저
    
### Tools
- **Android Studio**: Version 2023.3.1
- **Flutter DevTools**: 내장 디버깅 툴 사용

### Emulator
- **Android Emulator**: Pixel 5 API 33 (Android 13)


## 주요 기능
- **알람 설정**: 날짜와 시간을 선택하여 알람을 설정할 수 있습니다.
- **반복 알람**: 매일, 주간 등 주기적으로 알람을 설정할 수 있습니다.
- **커스텀 알림 사운드**: 알람 사운드를 사용자가 직접 선택할 수 있습니다. (Mozart, Nokia, Marimba 등)
- **진동 기능**: 소리 대신 진동으로 알림을 받을 수 있는 옵션을 제공합니다.
- **알람 편집 및 삭제**: 설정된 알람을 수정하거나 삭제할 수 있습니다.
- **Snooze 기능**: 알람을 1분 뒤 다시 울리도록 설정할 수 있습니다.

## 실행 화면
| 홈 화면                           | 알람 설정 화면                    | 알람 울림 화면                  |
|-----------------------------------|-----------------------------------|---------------------------------|
| <img src="https://github.com/user-attachments/assets/7e96780f-bf50-4c22-b116-d8d64b9d3175" width="200"> | <img src="https://github.com/user-attachments/assets/6f7bc199-4390-47d3-b3f4-ab9ef7a20a1a" width="200"> | <img src="https://github.com/user-attachments/assets/af66fe31-72c3-47b3-ad92-296da9c3a08d" width="200"> |


## 설치 및 실행
1. Flutter 환경을 설정합니다. [Flutter 설치 가이드](https://docs.flutter.dev/get-started/install)를 참고하세요.
2. 저장소를 클론합니다:
   ```bash
   git clone https://github.com/username/alarm-app.git
