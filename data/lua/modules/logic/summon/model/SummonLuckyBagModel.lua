module("modules.logic.summon.model.SummonLuckyBagModel", package.seeall)

local var_0_0 = class("SummonLuckyBagModel", BaseModel)

function var_0_0.isLuckyBagOpened(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SummonMainModel.instance:getPoolServerMO(arg_1_1)

	if var_1_0 and var_1_0.luckyBagMO then
		return var_1_0.luckyBagMO:isOpened(arg_1_2)
	end

	return false
end

function var_0_0.getGachaRemainTimes(arg_2_0, arg_2_1)
	local var_2_0 = SummonConfig.instance:getSummonPool(arg_2_1)
	local var_2_1 = SummonMainModel.instance:getPoolServerMO(arg_2_1)
	local var_2_2 = SummonConfig.getSummonSSRTimes(var_2_0)
	local var_2_3 = SummonConfig.instance:getSummonLuckyBag(arg_2_1)

	if var_2_3 and next(var_2_3) then
		if var_2_1 and var_2_1.luckyBagMO then
			local var_2_4 = #var_2_3
			local var_2_5 = math.max(0, var_2_4 - var_2_1.luckyBagMO.getTimes) * var_2_2 - var_2_1.luckyBagMO.notSSRCount

			return math.max(0, var_2_5)
		else
			return 0
		end
	else
		return 0
	end
end

function var_0_0.isLuckyBagGot(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = SummonMainModel.instance:getPoolServerMO(arg_3_1)

	if var_3_0 and var_3_0.luckyBagMO then
		return var_3_0.luckyBagMO:isGot(arg_3_2)
	end

	return false
end

function var_0_0.getLuckyGodCount(arg_4_0, arg_4_1)
	local var_4_0 = SummonMainModel.instance:getPoolServerMO(arg_4_1)

	if var_4_0 and var_4_0.luckyBagMO then
		return var_4_0.luckyBagMO.getTimes
	end

	return 0
end

function var_0_0.needAutoPopup(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = PlayerModel.instance:getPlayinfo()

	if not var_5_0 or var_5_0.userId == 0 then
		return nil
	end

	local var_5_1 = string.format("LuckyBagAutoPopup_%s_%s_%s", var_5_0.userId, arg_5_1, arg_5_2)

	if string.nilorempty(PlayerPrefsHelper.getString(var_5_1, "")) then
		return true
	end

	return false
end

function var_0_0.recordAutoPopup(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = PlayerModel.instance:getPlayinfo()

	if not var_6_0 or var_6_0.userId == 0 then
		return nil
	end

	local var_6_1 = string.format("LuckyBagAutoPopup_%s_%s_%s", var_6_0.userId, arg_6_1, arg_6_2)

	PlayerPrefsHelper.setString(var_6_1, "1")
end

var_0_0.instance = var_0_0.New()

return var_0_0
