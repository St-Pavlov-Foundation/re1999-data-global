-- chunkname: @modules/logic/mainsceneswitch/controller/MainSceneSwitchEnum.lua

module("modules.logic.mainsceneswitch.controller.MainSceneSwitchEnum", package.seeall)

local MainSceneSwitchEnum = _M

MainSceneSwitchEnum.ItemTypeSelected = 1
MainSceneSwitchEnum.ItemTypeUnSelected = 2
MainSceneSwitchEnum.ItemHeight = 190
MainSceneSwitchEnum.ItemUnSelectedScale = 0.78
MainSceneSwitchEnum.ItemUnSelectedHeight = MainSceneSwitchEnum.ItemHeight * MainSceneSwitchEnum.ItemUnSelectedScale
MainSceneSwitchEnum.PageWidth = 2592
MainSceneSwitchEnum.PageSwitchTime = 2
MainSceneSwitchEnum.SceneStutas = {
	Unlock = 1,
	Lock = 2,
	LockCanGet = 3
}
MainSceneSwitchEnum.ReddotStatus = {
	Close = 1,
	Open = 2
}
MainSceneSwitchEnum.DefaultScene = 1
MainSceneSwitchEnum.SpSceneId = 4

return MainSceneSwitchEnum
