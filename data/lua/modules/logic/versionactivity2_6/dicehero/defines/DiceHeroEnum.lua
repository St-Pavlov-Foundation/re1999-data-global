module("modules.logic.versionactivity2_6.dicehero.defines.DiceHeroEnum", package.seeall)

local var_0_0 = _M

var_0_0.LevelType = {
	Fight = 2,
	Story = 1
}
var_0_0.GetRewardType = {
	All = 1,
	One = 2,
	None = 0
}
var_0_0.RewardType = {
	SkillCard = 2,
	Hero = 1,
	Relic = 3
}
var_0_0.DialogContentType = {
	Narration = 3,
	Talk = 2,
	Title = 1
}
var_0_0.SkillType = {
	Hero = 2,
	Normal = 1
}
var_0_0.GameStatu = {
	Win = 1,
	Lose = 2,
	None = 0
}
var_0_0.SkillEffectType = {
	FixDamageByDicePoint = 108,
	AddBuff = 40,
	FixAddShield = 107,
	Damage3 = 12,
	AddBuffLayer = 41,
	BanSkillCard = 110,
	BuffAddBuff = 109,
	ChangeShield1 = 20,
	LockDice = 105,
	FixDamageRate2 = 111,
	ChangePower1 = 30,
	AddShield = 103,
	DiceMix = 112,
	Damage1 = 10,
	FixDamageAddValue = 106,
	ChangeMaxPower = 32,
	ChangeShield2 = 21,
	FixDamageRate = 104,
	DamageByType = 102,
	ChangeShield3 = 22,
	ChangePower2 = 31,
	Damage2 = 11,
	AddDice = 101
}
var_0_0.GameProgress = {
	PlaySkill = 1,
	RollDice = 2,
	UseSkill = 3,
	None = 0
}
var_0_0.DiceStatu = {
	HardLock = 2,
	SoftLock = 1,
	Normal = 0
}
var_0_0.DiceType = {
	Power = 4,
	Def = 2,
	Atk = 1
}
var_0_0.BaseDiceSuitDict = {
	[var_0_0.DiceType.Atk] = true,
	[var_0_0.DiceType.Def] = true,
	[var_0_0.DiceType.Power] = true
}
var_0_0.CardType = {
	Power = 3,
	Def = 2,
	Hero = 4,
	Atk = 1
}
var_0_0.HeroCardType = {
	PassiveSkill = 2,
	ActiveSkill = 1,
	None = 0
}
var_0_0.FightActionType = {
	UseSkill = 1,
	Effect = 2
}
var_0_0.FightEffectType = {
	ChangePower = 5,
	RemoveBuff = 2,
	Damage = 8,
	ChangeMaxPower = 6,
	ChangeHp = 7,
	AddBuff = 1,
	UpdateSkillCard = 10,
	DiceChangeStatus = 9,
	DiceBoxFull = 12,
	UpdateDiceBox = 11,
	UpdateBuff = 3,
	ChangeShield = 4
}
var_0_0.SkillCardTargetType = {
	RandomEnemy = 4,
	Self = 2,
	AllEnemy = 3,
	SingleEnemy = 1,
	None = 0
}
var_0_0.CantUseReason = {
	NoUseCount = 2,
	NoDice = 1,
	BanSkill = 3
}
var_0_0.FightEffectTypeToName = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.FightEffectType) do
	var_0_0.FightEffectTypeToName[iter_0_1] = iter_0_0
end

return var_0_0
