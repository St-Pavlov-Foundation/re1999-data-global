module("modules.logic.dungeon.model.RewardPointInfoMO", package.seeall)

local var_0_0 = pureTable("RewardPointInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.chapterId = arg_1_1.chapterId
	arg_1_0.rewardPoint = arg_1_1.rewardPoint
	arg_1_0.hasGetPointRewardIds = arg_1_1.hasGetPointRewardIds or {}
end

function var_0_0.setRewardPoint(arg_2_0, arg_2_1)
	arg_2_0.rewardPoint = arg_2_1
end

return var_0_0
