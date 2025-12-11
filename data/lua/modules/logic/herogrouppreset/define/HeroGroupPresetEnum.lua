module("modules.logic.herogrouppreset.define.HeroGroupPresetEnum", package.seeall)

local var_0_0 = _M

var_0_0.MaxNum = 10
var_0_0.MinNum = 1
var_0_0.ShowType = {
	Fight = 2,
	Normal = 1
}
var_0_0.HeroGroupType = {
	Common = 2,
	TowerPermanentAndLimit = 10
}
var_0_0.HeroGroupType2SnapshotAllType = {
	[var_0_0.HeroGroupType.Common] = ModuleEnum.HeroGroupSnapshotType.Common,
	[var_0_0.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
}
var_0_0.HeroGroupType2SnapshotType = {
	[var_0_0.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit
}
var_0_0.HeroGroupSnapshotTypeOpen = {
	[var_0_0.HeroGroupType.TowerPermanentAndLimit] = true
}
var_0_0.HeroGroupSnapshotTypeShowBoss = {
	[var_0_0.HeroGroupType.TowerPermanentAndLimit] = true
}

return var_0_0
