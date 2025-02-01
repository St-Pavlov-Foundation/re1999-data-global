module("modules.logic.versionactivity1_4.act136.view.Activity136ViewContainer", package.seeall)

slot0 = class("Activity136ViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Activity136View.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
