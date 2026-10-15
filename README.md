# battery-guard

Ubuntu GNOME 노트북에서 시스템 배터리를 1분마다 확인합니다. 방전 중 잔량이 10% 이하가 되면 터미널 창으로 30초간 경고합니다. 그 창에서 아무 키나 누르거나 창을 닫으면 취소됩니다. 아무 입력이 없으면 잔량과 방전 상태를 다시 확인한 뒤 절전합니다.

한 번 경고한 뒤에는 절전에서 깨어나거나 경고를 취소해도 반복하지 않습니다. 배터리가 다시 10%를 넘으면 다음 저전력 상황을 감시합니다. 배터리를 읽을 수 없거나 그래픽 세션/터미널을 사용할 수 없으면 절전하지 않습니다.

## 요구 사항

- Ubuntu GNOME, `systemd --user`, Bash, `gnome-terminal`
- `/sys/class/power_supply/BAT*`에 표시되는 시스템 배터리
- 일반 사용자 세션에서 `systemctl suspend` 사용 권한

## 설치

저장소를 내려받은 디렉터리에서 실행합니다. `sudo`는 필요하지 않습니다.

```bash
./install.sh
```

설치 시 `~/.local/bin/battery-guard`, `~/.local/libexec/battery-guard/`, `~/.config/systemd/user/`에 파일을 복사하고 감시 타이머를 켭니다. `~/.local/bin`이 `PATH`에 없다면 새 터미널을 열거나 `~/.local/bin/battery-guard`로 실행하세요.

## 사용

```bash
battery-guard start
battery-guard stop
battery-guard status
```

`stop`은 타이머와 진행 중인 감시 서비스를 중지합니다. 경고 창이 이미 떠 있다면 창을 닫거나 아무 키나 눌러 닫으세요.

제거하려면 저장소 디렉터리에서 `./uninstall.sh`를 실행합니다.

## 주의

이 도구는 **절전(suspend)** 을 사용합니다. 최대절전(hibernate)과 달리 작업은 메모리에 남아 있으므로, 절전 중 배터리가 완전히 방전되면 저장하지 않은 작업을 잃을 수 있습니다. 10%도 완전 방전을 막는 보장은 아닙니다. 노트북의 실제 절전 소모량은 기기마다 다릅니다.

이 도구는 실제 배터리 부족 및 절전 동작을 자동으로 테스트하지 않습니다.
