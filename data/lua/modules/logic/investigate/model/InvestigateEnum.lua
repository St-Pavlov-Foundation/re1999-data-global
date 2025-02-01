module("modules.logic.investigate.model.InvestigateEnum", package.seeall)

slot0 = _M
slot0.OpinionStatus = {
	Locked = 1,
	Linked = 4,
	Unlinked = 2,
	UnlinkedExtend = 3,
	LinkedExtend = 5
}
slot0.OpinionTab = {
	Extend = 2,
	Normal = 1
}
slot0.OnceActionType = {
	ReddotClue = 4,
	StoryBtn = 3,
	InfoUnlock = 1,
	ClueUnlock = 2
}
slot0.ExtendAnimName = {
	Right = "right",
	Middle = "middle",
	Left = "left"
}

return slot0
