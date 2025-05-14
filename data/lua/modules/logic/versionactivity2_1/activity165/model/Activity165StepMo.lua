module("modules.logic.versionactivity2_1.activity165.model.Activity165StepMo", package.seeall)

local var_0_0 = class("Activity165StepMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0._actId = nil
	arg_1_0.stepId = nil
	arg_1_0.stepCo = nil
	arg_1_0.isEndingStep = nil
	arg_1_0.isFirstStep = nil
	arg_1_0.nextSteps = nil
	arg_1_0.lastSteps = nil
	arg_1_0.roundSteps = nil
	arg_1_0.isUnlock = nil
	arg_1_0.isFixStep = nil
	arg_1_0.canUseKeywordMos = nil
end

function var_0_0.onInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._actId = arg_2_1
	arg_2_0.stepId = arg_2_2
	arg_2_0.stepCo = Activity165Config.instance:getStepCo(arg_2_1, arg_2_2)
	arg_2_0.nextSteps = {}

	if not string.nilorempty(arg_2_0.stepCo.answersKeywordIds) then
		arg_2_0.isEndingStep = arg_2_0.stepCo.answersKeywordIds == "-1"

		if not arg_2_0.isEndingStep then
			local var_2_0 = GameUtil.splitString2(arg_2_0.stepCo.answersKeywordIds, "#", "|")

			for iter_2_0, iter_2_1 in pairs(var_2_0) do
				if LuaUtil.tableNotEmpty(iter_2_1) then
					local var_2_1 = iter_2_1[1]
					local var_2_2 = arg_2_0.nextSteps[var_2_1] or {
						nextId = var_2_1
					}
					local var_2_3 = var_2_2.needKws or {}
					local var_2_4 = {}

					for iter_2_2 = 2, #iter_2_1 do
						table.insert(var_2_4, iter_2_1[iter_2_2])
					end

					table.insert(var_2_3, var_2_4)

					var_2_2.needKws = var_2_3
					arg_2_0.nextSteps[var_2_1] = var_2_2
				end
			end
		end
	end

	arg_2_0.lastSteps = {}
	arg_2_0.roundSteps = {}

	if not string.nilorempty(arg_2_0.stepCo.nextStepConditionIds) then
		local var_2_5 = GameUtil.splitString2(arg_2_0.stepCo.nextStepConditionIds, "#", "|")

		for iter_2_3, iter_2_4 in pairs(var_2_5) do
			if LuaUtil.tableNotEmpty(iter_2_4) then
				local var_2_6 = {}

				for iter_2_5 = 2, #iter_2_4 do
					table.insert(var_2_6, iter_2_4[iter_2_5])
				end

				if LuaUtil.tableNotEmpty(var_2_6) then
					table.insert(arg_2_0.lastSteps, var_2_6)
				end

				local var_2_7 = tabletool.copy(var_2_6)

				table.insert(var_2_7, arg_2_0.stepId)
				table.insert(var_2_7, iter_2_4[1])
				table.insert(arg_2_0.roundSteps, var_2_7)
			end
		end
	end

	arg_2_0.isUnlock = false
	arg_2_0.canUseKeywordMos = {}

	if not string.nilorempty(arg_2_0.stepCo.optionalKeywordIds) then
		local var_2_8 = string.splitToNumber(arg_2_0.stepCo.optionalKeywordIds, "#")

		for iter_2_6, iter_2_7 in pairs(var_2_8) do
			local var_2_9 = arg_2_3:getKeywordMo(iter_2_7)

			table.insert(arg_2_0.canUseKeywordMos, var_2_9)
		end
	end
end

function var_0_0.setCanUseKeywords(arg_3_0)
	return
end

function var_0_0.isSameTableValue(arg_4_0, arg_4_1, arg_4_2)
	if LuaUtil.tableNotEmpty(arg_4_1) and LuaUtil.tableNotEmpty(arg_4_2) then
		if tabletool.len(arg_4_1) ~= tabletool.len(arg_4_2) then
			return false
		end

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			if not LuaUtil.tableContains(arg_4_2, iter_4_1) then
				return false
			end
		end

		return true
	end
end

function var_0_0.onReset(arg_5_0)
	arg_5_0.isUnlock = nil
	arg_5_0.isFixStep = nil
end

function var_0_0.getNextStep(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.nextSteps) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1.needKws) do
			if arg_6_0:isSameTableValue(iter_6_3, arg_6_1) then
				return iter_6_1.nextId
			end
		end
	end
end

function var_0_0.getNextStepKeyword(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.nextSteps) do
		if iter_7_1.nextId == arg_7_1 then
			local var_7_0, var_7_1 = next(iter_7_1.needKws)

			return var_7_1
		end
	end
end

function var_0_0.setUnlock(arg_8_0, arg_8_1)
	arg_8_0.isUnlock = arg_8_1
end

function var_0_0.getCanEndingRound(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.roundSteps) do
		local var_9_1 = iter_9_1[#iter_9_1]

		if LuaUtil.tableContains(arg_9_1, var_9_1) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.getCanUseKeywords(arg_10_0)
	return arg_10_0.canUseKeywordMos
end

return var_0_0
