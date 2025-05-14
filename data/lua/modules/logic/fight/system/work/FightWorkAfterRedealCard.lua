module("modules.logic.fight.system.work.FightWorkAfterRedealCard", package.seeall)

local var_0_0 = class("FightWorkAfterRedealCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
