module("modules.logic.versionactivity1_6.act147.model.FurnaceTreasureModel", package.seeall)

local var_0_0 = class("FurnaceTreasureModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:resetData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:resetData()
end

function var_0_0._checkServerData(arg_3_0, arg_3_1)
	local var_3_0 = false

	if arg_3_1 then
		local var_3_1 = arg_3_1.activityId

		var_3_0 = arg_3_0:_checkActId(var_3_1)
	end

	return var_3_0
end

function var_0_0._checkActId(arg_4_0, arg_4_1)
	local var_4_0 = false

	if arg_4_1 then
		var_4_0 = arg_4_1 == arg_4_0:getActId()
	end

	return var_4_0
end

function var_0_0.getActId(arg_5_0)
	local var_5_0 = ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.Act147)

	return var_5_0 and var_5_0[1]
end

function var_0_0.isActivityOpen(arg_6_0)
	local var_6_0 = arg_6_0:getActId()

	return (ActivityModel.instance:isActOnLine(var_6_0))
end

function var_0_0._checkGoodsData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = false
	local var_7_1 = arg_7_0:isActivityOpen()

	if not arg_7_1 or not arg_7_2 and not var_7_1 then
		return var_7_0
	end

	if arg_7_0._store2GoodsData[arg_7_1] and arg_7_0._store2GoodsData[arg_7_1][arg_7_2] then
		var_7_0 = true
	else
		logError(string.format("FurnaceTreasureModel:_checkGoodsData error,data is nil, storeId:%s, goodsId:%s", arg_7_1, arg_7_2))
	end

	return var_7_0
end

function var_0_0.getGoodsPoolId(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0

	if not arg_8_0:_checkGoodsData(arg_8_1, arg_8_2) then
		return var_8_0
	end

	return arg_8_0._store2GoodsData[arg_8_1][arg_8_2].poolId
end

function var_0_0.getGoodsRemainCount(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	if not arg_9_0:_checkGoodsData(arg_9_1, arg_9_2) then
		return var_9_0
	end

	return arg_9_0._store2GoodsData[arg_9_1][arg_9_2].remainCount
end

function var_0_0.getGoodsListByStoreId(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_0:isActivityOpen()

	if arg_10_1 and var_10_1 and arg_10_0._store2GoodsData[arg_10_1] then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._store2GoodsData[arg_10_1]) do
			var_10_0[#var_10_0 + 1] = iter_10_0
		end
	end

	return var_10_0
end

function var_0_0.getCostItem(arg_11_0, arg_11_1)
	local var_11_0 = FurnaceTreasureEnum.StoreId2CostItem[arg_11_1]

	if not var_11_0 then
		logError(string.format("FurnaceTreasureModel:getCostItem error, no store cost item, storeId:%s", arg_11_1))
	end

	return var_11_0
end

function var_0_0.getTotalRemainCount(arg_12_0)
	return arg_12_0._totalRemainCount
end

function var_0_0.getSpinePlayData(arg_13_0, arg_13_1)
	local var_13_0 = {
		motion = FurnaceTreasureEnum.BeginnerViewSpinePlayData
	}

	if arg_13_1 and FurnaceTreasureEnum.Pool2SpinePlayData[arg_13_1] then
		var_13_0.motion = FurnaceTreasureEnum.Pool2SpinePlayData[arg_13_1]
	end

	return var_13_0
end

function var_0_0.setServerData(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0:_checkServerData(arg_14_1) then
		return
	end

	if arg_14_2 then
		arg_14_0:resetData()
	end

	if arg_14_1.act147Goods then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1.act147Goods) do
			arg_14_0:setGoodsData(iter_14_1)
		end
	end

	arg_14_0:setTotalRemainCount(arg_14_1.totalRemainCount)
	FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
end

function var_0_0.setGoodsData(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.belongStoreId
	local var_15_1 = arg_15_1.id
	local var_15_2 = arg_15_1.remainCount
	local var_15_3 = arg_15_1.poolId
	local var_15_4 = arg_15_0._store2GoodsData[var_15_0]

	if not var_15_4 then
		var_15_4 = {}
		arg_15_0._store2GoodsData[var_15_0] = var_15_4
	end

	if not var_15_4[var_15_1] then
		var_15_4[var_15_1] = {
			poolId = var_15_3
		}
	end

	arg_15_0:setGoodsRemainCount(var_15_0, var_15_1, var_15_2)
end

function var_0_0.updateGoodsData(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.activityId

	if not arg_16_0:_checkActId(var_16_0) then
		return
	end

	local var_16_1 = arg_16_1.goodsId
	local var_16_2 = arg_16_1.remainCount
	local var_16_3 = arg_16_1.storeId

	arg_16_0:setGoodsRemainCount(var_16_3, var_16_1, var_16_2)
	FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
end

function var_0_0.setGoodsRemainCount(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0._store2GoodsData[arg_17_1]
	local var_17_1 = var_17_0 and var_17_0[arg_17_2] or nil

	if not var_17_1 then
		return
	end

	var_17_1.remainCount = arg_17_3
end

function var_0_0.setTotalRemainCount(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or 0
	arg_18_0._totalRemainCount = arg_18_1
end

function var_0_0.decreaseTotalRemainCount(arg_19_0, arg_19_1)
	if arg_19_0:_checkActId(arg_19_1) then
		local var_19_0 = arg_19_0:getActId()
		local var_19_1 = arg_19_0:getTotalRemainCount(var_19_0) - 1

		arg_19_0:setTotalRemainCount(var_19_1)
		FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
	end
end

function var_0_0.resetData(arg_20_0, arg_20_1)
	arg_20_0._store2GoodsData = {}

	arg_20_0:setTotalRemainCount()

	if arg_20_1 then
		FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
