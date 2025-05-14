module("modules.logic.guide.model.GuideMO", package.seeall)

local var_0_0 = pureTable("GuideMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.serverStepId = -1
	arg_1_0.clientStepId = -1
	arg_1_0.currGuideId = -1
	arg_1_0.currStepId = -1
	arg_1_0.isFinish = false
	arg_1_0.isExceptionFinish = false
	arg_1_0.isJumpPass = false
	arg_1_0.targetStepId = nil
	arg_1_0._againStepCOs = nil
end

function var_0_0.getCurStepCO(arg_2_0)
	return (GuideConfig.instance:getStepCO(arg_2_0.currGuideId, arg_2_0.currStepId))
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.guideId
	arg_3_0.serverStepId = arg_3_1.stepId or 0
	arg_3_0.clientStepId = arg_3_1.stepId or 0

	arg_3_0:_setCurrStep()

	arg_3_0.isFinish = arg_3_0.serverStepId == -1

	local var_3_0 = GuideConfig.instance:getStepCO(arg_3_0.id, arg_3_0.currStepId)

	if var_3_0 ~= nil and string.nilorempty(var_3_0.againSteps) == false then
		arg_3_0._againStepCOs = {}

		local var_3_1 = GameUtil.splitString2(var_3_0.againSteps, true, "|", "#")

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			local var_3_2 = #iter_3_1 == 1 and arg_3_0.id or iter_3_1[1]
			local var_3_3 = #iter_3_1 == 1 and iter_3_1[1] or iter_3_1[2]
			local var_3_4 = GuideConfig.instance:getStepCO(var_3_2, var_3_3)

			if var_3_4 then
				table.insert(arg_3_0._againStepCOs, var_3_4)
			else
				logError("againSteps invalid: guide_" .. arg_3_0.id .. "_" .. var_3_0.stepId)
			end
		end

		if #arg_3_0._againStepCOs > 0 then
			arg_3_0.currGuideId = arg_3_0._againStepCOs[1].id
			arg_3_0.currStepId = arg_3_0._againStepCOs[1].stepId

			table.remove(arg_3_0._againStepCOs, 1)
		end
	end
end

function var_0_0.exceptionFinishGuide(arg_4_0)
	arg_4_0.serverStepId = -1
	arg_4_0.clientStepId = -1
	arg_4_0.currGuideId = -1
	arg_4_0.currStepId = -1
	arg_4_0.isFinish = true
	arg_4_0.isExceptionFinish = true
end

function var_0_0.updateGuide(arg_5_0, arg_5_1)
	arg_5_0._againStepCOs = nil
	arg_5_0.id = arg_5_1.guideId
	arg_5_0.serverStepId = arg_5_1.stepId

	if arg_5_0.targetStepId then
		arg_5_0.clientStepId = GuideConfig.instance:getPrevStepId(arg_5_0.id, arg_5_0.targetStepId)
		arg_5_0.targetStepId = nil
	elseif arg_5_0.isJumpPass then
		arg_5_0.clientStepId = -1
	elseif arg_5_1.stepId ~= -1 then
		arg_5_0.clientStepId = arg_5_1.stepId
	else
		local var_5_0 = -1
		local var_5_1 = GuideConfig.instance:getStepList(arg_5_0.id)

		if var_5_1[#var_5_1].keyStep ~= 1 then
			for iter_5_0 = #var_5_1 - 1, 1, -1 do
				local var_5_2 = var_5_1[iter_5_0]

				if var_5_2.keyStep == 1 then
					var_5_0 = var_5_2.stepId

					break
				end
			end
		end

		arg_5_0.clientStepId = var_5_0
	end

	arg_5_0:_setCurrStep()

	arg_5_0.isFinish = arg_5_0.serverStepId == -1
end

function var_0_0.setClientStep(arg_6_0, arg_6_1)
	if (arg_6_0._againStepCOs and #arg_6_0._againStepCOs or 0) == 0 and arg_6_1 < arg_6_0.serverStepId then
		arg_6_0.clientStepId = arg_6_0.serverStepId
	else
		arg_6_0.clientStepId = arg_6_1

		local var_6_0 = GuideConfig.instance:getStepList(arg_6_0.id)
		local var_6_1 = var_6_0 and var_6_0[#var_6_0]

		if var_6_1 and arg_6_0.clientStepId == var_6_1.stepId then
			arg_6_0.clientStepId = -1
		end
	end

	arg_6_0:_setCurrStep()
end

function var_0_0.gotoStep(arg_7_0, arg_7_1)
	arg_7_0._againStepCOs = nil
	arg_7_0.clientStepId = GuideConfig.instance:getPrevStepId(arg_7_0.id, arg_7_1)

	arg_7_0:_setCurrStep()
end

function var_0_0.toGotoStep(arg_8_0, arg_8_1)
	arg_8_0._againStepCOs = nil
	arg_8_0.targetStepId = arg_8_1
end

function var_0_0._setCurrStep(arg_9_0)
	local var_9_0 = GuideConfig.instance:getStepList(arg_9_0.id)

	arg_9_0.currGuideId = -1
	arg_9_0.currStepId = -1

	if arg_9_0._againStepCOs and #arg_9_0._againStepCOs > 0 then
		arg_9_0.currGuideId = arg_9_0._againStepCOs[1].id
		arg_9_0.currStepId = arg_9_0._againStepCOs[1].stepId

		table.remove(arg_9_0._againStepCOs, 1)
	elseif arg_9_0.clientStepId == 0 then
		arg_9_0.currGuideId = arg_9_0.id
		arg_9_0.currStepId = var_9_0[1].stepId
	elseif arg_9_0.clientStepId > 0 then
		arg_9_0.currGuideId = arg_9_0.id
		arg_9_0.currStepId = GuideConfig.instance:getNextStepId(arg_9_0.id, arg_9_0.clientStepId)
	end
end

return var_0_0
