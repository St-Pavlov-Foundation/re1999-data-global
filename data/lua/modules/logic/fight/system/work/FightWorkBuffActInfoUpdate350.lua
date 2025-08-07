module("modules.logic.fight.system.work.FightWorkBuffActInfoUpdate350", package.seeall)

local var_0_0 = class("FightWorkBuffActInfoUpdate350", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendFightEvent(FightEvent.UpdateBuffActInfo, arg_1_0.actEffectData.buffActInfo)
	arg_1_0:onDone(true)
end

return var_0_0
