module("modules.logic.fight.system.work.FightWorkStartBorn", package.seeall)

slot0 = class("FightWorkStartBorn", BaseWork)
slot1 = 10

function slot0.onStart(slot0)
	slot0:_playEnterVoice()

	slot0._flowParallel = FlowParallel.New()

	for slot5, slot6 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
		slot8 = false

		if slot6:getMO():isAssistBoss() then
			slot8 = true
		end

		if slot6.spine and not slot6.spine:hasAnimation(SpineAnimState.born) then
			slot8 = true
		end

		if not slot8 then
			FightWorkStartBornNormal.New(slot6, true).dontDealBuff = true

			if FightDataHelper.entityMgr:isSub(slot6.id) then
				slot9:onStart()
			else
				slot0._flowParallel:addWork(slot9)
			end
		else
			if slot6.nameUI then
				slot6.nameUI:setActive(true)
			end

			slot6:setAlpha(1, 0)
		end
	end

	TaskDispatcher.runDelay(slot0._onBornTimeout, slot0, uv0)
	FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBorn)
	slot0._flowParallel:registerDoneListener(slot0._onBornEnd, slot0)
	slot0._flowParallel:start()
end

function slot0._playEnterVoice(slot0)
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	if FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false) and #slot1 > 0 then
		slot3 = slot1[math.random(#slot1)]:getMO().modelId

		FightAudioMgr.instance:playHeroVoiceRandom(slot3, CharacterEnum.VoiceType.EnterFight)

		FightAudioMgr.instance.enterFightVoiceHeroID = slot3
	end
end

function slot0._onBornEnd(slot0)
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	slot0:onDone(true)
end

function slot0._onBornTimeout(slot0)
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	logError("播放出生效果时间超过" .. uv0 .. "秒")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flowParallel then
		slot0._flowParallel:stop()
		slot0._flowParallel:unregisterDoneListener(slot0._onBornEnd, slot0)
	end

	TaskDispatcher.cancelTask(slot0._onBornTimeout, slot0)
end

return slot0
