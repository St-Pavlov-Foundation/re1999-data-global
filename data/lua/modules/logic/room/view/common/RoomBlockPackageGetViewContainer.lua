module("modules.logic.room.view.common.RoomBlockPackageGetViewContainer", package.seeall)

slot0 = class("RoomBlockPackageGetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomBlockPackageGetView.New())

	return slot1
end

return slot0
