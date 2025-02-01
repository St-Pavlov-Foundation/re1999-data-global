module("modules.logic.enemyinfo.define.EnemyInfoEnum", package.seeall)

slot0 = _M
slot0.TabEnum = {
	Season123 = 3,
	WeekWalk = 2,
	Rouge = 5,
	BossRush = 4,
	Normal = 1
}
slot0.TabWidth = 252
slot0.LeftTabRatio = 0.45
slot0.RightTabRatio = 0.55
slot0.LineHeight = 2
slot0.RuleTopMargin = 70
slot0.RuleItemHeight = 180
slot0.RuleItemWeight = 140
slot0.SkillDescLeftMargin = 100
slot0.EnemyGroupLeftMargin = 94
slot0.ScrollEnemyMargin = {
	Left = 80,
	Up = 0,
	Bottom = 300,
	Right = 100
}
slot0.EnemyInfoMargin = {
	Left = 100,
	Right = 50
}
slot0.WithTabOffset = {
	LeftRatio = -0.03,
	EnemyInfoLeftMargin = -60,
	ScrollEnemyLeftMargin = -10,
	RightRatio = 0.03,
	ScrollEnemyUpMargin = 30
}
slot0.Tip = {
	BuffTip = 2,
	RuleTip = 1
}
slot0.TagColor = {
	"#6680bd",
	"#d05b4c",
	"#c7b376"
}
slot0.StageColor = {
	Normal = Color(0.596078431372549, 0.596078431372549, 0.596078431372549, 1),
	Select = Color(1, 1, 1, 1)
}
slot0.TipOffsetX = 20
slot0.BuffTipOffset = {
	x = 40,
	y = 30
}

return slot0
