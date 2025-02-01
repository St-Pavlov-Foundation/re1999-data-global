module("modules.logic.room.view.debug.RoomDebugSelectPackageViewContainer", package.seeall)

slot0 = class("RoomDebugSelectPackageViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomDebugSelectPackageView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
