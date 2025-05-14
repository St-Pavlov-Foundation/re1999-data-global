module("modules.logic.critter.view.RoomCritterFilterViewContainer", package.seeall)

local var_0_0 = class("RoomCritterFilterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterFilterView.New())

	return var_1_0
end

return var_0_0
