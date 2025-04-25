module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueChangeTrigger", package.seeall)

slot0 = class("FightWorkRedOrBlueChangeTrigger", FightEffectBase)

function slot0.onStart(slot0)
	FightDataHelper.LYDataMgr:refreshShowAreaSize()
	slot0:onDone(true)
end

return slot0
