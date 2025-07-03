module("modules.logic.character.defines.CharacterEnum", package.seeall)

local var_0_0 = _M

var_0_0.VoiceType = {
	FightBehit = 6,
	Skill = 18,
	FightCardStar12 = 3,
	MainViewSpecialTouch = 12,
	EnterFight = 2,
	BreakThrough = 10,
	SpecialIdle1 = 20,
	LimitedEntrance = 22,
	HeroGroup = 1,
	MainViewNoInteraction = 16,
	MainViewDragSpecialRespond = 25,
	FightCardUnique = 5,
	Summon = 11,
	FightDie = 8,
	GetSkin = 9,
	SpecialIdle2 = 21,
	FightResult = 7,
	MultiVoice = 26,
	MainViewSpecialInteraction = 23,
	WeatherChange = 14,
	MainViewNormalTouch = 13,
	GreetingInThumbnail = 19,
	FightCardStar3 = 4,
	MainViewSpecialRespond = 24,
	Greeting = 17,
	MainViewWelcome = 15
}
var_0_0.AttrDarkColor = GameUtil.parseColor("#736e6a")
var_0_0.AttrLightColor = GameUtil.parseColor("#efece6")
var_0_0.MaxSkillExLevel = 5
var_0_0.DrawingState = {
	Dynamic = 0,
	Static = 1
}
var_0_0.CharacterSwitchViewOffsetX = -108
var_0_0.SkinOpen = true
var_0_0.TalentOpen = false
var_0_0.Star = {
	2,
	3,
	4,
	5,
	6
}
var_0_0.Color = {
	2,
	3,
	4,
	5,
	6
}
var_0_0.LevelUpGuideId = 108
var_0_0.MaxRare = 5
var_0_0.CareerType = {
	Shou = 4,
	Zhi = 6,
	Ling = 5,
	Xing = 2,
	Mu = 3,
	Yan = 1
}
var_0_0.DamageType = {
	Real = 1,
	Spirit = 2
}
var_0_0.TalentRank = 2
var_0_0.showAttributeOption = {
	ShowCurrent = 0,
	ShowMax = 1,
	ShowMin = -1
}
var_0_0.CharacterDataItemType = {
	Culture = 3,
	Item = 2,
	Title = 1
}
var_0_0.CharacterDataUnLockType = {
	Faith = 1,
	TalentLevel = 5,
	RankLevel = 2,
	Level = 3,
	Episode = 6,
	SkillLevel = 4
}
var_0_0.SkinGainApproach = {
	Activity = 3,
	Store = 2,
	Rank = 1,
	BPReward = 4,
	Permanent = 5,
	Init = 0
}
var_0_0.FilterType = {
	HeroGroup = 2,
	BackpackHero = 1,
	AdventureCharacter = 4,
	SkinOffsetAdjust = 5,
	ShowCharacter = 3,
	CharVoiceSetting = 7,
	WeekWalk = 6
}
var_0_0.AttrId = {
	Cri = 201,
	Absorb = 210,
	Recri = 202,
	DefenseIgnore = 213,
	Heal = 212,
	ReboundDmg = 218,
	Attack = 102,
	DefenseBase = 603,
	CriDmg = 203,
	MdefenseBase = 604,
	DropDmg = 206,
	HpBase = 601,
	Technic = 105,
	CriDef = 204,
	Mdefense = 104,
	Clutch = 211,
	MdefensePercent = 608,
	AttackBase = 602,
	Revive = 209,
	CurrentHp = 100,
	HpPercent = 605,
	ReuseDmg = 220,
	PoisonAddRate = 301,
	ExtraDmg = 219,
	DefensePercent = 607,
	PlayAddRate = 215,
	AddDmg = 205,
	PlayDropRate = 216,
	AttackPercent = 606,
	NormalSkillRate = 214,
	Hp = 101,
	LostHp = 99,
	Defense = 103
}
var_0_0.AttrIdToAttrName = {
	[var_0_0.AttrId.Hp] = "hp",
	[var_0_0.AttrId.Attack] = "atk",
	[var_0_0.AttrId.Defense] = "def",
	[var_0_0.AttrId.Mdefense] = "mdef",
	[var_0_0.AttrId.Technic] = "technic",
	[var_0_0.AttrId.Cri] = "cri",
	[var_0_0.AttrId.Recri] = "recri",
	[var_0_0.AttrId.CriDmg] = "cri_dmg",
	[var_0_0.AttrId.CriDef] = "cri_def",
	[var_0_0.AttrId.AddDmg] = "add_dmg",
	[var_0_0.AttrId.DropDmg] = "drop_dmg"
}
var_0_0.BaseAttrIdList = {
	var_0_0.AttrId.Attack,
	var_0_0.AttrId.Hp,
	var_0_0.AttrId.Defense,
	var_0_0.AttrId.Mdefense,
	var_0_0.AttrId.Technic
}
var_0_0.UpAttrIdList = {
	var_0_0.AttrId.Cri,
	var_0_0.AttrId.Recri,
	var_0_0.AttrId.CriDmg,
	var_0_0.AttrId.CriDef,
	var_0_0.AttrId.AddDmg,
	var_0_0.AttrId.DropDmg,
	var_0_0.AttrId.NormalSkillRate,
	var_0_0.AttrId.Clutch,
	var_0_0.AttrId.Revive,
	var_0_0.AttrId.Absorb,
	var_0_0.AttrId.Heal,
	var_0_0.AttrId.DefenseIgnore
}
var_0_0.ShowSkinEnum = {
	Static = 1,
	Dynamic = 2
}
var_0_0.OpenSkinViewEnum = {
	SkinStore = 2,
	SkinTip = 3,
	Normal = 1
}
var_0_0.TalentTxtByHeroType = {
	"1",
	"1",
	"1",
	"1",
	"1",
	"6"
}
var_0_0.skillIndex = {
	Skill2 = 2,
	SkillEx = 3,
	Skill1 = 1
}
var_0_0.DefaultSkinId = {
	DuDuGu = 310401
}

setmetatable(var_0_0.TalentTxtByHeroType, {
	__index = function(arg_1_0, arg_1_1)
		return "1"
	end
})

var_0_0.HumanHeroType = 6

return var_0_0
