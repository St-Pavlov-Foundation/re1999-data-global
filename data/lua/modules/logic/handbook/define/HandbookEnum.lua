module("modules.logic.handbook.define.HandbookEnum", package.seeall)

slot0 = _M
slot0.Type = {
	Character = 3,
	Story = 1,
	CG = 2,
	Equip = 4
}
slot0.HeroType = {
	Common = 1,
	AllHero = 99
}
slot0.CGType = {
	Role = 2,
	Dungeon = 1
}
slot0.BookBGRes = {
	[slot0.HeroType.Common] = {
		left = "peper_06",
		right = "peper_05"
	},
	[slot0.HeroType.AllHero] = {
		left = "img_tujian_bg_zuo",
		right = "img_tujian_bg_you"
	}
}

return slot0
