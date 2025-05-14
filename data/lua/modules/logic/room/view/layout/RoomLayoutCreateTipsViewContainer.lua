module("modules.logic.room.view.layout.RoomLayoutCreateTipsViewContainer", package.seeall)

local var_0_0 = class("RoomLayoutCreateTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomLayoutCreateTipsView.New())

	return var_1_0
end

return var_0_0
