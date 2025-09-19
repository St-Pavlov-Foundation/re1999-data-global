module("modules.logic.fight.config.FightRightElementEnum", package.seeall)

local var_0_0 = _M
local var_0_1 = 0

local function var_0_2()
	var_0_1 = var_0_1 + 1

	return var_0_1
end

var_0_0.Elements = {
	BossRush = var_0_2(),
	CharSupport = var_0_2(),
	MelodyLevel = var_0_2(),
	MelodySkill = var_0_2(),
	RougeCoin = var_0_2(),
	RougeGongMing = var_0_2(),
	RougeTongPin = var_0_2(),
	AssistBoss = var_0_2(),
	AssistBossScore = var_0_2(),
	DoomsdayClock = var_0_2(),
	Dice = var_0_2(),
	DouQuQuCoin = var_0_2(),
	DouQuQuHunting = var_0_2(),
	SurvivalTalent = var_0_2()
}
var_0_0.Priority = {
	var_0_0.Elements.Dice,
	var_0_0.Elements.BossRush,
	var_0_0.Elements.SurvivalTalent,
	var_0_0.Elements.MelodyLevel,
	var_0_0.Elements.MelodySkill,
	var_0_0.Elements.AssistBossScore,
	var_0_0.Elements.AssistBoss,
	var_0_0.Elements.DoomsdayClock,
	var_0_0.Elements.DouQuQuCoin,
	var_0_0.Elements.DouQuQuHunting,
	var_0_0.Elements.RougeCoin,
	var_0_0.Elements.RougeGongMing,
	var_0_0.Elements.RougeTongPin,
	var_0_0.Elements.CharSupport
}
var_0_0.ElementsSizeDict = {
	[var_0_0.Elements.Dice] = Vector2(540, 150),
	[var_0_0.Elements.BossRush] = Vector2(200, 135),
	[var_0_0.Elements.CharSupport] = Vector2(200, 130),
	[var_0_0.Elements.MelodyLevel] = Vector2(300, 50),
	[var_0_0.Elements.MelodySkill] = Vector2(200, 175),
	[var_0_0.Elements.RougeCoin] = Vector2(220, 84),
	[var_0_0.Elements.RougeGongMing] = Vector2(327, 111),
	[var_0_0.Elements.RougeTongPin] = Vector2(412.9, 111),
	[var_0_0.Elements.AssistBoss] = Vector2(200, 200),
	[var_0_0.Elements.AssistBossScore] = Vector2(200, 100),
	[var_0_0.Elements.DoomsdayClock] = Vector2(200, 350),
	[var_0_0.Elements.DouQuQuCoin] = Vector2(400, 80),
	[var_0_0.Elements.DouQuQuHunting] = Vector2(220, 148),
	[var_0_0.Elements.SurvivalTalent] = Vector2(240, 200)
}
var_0_0.ElementsNodeName = {
	[var_0_0.Elements.BossRush] = "bossrush_score",
	[var_0_0.Elements.CharSupport] = "#go_charsupport",
	[var_0_0.Elements.MelodyLevel] = "melody_level",
	[var_0_0.Elements.MelodySkill] = "melody_skill",
	[var_0_0.Elements.RougeCoin] = "rougeCoin",
	[var_0_0.Elements.RougeGongMing] = "rougeGongMing",
	[var_0_0.Elements.RougeTongPin] = "rougeTongPin",
	[var_0_0.Elements.AssistBoss] = "assistboss",
	[var_0_0.Elements.AssistBossScore] = "assistbossscore",
	[var_0_0.Elements.DoomsdayClock] = "doomsdayclock",
	[var_0_0.Elements.Dice] = "dice",
	[var_0_0.Elements.DouQuQuCoin] = "douququCoin",
	[var_0_0.Elements.DouQuQuHunting] = "douququHunting",
	[var_0_0.Elements.SurvivalTalent] = "survival_talent"
}
var_0_0.AnchorTweenDuration = 0.2

return var_0_0
