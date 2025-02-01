module("modules.logic.versionactivity.view.VersionActivityVideoViewContainer", package.seeall)

slot0 = class("VersionActivityVideoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityVideoView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
