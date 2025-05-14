module("modules.logic.fight.system.work.FightWorkNormalDialog", package.seeall)

local var_0_0 = class("FightWorkNormalDialog", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._dialogType = arg_1_1
	arg_1_0._param = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, arg_2_0._dialogType, arg_2_0._param)

	if FightViewDialog.showFightDialog then
		arg_2_0._dialogWork = FightWorkWaitDialog.New()

		arg_2_0._dialogWork:registerDoneListener(arg_2_0._onFightDialogEnd, arg_2_0)
		arg_2_0._dialogWork:onStart()

		return
	end

	arg_2_0:onDone(true)
end

function var_0_0._onFightDialogEnd(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_4_0._onFightDialogEnd, arg_4_0)

	if arg_4_0._dialogWork then
		arg_4_0._dialogWork:unregisterDoneListener(arg_4_0._onFightDialogEnd, arg_4_0)

		arg_4_0._dialogWork = nil
	end
end

return var_0_0
