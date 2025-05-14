module("modules.logic.versionactivity1_9.heroinvitation.rpc.HeroInvitationRpc", package.seeall)

local var_0_0 = class("HeroInvitationRpc", BaseRpc)

function var_0_0.sendGetHeroInvitationInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = HeroInvitationModule_pb.GetHeroInvitationInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetHeroInvitationInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGetHeroInvitationInfoReply(arg_2_2)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

function var_0_0.sendGainInviteRewardRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = HeroInvitationModule_pb.GainInviteRewardRequest()

	var_3_0.id = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveGainInviteRewardReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGainInviteRewardReply(arg_4_2)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

function var_0_0.sendGainFinalInviteRewardRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = HeroInvitationModule_pb.GainFinalInviteRewardRequest()

	return arg_5_0:sendMsg(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.onReceiveGainFinalInviteRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	HeroInvitationModel.instance:onGainFinalInviteRewardReply(arg_6_2)
	HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.UpdateInfo)
end

var_0_0.instance = var_0_0.New()

return var_0_0
