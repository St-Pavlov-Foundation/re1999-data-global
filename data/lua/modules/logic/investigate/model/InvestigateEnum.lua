module("modules.logic.investigate.model.InvestigateEnum", package.seeall)

local var_0_0 = _M

var_0_0.OpinionStatus = {
	Locked = 1,
	Linked = 4,
	Unlinked = 2,
	UnlinkedExtend = 3,
	LinkedExtend = 5
}
var_0_0.OpinionTab = {
	Extend = 2,
	Normal = 1
}
var_0_0.OnceActionType = {
	ReddotClue = 4,
	StoryBtn = 3,
	InfoUnlock = 1,
	ClueUnlock = 2
}
var_0_0.ExtendAnimName = {
	Right = "right",
	Middle = "middle",
	Left = "left"
}

return var_0_0
