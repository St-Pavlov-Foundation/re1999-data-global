module("modules.logic.tower.model.TowerStoreModel", package.seeall)

local var_0_0 = class("TowerStoreModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.goodsInfosDict = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getCurrencyIcon(arg_3_0, arg_3_1)
	local var_3_0 = CurrencyEnum.CurrencyType.TowerStore

	if var_3_0 then
		local var_3_1 = CurrencyConfig.instance:getCurrencyCo(var_3_0)

		if var_3_1 then
			return var_3_1.icon .. "_1"
		end
	end
end

function var_0_0.getCurrencyCount(arg_4_0, arg_4_1)
	local var_4_0 = CurrencyEnum.CurrencyType.TowerStore

	if var_4_0 then
		local var_4_1 = CurrencyModel.instance:getCurrency(var_4_0)

		if var_4_1 then
			return var_4_1.quantity
		end
	end

	return 0
end

function var_0_0.getStoreGroupMO(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(StoreEnum.TowerStore) do
		var_5_0[iter_5_1] = StoreModel.instance:getStoreMO(iter_5_1)
	end

	return var_5_0
end

function var_0_0.getStoreGroupName(arg_6_0, arg_6_1)
	local var_6_0 = StoreConfig.instance:getTabConfig(arg_6_1)

	if var_6_0 then
		return var_6_0.name, var_6_0.nameEn
	end
end

function var_0_0.getUpdateStoreRemainTime(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getUpdateStoreActivityMo()

	if var_7_0 then
		return (var_7_0:getRemainTimeStr2ByEndTime(arg_7_1))
	end

	return ""
end

function var_0_0.getUpdateStoreActivityMo(arg_8_0)
	local var_8_0 = arg_8_0:checkUpdateStoreActivity()
	local var_8_1 = ActivityModel.instance:getActivityInfo()[var_8_0]

	if var_8_1 and ActivityHelper.getActivityStatus(var_8_0) == ActivityEnum.ActivityStatus.Normal then
		return var_8_1
	end
end

function var_0_0.checkUpdateStoreActivity(arg_9_0)
	local var_9_0 = arg_9_0:getStoreGroupMO()
	local var_9_1

	if var_9_0 then
		local var_9_2 = var_9_0[StoreEnum.TowerStore.UpdateStore]

		if var_9_2 then
			for iter_9_0, iter_9_1 in pairs(var_9_2:getGoodsList()) do
				if not var_9_1 then
					if iter_9_1.config.activityId ~= 0 then
						var_9_1 = iter_9_1.config.activityId
					end
				elseif var_9_1 ~= iter_9_1.config.activityId then
					logError("回声港湾的红帆陈列馆绑定活动id不一致：" .. "  " .. iter_9_1.config.id)

					return iter_9_1.config.activityId
				end
			end
		end
	end

	return var_9_1
end

function var_0_0.checkStoreNewGoods(arg_10_0)
	local var_10_0 = arg_10_0:checkUpdateStoreActivity()

	if arg_10_0:isHasNewGoods() then
		arg_10_0._isHasNewGoods = true
	elseif var_10_0 then
		local var_10_1 = arg_10_0:getStoreNewGoodsPrefKey()

		arg_10_0._isHasNewGoods = not ActivityEnterMgr.instance:isEnteredActivity(var_10_0)

		if not arg_10_0._isHasNewGoods then
			arg_10_0._isHasNewGoods = PlayerPrefsHelper.getNumber(var_10_1, 0) == 0
		end
	else
		arg_10_0._isHasNewGoods = false
	end

	return arg_10_0._isHasNewGoods
end

function var_0_0.setNotNewStoreGoods(arg_11_0)
	local var_11_0 = arg_11_0:getStoreNewGoodsPrefKey()

	PlayerPrefsHelper.setNumber(var_11_0, 1)

	arg_11_0._isHasNewGoods = false
end

function var_0_0.isHasNewGoodsInStore(arg_12_0)
	return arg_12_0._isHasNewGoods
end

function var_0_0.getStoreNewGoodsPrefKey(arg_13_0)
	local var_13_0 = arg_13_0:checkUpdateStoreActivity() or 0
	local var_13_1 = PlayerModel.instance:getPlayinfo()
	local var_13_2 = var_13_1 and var_13_1.userId or 1999

	return "TowerStoreModel_StoreNewGoods_" .. var_13_2 .. "|" .. var_13_0
end

function var_0_0.getStore(arg_14_0)
	return {
		StoreEnum.TowerStore.UpdateStore,
		StoreEnum.TowerStore.NormalStore
	}
end

function var_0_0.saveAllStoreGroupNewData(arg_15_0)
	local var_15_0 = StoreEnum.TowerStore.NormalStore

	arg_15_0:clearStoreGroupMo(var_15_0)
	arg_15_0:saveStoreGroupNewMo(var_15_0)
end

function var_0_0.readAllStoreGroupNewData(arg_16_0)
	local var_16_0 = StoreEnum.TowerStore.NormalStore

	arg_16_0:readStoreGroupNewMo(var_16_0)
end

function var_0_0.saveStoreGroupNewMo(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getStoreGoodsNewDataPrefKey(arg_17_1)
	local var_17_1 = ""

	if not arg_17_0._storeGroupGoodsMo then
		PlayerPrefsHelper.setString(var_17_0, var_17_1)

		return
	end

	local var_17_2 = arg_17_0._storeGroupGoodsMo[arg_17_1]

	if var_17_2 then
		for iter_17_0, iter_17_1 in pairs(var_17_2) do
			var_17_1 = var_17_1 .. string.format("%s#%s#%s|", iter_17_1.goodsId, iter_17_1.limitCount, iter_17_1.isNew and 0 or 1)
		end
	end

	PlayerPrefsHelper.setString(var_17_0, var_17_1)
end

function var_0_0.readStoreGroupNewMo(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getStoreGoodsNewDataPrefKey(arg_18_1)
	local var_18_1 = PlayerPrefsHelper.getString(var_18_0, "")

	if not arg_18_0._storeGroupGoodsMo then
		arg_18_0._storeGroupGoodsMo = {}
	end

	arg_18_0._storeGroupGoodsMo[arg_18_1] = {}

	local var_18_2 = arg_18_0:getStoreGroupMO()

	if not var_18_2 then
		return
	end

	local var_18_3 = var_18_2[arg_18_1]

	if not var_18_3 then
		return
	end

	local var_18_4 = var_18_3:getGoodsList()

	for iter_18_0, iter_18_1 in pairs(var_18_4) do
		local var_18_5 = iter_18_1.goodsId
		local var_18_6 = iter_18_1.config.maxBuyCount - iter_18_1.buyCount
		local var_18_7 = {
			goodsId = var_18_5,
			limitCount = var_18_6
		}

		if not string.nilorempty(var_18_1) then
			local var_18_8 = GameUtil.splitString2(var_18_1, true, "|", "#")
			local var_18_9

			for iter_18_2, iter_18_3 in pairs(var_18_8) do
				if iter_18_3 and iter_18_3[1] == var_18_5 then
					if iter_18_3[2] ~= var_18_6 then
						var_18_7.isNew = true
					else
						var_18_7.isNew = iter_18_3[3] == 0
						var_18_9 = true
					end
				end
			end

			if not var_18_9 then
				var_18_7.isNew = true
			end
		else
			var_18_7.isNew = true
		end

		arg_18_0._storeGroupGoodsMo[arg_18_1][var_18_5] = var_18_7
	end
end

function var_0_0.clearStoreGroupMo(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._storeGroupGoodsMo and arg_19_0._storeGroupGoodsMo[arg_19_1]

	if var_19_0 then
		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			iter_19_1.isNew = false
		end
	end
end

function var_0_0.getStoreGoodsNewData(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._storeGroupGoodsMo and arg_20_0._storeGroupGoodsMo[arg_20_1]

	return var_20_0 and var_20_0[arg_20_2]
end

function var_0_0.isHasNewGoods(arg_21_0)
	local var_21_0 = StoreEnum.TowerStore.NormalStore
	local var_21_1 = arg_21_0._storeGroupGoodsMo and arg_21_0._storeGroupGoodsMo[var_21_0]

	if var_21_1 then
		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			if iter_21_1.isNew then
				return true
			end
		end
	end
end

function var_0_0.onClickGoodsItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getStoreGoodsNewData(arg_22_1, arg_22_2)

	if var_22_0 then
		var_22_0.isNew = false
	end
end

function var_0_0.getStoreGoodsNewDataPrefKey(arg_23_0, arg_23_1)
	local var_23_0 = PlayerModel.instance:getPlayinfo()
	local var_23_1 = var_23_0 and var_23_0.userId or 1999

	return "TowerStoreModel_StoreGoodsNewData_" .. arg_23_1 .. "_" .. var_23_1
end

function var_0_0.isUpdateStoreEmpty(arg_24_0)
	local var_24_0 = arg_24_0:getStoreGroupMO()
	local var_24_1 = var_24_0 and var_24_0[StoreEnum.TowerStore.UpdateStore]

	return not var_24_1 or next(var_24_1:getGoodsList()) == nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
