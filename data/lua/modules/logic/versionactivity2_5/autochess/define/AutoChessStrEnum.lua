module("modules.logic.versionactivity2_5.autochess.define.AutoChessStrEnum", package.seeall)

slot0 = _M
slot0.CostType = {
	Coin = "coin",
	Hp = "hp"
}
slot0.SkillType = {
	Passive = "passive",
	Active = "active"
}
slot0.ChessType = {
	Support = "Support",
	Attack = "Attack"
}
slot0.Tag2EffectId = {
	Die = 10002,
	Ranged = 20002,
	BattleFury = 2003,
	Damaged = 20001,
	GrowUp = 10003,
	Raw = 10001
}
slot0.SkillEffect = {
	GrowUpNow2 = "GrowUpNow2",
	RoundAddCoin = "RoundAddCoin",
	AdditionalDamage = "AdditionalDamage",
	DigTreasure = "DigTreasure"
}

return slot0
