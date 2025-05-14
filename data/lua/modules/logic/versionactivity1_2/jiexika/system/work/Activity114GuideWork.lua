module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114GuideWork", package.seeall)

local var_0_0 = class("Activity114GuideWork", Activity114BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._guideId = arg_1_1

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = GuideModel.instance:getById(arg_2_0._guideId)

	if var_2_0 and var_2_0.isFinish or not var_2_0 then
		if not var_2_0 then
			logError("指引没有自动接？？？")
		end

		arg_2_0:onDone(false)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_2_0._onGuideFinish, arg_2_0)
	Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(arg_2_0._guideId))
end

function var_0_0._onGuideFinish(arg_3_0, arg_3_1)
	if arg_3_0._guideId ~= arg_3_1 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_3_0._onGuideFinish, arg_3_0)

	if Activity114Model.instance:isEnd() then
		arg_3_0:onDone(false)

		return
	end

	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_4_0._onGuideFinish, arg_4_0)
	var_0_0.super.clearWork(arg_4_0)
end

return var_0_0
