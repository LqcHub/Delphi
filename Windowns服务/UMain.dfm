object MyWinService: TMyWinService
  OldCreateOrder = False
  OnDestroy = ServiceDestroy
  AllowPause = False
  DisplayName = 'WinServerTest'
  AfterInstall = ServiceAfterInstall
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 339
  Width = 527
end
