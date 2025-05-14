module("modules.logic.resonance.defines.HeroResonanceEnum", package.seeall)

local var_0_0 = {}

var_0_0.PutCube = 0
var_0_0.GetCube = 1
var_0_0.FromRabbet = 2
var_0_0.FromBag = 3
var_0_0.StyleCubeState = {
	Lock = 3,
	Select = 2,
	New = 5,
	Use = 4,
	Normal = 1
}
var_0_0.QuickLayoutType = {
	{
		isNeedParam = true,
		name = "character_copy_talentLayout_copy_code"
	},
	{
		isNeedParam = true,
		name = "character_copy_talentLayout_use_code"
	},
	{
		isNeedParam = false,
		name = "character_copy_talentLayout_default"
	}
}
var_0_0.AttrChange = {
	[0] = {
		NumColor = "#CAC8C5"
	},
	{
		ChangeImage = "character_style_up",
		NumColor = "#52AA64"
	},
	{
		ChangeImage = "character_style_down",
		NumColor = "#B95959"
	}
}

return var_0_0
