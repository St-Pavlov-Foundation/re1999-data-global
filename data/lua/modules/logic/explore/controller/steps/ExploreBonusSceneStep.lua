module("modules.logic.explore.controller.steps.ExploreBonusSceneStep", package.seeall)

local var_0_0 = class("ExploreBonusSceneStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreSimpleModel.instance:onGetBonus(arg_1_0._data.bonusSceneId, arg_1_0._data.options)
	arg_1_0:onDone()
end

return var_0_0
