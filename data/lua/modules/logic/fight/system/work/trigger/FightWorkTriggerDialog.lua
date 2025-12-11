module("modules.logic.fight.system.work.trigger.FightWorkTriggerDialog", package.seeall)

local var_0_0 = class("FightWorkTriggerDialog", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	if FightDataHelper.stateMgr.isReplay then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._config = lua_trigger_action.configDict[arg_2_0.actEffectData.effectNum]

	if arg_2_0._config then
		local var_2_0 = tonumber(arg_2_0._config.param1)
		local var_2_1 = tonumber(arg_2_0._config.param2)
		local var_2_2 = lua_battle_dialog.configDict[var_2_0] and lua_battle_dialog.configDict[var_2_0][var_2_1]

		if var_2_2 then
			FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.Trigger, var_2_2)

			arg_2_0._dialogWork = FightWorkWaitDialog.New()

			arg_2_0._dialogWork:registerDoneListener(arg_2_0._onFightDialogEnd, arg_2_0)
			arg_2_0._dialogWork:onStart()

			return
		end
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
