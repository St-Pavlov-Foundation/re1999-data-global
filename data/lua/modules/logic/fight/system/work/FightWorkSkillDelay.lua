module("modules.logic.fight.system.work.FightWorkSkillDelay", package.seeall)

local var_0_0 = class("FightWorkSkillDelay", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = lua_fight_skill_delay.configDict[arg_2_0.fightStepData.actId]

	if var_2_0 then
		if FightDataHelper.stateMgr.isReplay then
			arg_2_0:onDone(true)
		else
			TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, var_2_0.delay / 1000 / FightModel.instance:getSpeed())
		end
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
