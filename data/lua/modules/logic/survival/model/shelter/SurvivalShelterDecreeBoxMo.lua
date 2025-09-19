module("modules.logic.survival.model.shelter.SurvivalShelterDecreeBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterDecreeBoxMo")

function var_0_0.init(arg_1_0)
	arg_1_0.decrees = {}
end

function var_0_0.updateDecreeInfos(arg_2_0, arg_2_1)
	arg_2_0.decrees = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0:updateDecreeInfo(iter_2_1)
	end
end

function var_0_0.updateDecreeInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getDecreeInfo(arg_3_1.no)

	if not var_3_0 then
		var_3_0 = SurvivalShelterDecreeMo.New()

		var_3_0:init(arg_3_1.no, arg_3_0)

		arg_3_0.decrees[arg_3_1.no] = var_3_0
	end

	var_3_0:updateInfo(arg_3_1)
end

function var_0_0.getDecreeInfo(arg_4_0, arg_4_1)
	return arg_4_0.decrees[arg_4_1]
end

function var_0_0.isFinish(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getDecreeInfo(arg_5_1)

	if not var_5_0 then
		return false
	end

	if var_5_0:isFinish() then
		return true
	end

	local var_5_1 = arg_5_1 + 1
	local var_5_2 = arg_5_0:getDecreeInfo(var_5_1)

	if not var_5_2 then
		return false
	end

	if not var_5_2:isCurPolicyEmpty() then
		return true
	end

	return false
end

function var_0_0.isCurAllPolicyNotFinish(arg_6_0)
	local var_6_0 = false
	local var_6_1 = #arg_6_0.decrees

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.decrees) do
		if not arg_6_0:isFinish(iter_6_1.id) then
			var_6_0 = iter_6_1:isAllPolicyNotFinish()
			var_6_1 = iter_6_0

			break
		end
	end

	return var_6_0, var_6_1
end

function var_0_0.getCurPolicyNeedTags(arg_7_0)
	if not arg_7_0.decrees then
		return {}
	end

	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.decrees) do
		if not arg_7_0:isFinish(iter_7_1.id) then
			var_7_0 = iter_7_0

			break
		end
	end

	if not var_7_0 then
		return {}
	end

	return arg_7_0:getDecreeInfo(var_7_0):getCurPolicyNeedTags()
end

return var_0_0
