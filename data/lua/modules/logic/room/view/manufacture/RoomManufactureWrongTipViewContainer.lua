module("modules.logic.room.view.manufacture.RoomManufactureWrongTipViewContainer", package.seeall)

local var_0_0 = class("RoomManufactureWrongTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomManufactureWrongTipView.New())

	return var_1_0
end

return var_0_0
