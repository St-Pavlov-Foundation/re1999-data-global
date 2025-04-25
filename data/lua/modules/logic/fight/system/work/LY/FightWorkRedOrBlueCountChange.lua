module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueCountChange", package.seeall)

slot0 = class("FightWorkRedOrBlueCountChange", FightEffectBase)

function slot0.onStart(slot0)
	FightDataHelper.LYDataMgr:setLYCountBuff(slot0._actEffectMO.buff)

	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
