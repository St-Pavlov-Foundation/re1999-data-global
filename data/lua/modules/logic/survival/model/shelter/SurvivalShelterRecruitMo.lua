module("modules.logic.survival.model.shelter.SurvivalShelterRecruitMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterRecruitMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.config = lua_survival_recruit.configDict[arg_1_1.id]
	arg_1_0.tags = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.tags) do
		table.insert(arg_1_0.tags, iter_1_1)
	end

	arg_1_0.selectCount = arg_1_0.config and arg_1_0.config.chooseNum or 0
	arg_1_0.selectedTags = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.selectedTags) do
		table.insert(arg_1_0.selectedTags, iter_1_3)
	end

	arg_1_0.canRefreshTimes = arg_1_1.canRefreshTimes
	arg_1_0.goodList = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.good) do
		local var_1_0 = {
			id = iter_1_5.id,
			npcId = iter_1_5.npcId
		}

		table.insert(arg_1_0.goodList, var_1_0)
	end
end

function var_0_0.isInRecruit(arg_2_0)
	return next(arg_2_0.selectedTags) ~= nil and next(arg_2_0.goodList) == nil
end

function var_0_0.isCanRecruit(arg_3_0)
	return next(arg_3_0.selectedTags) == nil and next(arg_3_0.goodList) == nil
end

function var_0_0.isCanSelectNpc(arg_4_0)
	return next(arg_4_0.goodList) ~= nil
end

return var_0_0
