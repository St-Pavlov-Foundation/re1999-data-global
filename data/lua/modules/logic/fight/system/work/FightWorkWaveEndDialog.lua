module("modules.logic.fight.system.work.FightWorkWaveEndDialog", package.seeall)

local var_0_0 = class("FightWorkWaveEndDialog", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getCurWaveId()

	FightWorkStepChangeWave.needStopMonsterWave = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEnd, var_1_0)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterWaveEndAndCheckBuffId, var_1_0)

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
