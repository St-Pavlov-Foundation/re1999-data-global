module("modules.logic.fight.system.work.FightWorkCardDissolveDone", package.seeall)

local var_0_0 = class("FightWorkCardDissolveDone", BaseWork)

function var_0_0.onStart(arg_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
