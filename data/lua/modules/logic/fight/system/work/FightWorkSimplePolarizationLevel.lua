module("modules.logic.fight.system.work.FightWorkSimplePolarizationLevel", package.seeall)

slot0 = class("FightWorkSimplePolarizationLevel", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendMsg(FightMsgId.RefreshSimplePolarizationLevel)
	slot0:onDone(true)
end

return slot0
