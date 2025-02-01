module("modules.logic.room.view.RoomCharacterPlaceInfoViewContainer", package.seeall)

slot0 = class("RoomCharacterPlaceInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCharacterPlaceInfoView.New())

	return slot1
end

return slot0
