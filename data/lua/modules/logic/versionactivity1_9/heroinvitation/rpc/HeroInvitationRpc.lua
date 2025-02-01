module("modules.logic.versionactivity1_9.heroinvitation.rpc.HeroInvitationRpc", package.seeall)

slot0 = class("HeroInvitationRpc", BaseRpc)

function slot0.sendGetHeroInvitationInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroInvitationModule_pb.GetHeroInvitationInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetHeroInvitationInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGetHeroInvitationInfoReply(slot2)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

function slot0.sendGainInviteRewardRequest(slot0, slot1, slot2, slot3)
	slot4 = HeroInvitationModule_pb.GainInviteRewardRequest()
	slot4.id = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGainInviteRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGainInviteRewardReply(slot2)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

function slot0.sendGainFinalInviteRewardRequest(slot0, slot1, slot2)
	return slot0:sendMsg(HeroInvitationModule_pb.GainFinalInviteRewardRequest(), slot1, slot2)
end

function slot0.onReceiveGainFinalInviteRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGainFinalInviteRewardReply(slot2)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

slot0.instance = slot0.New()

return slot0
