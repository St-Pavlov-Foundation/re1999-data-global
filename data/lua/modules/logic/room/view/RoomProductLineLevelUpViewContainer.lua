module("modules.logic.room.view.RoomProductLineLevelUpViewContainer", package.seeall)

slot0 = class("RoomProductLineLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomProductLineLevelUpView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(ViewName.RoomProductLineLevelUpView, nil, true)
end

return slot0
