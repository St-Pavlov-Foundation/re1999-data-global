module("modules.logic.fight.controller.replay.FightReplayWorkWaitRoundEnd", package.seeall)

slot0 = class("FightReplayWorkWaitRoundEnd", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundEnd, slot0)
end

function slot0._onRoundEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundEnd, slot0)
end

return slot0
