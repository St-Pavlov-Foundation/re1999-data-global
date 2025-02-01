module("modules.logic.fight.system.work.FightWorkEndGC", package.seeall)

slot0 = class("FightWorkEndGC", BaseWork)

function slot0.onStart(slot0)
	for slot5, slot6 in pairs(FightEffectPool.releaseUnuseEffect()) do
		FightPreloadController.instance:releaseAsset(slot5)
	end

	FightPreloadController.instance:releaseTimelineRefAsset()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
	slot0:onDone(true)
end

return slot0
