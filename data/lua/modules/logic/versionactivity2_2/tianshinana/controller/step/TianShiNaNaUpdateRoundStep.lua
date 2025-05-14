module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaUpdateRoundStep", package.seeall)

local var_0_0 = class("TianShiNaNaUpdateRoundStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0)
	TianShiNaNaModel.instance.nowRound = arg_1_0._data.currRound
	TianShiNaNaModel.instance.stepCount = arg_1_0._data.stepCount
	TianShiNaNaModel.instance.waitClickJump = arg_1_0._data.reason == 1

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.RoundUpdate, tostring(arg_1_0._data.currRound + 1))

	if TianShiNaNaModel.instance.waitClickJump then
		TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.WaitClickJumpRound, arg_1_0._onClick, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onClick(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.WaitClickJumpRound, arg_3_0._onClick, arg_3_0)
end

return var_0_0
