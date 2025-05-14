module("modules.logic.room.view.debug.RoomDebugEntranceViewContainer", package.seeall)

local var_0_0 = class("RoomDebugEntranceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomDebugEntranceView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	if RoomController.instance:isEditorMode() then
		return
	end

	arg_2_0:closeThis()
end

return var_0_0
