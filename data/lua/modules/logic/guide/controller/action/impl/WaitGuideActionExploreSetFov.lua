module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreSetFov", package.seeall)

local var_0_0 = class("WaitGuideActionExploreSetFov", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1] or 35
	local var_1_2 = var_1_0[2] or 0
	local var_1_3 = var_1_0[3] or EaseType.Linear
	local var_1_4 = GameSceneMgr.instance:getCurScene().camera

	if not var_1_4 or not isTypeOf(var_1_4, ExploreSceneCameraComp) then
		arg_1_0:onDone(true)

		return
	end

	if var_1_2 > 0 then
		var_1_4:setEaseTime(var_1_2)
		var_1_4:setEaseType(var_1_3)
		var_1_4:setFov(var_1_1)
		TaskDispatcher.runDelay(arg_1_0.onCameraChangeDone, arg_1_0, var_1_2)
	else
		var_1_4:setFov(var_1_1)
		var_1_4:applyDirectly()
		arg_1_0:onDone(true)
	end
end

function var_0_0.onCameraChangeDone(arg_2_0)
	arg_2_0:resetCameraParam()
	arg_2_0:onDone(true)
end

function var_0_0.resetCameraParam(arg_3_0)
	local var_3_0 = GameSceneMgr.instance:getCurScene().camera

	if not var_3_0 or not isTypeOf(var_3_0, ExploreSceneCameraComp) then
		return
	end

	var_3_0:setEaseTime(ExploreConstValue.CameraTraceTime)
	var_3_0:setEaseType(EaseType.Linear)
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0:resetCameraParam()
	TaskDispatcher.cancelTask(arg_4_0.onCameraChangeDone, arg_4_0)
end

return var_0_0
