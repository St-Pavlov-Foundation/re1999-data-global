module("modules.logic.store.model.StoreModel", package.seeall)

slot0 = class("StoreModel", BaseModel)

function slot0.isRedTabReadOnceClient(slot0, slot1)
	if slot1 == StoreEnum.StoreId.EventPackage and not StoreController.instance:getIsOpenedEventPackage() then
		if not uv0.instance:getPackageGoodValidList(slot1) or #slot2 == 0 then
			return false
		end

		return true
	end

	return false
end

function slot0.onInit(slot0)
	slot0._storeMODict = {}
	slot0._chargeStoreDic = {}
	slot0._allPackageDic = {}
	slot0._chargePackageStoreDic = {}
	slot0._versionChargePackageDict = {}
	slot0._onceTimeChargePackageDict = {}
	slot0._eventChargePackageDict = {}
	slot0._recommendPackageList = {}
	slot0._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = slot0._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = slot0._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = slot0._chargePackageStoreDic,
		[StoreEnum.StoreId.EventPackage] = slot0._eventChargePackageDict
	}
	slot0._curPackageStore = StoreEnum.StoreId.NormalPackage
	slot0.monthCardInfo = nil
	slot0._packageStoreRpcLeftNum = 0
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getStoreInfosReply(slot0, slot1)
	if slot1.storeInfos and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = StoreMO.New()

			slot8:init(slot7)

			slot0._storeMODict[slot8.id] = slot8

			if StoreConfig.instance:getTabConfig(slot8.id) and slot9.belongFirstTab == StoreEnum.StoreId.Package then
				if slot0:getCurPackageStore() ~= 0 and slot10 == slot8.id then
					slot0:updatePackageStoreList(slot8.id)
				end
			elseif slot8.id == StoreEnum.StoreId.Skin then
				StoreClothesGoodsItemListModel.instance:setMOList(slot8:getGoodsList())
			end
		end
	end
end

function slot0.buyGoodsReply(slot0, slot1)
	if slot0._storeMODict[slot1.storeId] then
		slot2:buyGoodsReply(slot1.goodsId, slot1.num)
	end
end

function slot0.initChargeInfo(slot0, slot1)
	slot0._chargeStoreDic = {}
	slot0._allPackageDic = {}
	slot0._chargePackageStoreDic = {}
	slot0._versionChargePackageDict = {}
	slot0._onceTimeChargePackageDict = {}
	slot0._skinChargeDict = {}
	slot0._recommendPackageList = {}
	slot0._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = slot0._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = slot0._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = slot0._chargePackageStoreDic,
		[StoreEnum.StoreId.RecommendPackage] = slot0._recommendPackageList,
		[StoreEnum.StoreId.EventPackage] = slot0._eventChargePackageDict
	}
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if StoreConfig.instance:getChargeGoodsConfig(slot7.id, true) then
			if slot8.belongStoreId == StoreEnum.StoreId.Charge or slot8.belongStoreId == StoreEnum.StoreId.PubbleCharge or slot8.belongStoreId == StoreEnum.StoreId.GlowCharge then
				slot9 = StoreChargeGoodsMO.New()

				slot9:init(StoreEnum.StoreId.Charge, slot7)

				slot0._chargeStoreDic[slot7.id] = slot9
			elseif slot8.belongStoreId == StoreEnum.StoreId.Skin then
				table.insert(slot2, slot7)
			else
				slot9 = StorePackageGoodsMO.New()

				slot9:initCharge(slot8.belongStoreId, slot7)

				slot0._allPackageDic[slot7.id] = slot9

				if slot8.belongStoreId == StoreEnum.StoreId.NormalPackage then
					slot0._chargePackageStoreDic[slot7.id] = slot9
				elseif slot8.belongStoreId == StoreEnum.StoreId.VersionPackage then
					slot0._versionChargePackageDict[slot7.id] = slot9
				elseif slot8.belongStoreId == StoreEnum.StoreId.OneTimePackage then
					slot0._onceTimeChargePackageDict[slot7.id] = slot9
				elseif slot8.belongStoreId == StoreEnum.StoreId.EventPackage then
					slot0._eventChargePackageDict[slot7.id] = slot9
				end
			end
		end
	end

	slot0:_updateSkinChargePackage(slot2)
	slot0:updatePackageStoreList(slot0._curPackageStore)
