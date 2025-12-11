module("modules.logic.survival.controller.work.step.SurvivalTweenCameraWork", package.seeall)

local var_0_0 = class("SurvivalTweenCameraWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0:moveNext()
end

function var_0_0.moveNext(arg_2_0)
	local var_2_0 = table.remove(arg_2_0._stepMo.hex)

	if not var_2_0 then
		local var_2_1 = SurvivalMapModel.instance:getSceneMo()

		SurvivalMapHelper.instance:tryShowServerPanel(var_2_1.panel)
		arg_2_0:onDone(true)

		return
	end

	ViewMgr.instance:closeAllPopupViews()

	local var_2_2, var_2_3, var_2_4 = SurvivalHelper.instance:hexPointToWorldPoint(var_2_0.q, var_2_0.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_2_2, var_2_3, var_2_4), 0.3)
	TaskDispatcher.runDelay(arg_2_0.moveNext, arg_2_0, 0.4)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.moveNext, arg_3_0)
end

return var_0_0
