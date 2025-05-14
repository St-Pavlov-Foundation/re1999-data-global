module("modules.logic.versionactivity2_5.autochess.define.AutoChessStrEnum", package.seeall)

local var_0_0 = _M

var_0_0.CostType = {
	Coin = "coin",
	Hp = "hp"
}
var_0_0.SkillType = {
	Passive = "passive",
	Active = "active"
}
var_0_0.ChessType = {
	Support = "Support",
	Attack = "Attack"
}
var_0_0.Tag2EffectId = {
	Die = 10002,
	Ranged = 20002,
	BattleFury = 2003,
	Damaged = 20001,
	GrowUp = 10003,
	Raw = 10001
}
var_0_0.SkillEffect = {
	GrowUpNow2 = "GrowUpNow2",
	RoundAddCoin = "RoundAddCoin",
	AdditionalDamage = "AdditionalDamage",
	DigTreasure = "DigTreasure"
}

return var_0_0
