module("modules.logic.versionactivity1_4.act132.model.Activity132CollectMo", package.seeall)

local var_0_0 = class("Activity132CollectMo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.collectId = arg_1_1.collectId
	arg_1_0.name = arg_1_1.name
	arg_1_0.bg = arg_1_1.bg
	arg_1_0.nameEn = arg_1_1.nameEn
	arg_1_0.clueDict = {}

	local var_1_0 = string.splitToNumber(arg_1_1.clues, "#")

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = arg_1_0.clueDict[iter_1_1]
		local var_1_2 = Activity132Config.instance:getClueConfig(arg_1_0.activityId, iter_1_1)

		if not var_1_1 and var_1_2 then
			local var_1_3 = Activity132ClueMo.New(var_1_2)

			arg_1_0.clueDict[iter_1_1] = var_1_3
		end
	end

	arg_1_0._cfg = arg_1_1
end

function var_0_0.getClueList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.clueDict) do
		table.insert(var_2_0, iter_2_1)
	end

	if #var_2_0 > 1 then
		table.sort(var_2_0, SortUtil.keyLower("clueId"))
	end

	return var_2_0
end

function var_0_0.getClueMo(arg_3_0, arg_3_1)
	return arg_3_0.clueDict[arg_3_1]
end

function var_0_0.getName(arg_4_0)
	return arg_4_0._cfg.name
end

return var_0_0
