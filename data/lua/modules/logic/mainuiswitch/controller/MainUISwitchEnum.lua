-- chunkname: @modules/logic/mainuiswitch/controller/MainUISwitchEnum.lua

module("modules.logic.mainuiswitch.controller.MainUISwitchEnum", package.seeall)

local MainUISwitchEnum = _M

MainUISwitchEnum.ItemTypeSelected = 1
MainUISwitchEnum.ItemTypeUnSelected = 2
MainUISwitchEnum.ItemHeight = 190
MainUISwitchEnum.ItemUnSelectedScale = 0.78
MainUISwitchEnum.ItemUnSelectedHeight = MainUISwitchEnum.ItemHeight * MainUISwitchEnum.ItemUnSelectedScale
MainUISwitchEnum.MainUIPart = {
	NormalJumpFight = 12,
	BankEffect = 13,
	Room = 5,
	NormalFight = 11,
	Storage = 3,
	Quest = 2,
	Bank = 4,
	Power = 8,
	Fight = 9,
	Mail = 1,
	ActivityFight = 10,
	Role = 6,
	Summon = 7
}
MainUISwitchEnum.MainUIFontMaterialPath = "font/meshpro/outline_material/mainui/mainui_font_material_%s.mat"
MainUISwitchEnum.SwitchMainUIOffsetType = {
	{
		offsetX = 138
	},
	{
		offsetX = -187
	}
}
MainUISwitchEnum.MainUIScale = 0.8
MainUISwitchEnum.Skin = {
	V3a2 = 3,
	Sp01 = 2,
	Normal = 1
}
MainUISwitchEnum.EagleLocationType = {
	C = 3,
	A = 1,
	B = 2
}
MainUISwitchEnum.EagleAnim = {
	Idle3 = "idle3",
	Fly = "fly",
	Idle2 = "idle2",
	Land = "land",
	Idle1 = "idle1",
	Scare = "scare",
	Hover = "hover"
}
MainUISwitchEnum.HeadCutTime = 15
MainUISwitchEnum.HeadCutLoadime = 0.2
MainUISwitchEnum.AnimName = {
	Out = "out",
	Switch = "switch",
	Idle = "idle",
	In = "in"
}

return MainUISwitchEnum
