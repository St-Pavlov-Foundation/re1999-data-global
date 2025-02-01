module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpViewContainer", package.seeall)

slot0 = class("VersionActivity1_7WarmUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_7WarmUpView.New(),
		VersionActivity1_7WarmUpMapView.New()
	}
end

function slot0.isPlayingDesc(slot0)
	return slot0._isPlayingDesc
end

function slot0.setIsPlayingDesc(slot0, slot1)
	slot0._isPlayingDesc = slot1
end

return slot0
