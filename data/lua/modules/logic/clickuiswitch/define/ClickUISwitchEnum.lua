-- chunkname: @modules/logic/clickuiswitch/define/ClickUISwitchEnum.lua

module("modules.logic.clickuiswitch.define.ClickUISwitchEnum", package.seeall)

local ClickUISwitchEnum = _M

ClickUISwitchEnum.ItemTypeSelected = 1
ClickUISwitchEnum.ItemTypeUnSelected = 2
ClickUISwitchEnum.ItemHeight = 190
ClickUISwitchEnum.ItemUnSelectedScale = 0.78
ClickUISwitchEnum.ItemUnSelectedHeight = ClickUISwitchEnum.ItemHeight * ClickUISwitchEnum.ItemUnSelectedScale
ClickUISwitchEnum.Skin = {
	Laplace = 2,
	Normal = 1
}
ClickUISwitchEnum.SkinParams = {
	[ClickUISwitchEnum.Skin.Normal] = {
		id = 20001
	},
	[ClickUISwitchEnum.Skin.Laplace] = {
		id = 20002
	}
}
ClickUISwitchEnum.ClickUIPath = "ui/viewres/common/click/%s.prefab"
ClickUISwitchEnum.DefaultClickUIPrefabName = "common_click"
ClickUISwitchEnum.SaveClickUIPrefKey = "ClickUISwitchEnum_SaveClickUIPrefKey_"
ClickUISwitchEnum.SaveClickUIPrefKey = "ClickUISwitchEnum_ClickUIReddotPrefKey2_"

return ClickUISwitchEnum
