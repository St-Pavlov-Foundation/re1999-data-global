module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationModel", package.seeall)

local var_0_0 = class("HeroInvitationModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.finalReward = false

	TaskDispatcher.cancelTask(arg_2_0.checkInvitationTime, arg_2_0)
end

function var_0_0.onGetHeroInvitationInfoReply(arg_3_0, arg_3_1)
	arg_3_0:clear()
	arg_3_0:updateInvitationInfo(arg_3_1.info)
	TaskDispatcher.cancelTask(arg_3_0.checkInvitationTime, arg_3_0)
	TaskDispatcher.runRepeat(arg_3_0.checkInvitationTime, arg_3_0, 1)
end

function var_0_0.onGainInviteRewardReply(arg_4_0, arg_4_1)
	arg_4_0:updateInvitationInfo(arg_4_1.info)
end

function var_0_0.onGainFinalInviteRewardReply(arg_5_0, arg_5_1)
	arg_5_0:updateInvitationInfo(arg_5_1.info)
end

function var_0_0.updateInvitationInfo(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	if arg_6_1.gainReward then
		for iter_6_0 = 1, #arg_6_1.gainReward do
			arg_6_0:getInvitationMoById(arg_6_1.gainReward[iter_6_0]):setGainReward(true)
		end
	end

	arg_6_0.finalReward = arg_6_1.finalReward
end

function var_0_0.getInvitationMoById(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getById(arg_7_1)

	if not var_7_0 then
		var_7_0 = HeroInvitationMo.New()

		var_7_0:init(arg_7_1)
		arg_7_0:addAtLast(var_7_0)
	end

	return var_7_0
end

function var_0_0.getInvitationState(arg_8_0, arg_8_1)
	return arg_8_0:getInvitationMoById(arg_8_1):getInvitationState()
end

function var_0_0.isGainReward(arg_9_0, arg_9_1)
	return arg_9_0:getInvitationMoById(arg_9_1):isGainReward()
end

function var_0_0.getInvitationFinishCount(arg_10_0)
	local var_10_0 = HeroInvitationConfig.instance:getInvitationList()
	local var_10_1 = #var_10_0
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_3 = arg_10_0:getInvitationState(iter_10_1.id)

		if var_10_3 == HeroInvitationEnum.InvitationState.Finish or var_10_3 == HeroInvitationEnum.InvitationState.CanGet then
			var_10_2 = var_10_2 + 1
		end
	end

	return var_10_1, var_10_2
end

function var_0_0.getInvitationHasRewardCount(arg_11_0)
	local var_11_0 = HeroInvitationConfig.instance:getInvitationList()
	local var_11_1 = #var_11_0
	local var_11_2 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if arg_11_0:getInvitationState(iter_11_1.id) == HeroInvitationEnum.InvitationState.Finish then
			var_11_2 = var_11_2 + 1
		end
	end

	return var_11_1, var_11_2
end

function var_0_0.checkInvitationTime(arg_12_0)
	local var_12_0 = HeroInvitationConfig.instance:getInvitationList()
	local var_12_1 = false

	if var_12_0 then
		local var_12_2
		local var_12_3

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_4 = arg_12_0:getInvitationMoById(iter_12_1.id)
			local var_12_5 = var_12_4:getInvitationState()

			if var_12_5 ~= var_12_4.state then
				var_12_4.state = var_12_5
				var_12_1 = true
			end
		end
	end

	if var_12_1 then
		HeroInvitationController.instance:dispatchEvent(HeroInvitationEvent.StateChange)
	end
end

function var_0_0.getInvitationStateByElementId(arg_13_0, arg_13_1)
	local var_13_0 = HeroInvitationConfig.instance:getInvitationConfigByElementId(arg_13_1)

	if not var_13_0 then
		return
	end

	return arg_13_0:getInvitationState(var_13_0.id)
end

function var_0_0.isAllFinish(arg_14_0)
	local var_14_0, var_14_1 = arg_14_0:getInvitationFinishCount()

	return var_14_0 == var_14_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
