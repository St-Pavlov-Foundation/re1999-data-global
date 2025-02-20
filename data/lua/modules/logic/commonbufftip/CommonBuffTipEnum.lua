module("modules.logic.commonbufftip.CommonBuffTipEnum", package.seeall)

slot0 = _M
slot0.Pivot = {
	Left = Vector2(0, 1),
	Right = Vector2(1, 1),
	Down = Vector2(1, 0)
}
slot0.DefaultInterval = 50
slot0.BottomMargin = 50
slot0.TipWidth = 560
slot0.Anchor = {
	[ViewName.SkillTipView] = Vector2(-303.39, 57.22754),
	[ViewName.SkillTipView3] = Vector2(-303.39, 57.22754),
	[ViewName.FightFocusView] = Vector2(-225.47, 117.6),
	[ViewName.CharacterExSkillView] = Vector2(98.11, 266.6),
	[ViewName.V2a1_BossRush_OfferRoleView] = Vector2(-180, 100),
	[ViewName.TowerAssistBossTalentView] = Vector2(341, -210),
	[ViewName.TowerSkillTipView] = Vector2(874, 279)
}

return slot0
