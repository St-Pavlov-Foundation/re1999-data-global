module("modules.logic.versionactivity1_2.trade.model.Activity117OrderMO", package.seeall)

local var_0_0 = pureTable("Activity117OrderMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityId = arg_1_1

	local var_1_0 = Activity117Config.instance:getOrderConfig(arg_1_1, arg_1_2)

	arg_1_0:resetCo(var_1_0)
	arg_1_0:resetData()
end

function var_0_0.resetCo(arg_2_0, arg_2_1)
	arg_2_0.co = arg_2_1
	arg_2_0.id = arg_2_1.id
	arg_2_0.order = arg_2_1.order
	arg_2_0.minScore = arg_2_1.minDealScore
	arg_2_0.maxScore = arg_2_1.maxDealScore
	arg_2_0.maxAcceptScore = arg_2_1.maxAcceptScore
	arg_2_0.maxProgress = arg_2_1.maxProgress
	arg_2_0.desc = arg_2_1.name or ""
	arg_2_0.jumpId = arg_2_1.jumpId
end

function var_0_0.resetData(arg_3_0)
	arg_3_0.hasGetBonus = false
	arg_3_0.userDealScores = {}
	arg_3_0.progress = 0
end

function var_0_0.updateServerData(arg_4_0, arg_4_1)
	arg_4_0.hasGetBonus = arg_4_1.hasGetBonus
	arg_4_0.userDealScores = arg_4_1.userDealScores
	arg_4_0.progress = arg_4_1.progress

	arg_4_0:updateStatus()
end

function var_0_0.getLastRound(arg_5_0)
	return arg_5_0.userDealScores[#arg_5_0.userDealScores]
end

function var_0_0.sortOrderFunc(arg_6_0, arg_6_1)
	if arg_6_0.hasGetBonus and arg_6_1.hasGetBonus then
		return arg_6_0.order < arg_6_1.order
	end

	if not arg_6_0.hasGetBonus and not arg_6_1.hasGetBonus then
		if arg_6_0:isProgressEnough() and not arg_6_1:isProgressEnough() then
			return true
		end

		if not arg_6_0:isProgressEnough() and arg_6_1:isProgressEnough() then
			return false
		end

		return arg_6_0.order < arg_6_1.order
	end

	return not arg_6_0.hasGetBonus
end

function var_0_0.getDesc(arg_7_0)
	return arg_7_0.desc
end

function var_0_0.isProgressEnough(arg_8_0)
	return arg_8_0.progress >= arg_8_0.maxProgress
end

function var_0_0.updateStatus(arg_9_0)
	if arg_9_0.hasGetBonus then
		arg_9_0.status = Activity117Enum.Status.AlreadyGot

		return
	end

	if arg_9_0:isProgressEnough() then
		arg_9_0.status = Activity117Enum.Status.CanGet

		return
	end

	arg_9_0.status = Activity117Enum.Status.NotEnough
end

function var_0_0.getStatus(arg_10_0)
	return arg_10_0.status
end

function var_0_0.checkPrice(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.minScore
	local var_11_1 = arg_11_0.maxAcceptScore

	if var_11_1 < arg_11_1 then
		return Activity117Enum.PriceType.Bad
	end

	local var_11_2 = (var_11_1 - var_11_0) / 3

	if arg_11_1 <= var_11_0 + var_11_2 then
		return Activity117Enum.PriceType.Best
	end

	if arg_11_1 <= var_11_0 + 2 * var_11_2 then
		return Activity117Enum.PriceType.Better
	end

	return Activity117Enum.PriceType.Common
end

function var_0_0.getMinPrice(arg_12_0)
	for iter_12_0 = #arg_12_0.userDealScores, 1, -1 do
		if arg_12_0:checkPrice(arg_12_0.userDealScores[iter_12_0]) ~= Activity117Enum.PriceType.Bad then
			return arg_12_0.userDealScores[iter_12_0]
		end
	end

	return arg_12_0.minScore
end

return var_0_0
