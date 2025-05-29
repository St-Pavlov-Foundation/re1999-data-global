module("modules.logic.weekwalk_2.define.WeekWalk_2Enum", package.seeall)

local var_0_0 = _M

var_0_0.episodeId = 2600101
var_0_0.MaxLayer = 4
var_0_0.MaxStar = 3
var_0_0.FirstDeepLayer = 1
var_0_0.LayerStatus = {
	Pass = 2,
	UnLock = 0,
	Lock = 1
}
var_0_0.BattleIndex = {
	Second = 2,
	First = 1
}
var_0_0.TaskType = {
	Season = 6,
	Month = 5,
	Once = 3
}
var_0_0.BattleStatus = {
	Finished = 1,
	UnFinished = 0
}
var_0_0.CupType = {
	None2 = 5,
	Platinum = 4,
	Copper = 1,
	Gold = 3,
	Silver = 2,
	None = 0
}
var_0_0.LineValue = {
	1,
	0.7,
	0.3,
	0
}
var_0_0.OnceAnimType = {
	FightBuffNew = 5,
	RuleNew = 2,
	BuffNew = 3,
	ResultReview = 4,
	UnlockEpisode = 1
}
var_0_0.ResultAnimIndex = {
	Defence = 3,
	Attack = 1,
	Health = 2,
	CupData = 5,
	RoleData = 4
}

return var_0_0
