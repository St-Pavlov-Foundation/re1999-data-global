module("modules.logic.fight.system.work.FightWorkFocusMonsterAfterChangeHero", package.seeall)

local var_0_0 = class("FightWorkFocusMonsterAfterChangeHero", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._counter = 0
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:cancelFightWorkSafeTimer()

	local var_2_0, var_2_1 = FightWorkFocusMonster.getFocusEntityId()

	if var_2_0 and arg_2_0._counter < 5 then
		arg_2_0._counter = arg_2_0._counter + 1

		local var_2_2 = arg_2_0:com_registFlowSequence()

		var_2_2:addWork(Work2FightWork.New(FightWorkFocusMonster))
		var_2_2:registFinishCallback(arg_2_0.onStart, arg_2_0)
		var_2_2:start()
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
