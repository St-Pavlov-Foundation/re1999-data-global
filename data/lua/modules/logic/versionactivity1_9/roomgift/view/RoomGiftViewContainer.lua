module("modules.logic.versionactivity1_9.roomgift.view.RoomGiftViewContainer", package.seeall)

local var_0_0 = class("RoomGiftViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomGiftView.New())

	return var_1_0
end

return var_0_0
