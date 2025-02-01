module("modules.logic.room.view.RoomLevelUpTipsViewContainer", package.seeall)

slot0 = class("RoomLevelUpTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLevelUpTipsView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
