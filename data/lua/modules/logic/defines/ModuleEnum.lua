module("modules.logic.defines.ModuleEnum", package.seeall)

local var_0_0 = _M

var_0_0.HeroCountInGroup = 3
var_0_0.SubHeroCountInGroup = 1
var_0_0.MaxHeroCountInGroup = var_0_0.HeroCountInGroup + var_0_0.SubHeroCountInGroup
var_0_0.ServerUtcOffset = 28800
var_0_0.SpineHangPointRoot = "mountroot"
var_0_0.SpineHangPoint = {
	mounthead = "mounthead",
	mountbody = "mountbody",
	HeadStatic = "HeadStatic",
	mountfoot = "mountfoot",
	mounttop = "mounttop",
	mountmiddle = "mountmiddle",
	mounthproot = "mounthproot",
	BodyStatic = "BodyStatic",
	mountbottom = "mountbottom",
	bone = "bone",
	mountweapon = "mountweapon"
}
var_0_0.Gender = {
	Female = 2,
	Male = 1,
	None = 0
}
var_0_0.Performance = {
	High = 1,
	Undefine = 0,
	Low = 3,
	Middle = 2
}
var_0_0.TargetFrameRate = {
	Low = 30,
	High = 60
}
var_0_0.FullScreenState = {
	On = 1,
	Off = 0
}
var_0_0.HeroGroupType = {
	Default = 0,
	Trial = 6,
	Season166Base = 9,
	NormalFb = 1,
	Season = 5,
	Season166Train = 10,
	Season123 = 7,
	Resources = 2,
	Season123Retail = 8,
	Odyssey = 13,
	General = 12,
	Season166Teach = 11,
	Temp = 3
}
var_0_0.HeroGroupSnapshotType = {
	Season166Base = 8,
	Resources = 3,
	Act183Normal = 12,
	TowerBoss = 11,
	Season = 5,
	Common = 2,
	Season166Train = 9,
	Season123 = 6,
	TowerPermanentAndLimit = 10,
	Season123Retail = 7,
	Act183Boss = 13,
	Survival = 15,
	FiveHero = 16,
	Shelter = 14
}
var_0_0.FiveHeroEnum = {
	MaxHeroNum = 5,
	FifthIndex = 5
}
var_0_0.HeroGroupServerType = {
	Activity = 100,
	Equip = 2,
	Main = 1
}

return var_0_0
