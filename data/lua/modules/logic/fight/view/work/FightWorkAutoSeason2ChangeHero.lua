module("modules.logic.fight.view.work.FightWorkAutoSeason2ChangeHero", package.seeall)

slot0 = class("FightWorkAutoSeason2ChangeHero", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._opList = slot1
	slot0._index = slot2
	slot0._beginRoundOp = slot0._opList[slot2]
end

function slot0.onStart(slot0)
	if not slot0._beginRoundOp then
		slot0:onDone(true)

		return
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 30)

	slot0._toId = slot0._beginRoundOp.toId

	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0, LuaEventSystem.Low)
	FightController.instance:registerCallback(FightEvent.ReceiveChangeSubHeroReply, slot0._onReceiveChangeSubHeroReply, slot0)
	FightController.instance:registerCallback(FightEvent.ChangeSubHeroExSkillReply, slot0._onChangeSubHeroExSkillReply, slot0)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Season2AutoChangeHero)
	FightRpc.instance:sendChangeSubHeroRequest(slot0._opList[slot0._index - 2].toId, slot0._opList[slot0._index - 1].toId)
end

function slot0._onRoundSequenceFinish(slot0)
	if not slot0._changedSkill then
		slot0._changedSkill = true
	else
		slot0:clearWork()

		return
	end

	FightRpc.instance:sendChangeSubHeroExSkillRequest(slot0._toId)
end

function slot0._onReceiveChangeSubHeroReply(slot0, slot1)
	if slot1 ~= 0 then
		slot0:onDone(true)
	end
end

function slot0._onChangeSubHeroExSkillReply(slot0, slot1)
	if slot1 ~= 0 then
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Season2AutoChangeHero)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.ReceiveChangeSubHeroReply, slot0._onReceiveChangeSubHeroReply, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.ChangeSubHeroExSkillReply, slot0._onChangeSubHeroExSkillReply, slot0)
end

return slot0