end

function slot0._updateSkinChargePackage(slot0, slot1)
	if not slot0._skinChargeDict then
		slot0._skinChargeDict = {}
	end

	for slot5, slot6 in ipairs(slot1 or {}) do
		slot0:_addSkinChargePackage(slot6)
	end

	StoreController.instance:dispatchEvent(StoreEvent.SkinChargePackageUpdate)
end

function slot0._addSkinChargePackage(slot0, slot1)
	if not slot0._skinChargeDict then
		slot0._skinChargeDict = {}
	end

	slot2 = StoreSkinChargeMo.New()

	slot2:init(StoreEnum.StoreId.Skin, slot1)

	slot0._skinChargeDict[slot1.id] = slot2
end

function slot0.chargeOrderComplete(slot0, slot1)
	slot0.updateChargeStore = false

	if slot0._chargeStoreDic[slot1] == nil then
		if slot1 == StoreEnum.LittleMonthCardGoodsId then
			slot2 = slot0._allPackageDic[slot1]
		else
			slot2 = slot0._chargePackageStoreDic[slot1] or slot0._versionChargePackageDict[slot1] or slot0._onceTimeChargePackageDict[slot1]
		end
	else
		slot0.updateChargeStore = true
	end

	if slot2 then
		slot2.buyCount = slot2.buyCount + 1

		if slot2.config.id == StoreEnum.MonthCardGoodsId or slot3 == StoreEnum.LittleMonthCardGoodsId or slot3 == StoreEnum.SeasonCardGoodsId then
			ChargeRpc.instance:sendGetMonthCardInfoRequest(slot0.updateGoodsInfo, slot0)
		else
			slot0:updateGoodsInfo()
		end
	end
end

function slot0.updateGoodsInfo(slot0)
	if slot0.updateChargeStore then
		StoreChargeGoodsItemListModel.instance:setMOList(slot0._chargeStoreDic, slot0:getCurChargetStoreId())
	else
		slot0:updatePackageStoreList(slot0._curPackageStore)
	end
end

function slot0.getCurChargetStoreId(slot0)
	return slot0._curChargeStoreId or 0
end

function slot0.setCurChargeStoreId(slot0, slot1)
	slot0._curChargeStoreId = slot1
end

function slot0.setCurPackageStore(slot0, slot1)
	slot0._curPackageStore = slot1
end

function slot0.getCurPackageStore(slot0)
	return slot0._curPackageStore or 0
end

function slot0.setPackageStoreRpcNum(slot0, slot1)
	slot0._packageStoreRpcLeftNum = slot1
end

function slot0.setCurBuyPackageId(slot0, slot1)
	slot0._curBuyPackageId = slot1
end

function slot0.getCurBuyPackageId(slot0)
	return slot0._curBuyPackageId
end

function slot0.updatePackageStoreList(slot0, slot1)
	slot2 = slot1 or StoreEnum.StoreId.Package
	slot0._packageStoreRpcLeftNum = slot0._packageStoreRpcLeftNum - 1

	if slot0._packageStoreRpcLeftNum < 1 then
		if not slot1 or slot1 == StoreEnum.StoreId.RecommendPackage then
			StorePackageGoodsItemListModel.instance:setMOList(nil, slot0:getRecommendPackageList(true))
		else
			StorePackageGoodsItemListModel.instance:setMOList(slot0:getStoreMO(slot2), slot0._packageType2GoodsDict[slot1])
		end

		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end
end

function slot0.getStoreMO(slot0, slot1)
	return slot0._storeMODict[slot1]
end

