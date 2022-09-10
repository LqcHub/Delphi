object MyWinService: TMyWinService
  OldCreateOrder = False
  OnDestroy = ServiceDestroy
  DisplayName = 'WinServerTest'
  AfterInstall = ServiceAfterInstall
  AfterUninstall = ServiceAfterUninstall
  OnExecute = ServiceExecute
  OnPause = ServicePause
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 339
  Width = 527
end
