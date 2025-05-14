module("modules.logic.explore.controller.steps.ExploreTriggerAudioStep", package.seeall)

local var_0_0 = class("ExploreTriggerAudioStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	AudioMgr.instance:trigger(arg_1_0._data.id)
	arg_1_0:onDone()
end

return var_0_0