function slot0.getGoodsMO(slot0, slot1)
	if slot0._allPackageDic[slot1] then
		return slot0._allPackageDic[slot1]
	else
		for slot5, slot6 in pairs(slot0._storeMODict) do
			if slot6:getGoodsMO(slot1) then
				return slot7
			end
		end
	end
end

function slot0.getChargeGoods(slot0)
	return slot0._chargeStoreDic
end

function slot0.getChargeGoodsMo(slot0, slot1)
	return slot0._chargeStoreDic[slot1]
end

function slot0.isStoreSkinChargePackageValid(slot0, slot1)
	slot2 = false

	if slot0._skinChargeDict and slot0._skinChargeDict[StoreConfig.instance:getSkinChargeGoodsId(slot1)] then
		slot2 = true
	end

	return slot2
end

function slot0.getRecommendPackageList(slot0, slot1)
	if not slot1 then
		return slot0._recommendPackageList
	end

	slot0._recommendPackageList = {}

	if (CommonConfig.instance:getConstNum(ConstEnum.RecommendStoreCount) or 5) == 0 then
		return slot0._recommendPackageList
	end

	slot3 = {}
	slot5 = slot0:getPackageGoodList(StoreEnum.StoreId.OneTimePackage)
	slot6 = slot0:getPackageGoodList(StoreEnum.StoreId.NormalPackage)
	slot7 = slot0:getPackageGoodList(StoreEnum.StoreId.EventPackage)

	for slot11, slot12 in pairs(slot0:getPackageGoodList(StoreEnum.StoreId.VersionPackage)) do
		slot3[#slot3 + 1] = slot12
	end

	for slot11, slot12 in pairs(slot5) do
		slot3[#slot3 + 1] = slot12
	end

	for slot11, slot12 in pairs(slot6) do
		slot3[#slot3 + 1] = slot12
	end

	for slot11, slot12 in pairs(slot7) do
		slot3[#slot3 + 1] = slot12
	end

	if #slot3 > 1 then
		table.sort(slot3, slot0._packageSortFunction)
	end

	slot8 = 1

	for slot12 = 1, #slot3 do
		slot13 = slot3[slot12]

		if slot0:checkShowInRecommand(slot13, slot13.isChargeGoods) then
			slot0._recommendPackageList[slot8] = slot13

			if slot8 == slot2 then
				break
			end

			slot8 = slot8 + 1
		end
	end

	return slot0._recommendPackageList
end

function slot0.isGoodInRecommendList(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getRecommendPackageList(false)) do
		if slot7.goodsId == slot1 then
			return true
		end
	end
end

function slot0.getPackageGoodList(slot0, slot1)
	slot2 = {
		[slot8.id] = slot8
	}

	for slot7, slot8 in pairs(slot0._packageType2GoodsDict[slot1]) do
		-- Nothing
	end

	if slot0:getStoreMO(slot1) then
		for slot9, slot10 in pairs(slot4:getGoodsList()) do
			slot11 = StorePackageGoodsMO.New()

			slot11:init(slot1, slot10.goodsId, slot10.buyCount, slot10.offlineTime)

			slot2[slot10.goodsId] = slot11
		end
	end

	return slot2
end

function slot0.getPackageGoodValidList(slot0, slot1)
	slot2 = {}

	if slot1 == StoreEnum.StoreId.RecommendPackage then
		slot2 = slot0:getRecommendPackageList(true)
	else
		for slot7, slot8 in pairs(slot0:getPackageGoodList(slot1)) do
			if slot0:checkValid(slot8, slot8.isChargeGoods) then
				slot2[#slot2 + 1] = slot8
			end
		end
	end

	return slot2
end

function slot0.checkValid(slot0, slot1, slot2)
	slot2 = slot2 or false
	slot3 = true

	if slot1:isSoldOut() then
		if slot2 and slot1.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			slot3 = false
		end

		if slot2 == false and slot1.config.refreshTime == StoreEnum.RefreshTime.Forever then
			slot3 = false
		end
	end

	return slot3 and slot0:checkPreGoodsId(slot1.config.preGoodsId)
end

function slot0.checkShowInRecommand(slot0, slot1, slot2)
	if slot1.config.notShowInRecommend then
		return false
	end

	if slot1.config.id == StoreEnum.MonthCardGoodsId then
		if not slot0:hasPurchaseMonthCard() then
			return true
		else
			return not uv0.instance:IsMonthCardDaysEnough()
		end
	end

	slot2 = slot2 or false
	slot3 = true

	if slot1:isSoldOut() then
		slot3 = false
	end

	return slot3 and slot0:checkPreGoodsId(slot1.config.preGoodsId)
end

function slot0.checkPreGoodsId(slot0, slot1)
	if slot1 == 0 then
		return true
	end

	return slot0:getGoodsMO(slot1) and slot2:isSoldOut()
end

function slot0.getBuyCount(slot0, slot1, slot2)
	if not slot0._storeMODict[slot1] then
		return 0
	end

	return slot3:getBuyCount(slot2)
end

function slot0.isTabMainRedDotShow(slot0, slot1)
	slot2 = slot0:getAllRedDotInfo()

	if slot1 == StoreEnum.StoreId.Package and slot0:isRedTabReadOnceClient(StoreEnum.StoreId.EventPackage) then
		return true
	end

	if slot2 then
		for slot6, slot7 in pairs(slot2) do
			slot8 = nil
			slot9 = false

			if slot0:getGoodsMO(slot7.uid) then
				slot8 = StoreConfig.instance:getTabConfig(slot10.belongStoreId)
			else
				slot8 = StoreConfig.instance:getTabConfig(slot7.uid)
				slot9 = true
			end

			if slot8 then
				if slot8.belongFirstTab == 0 and slot8.belongSecondTab ~= 0 then
					slot11 = StoreConfig.instance:getTabConfig(slot12).belongFirstTab
				end

				if slot11 == 0 then
					slot11 = slot8.id
				end

				if slot7.value > 0 and slot1 == slot11 then
					return true, slot9
				end
			end
		end
	end

	return false
end

function slot0.isTabFirstRedDotShow(slot0, slot1)
	if slot0:getAllRedDotInfo() then
		for slot6, slot7 in pairs(slot2) do
			if slot0:getGoodsMO(slot7.uid) then
				if slot1 == StoreEnum.StoreId.RecommendPackage and slot0:isGoodInRecommendList(slot8.goodsId) and not (slot8.refreshTime == StoreEnum.ChargeRefreshTime.Week) and not (slot8.refreshTime == StoreEnum.ChargeRefreshTime.Month) then
					return true
				elseif slot7.value > 0 and slot1 == StoreConfig.instance:getTabConfig(slot8.belongStoreId).belongSecondTab then
					return true
				end
			end

			if slot7.value > 0 and slot7.uid == slot1 then
				return true, true
			end
		end
	end

	return false
end

function slot0.isTabSecondRedDotShow(slot0, slot1)
	if slot0:getAllRedDotInfo() then
		for slot6, slot7 in pairs(slot2) do
			if slot0:getGoodsMO(slot7.uid) and slot7.value > 0 and slot1 == slot8.belongStoreId then
				return true
			end
		end
	end

	return false
end

function slot0.isPackageStoreTabRedDotShow(slot0, slot1)
	slot2 = slot0:getAllRedDotInfo()

	if slot0:isRedTabReadOnceClient(slot1) then
		return true
	end

	if slot2 then
		for slot6, slot7 in pairs(slot2) do
			if slot0:getGoodsMO(slot7.uid) then
				if slot1 == StoreEnum.StoreId.RecommendPackage and slot0:isGoodInRecommendList(slot8.goodsId) then
					return true
				elseif slot7.value > 0 and slot1 == slot8.belongStoreId then
					return true
				end
			end
		end
	end

	return false
end

function slot0.getAllRedDotInfo(slot0)
	slot2 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)
	slot3 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)
	slot4 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a6FurnaceTreasure)
	slot5 = {}

	if RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab) then
		for slot9, slot10 in pairs(slot1.infos) do
			table.insert(slot5, slot10)
		end
	end

	if slot2 then
		for slot9, slot10 in pairs(slot2.infos) do
			table.insert(slot5, slot10)
		end
	end

	if slot3 then
		for slot9, slot10 in pairs(slot3.infos) do
			table.insert(slot5, slot10)
		end
	end

	if slot4 then
		for slot9, slot10 in pairs(slot4.infos) do
			table.insert(slot5, slot10)
		end
	end

	return slot5
end

function slot0.isGoodsItemRedDotShow(slot0, slot1)
	if RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab) then
		for slot7, slot8 in pairs(slot2.infos) do
			if slot8.uid == slot1 and slot8.value > 0 then
				return true
			end
		end
	end

	return false
