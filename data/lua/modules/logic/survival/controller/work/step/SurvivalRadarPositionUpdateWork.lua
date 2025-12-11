module("modules.logic.survival.controller.work.step.SurvivalRadarPositionUpdateWork", package.seeall)

local var_0_0 = class("SurvivalRadarPositionUpdateWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance:getSceneMo().sceneProp.radarPosition = arg_1_0._stepMo.position

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapRadarPosChange)
	arg_1_0:onDone(true)
end

return var_0_0
