module("modules.logic.survival.controller.work.SummaryAct.SurvivalSurmmaryActBuildCameraWork", package.seeall)

local var_0_0 = class("SurvivalSurmmaryActBuildCameraWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.mapCo = arg_1_1.mapCo
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = string.splitToNumber(arg_2_0.mapCo.orderPosition, ",")
	local var_2_1, var_2_2, var_2_3 = SurvivalHelper.instance:hexPointToWorldPoint(var_2_0[1], var_2_0[2] + SurvivalModel.instance.summaryActPosOffset)

	SurvivalMapHelper.instance:setFocusPos(var_2_1, var_2_2, var_2_3)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale, 0.44)
	arg_2_0:onDone(true)
end

function var_0_0.onDestroy(arg_3_0)
	local var_3_0 = SurvivalShelterModel.instance:getPlayerMo()
	local var_3_1, var_3_2, var_3_3 = SurvivalHelper.instance:hexPointToWorldPoint(var_3_0.pos.q, var_3_0.pos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_3_1, var_3_2, var_3_3), 0)
	var_0_0.super.onDestroy(arg_3_0)
end

return var_0_0
