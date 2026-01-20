-- chunkname: @modules/logic/mainswitchclassify/controller/MainSwitchClassifyEnum.lua

module("modules.logic.mainswitchclassify.controller.MainSwitchClassifyEnum", package.seeall)

local MainSwitchClassifyEnum = _M

MainSwitchClassifyEnum.Classify = {
	UI = 2,
	Scene = 1,
	Click = 3
}
MainSwitchClassifyEnum.StyleClassifyInfo = {
	[MainSwitchClassifyEnum.Classify.Scene] = {
		Sort = 1,
		Title = "main_switch_classify_title_1",
		Classify = MainSwitchClassifyEnum.Classify.Scene
	},
	[MainSwitchClassifyEnum.Classify.UI] = {
		Sort = 2,
		Title = "main_switch_classify_title_2",
		Classify = MainSwitchClassifyEnum.Classify.UI
	},
	[MainSwitchClassifyEnum.Classify.Click] = {
		Sort = 3,
		Title = "main_switch_classify_title_3",
		Classify = MainSwitchClassifyEnum.Classify.Click
	}
}
MainSwitchClassifyEnum.SwitchAnimDelayTime = 0
MainSwitchClassifyEnum.ClassifyShowInfo = {
	[MainSwitchClassifyEnum.Classify.UI] = {
		TitleLogo = "mainsceneswitch_logo03",
		Classify = MainSwitchClassifyEnum.Classify.UI
	},
	[MainSwitchClassifyEnum.Classify.Click] = {
		TitleLogo = "mainsceneswitch_logo04",
		Classify = MainSwitchClassifyEnum.Classify.Click
	}
}

return MainSwitchClassifyEnum
