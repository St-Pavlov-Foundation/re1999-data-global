module("modules.logic.clickuiswitch.define.ClickUISwitchEnum", package.seeall)

local var_0_0 = _M

var_0_0.ItemTypeSelected = 1
var_0_0.ItemTypeUnSelected = 2
var_0_0.ItemHeight = 190
var_0_0.ItemUnSelectedScale = 0.78
var_0_0.ItemUnSelectedHeight = var_0_0.ItemHeight * var_0_0.ItemUnSelectedScale
var_0_0.Skin = {
	Laplace = 2,
	Normal = 1
}
var_0_0.SkinParams = {
	[var_0_0.Skin.Normal] = {
		id = 20001
	},
	[var_0_0.Skin.Laplace] = {
		id = 20002
	}
}
var_0_0.ClickUIPath = "ui/viewres/common/click/%s.prefab"
var_0_0.DefaultClickUIPrefabName = "common_click"
var_0_0.SaveClickUIPrefKey = "ClickUISwitchEnum_SaveClickUIPrefKey_"
var_0_0.SaveClickUIPrefKey = "ClickUISwitchEnum_ClickUIReddotPrefKey2_"

return var_0_0
