-- chunkname: @modules/logic/defines/ModuleEnum.lua

module("modules.logic.defines.ModuleEnum", package.seeall)

local ModuleEnum = _M

ModuleEnum.HeroCountInGroup = 3
ModuleEnum.SubHeroCountInGroup = 1
ModuleEnum.MaxHeroCountInGroup = ModuleEnum.HeroCountInGroup + ModuleEnum.SubHeroCountInGroup
ModuleEnum.ServerUtcOffset = 28800
ModuleEnum.SpineHangPointRoot = "mountroot"
ModuleEnum.SpineHangPoint = {
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
ModuleEnum.Gender = {
	Female = 2,
	Male = 1,
	None = 0
}
ModuleEnum.Performance = {
	High = 1,
	Undefine = 0,
	Low = 3,
	Middle = 2
}
ModuleEnum.TargetFrameRate = {
	Low = 30,
	High = 60
}
ModuleEnum.FullScreenState = {
	On = 1,
	Off = 0
}
ModuleEnum.HeroGroupType = {
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
ModuleEnum.HeroGroupSnapshotType = {
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
ModuleEnum.FiveHeroEnum = {
	MaxHeroNum = 5,
	FifthIndex = 5
}
ModuleEnum.HeroGroupServerType = {
	Activity = 100,
	Equip = 2,
	Main = 1
}

return ModuleEnum
