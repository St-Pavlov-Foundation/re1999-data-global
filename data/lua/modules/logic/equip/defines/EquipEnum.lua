module("modules.logic.equip.defines.EquipEnum", package.seeall)

slot0 = _M
slot0.StrengthenMaxCount = 8
slot0.RefineMaxCount = 5
slot0.AnimationDurationTime = 0.167
slot0.ChooseEquipStatus = {
	Lock = 5,
	BeyondEquipHadNum = 1,
	ReduceNotSelectedEquip = 2,
	BeyondMaxStrengthenExperience = 4,
	BeyondMaxSelectEquip = 3,
	Success = 0
}
slot0.FromViewEnum = {
	FromCachotHeroGroupView = 4,
	FromCharacterView = 2,
	FromSeason123HeroGroupFightView = 6,
	FromRougeHeroGroupFightView = 7,
	FromSeason166HeroGroupFightView = 8,
	FromCachotHeroGroupFightView = 5,
	FromSeasonFightView = 3,
	FromHeroGroupFightView = 1
}
slot0.ConstId = {
	equipNotShowRefineRare = 16
}
slot0.ClientEquipType = {
	Config = 3,
	TrialEquip = 2,
	OtherPlayer = 4,
	TrialHero = 1,
	Normal = 0
}
slot0.DecomposeMaxCount = 100
slot0.DecomposeTxtAnimDuration = 0.5
slot0.DecomposeAnimDuration = 0.9
slot0.EquipEnterAnimWaitTime = 0.2
slot0.EquipDecomposeMinRare = 2
slot0.EquipDecomposeMaxRare = 3

return slot0
