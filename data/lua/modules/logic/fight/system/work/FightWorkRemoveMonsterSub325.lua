module("modules.logic.fight.system.work.FightWorkRemoveMonsterSub325", package.seeall)

local var_0_0 = class("FightWorkRemoveMonsterSub325", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendFightEvent(FightEvent.RefreshMonsterSubCount)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
