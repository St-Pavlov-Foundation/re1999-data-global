module("modules.logic.versionactivity2_8.nuodika.define.NuoDiKaEnum", package.seeall)

local var_0_0 = _M

var_0_0.MapPassType = {
	ClearEnemy = 1,
	UnlockItem = 2
}
var_0_0.EpisodeStatus = {
	BeforeStory = 0,
	MapGame = 1,
	Finished = 3,
	AfterStory = 2
}
var_0_0.NodeType = {
	Random = 2,
	Normal = 1
}
var_0_0.EventType = {
	Item = 2,
	Enemy = 3,
	Start = 1,
	Null = 0
}
var_0_0.EnemyType = {
	MainRole = 1,
	Normal = 0
}
var_0_0.EnemyState = {
	Disappear = 4,
	Freeze = 2,
	Hurt = 5,
	Selected = 3,
	Normal = 1
}
var_0_0.SkillType = {
	Halo = 5,
	AttackRandom = 3,
	UnlockAllNodes = 7,
	AttackSelected = 2,
	ReplaceHurt = 6,
	AttackReflect = 9,
	WarnEnemyNodes = 8,
	AttackAll = 4,
	RestoreLife = 1
}
var_0_0.TriggerTimingType = {
	Interact = 1,
	Active = 3,
	InteractTimes = 4,
	Death = 2
}
var_0_0.TriggerRangeType = {
	All = 4,
	SquareLength = 3,
	RhombusLength = 2,
	MainRole = 0,
	TargetNode = 1
}
var_0_0.ItemDragType = {
	CanMove = 1,
	NoMove = 0
}
var_0_0.ItemPlaceType = {
	AllEnemy = 0,
	AllNode = 1
}
var_0_0.ResultTipType = {
	Quit = 2,
	Restart = 1,
	None = 0
}
var_0_0.OnLineOffsetX = -50
var_0_0.OnLineOffsetY = 38
var_0_0.UnlockEventId = 10008
var_0_0.MapOffset = {
	NoOdd = {
		21,
		-24
	},
	XOdd = {
		-47,
		15
	},
	YOdd = {
		-46,
		-67
	},
	XYOdd = {
		-109,
		-25
	}
}

return var_0_0