end

function slot0.isStoreTabLock(slot0, slot1)
	if StoreConfig.instance:getStoreConfig(slot1) and slot2.needClearStore > 0 then
		for slot7, slot8 in pairs(slot0._storeMODict[slot2.needClearStore].goodsInfos) do
			if slot8.goodsId and StoreConfig.instance:getGoodsConfig(slot8.goodsId) and slot8.buyCount < slot9.maxBuyCount then
				return true
			end
		end
	end

	return false
end

function slot0.getFirstTabs(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(lua_store_entrance.configList) do
		if not StoreConfig.instance:hasTab(slot8.belongFirstTab) and not StoreConfig.instance:hasTab(slot8.belongSecondTab) then
			slot9 = LuaUtil.tableContains(StoreEnum.BossRushStore, slot8.id)

			if slot8.id == StoreEnum.StoreId.DecorateStore and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) == 0 and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.OldDecorateStore) == 0 then
				slot9 = true
			end

			if not slot9 and (not slot1 or slot0:isTabOpen(slot8.id)) then
				table.insert(slot3, slot8)
			end
		end
	end

	if slot2 and #slot3 > 1 then
		table.sort(slot3, slot0._tabSortFunction)
	end

	return slot3
end

function slot0.getSecondTabs(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(slot9.belongFirstTab) and slot9.belongFirstTab == slot1 and (not slot2 or slot0:isTabOpen(slot9.id)) then
			table.insert(slot4, slot9)
		end
	end

	if slot3 and #slot4 > 1 then
		table.sort(slot4, slot0._tabSortFunction)
	end

	return slot4
end

function slot0.getRecommendSecondTabs(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(slot8.belongFirstTab) and slot8.belongFirstTab == slot1 and (not slot2 or slot0:isTabOpen(slot8.id)) then
			table.insert({}, slot8)
		end
	end

	for slot7, slot8 in ipairs(lua_store_recommend.configList) do
		if slot8.type == 0 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getThirdTabs(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(slot9.belongSecondTab) and slot9.belongSecondTab == slot1 and (not slot2 or slot0:isTabOpen(slot9.id)) then
			table.insert(slot4, slot9)
		end
	end

	if slot3 and #slot4 > 1 then
		table.sort(slot4, slot0._tabSortFunction)
	end

	return slot4
end

function slot0.isTabOpen(slot0, slot1)
	if StoreConfig.instance:getTabConfig(slot1) then
		if slot2.openId and slot2.openId ~= 0 and not OpenModel.instance:isFunctionUnlock(slot2.openId) then
			return false
		end

		if slot2.openHideId and slot2.openHideId ~= 0 and OpenModel.instance:isFunctionUnlock(slot2.openHideId) then
			return false
		end

		slot3, slot4 = nil

		if not string.nilorempty(slot2.openTime) then
			slot3 = TimeUtil.stringToTimestamp(slot2.openTime)
		end

		if not string.nilorempty(slot2.endTime) then
			slot4 = TimeUtil.stringToTimestamp(slot2.endTime)
		end

		if string.nilorempty(slot2.openTime) and string.nilorempty(slot2.endTime) then
			-- Nothing
		elseif string.nilorempty(slot2.endTime) then
			if ServerTime.now() <= slot3 then
				return false
			end
		elseif string.nilorempty(slot2.openTime) then
			if slot4 <= ServerTime.now() then
				return false
			end
		elseif StoreConfig.instance:getOpenTimeDiff(slot3, slot4, ServerTime.now()) <= 0 then
			return false
		end

		if slot2.storeId == StoreEnum.StoreId.Package and GameFacade.isKOLTest() then
			return false
		end

		if StoreConfig.instance:getTabHierarchy(slot2.id) == 2 then
			if slot2.storeId and slot2.storeId ~= 0 then
				return true
			elseif slot0:getThirdTabs(slot2.id, true, false) and #slot5 > 0 then
				return true
			end
		else
			return true
		end
	end

	return false
end

function slot0._tabSortFunction(slot0, slot1)
	return slot1.order < slot0.order
end

function slot0._packageSortFunction(slot0, slot1)
	return slot0.config.order < slot1.config.order
end

function slot0.jumpTabIdToSelectTabId(slot0, slot1)
	slot2 = 0
	slot3 = 0
	slot4 = 0

	if StoreConfig.instance:getTabHierarchy(slot1) == 3 then
		slot2 = StoreConfig.instance:getTabConfig(StoreConfig.instance:getTabConfig(slot1) and slot6.belongSecondTab or 0) and slot7.belongFirstTab or 0
	elseif slot5 == 2 then
		if slot0:getThirdTabs(slot1, true, true) and #slot6 > 0 then
			slot4 = slot6[1].id
		end

		slot2 = StoreConfig.instance:getTabConfig(slot3) and slot7.belongFirstTab or 0
	else
		slot2 = slot1
		slot6 = slot0:getSecondTabs(slot2, true, true)

		if slot2 == StoreEnum.StoreId.Package then
			for slot10 = 1, #slot6 do
				if #slot0:getPackageGoodValidList(slot6[slot10].id) > 0 then
					slot3 = slot6[slot10].id

					break
				end
			end

			slot4 = 0
		elseif slot2 == StoreEnum.StoreId.DecorateStore then
			for slot10 = 1, #slot6 do
				if #DecorateStoreModel.instance:getDecorateGoodList(slot6[slot10].id) > 0 then
					slot3 = slot6[slot10].id

					break
				end
			end

			slot4 = 0
		elseif slot6 and #slot6 > 0 then
			if slot0:getThirdTabs(slot6[1].id, true, true) and #slot7 > 0 then
				slot4 = slot7[1].id
			end
		else
			slot3 = slot2
		end
	end

	return slot2, slot3, slot4
end

function slot0.jumpTabIdToStoreId(slot0, slot1)
	slot2 = 0
	slot3, slot4, slot5 = slot0:jumpTabIdToSelectTabId(slot1)
	slot7 = StoreConfig.instance:getTabConfig(slot4)
	slot8 = StoreConfig.instance:getTabConfig(slot3)

	if (StoreConfig.instance:getTabConfig(slot5) and slot6.storeId or 0) == 0 then
		slot2 = slot7 and slot7.storeId or 0
	end

	if slot2 == 0 then
		slot2 = slot8 and slot8.storeId or 0
	end

	return slot2
end

function slot0.updateMonthCardInfo(slot0, slot1)
	if slot1 then
		if slot0.monthCardInfo then
			slot0.monthCardInfo:update(slot1)
		else
			slot0.monthCardInfo = StoreMonthCardInfoMO.New()

			slot0.monthCardInfo:init(slot1)
		end
	end
end

function slot0.getMonthCardInfo(slot0)
	return slot0.monthCardInfo
end

function slot0.hasPurchaseMonthCard(slot0)
	return slot0.monthCardInfo ~= nil
end

function slot0.IsMonthCardDaysEnough(slot0)
	slot1 = false

	if slot0:hasPurchaseMonthCard() then
		slot1 = CommonConfig.instance:getConstNum(ConstEnum.MonthCardPurchaseRemindDay) < slot0:getMonthCardInfo():getRemainDay()
	end

	return slot1
end

function slot0.getCostStr(slot0, slot1)
	return "", slot1
end

function slot0.getCostSymbolAndPrice(slot0, slot1)
	slot3, slot4 = PayModel.instance:getProductOriginPriceNum(slot1)
	slot5 = ""

	if string.nilorempty(PayModel.instance:getProductOriginPriceSymbol(slot1)) then
		slot6 = string.reverse(slot4)
		slot7 = string.len(slot6) - string.find(slot6, "%d") + 1
		slot5 = string.sub(slot4, slot7 + 1, string.len(slot4))
		slot4 = string.sub(slot4, 1, slot7)
	end

	return slot2, slot4, slot5
end

function slot0.storeId2PackageGoodMoList(slot0, slot1)
	return slot0._packageType2GoodsDict[slot1] or {}
end

function slot0.checkTabShowNewTag(slot0, slot1)
	if slot0:getStoreMO(slot1) then
		for slot7, slot8 in pairs(slot2:getGoodsList()) do
			if slot8:needShowNew() then
				return true
			end
		end
	end

	return false
end

function slot0.setNewRedDotKey(slot0, slot1)
	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.StoreViewShowNew .. slot1, slot1)
end

function slot0.checkShowNewRedDot(slot0, slot1)
	if GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.StoreViewShowNew .. slot1, nil) then
		return false
	end

	return true
end

function slot0.isSkinGoodsCanRepeatBuy(slot0, slot1, slot2)
	if not slot1 then
		return false
	end

	slot4 = slot2 == nil

	if slot2 == nil then
		slot2 = string.splitToNumber(slot3.config.product, "#")[2]
	end

	if not SkinConfig.instance:getSkinCo(slot2) then
		return false
	end

	slot6 = slot3.config.storeId

	if not string.nilorempty(slot5.unavailableStore) then
		for slot12, slot13 in ipairs(string.split(slot7, "#") or {}) do
			if slot6 == slot13 then
				return false
			end
		end
	end

	if string.nilorempty(slot5.repeatBuyTime) then
		return false
	end

	if TimeUtil.stringToTimestamp(slot5.repeatBuyTime) < ServerTime.now() then
		return false
	end

	if not slot3:isSoldOut() and slot4 and StoreConfig.instance:getSkinChargeGoodsId(slot2) then
		slot10 = slot0._skinChargeDict[slot11] and slot12:isSoldOut()
	end

	return HeroModel.instance:checkHasSkin(slot2) and not slot10
end

function slot0.isSkinCanShowMessageBox(slot0, slot1)
	if not slot1 then
		return
	end

	if not lua_skin.configDict[slot1] then
		return
	end

	if not string.nilorempty(slot2.repeatBuyTime) and TimeUtil.stringToTimestamp(slot2.repeatBuyTime) < ServerTime.now() then
		return
	end

	if slot2.skinStoreId == 0 then
		return
	end

	if not slot0:getGoodsMO(slot4) then
		return
	end

	if slot6.isOnline and (string.nilorempty(slot5.config.onlineTime) and slot3 or TimeUtil.stringToTimestamp(slot6.onlineTime) - ServerTime.clientToServerOffset()) <= slot3 and slot3 <= (string.nilorempty(slot6.offlineTime) and slot3 or TimeUtil.stringToTimestamp(slot6.offlineTime) - ServerTime.clientToServerOffset()) and not slot5:isSoldOut() and not (tabletool.indexOf(string.splitToNumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SkinCanShowMessageBox, ""), "#"), slot1) ~= nil) then
		table.insert(slot12, slot1)
		GameUtil.playerPrefsSetStringByUserId(slot10, table.concat(slot12, "#"))

		return true
	end
end

slot0.instance = slot0.New()

return slot0
