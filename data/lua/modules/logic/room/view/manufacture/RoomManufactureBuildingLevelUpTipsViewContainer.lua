module("modules.logic.room.view.manufacture.RoomManufactureBuildingLevelUpTipsViewContainer", package.seeall)

local var_0_0 = class("RoomManufactureBuildingLevelUpTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomManufactureBuildingLevelUpTipsView.New())

	return var_1_0
end

return var_0_0
