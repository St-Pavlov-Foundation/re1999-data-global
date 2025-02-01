module("modules.logic.versionactivity1_2.yaxian.view.YaXianFindToothViewContainer", package.seeall)

slot0 = class("YaXianFindToothViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, YaXianFindToothView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
end

function slot0.onContainerInit(slot0)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_multiple)
end

return slot0
