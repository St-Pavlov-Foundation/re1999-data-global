module("modules.logic.fight.system.work.FightWorkAct174First", package.seeall)

slot0 = class("FightWorkAct174First", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_registTimer(slot0._delayAfterPerformance, FightEnum.PerformanceTime.DouQuQuXianHouShou)
	slot0:com_sendMsg(FightMsgId.ShowDouQuQuXianHouShou, slot0._actEffectMO)
end

return slot0
