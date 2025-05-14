module("modules.logic.pushbox.event.PushBoxEvent", package.seeall)

local var_0_0 = _M

var_0_0.Move = 1
var_0_0.StepFinished = 2
var_0_0.RevertStep = 3
var_0_0.StartElement = 4
var_0_0.RefreshElement = 5
var_0_0.RefreshWarningNum = 6
var_0_0.GameWin = 7
var_0_0.GameOver = 8
var_0_0.RefreshFanElement = 9
var_0_0.PlayTaskFinishTween = 10
var_0_0.DataEvent = {
	FinishEpisodeReply = 101,
	RefreshActivityData = 100,
	ReceiveTaskRewardReply = 102
}

return var_0_0
