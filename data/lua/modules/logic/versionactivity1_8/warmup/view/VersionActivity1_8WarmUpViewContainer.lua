module("modules.logic.versionactivity1_8.warmup.view.VersionActivity1_8WarmUpViewContainer", package.seeall)

slot0 = class("VersionActivity1_8WarmUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_8WarmUpView.New(),
		Act1_8WarmUpLeftView.New()
	}
end

function slot0.isPlayingDesc(slot0)
	return slot0._isPlayingDesc
end

function slot0.setIsPlayingDesc(slot0, slot1)
	slot0._isPlayingDesc = slot1
end

return slot0
