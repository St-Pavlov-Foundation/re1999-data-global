module("modules.logic.defines.ModuleEnum", package.seeall)

slot0 = _M
slot0.HeroCountInGroup = 3
slot0.SubHeroCountInGroup = 1
slot0.MaxHeroCountInGroup = slot0.HeroCountInGroup + slot0.SubHeroCountInGroup
slot0.ServerUtcOffset = 28800
slot0.SpineHangPointRoot = "mountroot"
slot0.SpineHangPoint = {
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
slot0.Gender = {
	Female = 2,
	Male = 1,
	None = 0
}
slot0.Performance = {
	High = 1,
	Undefine = 0,
	Low = 3,
	Middle = 2
}
slot0.TargetFrameRate = {
	Low = 30,
	High = 60
}
slot0.FullScreenState = {
	On = 1,
	Off = 0
}
slot0.HeroGroupType = {
	Default = 0,
	Trial = 6,
	Season166Base = 9,
	NormalFb = 1,
	Season = 5,
	Season166Train = 10,
	Season123 = 7,
	Resources = 2,
	Season123Retail = 8,
	General = 12,
	Season166Teach = 11,
	Temp = 3
}
slot0.HeroGroupSnapshotType = {
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
	Act183Boss = 13
}
slot0.HeroGroupServerType = {
	Activity = 100,
	Equip = 2,
	Main = 1
}

return slot0
