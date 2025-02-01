module("modules.logic.fight.controller.replay.FightReplayWorkWaitCardStage", package.seeall)

slot0 = class("FightReplayWorkWaitCardStage", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		slot0:onDone(true)
	else
		FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
	end
end

function slot0._onStageChange(slot0, slot1)
	if slot1 == FightEnum.Stage.Card then
		FightController.instance:unregisterCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

return slot0
