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
	Common = 2,
	TowerPermanentAndLimit = 10
}
HeroGroupPresetEnum.HeroGroupType2SnapshotAllType = {
	[HeroGroupPresetEnum.HeroGroupType.Common] = ModuleEnum.HeroGroupSnapshotType.Common,
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
}
HeroGroupPresetEnum.HeroGroupType2SnapshotType = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
}
HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = true
}
HeroGroupPresetEnum.HeroGroupSnapshotTypeShowBoss = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = true
}

return HeroGroupPresetEnum
