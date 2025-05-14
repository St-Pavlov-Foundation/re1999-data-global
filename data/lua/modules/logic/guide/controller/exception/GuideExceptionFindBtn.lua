module("modules.logic.guide.controller.exception.GuideExceptionFindBtn", package.seeall)

local var_0_0 = class("GuideExceptionFindBtn")

function var_0_0.ctor(arg_1_0)
	arg_1_0.guideId = nil
	arg_1_0.stepId = nil
	arg_1_0.repeatCount = nil
	arg_1_0.handlerFuncs = nil
	arg_1_0.handlerParams = nil
	arg_1_0.goPath = nil
	arg_1_0.elapseCount = 0
end

function var_0_0.startCheck(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.guideId = arg_2_1
	arg_2_0.stepId = arg_2_2
	arg_2_0.handlerFuncs = arg_2_4
	arg_2_0.handlerParams = arg_2_5

	local var_2_0 = string.split(arg_2_3, "_")
	local var_2_1 = tonumber(var_2_0[1])

	arg_2_0.repeatCount = var_2_0[2] and tonumber(var_2_0[2]) or 1
	arg_2_0._ignoreLog = var_2_0[3] and tonumber(var_2_0[3]) == 1
	arg_2_0.goPath = GuideModel.instance:getStepGOPath(arg_2_1, arg_2_2)

	TaskDispatcher.runRepeat(arg_2_0._onTick, arg_2_0, var_2_1)

	arg_2_0.elapseCount = 0
end

function var_0_0.stopCheck(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onTick, arg_3_0)

	arg_3_0.guideId = nil
	arg_3_0.stepId = nil
	arg_3_0.handlerFuncs = nil
	arg_3_0.handlerParams = nil
	arg_3_0.goPath = nil
	arg_3_0.elapseCount = 0
end

function var_0_0._onTick(arg_4_0)
	local var_4_0 = gohelper.find(arg_4_0.goPath)

	if not GuideUtil.isGOShowInScreen(var_4_0) then
		local var_4_1 = arg_4_0.handlerFuncs
		local var_4_2 = arg_4_0.handlerParams

		if not arg_4_0._ignoreLog then
			GuideActionFindGO._exceptionFindLog(arg_4_0.guideId, arg_4_0.stepId, arg_4_0.goPath, "[ExceptionFind]")
		end

		local var_4_3 = arg_4_0.guideId
		local var_4_4 = arg_4_0.stepId

		arg_4_0:stopCheck()

		if var_4_1 then
			for iter_4_0 = 1, #var_4_1 do
				GuideExceptionController.instance:handle(var_4_3, var_4_4, var_4_1[iter_4_0], var_4_2[iter_4_0])
			end
		end

		return
	end

	if arg_4_0.elapseCount and arg_4_0.repeatCount then
		arg_4_0.elapseCount = arg_4_0.elapseCount + 1

		if arg_4_0.elapseCount >= arg_4_0.repeatCount then
			arg_4_0:stopCheck()
		end
	end
end

return var_0_0
