module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationMo", package.seeall)

slot0 = pureTable("HeroInvitationMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.gainReward = false
	slot0.cfg = HeroInvitationConfig.instance:getInvitationConfig(slot1)
	slot0.state = slot0:getInvitationState()
end

function slot0.setGainReward(slot0, slot1)
	slot0.gainReward = slot1
	slot0.state = slot0:getInvitationState()
end

function slot0.isGainReward(slot0)
	return slot0.gainReward
end

function slot0.getInvitationState(slot0)
	if slot0:isGainReward() then
		return HeroInvitationEnum.InvitationState.Finish
	end

	if DungeonMapModel.instance:elementIsFinished(slot0.cfg.elementId) then
		return HeroInvitationEnum.InvitationState.CanGet
	end

	if ServerTime.now() < uv0.stringToTimestamp(slot1.openTime) then
		return HeroInvitationEnum.InvitationState.TimeLocked
	end

	if not DungeonMapModel.instance:getElementById(slot1.elementId) then
		return HeroInvitationEnum.InvitationState.ElementLocked
	end

	return HeroInvitationEnum.InvitationState.Normal
end

function slot0.stringToTimestamp(slot0)
	slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8 = string.find(slot0, "(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)")

	if not slot3 or not slot4 or not slot5 or not slot6 or not slot7 or not slot8 then
		return 0
	end

	return TimeUtil.dtTableToTimeStamp({
		year = slot3,
		month = slot4,
		day = slot5,
		hour = slot6,
		min = slot7,
		sec = slot8
	}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

return slot0
