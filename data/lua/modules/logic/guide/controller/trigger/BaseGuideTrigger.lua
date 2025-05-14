module("modules.logic.guide.controller.trigger.BaseGuideTrigger", package.seeall)

local var_0_0 = class("BaseGuideTrigger")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._triggerKey = arg_1_1
	arg_1_0._guideIdList = nil
	arg_1_0._canTrigger = false
end

function var_0_0.onReset(arg_2_0)
	arg_2_0._canTrigger = false
end

function var_0_0.setCanTrigger(arg_3_0, arg_3_1)
	arg_3_0._canTrigger = arg_3_1
end

function var_0_0.assertGuideSatisfy(arg_4_0, arg_4_1, arg_4_2)
	return false
end

function var_0_0.getParam(arg_5_0)
	return nil
end

function var_0_0.hasSatisfyGuide(arg_6_0)
	arg_6_0:_classifyGuide()

	local var_6_0 = arg_6_0._guideIdList and #arg_6_0._guideIdList or 0

	for iter_6_0 = 1, var_6_0 do
		local var_6_1 = arg_6_0._guideIdList[iter_6_0]
		local var_6_2 = GuideModel.instance:getById(var_6_1)
		local var_6_3 = GuideConfig.instance:getGuideCO(var_6_1)

		if (var_6_2 == nil or var_6_2.isFinish and var_6_3.restart == 1) and not GuideInvalidController.instance:isInvalid(var_6_1) then
			local var_6_4 = GuideConfig.instance:getTriggerParam(var_6_1)

			if var_6_3.parallel ~= 1 and arg_6_0:assertGuideSatisfy(arg_6_0:getParam(), var_6_4) then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkStartGuide(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._canTrigger then
		return
	end

	if arg_7_2 then
		arg_7_0:_checkStartOneGuide(arg_7_1, arg_7_2)
	else
		arg_7_0:_classifyGuide()

		for iter_7_0 = 1, #arg_7_0._guideIdList do
			local var_7_0 = arg_7_0._guideIdList[iter_7_0]

			arg_7_0:_checkStartOneGuide(arg_7_1, var_7_0)
		end
	end
end

function var_0_0._checkStartOneGuide(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = GuideModel.instance:getById(arg_8_2)
	local var_8_1 = GuideConfig.instance:getGuideCO(arg_8_2)

	if var_8_0 == nil or var_8_0.isFinish and var_8_1.restart == 1 then
		local var_8_2 = GuideConfig.instance:getTriggerParam(arg_8_2)

		if not GuideInvalidController.instance:isInvalid(arg_8_2) and arg_8_0:assertGuideSatisfy(arg_8_1, var_8_2) then
			if var_8_1.parallel == 1 then
				GuideController.instance:startGudie(arg_8_2)
			elseif GuideModel.instance:getDoingGuideId() == nil then
				GuideController.instance:toStartGudie(arg_8_2)
			end
		end
	end
end

function var_0_0._classifyGuide(arg_9_0)
	if arg_9_0._guideIdList == nil then
		arg_9_0._guideIdList = {}

		local var_9_0 = GuideConfig.instance:getGuideList()

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			if GuideConfig.instance:getTriggerType(iter_9_1.id) == arg_9_0._triggerKey then
				table.insert(arg_9_0._guideIdList, iter_9_1.id)
			end
		end
	end
end

return var_0_0
