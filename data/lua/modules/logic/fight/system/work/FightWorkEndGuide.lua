module("modules.logic.fight.system.work.FightWorkEndGuide", package.seeall)

slot0 = class("FightWorkEndGuide", BaseWork)

function slot0.onStart(slot0)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideFightEndPause", FightEvent.OnGuideFightEndPause, FightEvent.OnGuideFightEndContinue, slot0._done, slot0)
end

function slot0._done(slot0)
	slot0:onDone(true)
end

return slot0
