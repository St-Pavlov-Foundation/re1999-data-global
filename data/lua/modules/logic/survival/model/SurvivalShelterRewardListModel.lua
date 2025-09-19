module("modules.logic.survival.model.SurvivalShelterRewardListModel", package.seeall)

local var_0_0 = class("SurvivalShelterRewardListModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0)
	local var_1_0 = SurvivalConfig.instance:getRewardList() or {}

	if #var_1_0 > 1 then
		table.sort(var_1_0, SortUtil.keyLower("score"))
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
