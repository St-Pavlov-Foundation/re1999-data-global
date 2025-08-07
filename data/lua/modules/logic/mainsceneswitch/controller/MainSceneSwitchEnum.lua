module("modules.logic.mainsceneswitch.controller.MainSceneSwitchEnum", package.seeall)

local var_0_0 = _M

var_0_0.ItemTypeSelected = 1
var_0_0.ItemTypeUnSelected = 2
var_0_0.ItemHeight = 190
var_0_0.ItemUnSelectedScale = 0.78
var_0_0.ItemUnSelectedHeight = var_0_0.ItemHeight * var_0_0.ItemUnSelectedScale
var_0_0.PageWidth = 2592
var_0_0.PageSwitchTime = 2
var_0_0.SceneStutas = {
	Unlock = 1,
	Lock = 2,
	LockCanGet = 3
}
var_0_0.ReddotStatus = {
	Close = 1,
	Open = 2
}
var_0_0.DefaultScene = 1
var_0_0.SpSceneId = 4

return var_0_0
