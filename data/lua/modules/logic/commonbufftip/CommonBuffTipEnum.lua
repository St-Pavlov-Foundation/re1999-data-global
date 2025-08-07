module("modules.logic.commonbufftip.CommonBuffTipEnum", package.seeall)

local var_0_0 = _M

var_0_0.Pivot = {
	Left = Vector2(0, 1),
	Right = Vector2(1, 1),
	Down = Vector2(1, 0),
	Center = Vector2(0.5, 0.5)
}
var_0_0.DefaultInterval = 50
var_0_0.BottomMargin = 50
var_0_0.TipWidth = 560
var_0_0.Anchor = {
	[ViewName.SkillTipView] = Vector2(-303.39, 57.22754),
	[ViewName.SkillTipView3] = Vector2(-303.39, 57.22754),
	[ViewName.FightFocusView] = Vector2(-225.47, 117.6),
	[ViewName.CharacterExSkillView] = Vector2(98.11, 266.6),
	[ViewName.V2a1_BossRush_OfferRoleView] = Vector2(-180, 100),
	[ViewName.TowerAssistBossTalentView] = Vector2(341, -210),
	[ViewName.TowerSkillTipView] = Vector2(874, 279)
}

return var_0_0
