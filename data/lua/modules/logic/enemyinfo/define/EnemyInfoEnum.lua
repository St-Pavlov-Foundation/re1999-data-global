module("modules.logic.enemyinfo.define.EnemyInfoEnum", package.seeall)

local var_0_0 = _M

var_0_0.TabEnum = {
	Act191 = 7,
	WeekWalk_2 = 6,
	Rouge = 5,
	Season123 = 3,
	Survival = 8,
	TowerDeep = 9,
	WeekWalk = 2,
	BossRush = 4,
	Normal = 1
}
var_0_0.TabWidth = 252
var_0_0.LeftTabRatio = 0.45
var_0_0.RightTabRatio = 0.55
var_0_0.LineHeight = 2
var_0_0.RuleTopMargin = 70
var_0_0.RuleItemHeight = 180
var_0_0.RuleItemWeight = 140
var_0_0.SkillDescLeftMargin = 100
var_0_0.EnemyGroupLeftMargin = 94
var_0_0.ScrollEnemyMargin = {
	Left = 80,
	Up = 0,
	Bottom = 300,
	Right = 100
}
var_0_0.EnemyInfoMargin = {
	Left = 100,
	Right = 50
}
var_0_0.WithTabOffset = {
	LeftRatio = -0.03,
	EnemyInfoLeftMargin = -60,
	ScrollEnemyLeftMargin = -10,
	RightRatio = 0.03,
	ScrollEnemyUpMargin = 30
}
var_0_0.Tip = {
	BuffTip = 2,
	RuleTip = 1
}
var_0_0.TagColor = {
	"#6680bd",
	"#d05b4c",
	"#c7b376"
}
var_0_0.StageColor = {
	Normal = Color(0.596078431372549, 0.596078431372549, 0.596078431372549, 1),
	Select = Color(1, 1, 1, 1)
}
var_0_0.TipOffsetX = 20
var_0_0.BuffTipOffset = {
	x = 40,
	y = 30
}

return var_0_0
