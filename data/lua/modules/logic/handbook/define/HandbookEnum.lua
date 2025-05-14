module("modules.logic.handbook.define.HandbookEnum", package.seeall)

local var_0_0 = _M

var_0_0.Type = {
	Character = 3,
	Story = 1,
	CG = 2,
	Equip = 4
}
var_0_0.HeroType = {
	Common = 1,
	AllHero = 99
}
var_0_0.CGType = {
	Role = 2,
	Dungeon = 1
}
var_0_0.BookBGRes = {
	[var_0_0.HeroType.Common] = {
		left = "peper_06",
		right = "peper_05"
	},
	[var_0_0.HeroType.AllHero] = {
		left = "img_tujian_bg_zuo",
		right = "img_tujian_bg_you"
	}
}

return var_0_0
