module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationModel", package.seeall)

slot0 = class("HeroInvitationModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.finalReward = false

	TaskDispatcher.cancelTask(slot0.checkInvitationTime, slot0)
end

function slot0.onGetHeroInvitationInfoReply(slot0, slot1)
	slot0:clear()
	slot0:updateInvitationInfo(slot1.info)
	TaskDispatcher.cancelTask(slot0.checkInvitationTime, slot0)
	TaskDispatcher.runRepeat(slot0.checkInvitationTime, slot0, 1)
end

function slot0.onGainInviteRewardReply(slot0, slot1)
	slot0:updateInvitationInfo(slot1.info)
end

function slot0.onGainFinalInviteRewardReply(slot0, slot1)
	slot0:updateInvitationInfo(slot1.info)
end

function slot0.updateInvitationInfo(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.gainReward then
		for slot5 = 1, #slot1.gainReward do
			slot0:getInvitationMoById(slot1.gainReward[slot5]):setGainReward(true)
		end
	end

	slot0.finalReward = slot1.finalReward
end

function slot0.getInvitationMoById(slot0, slot1)
	if not slot0:getById(slot1) then
		slot2 = HeroInvitationMo.New()

		slot2:init(slot1)
		slot0:addAtLast(slot2)
	end

	return slot2
end

function slot0.getInvitationState(slot0, slot1)
	return slot0:getInvitationMoById(slot1):getInvitationState()
end

function slot0.isGainReward(slot0, slot1)
	return slot0:getInvitationMoById(slot1):isGainReward()
end

function slot0.getInvitationFinishCount(slot0)
	slot1 = HeroInvitationConfig.instance:getInvitationList()
	slot2 = #slot1

	for slot7, slot8 in ipairs(slot1) do
		if slot0:getInvitationState(slot8.id) == HeroInvitationEnum.InvitationState.Finish or slot9 == HeroInvitationEnum.InvitationState.CanGet then
			slot3 = 0 + 1
		end
	end

	return slot2, slot3
end

function slot0.getInvitationHasRewardCount(slot0)
	slot1 = HeroInvitationConfig.instance:getInvitationList()
	slot2 = #slot1

	for slot7, slot8 in ipairs(slot1) do
		if slot0:getInvitationState(slot8.id) == HeroInvitationEnum.InvitationState.Finish then
			slot3 = 0 + 1
		end
	end

	return slot2, slot3
end

function slot0.checkInvitationTime(slot0)
	slot2 = false

	if HeroInvitationConfig.instance:getInvitationList() then
		slot3, slot4 = nil

		for slot8, slot9 in ipairs(slot1) do
			slot3 = slot0:getInvitationMoById(slot9.id)

			if slot3:getInvitationState() ~= slot3.state then
				slot3.state = slot4
				slot2 = true
			end
		end
	end

	if slot2 then
		HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.StateChange)
	end
end

function slot0.getInvitationStateByElementId(slot0, slot1)
	if not HeroInvitationConfig.instance:getInvitationConfigByElementId(slot1) then
		return
	end

	return slot0:getInvitationState(slot2.id)
end

function slot0.isAllFinish(slot0)
	slot1, slot2 = slot0:getInvitationFinishCount()

	return slot1 == slot2
end

slot0.instance = slot0.New()

return slot0
