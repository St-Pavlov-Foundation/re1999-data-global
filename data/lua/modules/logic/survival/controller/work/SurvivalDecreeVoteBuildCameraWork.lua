module("modules.logic.survival.controller.work.SurvivalDecreeVoteBuildCameraWork", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteBuildCameraWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.playerPos = arg_2_1.playerPos
end

function var_0_0.onStart(arg_3_0)
	local var_3_0, var_3_1, var_3_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_3_0.playerPos.q, arg_3_0.playerPos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_3_0, var_3_1, var_3_2))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale, 0.44)
	arg_3_0:onBuildFinish()
end

function var_0_0.onBuildFinish(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	return
end

return var_0_0
