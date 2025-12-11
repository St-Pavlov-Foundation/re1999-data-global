module("modules.logic.roomfishing.view.RoomFishingRewardViewContainer", package.seeall)

local var_0_0 = class("RoomFishingRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomFishingRewardView.New())

	return var_1_0
end

return var_0_0
