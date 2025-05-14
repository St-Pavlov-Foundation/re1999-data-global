module("modules.logic.versionactivity2_1.aergusi.define.AergusiEnum", package.seeall)

local var_0_0 = _M

var_0_0.OperationType = {
	Probe = 2,
	GetClue = 6,
	Tip = 101,
	Merge = 103,
	Submit = 1,
	Refutation = 3,
	NextDialogs = 5,
	EndEpisode = 4,
	NotKeyProbe = 8,
	AutoBubble = 7,
	New = 102
}
var_0_0.ProgressState = {
	BeforeStory = 0,
	Evidence = 1,
	Finished = 3,
	AfterStory = 2
}
var_0_0.DialogPos = {
	Left = 1,
	Right = 2
}
var_0_0.DialogBubbleType = {
	Speaker = 1,
	Thought = 2
}
var_0_0.DialogBubblePos = {
	Left = 1,
	Right = 2
}
var_0_0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
var_0_0.DialogType = {
	SystemMsg = 0,
	NormalRight = 2,
	NormalLeft = 1
}
var_0_0.DialogGroupType = {
	Interact = 2,
	Normal = 1
}
var_0_0.DialogItemCls = {
	[var_0_0.DialogType.SystemMsg] = AergusiDialogSystemMessageItem,
	[var_0_0.DialogType.NormalLeft] = AergusiDialogNormalLeftItem,
	[var_0_0.DialogType.NormalRight] = AergusiDialogNormalRightItem
}
var_0_0.TaskMOAllFinishId = -100
var_0_0.MinHeight = {
	[var_0_0.DialogType.NormalLeft] = 150,
	[var_0_0.DialogType.NormalRight] = 150,
	[var_0_0.DialogType.SystemMsg] = 50
}
var_0_0.IntervalY = 40
var_0_0.MessageBgOffsetWidth = 30
var_0_0.MessageBgOffsetHeight = 20
var_0_0.MessageTxtMaxWidth = 711
var_0_0.MessageTxtOneLineHeight = 40
var_0_0.MessageNameHeight = 50
var_0_0.DialogReferenceOffsetHeight = 40
var_0_0.DialogDoubtOffsetHeight = 40
var_0_0.LevelScrollWidth = 2800
var_0_0.FirstGroupId = 101
var_0_0.FirstGroupLastStepId = 7
var_0_0.FirstDialogGuideId = 21302
var_0_0.AdamClueId = 8

return var_0_0
