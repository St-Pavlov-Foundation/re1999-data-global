module("modules.logic.dialogue.defines.DialogueEnum", package.seeall)

local var_0_0 = _M

var_0_0.Type = {
	RightMessage = 2,
	LeftMessage = 1,
	Option = 4,
	JumpToGroup = 5,
	SystemMessage = 3
}
var_0_0.MinHeight = {
	[var_0_0.Type.LeftMessage] = 150,
	[var_0_0.Type.RightMessage] = 150,
	[var_0_0.Type.SystemMessage] = 50,
	[var_0_0.Type.Option] = 50
}
var_0_0.IntervalY = 26
var_0_0.MessageBgOffsetWidth = 30
var_0_0.MessageBgOffsetHeight = 20
var_0_0.MessageTxtMaxWidth = 711
var_0_0.MessageTxtOneLineHeight = 40
var_0_0.MessageNameHeight = 50
var_0_0.DialogueItemCls = {
	[var_0_0.Type.LeftMessage] = DialogueNormalItem,
	[var_0_0.Type.RightMessage] = DialogueNormalItem,
	[var_0_0.Type.SystemMessage] = DialogueSystemMessageItem,
	[var_0_0.Type.Option] = DialogueOptionItem
}
var_0_0.OnDialogueDoneWaitTime = 1.5

return var_0_0
