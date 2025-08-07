module("modules.logic.mainuiswitch.controller.MainUISwitchEnum", package.seeall)

local var_0_0 = _M

var_0_0.ItemTypeSelected = 1
var_0_0.ItemTypeUnSelected = 2
var_0_0.ItemHeight = 190
var_0_0.ItemUnSelectedScale = 0.78
var_0_0.ItemUnSelectedHeight = var_0_0.ItemHeight * var_0_0.ItemUnSelectedScale
var_0_0.MainUIPart = {
	NormalJumpFight = 12,
	ActivityFight = 10,
	Room = 5,
	NormalFight = 11,
	Storage = 3,
	Quest = 2,
	Bank = 4,
	Power = 8,
	Fight = 9,
	Mail = 1,
	Role = 6,
	Summon = 7
}
var_0_0.MainUIFontMaterialPath = "font/meshpro/outline_material/mainui/mainui_font_material_%s.mat"
var_0_0.SwitchMainUIOffsetType = {
	{
		offsetX = 138
	},
	{
		offsetX = -187
	}
}
var_0_0.MainUIScale = 0.8
var_0_0.Skin = {
	Sp01 = 2,
	Normal = 1
}
var_0_0.EagleLocationType = {
	C = 3,
	A = 1,
	B = 2
}
var_0_0.EagleAnim = {
	Idle3 = "idle3",
	Fly = "fly",
	Idle2 = "idle2",
	Land = "land",
	Idle1 = "idle1",
	Scare = "scare",
	Hover = "hover"
}
var_0_0.HeadCutTime = 15
var_0_0.HeadCutLoadime = 0.2
var_0_0.AnimName = {
	Out = "out",
	Switch = "switch",
	Idle = "idle",
	In = "in"
}

return var_0_0
