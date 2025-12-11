module("modules.logic.survival.model.reputation.SurvivalReputationPropMo", package.seeall)

local var_0_0 = pureTable("SurvivalReputationPropMo")

function var_0_0.setData(arg_1_0, arg_1_1)
	arg_1_0.prop = arg_1_1
	arg_1_0.survivalShopMo = arg_1_0.survivalShopMo or SurvivalShopMo.New()

	arg_1_0.survivalShopMo:init(arg_1_0.prop.shop, arg_1_0.prop.reputationId, arg_1_0.prop.reputationLevel)
end

function var_0_0.onReceiveSurvivalReputationRewardReply(arg_2_0, arg_2_1)
	if not tabletool.indexOf(arg_2_0.prop.gain, arg_2_1) then
		table.insert(arg_2_0.prop.gain, arg_2_1)
	end
end

function var_0_0.getReputationLevel(arg_3_0)
	return arg_3_0.prop.reputationLevel
end

function var_0_0.isMaxLevel(arg_4_0)
	return SurvivalConfig.instance:getReputationMaxLevel(arg_4_0.prop.reputationId) <= arg_4_0.prop.reputationLevel
end

function var_0_0.isGainFreeReward(arg_5_0, arg_5_1)
	return tabletool.indexOf(arg_5_0.prop.gain, arg_5_1) ~= nil
end

function var_0_0.haveFreeReward(arg_6_0)
	for iter_6_0 = 1, arg_6_0.prop.reputationLevel do
		if not tabletool.indexOf(arg_6_0.prop.gain, iter_6_0) then
			return true
		end
	end

	return false
end

function var_0_0.getLevelBkg(arg_7_0)
	local var_7_0 = arg_7_0.prop.reputationLevel

	return "survival_commit_levelbg_" .. var_7_0
end

function var_0_0.getLevelProgressBkg(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.prop.reputationLevel
	local var_8_1
	local var_8_2 = arg_8_1 and 1 or 2

	return string.format("survival_commit_progressbg%s_%s", var_8_0, var_8_2)
end

return var_0_0
