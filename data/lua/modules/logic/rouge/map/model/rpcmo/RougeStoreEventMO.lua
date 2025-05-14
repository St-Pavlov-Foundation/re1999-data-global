module("modules.logic.rouge.map.model.rpcmo.RougeStoreEventMO", package.seeall)

local var_0_0 = class("RougeStoreEventMO", RougeBaseEventMO)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.boughtPosList = arg_1_0.jsonData.boughtGoodsPosSet

	if arg_1_0.jsonData.posGoodMap then
		arg_1_0.posGoodsList = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_0.jsonData.posGoodMap) do
			arg_1_0.posGoodsList[tonumber(iter_1_0)] = iter_1_1
		end
	end

	arg_1_0.refreshNum = arg_1_0.jsonData.refreshNum
	arg_1_0.refreshNeedCoin = arg_1_0.jsonData.refreshNeedCoin
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.update(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0.boughtPosList = arg_2_0.jsonData.boughtGoodsPosSet

	if arg_2_0.jsonData.posGoodMap then
		arg_2_0.posGoodsList = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_0.jsonData.posGoodMap) do
			arg_2_0.posGoodsList[tonumber(iter_2_0)] = iter_2_1
		end
	end

	arg_2_0.refreshNum = arg_2_0.jsonData.refreshNum
	arg_2_0.refreshNeedCoin = arg_2_0.jsonData.refreshNeedCoin
end

function var_0_0.checkIsSellOut(arg_3_0, arg_3_1)
	return tabletool.indexOf(arg_3_0.boughtPosList, arg_3_1)
end

function var_0_0.__tostring(arg_4_0)
	return var_0_0.super.__tostring(arg_4_0)
end

return var_0_0
