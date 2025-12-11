module("modules.logic.defines.MaterialEnum", package.seeall)

local var_0_0 = _M

var_0_0.MaterialType = {
	Bp = 25,
	PlayerCloth = 7,
	HeroSkin = 5,
	SpecialBlock = 14,
	Exp = 3,
	Faith = 6,
	EquipCard = 16,
	NewInsight = 24,
	Antique = 18,
	Building = 11,
	Item = 1,
	Formula = 12,
	Season123EquipCard = 19,
	Hero = 4,
	BlockPackage = 13,
	Act186Like = 26,
	Critter = 27,
	Equip = 9,
	PowerPotion = 10,
	PlayerClothExp = 8,
	Explore = 15,
	Currency = 2,
	RoomTheme = 1001,
	UnlockVoucher = 28,
	V1a5AiZiLa = 1002,
	None = 0
}
var_0_0.JumpProbability = {
	Small = 3,
	Little = 5,
	Large = 2,
	Must = 1,
	VerySmall = 4,
	Normal = 0
}
var_0_0.GetApproach = {
	RoomGainFaith = 46,
	RoomProductLine = 34,
	v2a2Act169SummonNewPick = 119,
	Act1_6SkillReset = 85,
	MonthCard = 42,
	RoomProductChange = 38,
	Activity = 25,
	v1a8Act157ComponentReward = 96,
	Act1_6SkillLvDown = 84,
	AutoChessRankReward = 134,
	Charge = 31,
	SkinCoupon = 139,
	RoomInteraction = 47,
	AutoChessPveReward = 127,
	Activity197View = 138,
	DungeonRewardPoint = 28,
	Task = 8,
	TaskAct = 13,
	Explore = 45,
	BattlePass = 49,
	AstrologyStarReward = 62,
	SignIn = 20,
	LifeCircleSign = 133,
	NoviceStageReward = 54
}
var_0_0.SubTypePackages = {
	[48] = true,
	[50] = true,
	[52] = true,
	[53] = true
}
var_0_0.JumpProbabilityDisplay = {
	[var_0_0.JumpProbability.Normal] = "material_jump_probability_normal",
	[var_0_0.JumpProbability.Must] = "material_jump_probability_must",
	[var_0_0.JumpProbability.Large] = "material_jump_probability_large",
	[var_0_0.JumpProbability.Small] = "material_jump_probability_small",
	[var_0_0.JumpProbability.VerySmall] = "material_jump_probability_verysmall",
	[var_0_0.JumpProbability.Little] = "material_jump_probability_little"
}
var_0_0.ItemSubType16 = 16
var_0_0.ItemRareN = 2
var_0_0.ItemRareR = 3
var_0_0.ItemRareSR = 4
var_0_0.ItemRareSSR = 5
var_0_0.PowerId = {
	BigPower_Expire = 11,
	SmallPower = 20,
	ActPowerId = 30,
	OverflowPowerId = 31,
	SmallPower_Expire = 10,
	BigPower = 21
}
var_0_0.PowerType = {
	Big = 2,
	Overflow = 4,
	Act = 3,
	Small = 1
}
var_0_0.ItemSubType = {
	MainScene = 24,
	Icon = 17,
	SelfCard = 21
}
var_0_0.PowerMakerStatus = {
	Making = 1,
	Pause = 0
}
var_0_0.PowerMakerItemId = 140055
var_0_0.PowerMakerFixedPauseTime = 43200
var_0_0.ActPowerBindActId = 11904

return var_0_0
