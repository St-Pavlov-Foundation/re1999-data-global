module("modules.logic.room.view.building.RoomStrengthViewContainer", package.seeall)

local var_0_0 = class("RoomStrengthViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomStrengthView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
