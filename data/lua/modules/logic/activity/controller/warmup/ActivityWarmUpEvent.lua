module("modules.logic.activity.controller.warmup.ActivityWarmUpEvent", package.seeall)

return {
	GameTriggerNoHit = 101,
	GameTriggerHit = 102,
	GameNextRound = 110,
	GameOverTimeOut = 201,
	GameOverFinished = 202,
	NotifyGameClear = 203,
	NotifyGameCancel = 204,
	PlayOrderFinish = 301,
	PlayOrderCancel = 302,
	ViewSwitchTab = 501,
	InfoReceived = 502,
	OnInfosReply = 503,
	TaskListUpdated = 601,
	TaskDayChanged = 602,
	TaskListNeedClose = 603,
	TaskListInit = 604
}
