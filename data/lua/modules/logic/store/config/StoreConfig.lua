module("modules.logic.store.config.StoreConfig", package.seeall)

local var_0_0 = class("StoreConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._storeEntranceConfig = nil
	arg_1_0._storeGoodsConfig = nil
	arg_1_0._storeRecommendConfig = nil
	arg_1_0._storeConfig = nil
	arg_1_0._storeChargeConfig = nil
	arg_1_0._storeChargeGoodsConfig = nil
	arg_1_0._dailyReleasePackageCfg = nil
	arg_1_0._storeMonthAddCfg = nil
	arg_1_0._critterStoreGoods = {}
	arg_1_0._preGoodsIdDict = nil
	arg_1_0._decorateProduct2GoodsId = {}
	arg_1_0._roomProduct2GoodsId = {}
	arg_1_0._configPriceKey = "price"
	arg_1_0._configBasePriceKey = "price"
	arg_1_0._configCurrencyCodeKey = "currencyCode"
	arg_1_0._configOriginalCostKey = "originalCost"

	if GameChannelConfig.isLongCheng() then
		arg_1_0._configBasePriceKey = "pricekr"
		arg_1_0._configPriceKey = "pricekr"
		arg_1_0._configCurrencyCodeKey = "currencyCodekr"
		arg_1_0._configOriginalCostKey = "originalCostkr"
	elseif GameChannelConfig.isGpJapan() then
		arg_1_0._configBasePriceKey = "pricejp"
		arg_1_0._configPriceKey = "pricejp"
		arg_1_0._configCurrencyCodeKey = "currencyCodejp"
		arg_1_0._configOriginalCostKey = "originalCostjp"
	end
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"store_entrance",
		"store_goods",
		"store",
		"store_recommend",
		"store_charge",
		"store_charge_goods",
		"month_card",
		"slow_release_gift",
		"store_charge_optional",
		"month_card_added",
		"store_charge_conditional"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "store_entrance" then
		arg_3_0._storeEntranceConfig = arg_3_2
	elseif arg_3_1 == "store_goods" then
		arg_3_0._storeGoodsConfig = arg_3_2

		arg_3_0:initPreGoodsIdDict(arg_3_2)
	elseif arg_3_1 == "store" then
		arg_3_0._storeConfig = arg_3_2
	elseif arg_3_1 == "store_recommend" then
		arg_3_0._storeRecommendConfig = arg_3_2
	elseif arg_3_1 == "store_charge" then
		arg_3_0._storeChargeConfig = arg_3_2
	elseif arg_3_1 == "store_charge_goods" then
		arg_3_0:initStoreChargeGoodsConfig(arg_3_2)
	elseif arg_3_1 == "month_card" then
		arg_3_0._monthCardConfig = arg_3_2
	elseif arg_3_1 == "slow_release_gift" then
		arg_3_0._dailyReleasePackageCfg = arg_3_2
	elseif arg_3_1 == "store_charge_optional" then
		arg_3_0._chargeOptionalConfig = arg_3_2
	elseif arg_3_1 == "month_card_added" then
		arg_3_0._storeMonthAddCfg = arg_3_2
	elseif arg_3_1 == "store_charge_conditional" then
		arg_3_0._storeChargeConditionalConfig = arg_3_2
	end
end

function var_0_0.initPreGoodsIdDict(arg_4_0, arg_4_1)
	arg_4_0._preGoodsIdDict = {}
	arg_4_0._roomProduct2GoodsId = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1.configDict) do
		if iter_4_1.preGoodsId ~= 0 then
			arg_4_0._preGoodsIdDict[iter_4_1.preGoodsId] = iter_4_0
		end

		local var_4_0 = tonumber(iter_4_1.storeId)

		if var_4_0 == StoreEnum.StoreId.NewRoomStore or var_4_0 == StoreEnum.StoreId.OldRoomStore then
			local var_4_1
			local var_4_2
			local var_4_3 = GameUtil.splitString2(iter_4_1.product, true)

			if var_4_3 and #var_4_3 == 1 then
				local var_4_4 = var_4_3[1]
				local var_4_5 = var_4_4[1]

				if var_4_5 == MaterialEnum.MaterialType.Building or var_4_5 == MaterialEnum.MaterialType.BlockPackage then
					var_4_1 = var_4_5
					var_4_2 = var_4_4[2]
				end
			end

			if var_4_1 and var_4_2 then
				local var_4_6 = arg_4_0._roomProduct2GoodsId[var_4_1]

				if not var_4_6 then
					var_4_6 = {}
					arg_4_0._roomProduct2GoodsId[var_4_1] = var_4_6
				end

				var_4_6[var_4_2] = iter_4_1.id
			end
		elseif var_4_0 == StoreEnum.StoreId.CritterStore then
			local var_4_7 = string.splitToNumber(iter_4_1.product, "#")

			if not arg_4_0._critterStoreGoods[var_4_7[2]] then
				arg_4_0._critterStoreGoods[var_4_7[2]] = {}
			end

			table.insert(arg_4_0._critterStoreGoods[var_4_7[2]], iter_4_1)
		elseif var_4_0 == StoreEnum.StoreId.NewDecorateStore or var_4_0 == StoreEnum.StoreId.OldDecorateStore then
			local var_4_8 = string.splitToNumber(iter_4_1.product, "#")

			if not arg_4_0._decorateProduct2GoodsId[var_4_8[2]] then
				arg_4_0._decorateProduct2GoodsId[var_4_8[2]] = {}
			end

			arg_4_0._decorateProduct2GoodsId[var_4_8[2]] = iter_4_1
		end
	end
