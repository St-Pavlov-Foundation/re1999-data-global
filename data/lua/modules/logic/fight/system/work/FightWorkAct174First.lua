module("modules.logic.fight.system.work.FightWorkAct174First", package.seeall)

local var_0_0 = class("FightWorkAct174First", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, FightEnum.PerformanceTime.DouQuQuXianHouShou)
	arg_1_0:com_sendMsg(FightMsgId.ShowDouQuQuXianHouShou, arg_1_0.actEffectData)
end

return var_0_0
