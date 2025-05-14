module("modules.logic.herogroup.model.HeroGroupRecommendGroupListModel", package.seeall)

local var_0_0 = class("HeroGroupRecommendGroupListModel", ListScrollModel)

function var_0_0.setGroupList(arg_1_0, arg_1_1)
	arg_1_0:setCurrentShowRecommendGroupMoId(arg_1_1)

	local var_1_0 = arg_1_1.heroRecommendInfos
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_2 = HeroGroupRecommendGroupMO.New()

		var_1_2:init(iter_1_1)
		table.insert(var_1_1, var_1_2)
	end

	table.sort(var_1_1, function(arg_2_0, arg_2_1)
		return arg_2_0.rate > arg_2_1.rate
	end)

	for iter_1_2 = #var_1_0 + 1, 5 do
		local var_1_3 = HeroGroupRecommendGroupMO.New()

		var_1_3:init()
		table.insert(var_1_1, var_1_3)
	end

	arg_1_0:setList(var_1_1)
end

function var_0_0.setCurrentShowRecommendGroupMoId(arg_3_0, arg_3_1)
	arg_3_0.showGroupId = arg_3_1.id
end

function var_0_0.isShowSampleMo(arg_4_0, arg_4_1)
	return arg_4_0.showGroupId == arg_4_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
