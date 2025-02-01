module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundEnd", package.seeall)

slot0 = class("WaitGuideActionFightRoundEnd", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundFinish, slot0)
end

function slot0._onRoundFinish(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundFinish, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundFinish, slot0)
end

return slot0
