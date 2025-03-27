module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundBegin", package.seeall)

slot0 = class("WaitGuideActionFightRoundBegin", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, slot0._onRoundStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundStart, slot0)
end

function slot0._onRoundStart(slot0)
	slot1 = FightModel.instance:getCurStage()

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Distribute1Card) or slot1 == FightEnum.Stage.Distribute or slot1 == FightEnum.Stage.Card then
		slot0:clearWork()
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, slot0._onRoundStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundStart, slot0)
end

return slot0
