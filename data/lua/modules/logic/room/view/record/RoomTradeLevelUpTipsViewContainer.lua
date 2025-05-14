module("modules.logic.room.view.record.RoomTradeLevelUpTipsViewContainer", package.seeall)

local var_0_0 = class("RoomTradeLevelUpTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomTradeLevelUpTipsView.New())

	return var_1_0
end

return var_0_0
