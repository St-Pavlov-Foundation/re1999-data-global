module("modules.logic.guide.controller.action.impl.GuideActionTriggerGuide", package.seeall)

local var_0_0 = class("GuideActionTriggerGuide", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0._triggerGuideId = not string.nilorempty(arg_1_3) and tonumber(arg_1_3)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)
	arg_2_0:onDone(true)
end

function var_0_0.onDestroy(arg_3_0)
	var_0_0.super.onDestroy(arg_3_0)

	if arg_3_0._triggerGuideId then
		local var_3_0 = GuideModel.instance:getById(arg_3_0._triggerGuideId)

		if var_3_0 and not var_3_0.isFinish then
			GuideController.instance:execNextStep(arg_3_0._triggerGuideId)
		else
			GuideController.instance:dispatchEvent(GuideEvent.TriggerGuide, arg_3_0._triggerGuideId)
		end
	else
		local var_3_1 = GuideModel.instance:getDoingGuideId()

		if var_3_1 then
			GuideController.instance:execNextStep(var_3_1)
		else
			GuideController.instance:dispatchEvent(GuideEvent.TriggerGuide)
		end
	end
end

return var_0_0
