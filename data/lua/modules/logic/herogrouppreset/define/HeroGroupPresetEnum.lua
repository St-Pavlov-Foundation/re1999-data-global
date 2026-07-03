-- chunkname: @modules/logic/herogrouppreset/define/HeroGroupPresetEnum.lua

module("modules.logic.herogrouppreset.define.HeroGroupPresetEnum", package.seeall)

local HeroGroupPresetEnum = _M

HeroGroupPresetEnum.MaxNum = 10
HeroGroupPresetEnum.MinNum = 1
HeroGroupPresetEnum.ShowType = {
	Fight = 2,
	Normal = 1
}
HeroGroupPresetEnum.HeroGroupType = {
	TowerPermanentAndLimit = 10,
	Common = 2,
	Abyss = 19
}
HeroGroupPresetEnum.HeroGroupType2SnapshotAllType = {
	[HeroGroupPresetEnum.HeroGroupType.Common] = ModuleEnum.HeroGroupSnapshotType.Common,
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit,
	[HeroGroupPresetEnum.HeroGroupType.Abyss] = ModuleEnum.HeroGroupSnapshotType.Abyss
}
HeroGroupPresetEnum.HeroGroupType2SnapshotType = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit,
	[HeroGroupPresetEnum.HeroGroupType.Abyss] = ModuleEnum.HeroGroupSnapshotType.Abyss
}
HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = true,
	[HeroGroupPresetEnum.HeroGroupType.Abyss] = true
}
HeroGroupPresetEnum.HeroGroupSnapshotTypeShowBoss = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = true
}

return HeroGroupPresetEnum
