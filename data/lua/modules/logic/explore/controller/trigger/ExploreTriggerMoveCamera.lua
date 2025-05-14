module("modules.logic.explore.controller.trigger.ExploreTriggerMoveCamera", package.seeall)

local var_0_0 = class("ExploreTriggerMoveCamera", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = string.splitToNumber(arg_1_1, "#")
	local var_1_1 = {
		stepType = ExploreEnum.StepType.CameraMove,
		id = var_1_0[1],
		moveTime = var_1_0[2],
		keepTime = var_1_0[3]
	}

	ExploreStepController.instance:insertClientStep(var_1_1, 1)
	ExploreStepController.instance:startStep()
	ExploreController.instance:getMap():getHero():stopMoving()
	arg_1_0:onDone(true)
end

return var_0_0
