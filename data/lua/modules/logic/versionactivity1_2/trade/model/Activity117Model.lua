module("modules.logic.versionactivity1_2.trade.model.Activity117Model", package.seeall)

local var_0_0 = class("Activity117Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._actDict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actDict = {}
end

function var_0_0.release(arg_3_0)
	arg_3_0._actDict = {}
end

function var_0_0.initAct(arg_4_0, arg_4_1)
	arg_4_0:getActData(arg_4_1, true)
end

function var_0_0.getActData(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0._actDict[arg_5_1]

	if not var_5_0 and arg_5_2 then
		var_5_0 = Activity117MO.New()

		var_5_0:init(arg_5_1)

		arg_5_0._actDict[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0.onReceiveInfos(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getActData(arg_6_1.activityId)

	if not var_6_0 then
		return
	end

	var_6_0:onInitServerData(arg_6_1)
end

function var_0_0.onNegotiateResult(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getActData(arg_7_1.activityId)

	if not var_7_0 then
		return
	end

	var_7_0:onNegotiateResult(arg_7_1)
end

function var_0_0.onDealSuccess(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getActData(arg_8_1.activityId)

	if not var_8_0 then
		return
	end

	var_8_0:onDealSuccess(arg_8_1)
end

function var_0_0.onOrderPush(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getActData(arg_9_1.activityId)

	if not var_9_0 then
		return
	end

	var_9_0:onOrderPush(arg_9_1)
end

function var_0_0.updateRewardDatas(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getActData(arg_10_1.activityId)

	if not var_10_0 then
		return
	end

	var_10_0:updateHasGetBonusIds(arg_10_1.bonusIds)
end

function var_0_0.getOrderDataById(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getActData(arg_11_1)

	if not var_11_0 then
		return
	end

	return var_11_0:getOrderData(arg_11_2)
end

function var_0_0.getOrderList(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getActData(arg_12_1)

	if not var_12_0 then
		return
	end

	return var_12_0:getOrderList(arg_12_2)
end

function var_0_0.getRewardList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getActData(arg_13_1)

	if not var_13_0 then
		return
	end

	return var_13_0:getRewardList()
end

function var_0_0.getRemainDay(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getActData(arg_14_1)

	if not var_14_0 then
		return 0
	end

	return var_14_0:getRemainDay()
end

function var_0_0.getCurrentScore(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getActData(arg_15_1)

	if not var_15_0 then
		return 0
	end

	return var_15_0:getCurrentScore()
end

function var_0_0.getNextScore(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getActData(arg_16_1)

	if not var_16_0 then
		return 0
	end

	return var_16_0:getNextScore(arg_16_2)
end

function var_0_0.setSelectOrder(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getActData(arg_17_1)

	if not var_17_0 then
		return
	end

	var_17_0:setSelectOrder(arg_17_2)
end

function var_0_0.getSelectOrder(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getActData(arg_18_1)

	if not var_18_0 then
		return
	end

	return var_18_0:getSelectOrder()
end

function var_0_0.isSelectOrder(arg_19_0, arg_19_1)
	return arg_19_0:getSelectOrder(arg_19_1) ~= nil
end

function var_0_0.setInQuote(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getActData(arg_20_1)

	if not var_20_0 then
		return
	end

	var_20_0:setInQuote(arg_20_2)
end

function var_0_0.isInQuote(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getActData(arg_21_1)

	if not var_21_0 then
		return
	end

	return var_21_0:isInQuote()
end

function var_0_0.getFinishOrderCount(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getActData(arg_22_1)

	if not var_22_0 then
		return
	end

	return var_22_0:getFinishOrderCount()
end

function var_0_0.clear(arg_23_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
