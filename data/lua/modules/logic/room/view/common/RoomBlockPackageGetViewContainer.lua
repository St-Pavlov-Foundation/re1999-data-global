module("modules.logic.room.view.common.RoomBlockPackageGetViewContainer", package.seeall)

local var_0_0 = class("RoomBlockPackageGetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomBlockPackageGetView.New())

	return var_1_0
end

return var_0_0
