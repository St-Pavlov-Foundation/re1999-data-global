module("modules.logic.explore.controller.trigger.ExploreTriggerBubbleDialogue", package.seeall)

local var_0_0 = class("ExploreTriggerBubbleDialogue", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2.uiComp:addUI(ExploreUnitDialogueView):setDialogueId(arg_1_1)
	arg_1_0:onStepDone(true)
end

return var_0_0
