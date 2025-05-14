module("modules.logic.room.view.RoomOpenGuideViewContainer", package.seeall)

local var_0_0 = class("RoomOpenGuideViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomOpenGuideView.New())

	return var_1_0
end

return var_0_0
