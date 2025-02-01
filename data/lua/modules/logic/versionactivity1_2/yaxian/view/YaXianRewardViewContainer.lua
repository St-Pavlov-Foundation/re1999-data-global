module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardViewContainer", package.seeall)

slot0 = class("YaXianRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, YaXianRewardView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
end

function slot0.onContainerInit(slot0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)
end

return slot0
