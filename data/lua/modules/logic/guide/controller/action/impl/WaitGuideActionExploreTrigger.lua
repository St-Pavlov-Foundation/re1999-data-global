module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTrigger", package.seeall)

local var_0_0 = class("WaitGuideActionExploreTrigger", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	ExploreController.instance:registerCallback(ExploreEvent.ExploreTriggerGuide, arg_1_0._onTriggerGuide, arg_1_0)
end

function var_0_0._onTriggerGuide(arg_2_0, arg_2_1)
	if arg_2_0.guideId == arg_2_1 then
		ExploreController.instance:unregisterCallback(ExploreEvent.ExploreTriggerGuide, arg_2_0._onTriggerGuide, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.ExploreTriggerGuide, arg_3_0._onTriggerGuide, arg_3_0)
end

return var_0_0
