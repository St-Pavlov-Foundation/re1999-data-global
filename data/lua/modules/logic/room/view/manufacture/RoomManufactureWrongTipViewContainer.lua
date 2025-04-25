module("modules.logic.room.view.manufacture.RoomManufactureWrongTipViewContainer", package.seeall)

slot0 = class("RoomManufactureWrongTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomManufactureWrongTipView.New())

	return slot1
end

return slot0