end

function var_0_0.initStoreChargeGoodsConfig(arg_5_0, arg_5_1)
	arg_5_0._storeChargeGoodsConfig = arg_5_1
	arg_5_0._skin2ChargeGoodsCfg = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._storeChargeGoodsConfig.configList) do
		if iter_5_1.belongStoreId == StoreEnum.StoreId.Skin then
			local var_5_0 = GameUtil.splitString2(iter_5_1.item, true)
			local var_5_1

			if var_5_0 and #var_5_0 == 1 then
				local var_5_2 = var_5_0[1]

				if var_5_2[1] == MaterialEnum.MaterialType.HeroSkin then
					var_5_1 = var_5_2[2]
				end
			end

			if var_5_1 then
				arg_5_0._skin2ChargeGoodsCfg[var_5_1] = iter_5_1
			end
		end
	end
end

function var_0_0.getSkinChargeGoodsCfg(arg_6_0, arg_6_1)
	return arg_6_0._skin2ChargeGoodsCfg[arg_6_1]
end

function var_0_0.getSkinChargePrice(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1
	local var_7_2 = arg_7_0:getSkinChargeGoodsCfg(arg_7_1)

	if var_7_2 then
		var_7_0 = var_7_2.price
		var_7_1 = var_7_2.originalCost
		var_7_0 = PayModel.instance:getProductPrice(var_7_2.id)
		var_7_1 = PayModel.instance:getProductPrice(var_7_2.originalCostGoodsId)
	end

	return var_7_0, var_7_1
end

function var_0_0.getSkinChargeGoodsId(arg_8_0, arg_8_1)
	local var_8_0
	local var_8_1 = arg_8_0:getSkinChargeGoodsCfg(arg_8_1)

	if var_8_1 then
		var_8_0 = var_8_1.id
	end

	return var_8_0
end

function var_0_0.getTabConfig(arg_9_0, arg_9_1)
	return arg_9_0._storeEntranceConfig.configDict[arg_9_1]
end

function var_0_0.getGoodsConfig(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._storeGoodsConfig.configDict[arg_10_1]

	if not var_10_0 then
		logError("找不到商品: " .. tostring(arg_10_1))
	end

	return var_10_0
end

function var_0_0.getCharageGoodsCfgListByPoolId(arg_11_0, arg_11_1)
	if not arg_11_0._poolId2CharageGoodsCfgListDic and arg_11_0._storeChargeGoodsConfig and arg_11_0._storeChargeConditionalConfig then
		arg_11_0._poolId2CharageGoodsCfgListDic = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_0._storeChargeGoodsConfig.configList) do
			local var_11_0 = arg_11_0:getChargeConditionalConfig(iter_11_1.taskid)
			local var_11_1 = var_11_0 and var_11_0.id

			if var_11_1 and var_11_1 ~= 0 then
				arg_11_0._poolId2CharageGoodsCfgListDic[var_11_1] = arg_11_0._poolId2CharageGoodsCfgListDic[var_11_1] or {}

				table.insert(arg_11_0._poolId2CharageGoodsCfgListDic[var_11_1], iter_11_1)
			end
		end
	end

	return arg_11_0._poolId2CharageGoodsCfgListDic and arg_11_0._poolId2CharageGoodsCfgListDic[arg_11_1]
end

function var_0_0.getChargeGoodsConfig(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._storeChargeGoodsConfig.configDict[arg_12_1]

	if not var_12_0 and arg_12_2 ~= true then
		logError("找不到充值商品: " .. tostring(arg_12_1))
	end

	return var_12_0
end

function var_0_0.findChargeConditionalConfigByGoodsId(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getChargeGoodsConfig(arg_13_1, true)

	if var_13_0 then
		return arg_13_0:getChargeConditionalConfig(var_13_0.taskid)
	end
end

function var_0_0.getChargeConditionalConfig(arg_14_0, arg_14_1)
	return arg_14_0._storeChargeConditionalConfig.configDict[arg_14_1]
end

function var_0_0.getChargeGoodsPrice(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getChargeGoodsConfig(arg_15_1, arg_15_2)

	if var_15_0 then
		return var_15_0[arg_15_0._configPriceKey]
	end

	return 0
end

function var_0_0.getBaseChargeGoodsPrice(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getChargeGoodsConfig(arg_16_1, arg_16_2)

	if var_16_0 then
		return var_16_0[arg_16_0._configBasePriceKey]
	end

	return 0
end

function var_0_0.getChargeGoodsCurrencyCode(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getChargeGoodsConfig(arg_17_1, arg_17_2)

	if var_17_0 then
		return var_17_0[arg_17_0._configCurrencyCodeKey]
	end

	return "USD"
end

function var_0_0.getChargeGoodsOriginalCost(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getChargeGoodsConfig(arg_18_1, arg_18_2)

	if var_18_0 then
		return var_18_0[arg_18_0._configOriginalCostKey]
	end

	return 0
end

function var_0_0.getAllChargeGoodsConfig(arg_19_0)
	return arg_19_0._storeChargeGoodsConfig.configDict
end

function var_0_0.getStoreChargeConfig(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0

	if arg_20_0._storeChargeConfig.configDict[arg_20_1] then
		var_20_0 = arg_20_0._storeChargeConfig.configDict[arg_20_1][arg_20_2]
	end

	if not var_20_0 and not arg_20_3 then
		logError("找不到充值商品相关配置: " .. tostring(arg_20_1) .. arg_20_2)
	end

	return var_20_0
end

function var_0_0.getStoreChargeConfigByProductID(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._storeChargeConfig.configDict
	local var_21_1 = BootNativeUtil.getPackageName()
	local var_21_2 = {}

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if iter_21_1[var_21_1] and iter_21_1[var_21_1].appStoreProductID == arg_21_1 then
			table.insert(var_21_2, iter_21_1[var_21_1])
		end
	end

	return var_21_2
end

function var_0_0.getStoreRecommendConfig(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._storeRecommendConfig.configDict[arg_22_1]

	if not var_22_0 then
		logError("找不到充值商品相关配置: " .. tostring(arg_22_1))
	end

	return var_22_0
end

function var_0_0.getStoreConfig(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._storeConfig.configDict[arg_23_1]

	if not var_23_0 then
		logError("找不到商店: " .. tostring(arg_23_1))
	end

	return var_23_0
end

function var_0_0.getAllStoreIds(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = arg_24_0._storeConfig.configDict

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		table.insert(var_24_0, iter_24_1.id)
	end

	return var_24_0
end

function var_0_0.getTabHierarchy(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getTabConfig(arg_25_1)

	if not var_25_0 then
		return 0
	end

	if not arg_25_0:hasTab(var_25_0.belongFirstTab) and not arg_25_0:hasTab(var_25_0.belongSecondTab) then
		return 1
	elseif not arg_25_0:hasTab(var_25_0.belongSecondTab) then
		return 2
	else
		return 3
	end
end

function var_0_0.isPackageStore(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getTabConfig(arg_26_1)

	if var_26_0 and var_26_0.belongFirstTab == StoreEnum.StoreId.Package then
		return true
	end

	return false
end

function var_0_0.getMonthCardConfig(arg_27_0, arg_27_1)
	if arg_27_1 == StoreEnum.LittleMonthCardGoodsId then
		local var_27_0 = arg_27_0._storeMonthAddCfg.configDict[arg_27_1]

		if var_27_0 ~= nil then
			return arg_27_0._monthCardConfig.configDict[var_27_0.month_id]
		end
	end

	return arg_27_0._monthCardConfig.configDict[arg_27_1]
end

function var_0_0.getDailyReleasePackageCfg(arg_28_0, arg_28_1)
	return arg_28_0._dailyReleasePackageCfg.configDict[arg_28_1]
end

function var_0_0.getOpenTimeDiff(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2 <= arg_29_1 then
		logError("结束时间比开启时间早")
	elseif arg_29_3 < arg_29_1 then
		return arg_29_3 - arg_29_1
	elseif arg_29_3 < arg_29_2 then
		return arg_29_2 - arg_29_3
	end

	return 0
end

function var_0_0.hasTab(arg_30_0, arg_30_1)
	return arg_30_1 and arg_30_1 ~= 0
end

function var_0_0.getRemain(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_2 <= 0 then
		return nil
	end

	local var_31_0 = arg_31_1.maxBuyCount

	if arg_31_1.refreshTime == StoreEnum.RefreshTime.Forever then
		if var_31_0 > 0 then
			if arg_31_1.jumpId ~= 0 then
				return formatLuaLang("store_limitget", arg_31_2)
			elseif arg_31_3 > 0 then
				return formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_31_2)
			else
				return formatLuaLang("store_buylimit_forever", arg_31_2)
			end
		else
			return nil
		end
	elseif arg_31_1.refreshTime == StoreEnum.RefreshTime.Day then
		return formatLuaLang("store_buylimit_day", arg_31_2)
	elseif arg_31_1.refreshTime == StoreEnum.RefreshTime.Week then
		return formatLuaLang("store_buylimit_week", arg_31_2)
	elseif arg_31_1.refreshTime == StoreEnum.RefreshTime.Month then
		return formatLuaLang("store_buylimit_month", arg_31_2)
	else
		return formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_31_2)
	end
end

function var_0_0.getRemainText(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	if arg_32_2 == StoreEnum.RefreshTime.Forever then
		if arg_32_1 > 0 then
			if arg_32_4 > 0 then
				return formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_32_3)
			else
				return formatLuaLang("store_buylimit_forever", arg_32_3)
			end
		else
			return nil
		end
	elseif arg_32_2 == StoreEnum.RefreshTime.Day then
		return formatLuaLang("store_buylimit_day", arg_32_3)
	elseif arg_32_2 == StoreEnum.RefreshTime.Week then
		return formatLuaLang("store_buylimit_week", arg_32_3)
	elseif arg_32_2 == StoreEnum.RefreshTime.Month then
		return formatLuaLang("store_buylimit_month", arg_32_3)
	else
		return formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_32_3)
	end
end

function var_0_0.getChargeRemainText(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	if arg_33_2 == StoreEnum.ChargeRefreshTime.Forever then
		if arg_33_1 > 0 then
			if arg_33_4 > 0 then
				return formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_33_3)
			else
				return formatLuaLang("store_buylimit_forever", arg_33_3)
			end
		else
			return nil
		end
	elseif arg_33_2 == StoreEnum.ChargeRefreshTime.MonthCard then
		local var_33_0 = StoreModel.instance:getMonthCardInfo()

		if var_33_0 then
			local var_33_1 = var_33_0:getRemainDay()

			if var_33_1 == StoreEnum.MonthCardStatus.NotPurchase then
				return nil
			elseif var_33_1 == StoreEnum.MonthCardStatus.NotEnoughOneDay then
				return luaLang("not_enough_one_day")
			else
				return formatLuaLang("remain_day", var_33_1)
			end
		else
			return nil
		end
	elseif arg_33_2 == StoreEnum.ChargeRefreshTime.Day then
		return formatLuaLang("store_buylimit_day", arg_33_3)
	elseif arg_33_2 == StoreEnum.ChargeRefreshTime.Week then
		return formatLuaLang("store_buylimit_week", arg_33_3)
	elseif arg_33_2 == StoreEnum.ChargeRefreshTime.Month then
		return formatLuaLang("store_buylimit_month", arg_33_3)
	else
		return formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_33_3)
	end
end

function var_0_0.hasNextGood(arg_34_0, arg_34_1)
	return arg_34_0._preGoodsIdDict[arg_34_1] ~= nil
end

function var_0_0.getRoomProductGoodsId(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0

	if arg_35_0._roomProduct2GoodsId then
		var_35_0 = (arg_35_0._roomProduct2GoodsId[arg_35_1] or {})[arg_35_2]
	end

	return var_35_0
end

function var_0_0.getRoomCritterProductGoods(arg_36_0, arg_36_1)
	return arg_36_0._critterStoreGoods[arg_36_1] or {}
end

function var_0_0.getChargeOptionalGroup(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0._chargeOptionalConfig.configDict[arg_37_1]

	if not var_37_0 then
		logError("充值商品ID未配置充值自选礼包表" .. tostring(arg_37_1))
	end

	return var_37_0
end

function var_0_0.getMonthCardAddConfig(arg_38_0, arg_38_1)
	return arg_38_0._storeMonthAddCfg.configDict[arg_38_1]
end

function var_0_0.getSeasonCardMultiFactor(arg_39_0)
	return CommonConfig.instance:getConstNum(2501)
end

function var_0_0.getDecorateGoodsCfgById(arg_40_0, arg_40_1)
	return arg_40_0._decorateProduct2GoodsId[arg_40_1]
end

function var_0_0.getDecorateGoodsIdById(arg_41_0, arg_41_1)
	local var_41_0
	local var_41_1 = arg_41_0:getDecorateGoodsCfgById(arg_41_1)

	if var_41_1 then
		var_41_0 = var_41_1.id
	end

	return var_41_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
