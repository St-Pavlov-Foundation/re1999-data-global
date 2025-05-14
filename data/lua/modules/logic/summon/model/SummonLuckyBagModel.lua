module("modules.logic.summon.model.SummonLuckyBagModel", package.seeall)

local var_0_0 = class("SummonLuckyBagModel", BaseModel)

function var_0_0.isLuckyBagOpened(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SummonMainModel.instance:getPoolServerMO(arg_1_1)

	if var_1_0 and var_1_0.luckyBagMO then
		return var_1_0.luckyBagMO:isOpened()
	end

	return false
end

function var_0_0.getGachaRemainTimes(arg_2_0, arg_2_1)
	local var_2_0 = SummonConfig.instance:getSummonPool(arg_2_1)
	local var_2_1 = SummonMainModel.instance:getPoolServerMO(arg_2_1)
	local var_2_2 = SummonConfig.getSummonSSRTimes(var_2_0)

	if var_2_1 and var_2_1.luckyBagMO then
		return var_2_2 - var_2_1.luckyBagMO.summonTimes
	end

	return var_2_2
end

function var_0_0.isLuckyBagGot(arg_3_0, arg_3_1)
	local var_3_0 = SummonMainModel.instance:getPoolServerMO(arg_3_1)

	if var_3_0 and var_3_0.luckyBagMO then
		return var_3_0.luckyBagMO:isGot(), var_3_0.luckyBagMO.luckyBagId
	end

	return false
end

function var_0_0.needAutoPopup(arg_4_0, arg_4_1)
	local var_4_0 = PlayerModel.instance:getPlayinfo()

	if not var_4_0 or var_4_0.userId == 0 then
		return nil
	end

	local var_4_1 = string.format("LuckyBagAutoPopup_%s_%s", var_4_0.userId, arg_4_1)

	if string.nilorempty(PlayerPrefsHelper.getString(var_4_1, "")) then
		return true
	end

	return false
end

function var_0_0.recordAutoPopup(arg_5_0, arg_5_1)
	local var_5_0 = PlayerModel.instance:getPlayinfo()

	if not var_5_0 or var_5_0.userId == 0 then
		return nil
	end

	local var_5_1 = string.format("LuckyBagAutoPopup_%s_%s", var_5_0.userId, arg_5_1)

	PlayerPrefsHelper.setString(var_5_1, "1")
end

var_0_0.instance = var_0_0.New()

return var_0_0
