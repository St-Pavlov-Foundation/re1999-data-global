module("modules.logic.fight.system.work.FightGuideCardEnd", package.seeall)

slot0 = class("FightGuideCardEnd", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideCardEndPause", FightEvent.OnGuideCardEndPause, FightEvent.OnGuideCardEndContinue, slot0._done, slot0)
end

function slot0._done(slot0)
	slot0:onDone(true)
end

return slot0
