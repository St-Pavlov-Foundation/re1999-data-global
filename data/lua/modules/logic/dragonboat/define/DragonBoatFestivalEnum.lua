module("modules.logic.dragonboat.define.DragonBoatFestivalEnum", package.seeall)

local var_0_0 = _M

var_0_0.PuzzleState = {
	Lock = 0,
	RewardGet = 4,
	Answering = 2,
	UnAnswer = 1,
	Solved = 3
}
var_0_0.OptionState = {
	UnAnswer = 0,
	Wrong = 1,
	Right = 2
}

return var_0_0
