module("modules.logic.backpack.model.ItemInsightModel", package.seeall)

local var_0_0 = class("ItemInsightModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._insightItemList = {}
	arg_2_0._latestPushItemUids = {}
end

function var_0_0.getInsightItem(arg_3_0, arg_3_1)
	return arg_3_0._insightItemList[tonumber(arg_3_1)]
end

function var_0_0.getInsightItemList(arg_4_0)
	return arg_4_0._insightItemList
end

function var_0_0.setInsightItemList(arg_5_0, arg_5_1)
	arg_5_0._insightItemList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = ItemInsightMo.New()

		var_5_0:init(iter_5_1)

		arg_5_0._insightItemList[tonumber(iter_5_1.uid)] = var_5_0
	end
end

function var_0_0.changeInsightItemList(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = tonumber(iter_6_1.uid)
		local var_6_1 = {
			itemid = iter_6_1.itemId,
			uid = var_6_0
		}

		table.insert(arg_6_0._latestPushItemUids, var_6_1)

		if not arg_6_0._insightItemList[var_6_0] then
			local var_6_2 = ItemInsightMo.New()

			var_6_2:init(iter_6_1)

			arg_6_0._insightItemList[var_6_0] = var_6_2
		else
			arg_6_0._insightItemList[var_6_0]:reset(iter_6_1)
		end
	end
end

function var_0_0.getLatestInsightChange(arg_7_0)
	return arg_7_0._latestPushItemUids
end

function var_0_0.getInsightItemCount(arg_8_0, arg_8_1)
	if not arg_8_0._insightItemList[arg_8_1] then
		return 0
	end

	if arg_8_0._insightItemList[arg_8_1].expireTime <= ServerTime.now() then
		return 0
	end

	return arg_8_0._insightItemList[arg_8_1].quantity
end

function var_0_0.getInsightItemCountById(arg_9_0, arg_9_1)
	local var_9_0 = 0
	local var_9_1 = ServerTime.now()

	for iter_9_0, iter_9_1 in pairs(arg_9_0._insightItemList) do
		if iter_9_1.insightId == arg_9_1 and arg_9_0._insightItemList[iter_9_1.uid].expireTime > ServerTime.now() then
			var_9_0 = var_9_0 + iter_9_1.quantity
		end
	end

	return var_9_0
end

function var_0_0.getInsightItemDeadline(arg_10_0, arg_10_1)
	return arg_10_0._insightItemList[arg_10_1] and tonumber(arg_10_0._insightItemList[arg_10_1].expireTime) or 0
end

function var_0_0.getInsightItemCoByUid(arg_11_0, arg_11_1)
	return arg_11_0._insightItemList[arg_11_1] and ItemConfig.instance:getInsightItemCo(arg_11_0._insightItemList[arg_11_1].id) or nil
end

function var_0_0.getEarliestExpireInsight(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1 = ServerTime.now()

	for iter_12_0, iter_12_1 in pairs(arg_12_0._insightItemList) do
		if iter_12_1.insightId == arg_12_1 and iter_12_1.quantity > 0 and iter_12_1.expireTime ~= 0 and var_12_1 < iter_12_1.expireTime then
			if var_12_0 then
				if var_12_0.expireTime > iter_12_1.expireTime then
					var_12_0 = iter_12_1
				end
			else
				var_12_0 = iter_12_1
			end
		end
	end

	return var_12_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
