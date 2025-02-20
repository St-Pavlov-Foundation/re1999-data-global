module("modules.logic.character.defines.CharacterTalentStyleEnum", package.seeall)

slot0 = _M
slot0.AttrChange = {
	[0] = {
		NumColor = "#CAC8C5"
	},
	{
		ChangeImage = "character_style_up",
		NumColor = "#65B96F"
	},
	{
		ChangeImage = "character_style_down",
		NumColor = "#D97373"
	},
	{
		ChangeColor = "#65B96F",
		ChangeText = "+",
		NumColor = "#CAC8C5"
	},
	{
		ChangeColor = "#D97373",
		ChangeText = "-",
		Alpha = 0.5,
		NumColor = "#CAC8C5"
	}
}
slot0.StatType = {
	{
		TxtColor = "#EA8438",
		ProgressColor = "#EA8438"
	},
	{
		TxtColor = "#995B2C",
		ProgressColor = "#955422"
	}
}

return slot0
