module("modules.logic.room.view.RoomLevelUpViewContainer", package.seeall)

slot0 = class("RoomLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLevelUpView.New())
	table.insert(slot1, RoomViewTopRight.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(ViewName.RoomLevelUpView, nil, true)
end

return slot0
