module("modules.logic.room.view.record.RoomTradeLevelUpTipsViewContainer", package.seeall)

slot0 = class("RoomTradeLevelUpTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomTradeLevelUpTipsView.New())

	return slot1
end

return slot0
