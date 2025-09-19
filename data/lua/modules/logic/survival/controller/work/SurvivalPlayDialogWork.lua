module("modules.logic.survival.controller.work.SurvivalPlayDialogWork", package.seeall)

local var_0_0 = class("SurvivalPlayDialogWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_0.context.fastExecute then
		arg_1_0:onDone(true)

		return
	end

	TipDialogController.instance:openTipDialogView(arg_1_0._stepMo.paramInt[1], arg_1_0._onPlayFinish, arg_1_0)
end

function var_0_0._onPlayFinish(arg_2_0)
	arg_2_0:onDone(true)
end

return var_0_0
