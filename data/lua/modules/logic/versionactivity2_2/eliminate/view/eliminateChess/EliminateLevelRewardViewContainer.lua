module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelRewardViewContainer", package.seeall)

local var_0_0 = class("EliminateLevelRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, EliminateLevelRewardView.New())

	return var_1_0
end

return var_0_0
