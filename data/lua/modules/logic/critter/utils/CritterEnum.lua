module("modules.logic.critter.utils.CritterEnum", package.seeall)

slot0 = _M
slot0.InvalidCritterUid = "0"
slot0.MoodFactor = 100
slot0.CritterBuildingChangeBuildingAnimTime = 0.2
slot0.ConstId = {
	HeroMoveRate = 15,
	DecomposeResult = 14,
	CritterTrainKeepTime = 16,
	SummonCost = 9,
	LowMood = 12,
	CritterBackpackCapacity = 8,
	IncubationFormula = 1,
	MaxPreviewCount = 13,
	DecomposeCountLimit = 17
}
slot0.AttributeType = {
	Patience = 2,
	Efficiency = 1,
	MoodRestore = 10001,
	Lucky = 3
}
slot0.OrderType = {
	MoodDown = 4,
	MoodUp = 3,
	RareDown = 2,
	RareUp = 1
}
slot0.MatureFilterType = {
	Mature = 2,
	All = 1,
	NotMature = 3
}
slot0.FilterType = {
	Race = 1,
	SkillTag = 2
}
slot0.MatureFilterTypeName = {
	[slot0.MatureFilterType.All] = "critter_mature_filter_all",
	[slot0.MatureFilterType.Mature] = "critter_mature_filter_mature",
	[slot0.MatureFilterType.NotMature] = "critter_mature_filter_not_mature"
}
slot0.TagType = {
	Common = 2,
	Race = 3,
	Base = 1
}
slot0.DecomposeMaxCount = 100
slot0.CritterDecomposeMinRare = 3
slot0.CritterDecomposeMaxRare = 5
slot0.CritterMaxSeatCount = 6
slot0.CritterScaleInSeatSlot = 0.06
slot0.CritterPressingEffectScaleInSeatSlot = 0.7
slot0.SeatSlotOperation = {
	Exchange = 1,
	Change = 0
}
slot0.OneKeyType = {
	Manufacture = 1,
	Transport = 2
}
slot0.EventType = {
	ActiveTime = 2,
	Special = 3,
	Normal = 1
}
slot0.CritterItemEventType = {
	SurpriseCollect = 4,
	TrainEventComplete = 2,
	HasTrainEvent = 1,
	NoMoodWork = 3
}
slot0.NormalEventId = {
	NormalGrow = 101
}
slot0.NeedActionEventTypeDict = {
	[slot0.EventType.ActiveTime] = true,
	[slot0.EventType.Special] = true
}
slot0.SkilTagType = {
	Common = 2,
	Race = 3,
	Base = 1
}
slot0.PosType = {
	Right = 3,
	Middle = 2,
	Left = 1
}
slot0.PreferenceType = {
	Catalogue = 2,
	All = 1,
	Critter = 3
}
slot0.CatalogueType = {
	SubClass = 3,
	Class = 2,
	Genus = 6,
	Phylum = 1,
	Family = 5,
	Order = 4
}
slot0.QualityImageNameMap = {
	"critter_manufacture_quality3",
	"critter_manufacture_quality3",
	"critter_manufacture_quality3",
	"critter_manufacture_quality4",
	"critter_manufacture_quality5"
}
slot0.QualityEggImageNameMap = {
	"room_summon_egg_1",
	"room_summon_egg_1",
	"room_summon_egg_1",
	"room_summon_egg_2",
	"room_summon_egg_3"
}
slot0.QualityEggLightImageNameMap = {
	"room_summon_egglight_1",
	"room_summon_egglight_1",
	"room_summon_egglight_1",
	"room_summon_egglight_2",
	"room_summon_egglight_3"
}
slot0.QualityEggSummomResNameMap = {
	"roomcrittersummonresult_egg1",
	"roomcrittersummonresult_egg1",
	"roomcrittersummonresult_egg1",
	"roomcrittersummonresult_egg2",
	"roomcrittersummonresult_egg3"
}
slot0.LangKey = {
	AgeChildhood = "critter_age_childhood_txt",
	AgeAult = "critter_age_adult_txt",
	HeroTrainLevel = "critter_hero_train_level_txt"
}
slot0.TrainOPState = {
	PairOP = 2,
	Normal = 1
}
slot0.Summon = {
	Ten = 10,
	One = 1
}
slot0.OppenFuncGuide = {
	RoomManufacture = 414,
	RoomTrade = 414,
	Critter = 414
}

return slot0
