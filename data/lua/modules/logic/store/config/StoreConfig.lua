module("modules.logic.store.config.StoreConfig", package.seeall)

slot0 = class("StoreConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._storeEntranceConfig = nil
	slot0._storeGoodsConfig = nil
	slot0._storeRecommendConfig = nil
	slot0._storeConfig = nil
	slot0._storeChargeConfig = nil
	slot0._storeChargeGoodsConfig = nil
	slot0._dailyReleasePackageCfg = nil
	slot0._storeMonthAddCfg = nil
	slot0._critterStoreGoods = {}
	slot0._preGoodsIdDict = nil
	slot0._roomProduct2GoodsId = {}
	slot0._configPriceKey = "price"
	slot0._configBasePriceKey = "price"
	slot0._configCurrencyCodeKey = "currencyCode"
	slot0._configOriginalCostKey = "originalCost"

	if GameChannelConfig.isLongCheng() then
		slot0._configBasePriceKey = "pricekr"
		slot0._configPriceKey = "pricekr"
		slot0._configCurrencyCodeKey = "currencyCodekr"
		slot0._configOriginalCostKey = "originalCostkr"
	elseif GameChannelConfig.isGpJapan() then
		slot0._configBasePriceKey = "pricejp"
		slot0._configPriceKey = "pricejp"
		slot0._configCurrencyCodeKey = "currencyCodejp"
		slot0._configOriginalCostKey = "originalCostjp"
	end
end

function slot0.reqConfigNames(slot0)
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
		"month_card_added"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "store_entrance" then
		slot0._storeEntranceConfig = slot2
	elseif slot1 == "store_goods" then
		slot0._storeGoodsConfig = slot2

		slot0:initPreGoodsIdDict(slot2)
	elseif slot1 == "store" then
		slot0._storeConfig = slot2
	elseif slot1 == "store_recommend" then
		slot0._storeRecommendConfig = slot2
	elseif slot1 == "store_charge" then
		slot0._storeChargeConfig = slot2
	elseif slot1 == "store_charge_goods" then
		slot0:initStoreChargeGoodsConfig(slot2)
	elseif slot1 == "month_card" then
		slot0._monthCardConfig = slot2
	elseif slot1 == "slow_release_gift" then
		slot0._dailyReleasePackageCfg = slot2
	elseif slot1 == "store_charge_optional" then
		slot0._chargeOptionalConfig = slot2
	elseif slot1 == "month_card_added" then
		slot0._storeMonthAddCfg = slot2
	end
end

function slot0.initPreGoodsIdDict(slot0, slot1)
	slot0._preGoodsIdDict = {}
	slot0._roomProduct2GoodsId = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		if slot6.preGoodsId ~= 0 then
			slot0._preGoodsIdDict[slot6.preGoodsId] = slot5
		end

		if tonumber(slot6.storeId) == StoreEnum.SubRoomNew or slot7 == StoreEnum.SubRoomOld then
			slot8, slot9 = nil

			if GameUtil.splitString2(slot6.product, true) and #slot10 == 1 and (slot10[1][1] == MaterialEnum.MaterialType.Building or slot12 == MaterialEnum.MaterialType.BlockPackage) then
				slot8 = slot12
				slot9 = slot11[2]
			end

			if slot8 and slot9 then
				if not slot0._roomProduct2GoodsId[slot8] then
					slot0._roomProduct2GoodsId[slot8] = {}
				end

				slot11[slot9] = slot6.id
			end
		elseif slot7 == StoreEnum.StoreId.CritterStore then
			if not slot0._critterStoreGoods[string.splitToNumber(slot6.product, "#")[2]] then
				slot0._critterStoreGoods[slot8[2]] = {}
			end

			table.insert(slot0._critterStoreGoods[slot8[2]], slot6)
		end
	end
end

function slot0.initStoreChargeGoodsConfig(slot0, slot1)
	slot0._storeChargeGoodsConfig = slot1
	slot0._skin2ChargeGoodsCfg = {}

	for slot5, slot6 in ipairs(slot0._storeChargeGoodsConfig.configList) do
		if slot6.belongStoreId == StoreEnum.StoreId.Skin then
			slot8 = nil

			if GameUtil.splitString2(slot6.item, true) and #slot7 == 1 and slot7[1][1] == MaterialEnum.MaterialType.HeroSkin then
				slot8 = slot9[2]
			end

			if slot8 then
				slot0._skin2ChargeGoodsCfg[slot8] = slot6
			end
		end
	end
end

function slot0.getSkinChargeGoodsCfg(slot0, slot1)
	return slot0._skin2ChargeGoodsCfg[slot1]
end

function slot0.getSkinChargePrice(slot0, slot1)
	slot2, slot3 = nil

	if slot0:getSkinChargeGoodsCfg(slot1) then
		slot2 = slot4.price
		slot3 = slot4.originalCost
		slot2 = PayModel.instance:getProductPrice(slot4.id)
		slot3 = PayModel.instance:getProductPrice(slot4.originalCostGoodsId)
	end

	return slot2, slot3
end

function slot0.getSkinChargeGoodsId(slot0, slot1)
	slot2 = nil

	if slot0:getSkinChargeGoodsCfg(slot1) then
		slot2 = slot3.id
	end

	return slot2
end

function slot0.getTabConfig(slot0, slot1)
	return slot0._storeEntranceConfig.configDict[slot1]
end

function slot0.getGoodsConfig(slot0, slot1)
	if not slot0._storeGoodsConfig.configDict[slot1] then
		logError("找不到商品: " .. tostring(slot1))
	end

	return slot2
end

function slot0.getChargeGoodsConfig(slot0, slot1, slot2)
	if not slot0._storeChargeGoodsConfig.configDict[slot1] and slot2 ~= true then
		logError("找不到充值商品: " .. tostring(slot1))
	end

	return slot3
end

function slot0.getChargeGoodsPrice(slot0, slot1, slot2)
	if slot0:getChargeGoodsConfig(slot1, slot2) then
		return slot3[slot0._configPriceKey]
	end

	return 0
end

function slot0.getBaseChargeGoodsPrice(slot0, slot1, slot2)
	if slot0:getChargeGoodsConfig(slot1, slot2) then
		return slot3[slot0._configBasePriceKey]
	end

	return 0
end

function slot0.getChargeGoodsCurrencyCode(slot0, slot1, slot2)
	if slot0:getChargeGoodsConfig(slot1, slot2) then
		return slot3[slot0._configCurrencyCodeKey]
	end

	return "USD"
end

function slot0.getChargeGoodsOriginalCost(slot0, slot1, slot2)
	if slot0:getChargeGoodsConfig(slot1, slot2) then
		return slot3[slot0._configOriginalCostKey]
	end

	return 0
end

function slot0.getAllChargeGoodsConfig(slot0)
	return slot0._storeChargeGoodsConfig.configDict
end

function slot0.getStoreChargeConfig(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot0._storeChargeConfig.configDict[slot1] then
		slot4 = slot0._storeChargeConfig.configDict[slot1][slot2]
	end

	if not slot4 and not slot3 then
		logError("找不到充值商品相关配置: " .. tostring(slot1) .. slot2)
	end

	return slot4
end

function slot0.getStoreChargeConfigByProductID(slot0, slot1)
	slot3 = BootNativeUtil.getPackageName()
	slot4 = {}

	for slot8, slot9 in pairs(slot0._storeChargeConfig.configDict) do
		if slot9[slot3] and slot9[slot3].appStoreProductID == slot1 then
			table.insert(slot4, slot9[slot3])
		end
	end

	return slot4
end

function slot0.getStoreRecommendConfig(slot0, slot1)
	if not slot0._storeRecommendConfig.configDict[slot1] then
		logError("找不到充值商品相关配置: " .. tostring(slot1))
	end

	return slot2
end

function slot0.getStoreConfig(slot0, slot1)
	if not slot0._storeConfig.configDict[slot1] then
		logError("找不到商店: " .. tostring(slot1))
	end

	return slot2
end

function slot0.getAllStoreIds(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(slot0._storeConfig.configDict) do
		table.insert(slot1, slot7.id)
	end

	return slot1
end

function slot0.getTabHierarchy(slot0, slot1)
	if not slot0:getTabConfig(slot1) then
		return 0
	end

	if not slot0:hasTab(slot2.belongFirstTab) and not slot0:hasTab(slot2.belongSecondTab) then
		return 1
	elseif not slot0:hasTab(slot2.belongSecondTab) then
		return 2
	else
		return 3
	end
end

function slot0.getMonthCardConfig(slot0, slot1)
	if slot1 == StoreEnum.LittleMonthCardGoodsId and slot0._storeMonthAddCfg.configDict[slot1] ~= nil then
		return slot0._monthCardConfig.configDict[slot2.month_id]
	end

	return slot0._monthCardConfig.configDict[slot1]
end

function slot0.getDailyReleasePackageCfg(slot0, slot1)
	return slot0._dailyReleasePackageCfg.configDict[slot1]
end

function slot0.getOpenTimeDiff(slot0, slot1, slot2, slot3)
	if slot2 <= slot1 then
		logError("结束时间比开启时间早")
	elseif slot3 < slot1 then
		return slot3 - slot1
	elseif slot3 < slot2 then
		return slot2 - slot3
	end

	return 0
end

function slot0.hasTab(slot0, slot1)
	return slot1 and slot1 ~= 0
end

function slot0.getRemain(slot0, slot1, slot2, slot3)
	if slot2 <= 0 then
		return nil
	end

	if slot1.refreshTime == StoreEnum.RefreshTime.Forever then
		if slot1.maxBuyCount > 0 then
			if slot1.jumpId ~= 0 then
				return formatLuaLang("store_limitget", slot2)
			elseif slot3 > 0 then
				return formatLuaLang("v1a4_bossrush_storeview_buylimit", slot2)
			else
				return formatLuaLang("store_buylimit_forever", slot2)
			end
		else
			return nil
		end
	elseif slot1.refreshTime == StoreEnum.RefreshTime.Day then
		return formatLuaLang("store_buylimit_day", slot2)
	elseif slot1.refreshTime == StoreEnum.RefreshTime.Week then
		return formatLuaLang("store_buylimit_week", slot2)
	elseif slot1.refreshTime == StoreEnum.RefreshTime.Month then
		return formatLuaLang("store_buylimit_month", slot2)
	else
		return formatLuaLang("v1a4_bossrush_storeview_buylimit", slot2)
	end
end

function slot0.getRemainText(slot0, slot1, slot2, slot3, slot4)
	if slot2 == StoreEnum.RefreshTime.Forever then
		if slot1 > 0 then
			if slot4 > 0 then
				return formatLuaLang("v1a4_bossrush_storeview_buylimit", slot3)
			else
				return formatLuaLang("store_buylimit_forever", slot3)
			end
		else
			return nil
		end
	elseif slot2 == StoreEnum.RefreshTime.Day then
		return formatLuaLang("store_buylimit_day", slot3)
	elseif slot2 == StoreEnum.RefreshTime.Week then
		return formatLuaLang("store_buylimit_week", slot3)
	elseif slot2 == StoreEnum.RefreshTime.Month then
		return formatLuaLang("store_buylimit_month", slot3)
	else
		return formatLuaLang("v1a4_bossrush_storeview_buylimit", slot3)
	end
end

function slot0.getChargeRemainText(slot0, slot1, slot2, slot3, slot4)
	if slot2 == StoreEnum.ChargeRefreshTime.Forever then
		if slot1 > 0 then
			if slot4 > 0 then
				return formatLuaLang("v1a4_bossrush_storeview_buylimit", slot3)
			else
				return formatLuaLang("store_buylimit_forever", slot3)
			end
		else
			return nil
		end
	elseif slot2 == StoreEnum.ChargeRefreshTime.MonthCard then
		if StoreModel.instance:getMonthCardInfo() then
			if slot5:getRemainDay() == StoreEnum.MonthCardStatus.NotPurchase then
				return nil
			elseif slot6 == StoreEnum.MonthCardStatus.NotEnoughOneDay then
				return luaLang("not_enough_one_day")
			else
				return formatLuaLang("remain_day", slot6)
			end
		else
			return nil
		end
	elseif slot2 == StoreEnum.ChargeRefreshTime.Day then
		return formatLuaLang("store_buylimit_day", slot3)
	elseif slot2 == StoreEnum.ChargeRefreshTime.Week then
		return formatLuaLang("store_buylimit_week", slot3)
	elseif slot2 == StoreEnum.ChargeRefreshTime.Month then
		return formatLuaLang("store_buylimit_month", slot3)
	else
		return formatLuaLang("v1a4_bossrush_storeview_buylimit", slot3)
	end
end

function slot0.hasNextGood(slot0, slot1)
	return slot0._preGoodsIdDict[slot1] ~= nil
end

function slot0.getRoomProductGoodsId(slot0, slot1, slot2)
	slot3 = nil

	if slot0._roomProduct2GoodsId then
		slot3 = (slot0._roomProduct2GoodsId[slot1] or {})[slot2]
	end

	return slot3
end

function slot0.getRoomCritterProductGoods(slot0, slot1)
	return slot0._critterStoreGoods[slot1] or {}
end

function slot0.getChargeOptionalGroup(slot0, slot1)
	if not slot0._chargeOptionalConfig.configDict[slot1] then
		logError("充值商品ID未配置充值自选礼包表" .. tostring(slot1))
	end

	return slot2
end

function slot0.getMonthCardAddConfig(slot0, slot1)
	return slot0._storeMonthAddCfg.configDict[slot1]
end

function slot0.getSeasonCardMultiFactor(slot0)
	return CommonConfig.instance:getConstNum(2501)
end

slot0.instance = slot0.New()

return slot0
