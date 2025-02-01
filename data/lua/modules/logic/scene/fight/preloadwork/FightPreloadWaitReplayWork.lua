module("modules.logic.scene.fight.preloadwork.FightPreloadWaitReplayWork", package.seeall)

slot0 = class("FightPreloadWaitReplayWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if FightModel.instance:getFightParam() and slot2.isReplay then
		if FightReplayModel.instance:isReplay() then
			slot0:onDone(true)
		else
			FightController.instance:registerCallback(FightEvent.StartReplay, slot0._onStartReplay, slot0)
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onStartReplay(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.StartReplay, slot0._onStartReplay, slot0)
end

return slot0
