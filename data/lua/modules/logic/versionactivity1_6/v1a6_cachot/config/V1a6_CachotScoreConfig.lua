module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotScoreConfig", package.seeall)

local var_0_0 = class("V1a6_CachotScoreConfig")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._scroeConfigTable = arg_1_1
end

function var_0_0.getConfigList(arg_2_0)
	return arg_2_0._scroeConfigTable.configList
end

function var_0_0.getStagePartRange(arg_3_0, arg_3_1)
	if arg_3_0._scroeConfigTable.configDict then
		local var_3_0
		local var_3_1
		local var_3_2
		local var_3_3

		for iter_3_0, iter_3_1 in pairs(arg_3_0._scroeConfigTable.configDict) do
			if arg_3_1 <= iter_3_1.score and (not var_3_0 or var_3_0 >= iter_3_1.score) then
				var_3_0 = iter_3_1.score
				var_3_3 = iter_3_0
			end

			if arg_3_1 > iter_3_1.score and (not var_3_1 or var_3_1 < iter_3_1.score) then
				var_3_1 = iter_3_1.score
				var_3_2 = iter_3_0
			end
		end

		return var_3_2, var_3_3
	end
end

function var_0_0.getStagePartConfig(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._scroeConfigTable and arg_4_0._scroeConfigTable.configDict

	if var_4_0 then
		return var_4_0[arg_4_1]
	end
end

function var_0_0.getStagePartScore(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._scroeConfigTable and arg_5_0._scroeConfigTable.configDict

	if var_5_0 and var_5_0[arg_5_1] then
		return var_5_0[arg_5_1].score
	end

	return 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
