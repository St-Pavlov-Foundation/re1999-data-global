module("modules.logic.fight.system.work.FightWorkSpecialDelay", package.seeall)

local var_0_0 = class("FightWorkSpecialDelay", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.5)

	local var_2_0 = FightHelper.getEntity(arg_2_0.fightStepData.fromId)
	local var_2_1 = var_2_0 and var_2_0:getMO()

	if var_2_1 then
		local var_2_2 = _G["FightWorkSpecialDelayModelId" .. var_2_1.modelId]

		if var_2_2 then
			TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)

			arg_2_0._delayClass = var_2_2.New(arg_2_0, arg_2_0.fightStepData)

			return
		end
	end

	arg_2_0:_delayDone()
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)

	if arg_4_0._delayClass then
		arg_4_0._delayClass:releaseSelf()

		arg_4_0._delayClass = nil
	end
end

return var_0_0
