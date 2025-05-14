module("modules.logic.room.view.critter.train.RoomCritterTrainEventResultViewContainer", package.seeall)

local var_0_0 = class("RoomCritterTrainEventResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterTrainEventResultView.New())

	return var_1_0
end

return var_0_0
