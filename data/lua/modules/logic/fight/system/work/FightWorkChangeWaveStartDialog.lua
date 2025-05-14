module("modules.logic.fight.system.work.FightWorkChangeWaveStartDialog", package.seeall)

local var_0_0 = class("FightWorkChangeWaveStartDialog", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getCurWaveId() + 1

	FightWorkStepChangeWave.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWave, var_1_0)

	if FightWorkStepChangeWave.needStopMonsterWave then
		arg_1_0._dialogWork = FightWorkWaitDialog.New()

		arg_1_0._dialogWork:registerDoneListener(arg_1_0._onFightDialogEnd, arg_1_0)
		arg_1_0._dialogWork:onStart()
	else
		arg_1_0:_onFightDialogEnd()
	end
end

function var_0_0._onFightDialogEnd(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_3_0._onFightDialogEnd, arg_3_0)

	if arg_3_0._dialogWork then
		arg_3_0._dialogWork:unregisterDoneListener(arg_3_0._onFightDialogEnd, arg_3_0)

		arg_3_0._dialogWork = nil
	end
end

return var_0_0
