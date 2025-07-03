module("modules.logic.fight.system.work.FightWorkEntitySync", package.seeall)

local var_0_0 = class("FightWorkEntitySync", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.entity

	if var_1_0 then
		arg_1_0:com_sendFightEvent(FightEvent.EntitySync, var_1_0.id)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
