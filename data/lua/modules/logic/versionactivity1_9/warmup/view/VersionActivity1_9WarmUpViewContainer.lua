module("modules.logic.versionactivity1_9.warmup.view.VersionActivity1_9WarmUpViewContainer", package.seeall)

slot0 = class("VersionActivity1_9WarmUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity1_9WarmUpView.New())

	return slot1
end

function slot0.isPlayingDesc(slot0)
	return slot0._isPlayingDesc
end

function slot0.setIsPlayingDesc(slot0, slot1)
	slot0._isPlayingDesc = slot1
end

return slot0
