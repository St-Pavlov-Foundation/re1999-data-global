module("modules.logic.versionactivity.view.VersionActivityTipsViewContainer", package.seeall)

slot0 = class("VersionActivityTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityTipsView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
