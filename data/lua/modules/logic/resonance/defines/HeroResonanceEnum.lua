module("modules.logic.resonance.defines.HeroResonanceEnum", package.seeall)

return {
	PutCube = 0,
	GetCube = 1,
	FromRabbet = 2,
	FromBag = 3,
	StyleCubeState = {
		Lock = 3,
		Select = 2,
		New = 5,
		Use = 4,
		Normal = 1
	},
	QuickLayoutType = {
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
	},
	AttrChange = {
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
}
