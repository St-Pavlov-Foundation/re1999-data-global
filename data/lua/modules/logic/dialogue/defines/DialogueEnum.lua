module("modules.logic.dialogue.defines.DialogueEnum", package.seeall)

slot0 = _M
slot0.Type = {
	RightMessage = 2,
	LeftMessage = 1,
	Option = 4,
	JumpToGroup = 5,
	SystemMessage = 3
}
slot0.MinHeight = {
	[slot0.Type.LeftMessage] = 150,
	[slot0.Type.RightMessage] = 150,
	[slot0.Type.SystemMessage] = 50,
	[slot0.Type.Option] = 50
}
slot0.IntervalY = 26
slot0.MessageBgOffsetWidth = 30
slot0.MessageBgOffsetHeight = 20
slot0.MessageTxtMaxWidth = 711
slot0.MessageTxtOneLineHeight = 40
slot0.MessageNameHeight = 50
slot0.DialogueItemCls = {
	[slot0.Type.LeftMessage] = DialogueNormalItem,
	[slot0.Type.RightMessage] = DialogueNormalItem,
	[slot0.Type.SystemMessage] = DialogueSystemMessageItem,
	[slot0.Type.Option] = DialogueOptionItem
}
slot0.OnDialogueDoneWaitTime = 1.5

return slot0
