;高进程
Process Priority,,High

;一直关闭 Capslock
SetCapsLockState, AlwaysOff

;AutoHotKey用 Send 发送按键时CapsLock是默认关闭的
;如果你的脚本执行的时候,CapsLock是开着的,AutoHotKey会自动关闭CapsLock,然后发送按键,再打开CapsLock 。
;找了个解决办法，使用SetStoreCapslockMode，说明如下：
;设置在 Send 后是否恢复 CapsLock 的状态。
SetStoreCapslockMode,Off

CapsLock::
  KeyWait, CapsLock
  If GetKeyState("CapsLock", "T") = 0
  {
    If (A_TimeSinceThisHotkey > 300)
    {
      Send {CapsLock}
    }
    Else
    {
      ; If (IME_GET()=1)
      ; {
      ;   Send #{Space}
      ; }
      ; Else
      ; {
      Send #{Space}
      ; }
    }
  }
  Else
  {
    Send {CapsLock}
  }
Return

; https://www.autoahk.com/archives/8755
IME_GET(WinTitle="")
{
  If (WinTitle="")
  {
    WinTitle = A
  }
  WinGet,hWnd,ID,%WinTitle%
  DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

  ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
  DetectSave := A_DetectHiddenWindows
  DetectHiddenWindows,ON
  SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
  DetectHiddenWindows,%DetectSave%
Return ErrorLevel
}

!c:: ; Alt+C 热键
  Send {ctrl down}c{ctrl up} ; 复制选定的文本. 也可以使用 ^c, 但这种方法更加可靠.
SendInput {{}`n{ctrl down}v{ctrl up}`n{}} ; 粘贴所复制的文本, 并在文本前后加上加粗标签.
Return

+CapsLock:: ; Shift+CapsLock 先输入英文再切换输入法
  Send {Enter}#{Space}
Return