module("modules.logic.fight.system.work.FightWorkAddRecordCard", package.seeall)

local var_0_0 = class("FightWorkAddRecordCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.ALF_AddRecordCardData, arg_1_0.actEffectData.buff)
	arg_1_0:onDone(true)
end

return var_0_0
