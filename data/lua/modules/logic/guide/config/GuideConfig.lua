module("modules.logic.guide.config.GuideConfig", package.seeall)

local var_0_0 = class("GuideConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._guideList = {}
	arg_1_0._guide2StepList = {}
	arg_1_0._stepId2AdditionStepMap = {}
	arg_1_0._triggerTypeDict = {}
	arg_1_0._triggerParamDict = {}
	arg_1_0._invalidTypeListDict = {}
	arg_1_0._invalidListDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"guide",
		"guide_step",
		"guide_mask",
		"guide_step_addition"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "guide" then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			if iter_3_1.isOnline == 1 then
				table.insert(arg_3_0._guideList, iter_3_1)

				local var_3_0 = string.split(iter_3_1.trigger, "#")

				arg_3_0._triggerTypeDict[iter_3_1.id] = var_3_0[1]
				arg_3_0._triggerParamDict[iter_3_1.id] = var_3_0[2]

				local var_3_1 = GameUtil.splitString2(iter_3_1.invalid, false, "|", "#")

				arg_3_0._invalidTypeListDict[iter_3_1.id] = {}
				arg_3_0._invalidListDict[iter_3_1.id] = {}

				if not string.nilorempty(iter_3_1.invalid) then
					for iter_3_2, iter_3_3 in ipairs(var_3_1) do
						table.insert(arg_3_0._invalidTypeListDict[iter_3_1.id], iter_3_3[1])
						table.insert(arg_3_0._invalidListDict[iter_3_1.id], iter_3_3)
					end
				end
			end
		end
	elseif arg_3_1 == "guide_step" then
		for iter_3_4, iter_3_5 in ipairs(arg_3_2.configList) do
			local var_3_2 = arg_3_0._guide2StepList[iter_3_5.id]

			if not var_3_2 then
				var_3_2 = {}
				arg_3_0._guide2StepList[iter_3_5.id] = var_3_2
			end

			table.insert(var_3_2, iter_3_5)
		end
	elseif arg_3_1 == "guide_step_addition" then
		arg_3_0._stepId2AdditionStepMap = arg_3_2.configDict
	end
end

function var_0_0.getGuideList(arg_4_0)
	return arg_4_0._guideList
end

function var_0_0.getGuideCO(arg_5_0, arg_5_1)
	return lua_guide.configDict[arg_5_1]
end

function var_0_0.getStepList(arg_6_0, arg_6_1)
	return arg_6_0._guide2StepList[arg_6_1]
end

function var_0_0.getStepCO(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = lua_guide_step.configDict[arg_7_1]

	if var_7_0 then
		return var_7_0[arg_7_2]
	else
		return arg_7_0:getAddtionStepCfg(arg_7_1, arg_7_2)
	end
end

function var_0_0.getAddtionStepCfg(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._stepId2AdditionStepMap[arg_8_1]

	if var_8_0 then
		return var_8_0[arg_8_2]
	end
end

function var_0_0.getHighestPriorityGuideId(arg_9_0, arg_9_1)
	local var_9_0
	local var_9_1

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_2 = arg_9_0:getGuideCO(iter_9_1)

		if var_9_2 and (not var_9_0 or not var_9_1 or var_9_1 < var_9_2.priority) then
			var_9_0 = iter_9_1
			var_9_1 = var_9_2.priority
		end
	end

	return var_9_0 or arg_9_1 and arg_9_1[1]
end

function var_0_0.getTriggerType(arg_10_0, arg_10_1)
	return arg_10_0._triggerTypeDict[arg_10_1]
end

function var_0_0.getTriggerParam(arg_11_0, arg_11_1)
	return arg_11_0._triggerParamDict[arg_11_1]
end

function var_0_0.getInvalidTypeList(arg_12_0, arg_12_1)
	return arg_12_0._invalidTypeListDict[arg_12_1]
end

function var_0_0.getInvalidList(arg_13_0, arg_13_1)
	return arg_13_0._invalidListDict[arg_13_1]
end

function var_0_0.getPrevStepId(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getStepList(arg_14_1)

	if var_14_0[1].stepId == arg_14_2 then
		return 0
	end

	for iter_14_0 = 2, #var_14_0 do
		if var_14_0[iter_14_0].stepId == arg_14_2 then
			return var_14_0[iter_14_0 - 1].stepId
		end
	end

	return -1
end

function var_0_0.getNextStepId(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getStepList(arg_15_1)

	if var_15_0 then
		for iter_15_0 = 1, #var_15_0 - 1 do
			if var_15_0[iter_15_0].stepId == arg_15_2 then
				return var_15_0[iter_15_0 + 1].stepId
			end
		end
	end

	return -1
end

var_0_0.instance = var_0_0.New()

return var_0_0
