module("modules.logic.guide.controller.action.impl.WaitGuideActionFightWaveBegin", package.seeall)

slot0 = class("WaitGuideActionFightWaveBegin", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, slot0._onBeginWave, slot0)

	slot0._groundId = tonumber(slot0.actionParam)
end

function slot0._onBeginWave(slot0)
	if slot0._groundId and FightModel.instance:getCurMonsterGroupId() ~= slot0._groundId then
		return
	end

	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
end

return slot0
