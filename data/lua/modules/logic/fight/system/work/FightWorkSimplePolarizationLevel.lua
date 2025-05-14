module("modules.logic.fight.system.work.FightWorkSimplePolarizationLevel", package.seeall)

local var_0_0 = class("FightWorkSimplePolarizationLevel", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendMsg(FightMsgId.RefreshSimplePolarizationLevel)
	arg_1_0:onDone(true)
end

return var_0_0
