module("modules.logic.mainswitchclassify.controller.MainSwitchClassifyEnum", package.seeall)

local var_0_0 = _M

var_0_0.Classify = {
	UI = 2,
	Scene = 1
}
var_0_0.StyleClassifyInfo = {
	[var_0_0.Classify.Scene] = {
		Sort = 1,
		Title = "main_switch_classify_title_1"
	},
	[var_0_0.Classify.UI] = {
		Sort = 2,
		Title = "main_switch_classify_title_2"
	}
}
var_0_0.SwitchAnimDelayTime = 0

return var_0_0
