module("modules.logic.versionactivity1_4.act129.model.Activity129PoolMo", package.seeall)

local var_0_0 = class("Activity129PoolMo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.poolId = arg_1_1.poolId
	arg_1_0.poolType = arg_1_1.type
	arg_1_0.count = 0
	arg_1_0.rewardDict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.count = arg_2_1.count
	arg_2_0.rewardDict = {}

	for iter_2_0 = 1, #arg_2_1.rewards do
		local var_2_0 = arg_2_1.rewards[iter_2_0]
		local var_2_1 = arg_2_0:getRewardItem(var_2_0.rare, var_2_0.rewardType, var_2_0.rewardId)

		var_2_1.num = var_2_1.num + var_2_0.num
	end
end

function var_0_0.onLotterySuccess(arg_3_0, arg_3_1)
	arg_3_0.count = arg_3_0.count + arg_3_1.num

	for iter_3_0 = 1, #arg_3_1.rewards do
		local var_3_0 = arg_3_1.rewards[iter_3_0]
		local var_3_1 = arg_3_0:getRewardItem(var_3_0.rare, var_3_0.rewardType, var_3_0.rewardId)

		var_3_1.num = var_3_1.num + var_3_0.num
	end
end

function var_0_0.getRewardItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0.rewardDict[arg_4_1] then
		arg_4_0.rewardDict[arg_4_1] = {}
	end

	if not arg_4_0.rewardDict[arg_4_1][arg_4_2] then
		arg_4_0.rewardDict[arg_4_1][arg_4_2] = {}
	end

	if not arg_4_0.rewardDict[arg_4_1][arg_4_2][arg_4_3] then
		arg_4_0.rewardDict[arg_4_1][arg_4_2][arg_4_3] = {
			num = 0,
			rare = arg_4_1,
			rewardType = arg_4_2,
			rewardId = arg_4_3
		}
	end

	return arg_4_0.rewardDict[arg_4_1][arg_4_2][arg_4_3]
end

function var_0_0.getGoodsGetNum(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	return arg_5_0:getRewardItem(arg_5_1, arg_5_2, arg_5_3).num
end

function var_0_0.checkPoolIsEmpty(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:getPoolDrawCount()

	return var_6_1 ~= 0 and var_6_1 <= var_6_0
end

function var_0_0.getPoolDrawCount(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = Activity129Config.instance:getGoodsDict(arg_7_0.poolId)

	for iter_7_0, iter_7_1 in pairs(var_7_2) do
		local var_7_3 = GameUtil.splitString2(iter_7_1.goodsId, true)

		if var_7_3 then
			for iter_7_2, iter_7_3 in ipairs(var_7_3) do
				if iter_7_3[4] > 0 then
					var_7_0 = var_7_0 + iter_7_3[4]
					var_7_1 = var_7_1 + arg_7_0:getGoodsGetNum(iter_7_0, iter_7_3[1], iter_7_3[2])
				end
			end
		end
	end

	return var_7_1, var_7_0
end

return var_0_0
