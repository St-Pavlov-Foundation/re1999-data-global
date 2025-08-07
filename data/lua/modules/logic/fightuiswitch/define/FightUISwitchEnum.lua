module("modules.logic.fightuiswitch.define.FightUISwitchEnum", package.seeall)

local var_0_0 = _M

var_0_0.StyleClassify = {
	FightCard = 2,
	FightFloat = 1
}
var_0_0.StyleClassifyInfo = {
	[var_0_0.StyleClassify.FightCard] = {
		Sort = 1,
		ClassifyTitle = "fightuiswitch_classify_2",
		SimpleProperty = PlayerEnum.SimpleProperty.FightUICardStyle,
		SubType = ItemEnum.SubType.FightCard
	},
	[var_0_0.StyleClassify.FightFloat] = {
		Sort = 2,
		ClassifyTitle = "fightuiswitch_classify_1",
		SimpleProperty = PlayerEnum.SimpleProperty.FightUIFloatStyle,
		SubType = ItemEnum.SubType.FightFloatType
	}
}
var_0_0.SceneRes = "ui/viewres/mainsceneswitch/%s.prefab"
var_0_0.AnimKey = {
	Switch = "switch",
	Close = "close",
	Open = "open"
}
var_0_0.SwitchAnimDelayTime = 0.16
var_0_0.SwitchAnimTime = 3

return var_0_0
