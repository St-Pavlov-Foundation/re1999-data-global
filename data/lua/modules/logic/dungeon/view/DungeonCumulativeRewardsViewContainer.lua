module("modules.logic.dungeon.view.DungeonCumulativeRewardsViewContainer", package.seeall)

local var_0_0 = class("DungeonCumulativeRewardsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, DungeonCumulativeRewardsView.New())

	return var_1_0
end

return var_0_0
