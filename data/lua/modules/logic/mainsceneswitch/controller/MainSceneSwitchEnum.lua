module("modules.logic.mainsceneswitch.controller.MainSceneSwitchEnum", package.seeall)

slot0 = _M
slot0.ItemTypeSelected = 1
slot0.ItemTypeUnSelected = 2
slot0.ItemHeight = 190
slot0.ItemUnSelectedScale = 0.78
slot0.ItemUnSelectedHeight = slot0.ItemHeight * slot0.ItemUnSelectedScale
slot0.PageWidth = 2592
slot0.PageSwitchTime = 2
slot0.SceneStutas = {
	Unlock = 1,
	Lock = 2,
	LockCanGet = 3
}
slot0.ReddotStatus = {
	Close = 1,
	Open = 2
}
slot0.DefaultScene = 1

return slot0
