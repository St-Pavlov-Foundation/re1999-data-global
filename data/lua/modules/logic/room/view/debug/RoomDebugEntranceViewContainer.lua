module("modules.logic.room.view.debug.RoomDebugEntranceViewContainer", package.seeall)

slot0 = class("RoomDebugEntranceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomDebugEntranceView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	if RoomController.instance:isEditorMode() then
		return
	end

	slot0:closeThis()
end

return slot0
