module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetViewContainer", package.seeall)

slot0 = class("Activity114MeetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Activity114MeetView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
