module("modules.logic.fight.system.work.FightWorkTrigger", package.seeall)

local var_0_0 = class("FightWorkTrigger", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._actEffectMO.effectNum

	if arg_1_0._actEffectMO.configEffect == -1 and var_1_0 == 4150002 then
		local var_1_1 = false

		if arg_1_0._fightStepMO.actEffectMOs then
			local var_1_2 = false

			for iter_1_0, iter_1_1 in ipairs(arg_1_0._fightStepMO.actEffectMOs) do
				if iter_1_1 == arg_1_0._actEffectMO then
					var_1_2 = iter_1_0
					var_1_1 = true
				end
			end

			for iter_1_2 = var_1_2 + 1, #arg_1_0._fightStepMO.actEffectMOs do
				local var_1_3 = arg_1_0._fightStepMO.actEffectMOs[iter_1_2]

				if var_1_3.effectType == FightEnum.EffectType.TRIGGER and var_1_3.configEffect == -1 and var_1_3.effectNum == 4150002 then
					var_1_1 = false
				end
			end
		end

		if var_1_1 then
			arg_1_0:cancelFightWorkSafeTimer()
			arg_1_0:com_registTimer(arg_1_0._yuranDelayDone, 0.3)
		else
			arg_1_0:onDone(true)
		end

		return
	end

	local var_1_4 = lua_trigger_action.configDict[var_1_0]

	if var_1_4 then
		local var_1_5 = _G["FightWorkTrigger" .. var_1_4.actionType]

		if var_1_5 then
			arg_1_0:cancelFightWorkSafeTimer()

			arg_1_0._work = var_1_5.New(arg_1_0._fightStepMO, arg_1_0._actEffectMO)

			arg_1_0._work:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
			arg_1_0._work:onStart(arg_1_0.context)
		else
			arg_1_0:onDone(true)
		end
	else
		logError("触发器行为表找不到id:" .. var_1_0)
		arg_1_0:onDone(true)
	end
end

function var_0_0._yuranDelayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._onWorkDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._work then
		arg_4_0._work:unregisterDoneListener(arg_4_0._onWorkDone, arg_4_0)
		arg_4_0._work:onStop()

		arg_4_0._work = nil
	end
end

return var_0_0
