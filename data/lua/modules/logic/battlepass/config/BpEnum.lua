module("modules.logic.battlepass.config.BpEnum", package.seeall)

slot0 = _M
slot0.PayStatus = {
	Pay1 = 1,
	Pay2 = 2,
	NotPay = 0
}
slot0.ScoreItemId = 970001
slot0.LevelUpMinTime = 2
slot0.LevelUpTotalTime = 5
slot0.TaskGetAnimTime = 0.43
slot0.TaskMaskTime = 0.6
slot0.BonusTweenMin = 5
slot0.BonusTweenTime = 3.5
slot0.AddScoreTime = 1
slot0.ButtonName = {
	Goto = "前往解锁",
	Close = "关闭",
	CloseBg = "空白处关闭"
}

return slot0
