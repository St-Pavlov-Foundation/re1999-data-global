module("modules.logic.store.model.StoreMO", package.seeall)

local var_0_0 = pureTable("StoreMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.nextRefreshTime = arg_1_1.nextRefreshTime
	arg_1_0.goodsInfos = arg_1_1.goodsInfos
	arg_1_0.offlineTime = arg_1_1.offlineTime

	arg_1_0:_initstoreGoodsMOList()
end

function var_0_0._initstoreGoodsMOList(arg_2_0)
	arg_2_0._storeGoodsMOList = {}

	if arg_2_0.goodsInfos and #arg_2_0.goodsInfos > 0 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.goodsInfos) do
			local var_2_0 = StoreGoodsMO.New()

			var_2_0:init(arg_2_0.id, iter_2_1)
			table.insert(arg_2_0._storeGoodsMOList, var_2_0)
		end
	end
end

function var_0_0.buyGoodsReply(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._storeGoodsMOList and #arg_3_0._storeGoodsMOList > 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._storeGoodsMOList) do
			if iter_3_1.goodsId == arg_3_1 then
				iter_3_1:buyGoodsReply(arg_3_2)

				return
			end
		end
	end
end

function var_0_0.getBuyCount(arg_4_0, arg_4_1)
	if arg_4_0._storeGoodsMOList and #arg_4_0._storeGoodsMOList > 0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._storeGoodsMOList) do
			if iter_4_1.goodsId == arg_4_1 then
				return iter_4_1.buyCount or 0
			end
		end
	end

	return 0
end

function var_0_0.getGoodsList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._storeGoodsMOList

	if arg_5_1 and #var_5_0 > 0 then
		table.sort(var_5_0, arg_5_0._goodsSortFunction)
	end

	return var_5_0
end

function var_0_0.getGoodsCount(arg_6_0)
	return arg_6_0._storeGoodsMOList and #arg_6_0._storeGoodsMOList or 0
end

function var_0_0.getGoodsMO(arg_7_0, arg_7_1)
	if arg_7_0._storeGoodsMOList and #arg_7_0._storeGoodsMOList > 0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._storeGoodsMOList) do
			if iter_7_1.goodsId == arg_7_1 then
				return iter_7_1
			end
		end
	end
end

function var_0_0._goodsSortFunction(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:isSoldOut()
	local var_8_1 = arg_8_1:isSoldOut()
	local var_8_2 = arg_8_0:alreadyHas()
	local var_8_3 = arg_8_1:alreadyHas()

	if var_8_2 and not var_8_3 then
		return false
	elseif var_8_3 and not var_8_2 then
		return true
	end

	if var_8_0 and not var_8_1 then
		return false
	elseif var_8_1 and not var_8_0 then
		return true
	end

	local var_8_4 = StoreConfig.instance:getGoodsConfig(arg_8_0.goodsId)
	local var_8_5 = StoreConfig.instance:getGoodsConfig(arg_8_1.goodsId)

	if var_8_4.order > var_8_5.order then
		return true
	elseif var_8_4.order < var_8_5.order then
		return false
	end

	return var_8_4.id < var_8_5.id
end

return var_0_0
