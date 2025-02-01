module("modules.logic.room.view.RoomTipsViewContainer", package.seeall)

slot0 = class("RoomTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		RoomTipsView.New()
	}
end

return slot0
