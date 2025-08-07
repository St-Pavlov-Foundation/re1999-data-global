module("modules.logic.fight.system.work.FightWorkProgressMaxChange", package.seeall)

local var_0_0 = class("FightWorkProgressMaxChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendMsg(FightMsgId.FightMaxProgressValueChange, arg_1_0.actEffectData.buffActId)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
