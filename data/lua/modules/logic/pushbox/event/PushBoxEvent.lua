module("modules.logic.pushbox.event.PushBoxEvent", package.seeall)

slot0 = _M
slot0.Move = 1
slot0.StepFinished = 2
slot0.RevertStep = 3
slot0.StartElement = 4
slot0.RefreshElement = 5
slot0.RefreshWarningNum = 6
slot0.GameWin = 7
slot0.GameOver = 8
slot0.RefreshFanElement = 9
slot0.PlayTaskFinishTween = 10
slot0.DataEvent = {
	FinishEpisodeReply = 101,
	RefreshActivityData = 100,
	ReceiveTaskRewardReply = 102
}

return slot0
