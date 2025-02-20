module("modules.logic.fight.system.work.FightWorkEndGC", package.seeall)

slot0 = class("FightWorkEndGC", BaseWork)

function slot0.onStart(slot0)
	FightPreloadController.instance:releaseTimelineRefAsset()
	FightHelper.clearNoUseEffect()
	slot0:onDone(true)
end

return slot0
