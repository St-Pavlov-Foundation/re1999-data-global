module("modules.logic.mainswitchclassify.controller.MainSwitchClassifyEnum", package.seeall)

local var_0_0 = _M

var_0_0.Classify = {
	UI = 2,
	Scene = 1,
	Click = 3
}
var_0_0.StyleClassifyInfo = {
	[var_0_0.Classify.Scene] = {
		Sort = 1,
		Title = "main_switch_classify_title_1",
		Classify = var_0_0.Classify.Scene
	},
	[var_0_0.Classify.UI] = {
		Sort = 2,
		Title = "main_switch_classify_title_2",
		Classify = var_0_0.Classify.UI
	},
	[var_0_0.Classify.Click] = {
		Sort = 3,
		Title = "main_switch_classify_title_3",
		Classify = var_0_0.Classify.Click
	}
}
var_0_0.SwitchAnimDelayTime = 0
var_0_0.ClassifyShowInfo = {
	[var_0_0.Classify.UI] = {
		TitleLogo = "mainsceneswitch_logo03",
		Classify = var_0_0.Classify.UI
	},
	[var_0_0.Classify.Click] = {
		TitleLogo = "mainsceneswitch_logo04",
		Classify = var_0_0.Classify.Click
	}
}

return var_0_0
