module("modules.logic.explore.controller.trigger.ExploreTriggerPlayAudio", package.seeall)

local var_0_0 = class("ExploreTriggerPlayAudio", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	arg_1_1 = tonumber(arg_1_1) or 0

	if arg_1_1 > 0 then
		local var_1_0 = ExploreStepController.instance:getStepIndex(ExploreEnum.StepType.CameraMove)
		local var_1_1 = ExploreStepController.instance:getStepIndex(ExploreEnum.StepType.ShowArea)

		if var_1_0 >= 0 then
			local var_1_2 = {
				stepType = ExploreEnum.StepType.TriggerAudio,
				id = arg_1_1
			}

			ExploreStepController.instance:insertClientStep(var_1_2, var_1_0 + 1)
		elseif var_1_1 > 0 then
			local var_1_3 = {
				stepType = ExploreEnum.StepType.TriggerAudio,
				id = arg_1_1
			}

			ExploreStepController.instance:insertClientStep(var_1_3, var_1_1)
		else
			AudioMgr.instance:trigger(arg_1_1)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
