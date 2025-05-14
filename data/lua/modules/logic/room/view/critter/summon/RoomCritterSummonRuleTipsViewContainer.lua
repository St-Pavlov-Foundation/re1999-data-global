module("modules.logic.room.view.critter.summon.RoomCritterSummonRuleTipsViewContainer", package.seeall)

local var_0_0 = class("RoomCritterSummonRuleTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterSummonRuleTipsView.New())

	return var_1_0
end

return var_0_0
