module("modules.logic.fight.system.work.FightWorkCallMonsterToSub", package.seeall)

local var_0_0 = class("FightWorkCallMonsterToSub", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendFightEvent(FightEvent.AddSubEntity)
	arg_1_0:onDone(true)
end

return var_0_0
