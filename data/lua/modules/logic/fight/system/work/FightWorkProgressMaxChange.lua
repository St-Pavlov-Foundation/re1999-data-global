module("modules.logic.fight.system.work.FightWorkProgressMaxChange", package.seeall)

slot0 = class("FightWorkProgressMaxChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendMsg(FightMsgId.FightMaxProgressValueChange)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
