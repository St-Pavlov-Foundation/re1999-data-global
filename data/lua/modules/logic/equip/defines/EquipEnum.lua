module("modules.logic.equip.defines.EquipEnum", package.seeall)

local var_0_0 = _M

var_0_0.StrengthenMaxCount = 8
var_0_0.RefineMaxCount = 5
var_0_0.AnimationDurationTime = 0.167
var_0_0.ChooseEquipStatus = {
	Lock = 5,
	BeyondEquipHadNum = 1,
	ReduceNotSelectedEquip = 2,
	BeyondMaxStrengthenExperience = 4,
	BeyondMaxSelectEquip = 3,
	Success = 0
}
var_0_0.FromViewEnum = {
	FromOdysseyHeroGroupFightView = 9,
	FromCharacterView = 2,
	FromCachotHeroGroupView = 4,
	FromSeason123HeroGroupFightView = 6,
	FromAssassinHeroView = 10,
	FromSeason166HeroGroupFightView = 8,
	FromSeasonFightView = 3,
	FromHeroGroupFightView = 1,
	FromRougeHeroGroupFightView = 7,
	FromCachotHeroGroupFightView = 5
}
var_0_0.ConstId = {
	equipNotShowRefineRare = 16
}
var_0_0.ClientEquipType = {
	Config = 3,
	TrialEquip = 2,
	OtherPlayer = 4,
	TrialHero = 1,
	Normal = 0
}
var_0_0.DecomposeMaxCount = 100
var_0_0.DecomposeTxtAnimDuration = 0.5
var_0_0.DecomposeAnimDuration = 0.9
var_0_0.EquipEnterAnimWaitTime = 0.2
var_0_0.EquipDecomposeMinRare = 2
var_0_0.EquipDecomposeMaxRare = 3

return var_0_0
