module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationMo", package.seeall)

local var_0_0 = pureTable("HeroInvitationMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.gainReward = false
	arg_1_0.cfg = HeroInvitationConfig.instance:getInvitationConfig(arg_1_1)
	arg_1_0.state = arg_1_0:getInvitationState()
end

function var_0_0.setGainReward(arg_2_0, arg_2_1)
	arg_2_0.gainReward = arg_2_1
	arg_2_0.state = arg_2_0:getInvitationState()
end

function var_0_0.isGainReward(arg_3_0)
	return arg_3_0.gainReward
end

function var_0_0.getInvitationState(arg_4_0)
	if arg_4_0:isGainReward() then
		return HeroInvitationEnum.InvitationState.Finish
	end

	local var_4_0 = arg_4_0.cfg

	if DungeonMapModel.instance:elementIsFinished(var_4_0.elementId) then
		return HeroInvitationEnum.InvitationState.CanGet
	end

	if var_0_0.stringToTimestamp(var_4_0.openTime) > ServerTime.now() then
		return HeroInvitationEnum.InvitationState.TimeLocked
	end

	if not DungeonMapModel.instance:getElementById(var_4_0.elementId) then
		return HeroInvitationEnum.InvitationState.ElementLocked
	end

	return HeroInvitationEnum.InvitationState.Normal
end

function var_0_0.stringToTimestamp(arg_5_0)
	local var_5_0, var_5_1, var_5_2, var_5_3, var_5_4, var_5_5, var_5_6, var_5_7 = string.find(arg_5_0, "(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)")

	if not var_5_2 or not var_5_3 or not var_5_4 or not var_5_5 or not var_5_6 or not var_5_7 then
		return 0
	end

	local var_5_8 = {
		year = var_5_2,
		month = var_5_3,
		day = var_5_4,
		hour = var_5_5,
		min = var_5_6,
		sec = var_5_7
	}

	return TimeUtil.dtTableToTimeStamp(var_5_8) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

return var_0_0
