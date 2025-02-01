module("modules.logic.versionactivity2_1.aergusi.define.AergusiEnum", package.seeall)

slot0 = _M
slot0.OperationType = {
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
slot0.ProgressState = {
	BeforeStory = 0,
	Evidence = 1,
	Finished = 3,
	AfterStory = 2
}
slot0.DialogPos = {
	Left = 1,
	Right = 2
}
slot0.DialogBubbleType = {
	Speaker = 1,
	Thought = 2
}
slot0.DialogBubblePos = {
	Left = 1,
	Right = 2
}
slot0.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
slot0.DialogType = {
	SystemMsg = 0,
	NormalRight = 2,
	NormalLeft = 1
}
slot0.DialogGroupType = {
	Interact = 2,
	Normal = 1
}
slot0.DialogItemCls = {
	[slot0.DialogType.SystemMsg] = AergusiDialogSystemMessageItem,
	[slot0.DialogType.NormalLeft] = AergusiDialogNormalLeftItem,
	[slot0.DialogType.NormalRight] = AergusiDialogNormalRightItem
}
slot0.TaskMOAllFinishId = -100
slot0.MinHeight = {
	[slot0.DialogType.NormalLeft] = 150,
	[slot0.DialogType.NormalRight] = 150,
	[slot0.DialogType.SystemMsg] = 50
}
slot0.IntervalY = 40
slot0.MessageBgOffsetWidth = 30
slot0.MessageBgOffsetHeight = 20
slot0.MessageTxtMaxWidth = 711
slot0.MessageTxtOneLineHeight = 40
slot0.MessageNameHeight = 50
slot0.DialogReferenceOffsetHeight = 40
slot0.DialogDoubtOffsetHeight = 40
slot0.LevelScrollWidth = 2800
slot0.FirstGroupId = 101
slot0.FirstGroupLastStepId = 7
slot0.FirstDialogGuideId = 21302
slot0.AdamClueId = 8

return slot0
