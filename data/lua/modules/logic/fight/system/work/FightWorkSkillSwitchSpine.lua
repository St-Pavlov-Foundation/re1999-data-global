module("modules.logic.fight.system.work.FightWorkSkillSwitchSpine", package.seeall)

slot0 = class("FightWorkSkillSwitchSpine", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5)

	if not (FightHelper.getEntity(slot0._fightStepMO.fromId) and slot1:getMO()) then
		slot0:onDone(true)

		return
	end

	if FightEntityDataHelper.isPlayerUid(slot2.id) then
		slot0:onDone(true)

		return
	end

	if not slot0._fightStepMO.supportHeroId then
		slot0:onDone(true)

		return
	end

	if slot3 ~= 0 and slot3 ~= slot2.modelId then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)

		slot0._flow = FlowSequence.New()

		if not (FightConfig.instance:getSkinCO(FightHelper.processSkinByStepMO(slot0._fightStepMO)) and slot1:getSpineUrl(slot5)) then
			logError("释放支援角色技能,但是找不到替换spine的url, heroId:" .. slot2.modelId)
			slot0:onDone(true)

			return
		end

		if slot1.spine and slot1.spine.releaseSpecialSpine then
			slot1.spine:releaseSpecialSpine()

			slot1.spine.LOCK_SPECIALSPINE = true
		end

		slot0.context.Custom_OriginSkin = slot2.skin
		slot2.skin = slot4

		slot0._flow:addWork(FightWorkChangeEntitySpine.New(slot1, slot6))
		slot0._flow:registerDoneListener(slot0._onFlowDone, slot0)
		slot0._flow:start()

		return
	end

	slot0:onDone(true)
end

function slot0._onFlowDone(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onFlowDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
