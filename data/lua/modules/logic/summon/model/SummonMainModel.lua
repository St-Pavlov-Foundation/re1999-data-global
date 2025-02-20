module("modules.logic.summon.model.SummonMainModel", package.seeall)

slot0 = class("SummonMainModel", BaseModel)

function slot0.onInit(slot0)
	slot0:releaseViewData()

	slot0.flagModel = SummonFlagSubModel.New()
end

function slot0.reInit(slot0)
	slot0:releaseViewData()
	slot0:releaseServerData()

	slot0.flagModel = SummonFlagSubModel.New()
end

function slot0.releaseServerData(slot0)
	slot0._hasNewbiePool = nil
	slot0._newbieProgress = nil
	slot0._curPoolIndex = nil
	slot0._curPoolId = nil
	slot0._curPool = nil
	slot0._validServerPoolMap = nil
end

function slot0.releaseViewData(slot0)
	slot0:clear()

	slot0._poolList = nil
	slot0._isFirstTimeOpen = true
end

function slot0.initCategory(slot0, slot1)
	slot0:releaseViewData()

	slot0._poolList = uv0.getValidPools()

	slot0:setList(slot0._poolList)

	if slot0:getCount() > 0 then
		slot0._curPoolIndex = 1
		slot0._curPool = slot0:getByIndex(1)
		slot0._curPoolId = slot0._curPool.id
	else
		logError("summon pool config is empty!")
	end

	slot0:_updateSummonDiamondStatus()
end

function slot0.updateByServerData(slot0)
	slot0:releaseViewData()

	slot0._poolList = uv0.getValidPools()

	slot0:setList(slot0._poolList)

	if slot0:getCount() > 0 then
		if slot0._curPoolId == nil or not slot0:trySetSelectPoolId(slot0._curPoolId) then
			slot0._curPoolIndex = 1
			slot0._curPool = slot0:getByIndex(1)
			slot0._curPoolId = slot0._curPool.id
		end
	else
		logError("no summon pool available!")
	end

	SummonMainCategoryListModel.instance:initCategory()
end

function slot0.updateLastPoolId(slot0)
	if slot0._curPoolId then
		SummonController.instance:setLastPoolId(slot0._curPoolId)
	end
end

function slot0.getPoolsWithServer(slot0, slot1, slot2)
	SummonRpc.instance:sendGetSummonInfoRequest(uv0.onGetPoolsWithServer, {
		callback = slot1,
		callbackObj = slot2
	})
end

function slot0.onGetPoolsWithServer(slot0)
	slot2 = slot0.callbackObj

	if slot0.callback then
		if slot2 then
			slot1(slot2, uv0.getValidPools())
		else
			slot1(slot3)
		end
	end
end

function slot0.equipPoolIsValid()
	for slot4, slot5 in ipairs(SummonConfig.instance:getValidPoolList()) do
		if uv0.getResultType(slot5) == SummonEnum.ResultType.Equip and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SummonEquip) then
			return true
		end
	end
end

function slot0.getValidPools()
	slot1 = {}
	slot2 = false

	for slot6, slot7 in pairs(SummonConfig.instance:getValidPoolList()) do
		if uv0.instance:getPoolServerMO(slot7.id) and slot8:isOpening() then
			slot2 = true

			if uv0.getResultType(slot7) == SummonEnum.ResultType.Equip and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SummonEquip) then
				slot2 = false
			elseif uv0.getADPageTabIndex(slot7) == SummonEnum.TabContentIndex.CharNewbie and not uv0.instance:getNewbiePoolExist() then
				slot2 = false
			end

			if slot2 then
				table.insert(slot1, slot7)
			end
		end
	end

	table.sort(slot1, uv0.sortSummonCategory)

	return slot1
end

slot0.defaultSettings = {
	{
		"ui/viewres/summon/summonmaincharacterview.prefab"
	},
	{
		"ui/viewres/summon/summonmainequipview.prefab"
	},
	{
		"ui/viewres/summon/summonmaincharacternewbie.prefab"
	},
	{
		"ui/viewres/summon/summonmaincharacterprobup.prefab"
	},
	{
		"ui/viewres/summon/summonmainequipprobup.prefab"
	}
}
slot0.defaultUIClzMap = {
	SummonMainCharacterView,
	SummonMainEquipView,
	SummonMainCharacterNewbie,
	SummonMainCharacterProbUp,
	SummonMainEquipProbUp
}

function slot0.resetTabResSettings(slot0)
	slot1 = tabletool.copy(uv0.defaultSettings)
	slot2 = tabletool.copy(uv0.defaultUIClzMap)
	slot4 = {}
	slot5 = {}
	slot0._poolIDTabMap = {}

	for slot9, slot10 in ipairs(SummonConfig.instance:getValidPoolList()) do
		slot12 = uv0.defaultUIClzMap[uv0.getADPageTabIndex(slot10)]
		slot13 = nil

		if not string.nilorempty(slot10.customClz) then
			slot13 = _G[slot10.customClz]
		end

		slot13 = slot13 or slot12
		slot14 = uv0.defaultSettings[slot11][1]
		slot15 = nil

		if not string.nilorempty(slot10.prefabPath) then
			slot15 = string.format("ui/viewres/summon/%s.prefab", slot10.prefabPath)
		end

		slot15 = slot15 or slot14

		if slot13 ~= slot12 or slot15 ~= slot14 then
			table.insert(slot1, {
				slot15
			})
			table.insert(slot2, slot13)

			slot0._poolIDTabMap[slot10.id] = #slot1
		end
	end

	module_views.SummonADView.tabRes[3] = slot1
	slot0._tab2UIClassDef = slot2
end

function slot0.sortSummonCategory(slot0, slot1)
	if slot0.priority ~= slot1.priority then
		return slot1.priority < slot0.priority
	else
		return slot0.id < slot1.id
	end
end

function slot0.setFirstTimeSwitch(slot0, slot1)
	slot0._isFirstTimeSwitch = slot1
end

function slot0.getFirstTimeSwitch(slot0)
	return slot0._isFirstTimeSwitch
end

function slot0.getCurPool(slot0)
	return slot0:getById(slot0._curPoolId)
end

function slot0.createUIClassTab(slot0)
	for slot5, slot6 in ipairs(slot0._tab2UIClassDef) do
		-- Nothing
	end

	return {
		[slot5] = slot6.New()
	}
end

function slot0.getUIClassDef(slot0, slot1)
	return slot0._tab2UIClassDef[slot1]
end

function slot0.getCurADPageIndex(slot0)
	if slot0:getCurPool() == nil then
		return nil
	end

	if slot0._poolIDTabMap[slot1.id] then
		return slot2
	else
		return uv0.getADPageTabIndex(slot1)
	end
end

function slot0.getADPageTabIndexForUI(slot0, slot1)
	if slot1 == nil or slot0._poolIDTabMap == nil then
		return nil
	end

	if slot0._poolIDTabMap[slot1.id] then
		return slot2
	else
		return uv0.getADPageTabIndex(slot1)
	end
end

function slot0.getADPageTabIndex(slot0)
	return SummonEnum.Type2PageIndex[slot0.type] or SummonEnum.TabContentIndex.CharNormal
end

function slot0.hasPoolAvailable(slot0, slot1)
	if slot1 == nil then
		return slot0:getCount() > 0
	else
		return slot0:getById(slot1) ~= nil
	end
end

function slot0.hasPoolGroupAvailable(slot0, slot1)
	if slot0:getList() and #slot2 > 0 then
		for slot6, slot7 in pairs(slot2) do
			if slot7.jumpGroupId == slot1 then
				return slot7
			end
		end
	end

	return nil
end

function slot0.getPoolServerMO(slot0, slot1)
	if slot0._validServerPoolMap then
		return slot0._validServerPoolMap[slot1]
	end
end

function slot0.getServerMOMap(slot0)
	return slot0._validServerPoolMap
end

function slot0.trySetSelectPoolIndex(slot0, slot1)
	if slot0:getCount() == 0 then
		return false
	elseif slot1 < 1 then
		slot1 = slot2
	elseif slot2 < slot1 then
		slot1 = 1
	end

	slot3 = slot0:getByIndex(slot1)
	slot0._curPoolIndex = slot1
	slot0._curPoolId = slot3.id
	slot0._curPool = slot3

	SummonController.instance:setLastPoolId(slot0._curPoolId)
	slot0:_updateSummonDiamondStatus()

	return true
end

function slot0.trySetSelectPoolId(slot0, slot1)
	if slot0:getById(slot1) then
		slot0._curPoolIndex = slot0:getIndex(slot2)
		slot0._curPoolId = slot1
		slot0._curPool = slot2

		SummonController.instance:setLastPoolId(slot0._curPoolId)
		slot0:_updateSummonDiamondStatus()

		return true
	end

	return false
end

function slot0._updateSummonDiamondStatus(slot0)
	slot1 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.SingleSummonPer), "#")
	slot0.everyCostCount = slot1[3]
	slot0.costCurrencyType = slot1[1]
	slot0.costCurrencyId = slot1[2]
end

function slot0.getOwnCostCurrencyNum(slot0)
	return ItemModel.instance:getItemQuantity(slot0.costCurrencyType, slot0.costCurrencyId)
end

slot0.EmptyDetailDict = {}

function slot0.getEquipDetailListByPool(slot0, slot1)
	if slot1 then
		return SummonConfig.instance:getEquipDetailByPoolId(slot1.id) or uv0.EmptyDetailDict
	else
		return uv0.EmptyDetailDict
	end
end

function slot0.sortDetailByLocation(slot0, slot1)
	if slot0.detailCo.location ~= slot1.detailCo.location then
		return slot0.detailCo.location < slot1.detailCo.location
	else
		return slot0.detailCo.id < slot1.detailCo.id
	end
end

function slot0.getCurIndex(slot0)
	return slot0._curPoolIndex
end

function slot0.getCurId(slot0)
	return slot0._curPoolId
end

function slot0.setNewbiePoolExist(slot0, slot1)
	slot0._hasNewbiePool = slot1
end

function slot0.getNewbiePoolExist(slot0)
	return slot0._hasNewbiePool
end

function slot0.setNewbieProgress(slot0, slot1)
	slot0._newbieProgress = slot1
end

function slot0.getNewbieProgress(slot0)
	return slot0._newbieProgress
end

function slot0.setServerPoolInfos(slot0, slot1)
	slot0._validServerPoolMap = slot0._validServerPoolMap or {}
	slot2 = {
		[slot7.poolId] = slot7
	}

	for slot6, slot7 in ipairs(slot1) do
		if not slot0._validServerPoolMap[slot7.poolId] then
			slot8 = SummonMainPoolMO.New()

			slot8:init(slot7)

			slot0._validServerPoolMap[slot7.poolId] = slot8
		else
			slot8:update(slot7)
		end
	end

	for slot6, slot7 in pairs(slot0._validServerPoolMap) do
		if not slot2[slot7.id] then
			slot0._validServerPoolMap[slot6] = nil
		end
	end

	slot0:refreshRecord()
end

function slot0.getFirstValidPool(slot0)
	if slot0._poolList then
		return slot0._poolList[1]
	end
end

function slot0.refreshRecord(slot0)
	slot0.flagModel:init()
	slot0.flagModel:compareRecord(uv0.getValidPools())
end

function slot0.categoryHasNew(slot0, slot1)
	slot2 = false

	if slot0.flagModel then
		slot2 = slot0.flagModel:isNew(slot1)
	end

	return slot2
end

function slot0.hasNextDayFree(slot0, slot1)
	if SummonConfig.instance:canShowSingleFree(slot1) then
		if slot0:getPoolServerMO(slot1) and slot4.usedFreeCount < SummonConfig.instance:getSummonPool(slot1).totalFreeCount then
			return true
		end
	end

	return false
end

function slot0.entryHasNew(slot0)
	if slot0.flagModel then
		return slot0.flagModel:hasNew()
	end

	return false
end

function slot0.entryHasFree(slot0)
	for slot5, slot6 in ipairs(uv0.getValidPools()) do
		if slot0:getPoolServerMO(slot6.id) and slot7.haveFree then
			return true
		end
	end

	return false
end

function slot0.getCustomPickProbability(slot0, slot1)
	if SummonConfig.instance:getSummonPool(slot1) and slot2.type == SummonEnum.Type.CustomPick then
		slot3 = string.split(slot2.param, "|")
		slot4 = tonumber(slot3[1])

		for slot10 = 1, #string.splitToNumber(slot3[2], "#") do
			slot6 = 0 + slot5[slot10]
		end

		return slot6 * 0.001 / slot4 * 100, slot2.totalPosibility, false
	end

	if slot2 and slot2.type == SummonEnum.Type.StrongCustomOnePick then
		if SummonCustomPickModel.instance:isHaveFirstSSR(slot1) then
			return 50, 0, false
		else
			return 100, 0, true
		end
	end

	return 0, 0, false
end

function slot0.getDiscountTime10Server(slot0, slot1)
	if slot0:getPoolServerMO(slot1) then
		return slot2.discountTime
	end

	return 0
end

function slot0.getDiscountCostId(slot0, slot1)
	if SummonConfig.instance:getSummonPool(slot1) then
		for slot8, slot9 in ipairs(string.split(slot2.discountCost10, "|")) do
			if string.splitToNumber(slot9, "#") then
				return slot10[2]
			end
		end
	end

	return 0
end

function slot0.getDiscountTime10(slot0, slot1)
	if SummonConfig.instance:getSummonPool(slot1) then
		return slot2.discountTime10
	end

	return 0
end

function slot0.getDiscountCost10(slot0, slot1, slot2)
	slot3 = slot0:getDiscountTime10(slot1)

	if slot3 >= (slot2 or slot3 - slot0:getDiscountTime10Server(slot1) + 1) and SummonConfig.instance:getSummonPool(slot1) then
		for slot12, slot13 in ipairs(string.split(slot6.discountCost10, "|")) do
			if string.splitToNumber(slot13, "#") and slot14[1] == slot5 then
				return slot14[3]
			end
		end
	end

	return -1
end

function slot0.getCostByConfig(slot0)
	if string.nilorempty(slot0) then
		logError("no summon cost config")

		return
	end

	for slot5, slot6 in ipairs(string.split(slot0, "|")) do
		slot7 = string.splitToNumber(slot6, "#")
		slot8 = slot7[1]
		slot9 = slot7[2]
		slot10 = slot7[3]

		if slot5 >= #slot1 then
			return slot8, slot9, slot10
		end

		if slot10 <= ItemModel.instance:getItemQuantity(slot8, slot9) then
			return slot8, slot9, slot10
		end
	end
end

function slot0.getLastCostByConfig(slot0)
	if string.nilorempty(slot0) then
		logError("no summon cost config")

		return
	end

	slot1 = string.split(slot0, "|")
	slot2 = string.splitToNumber(slot1[#slot1], "#")

	return slot2[1], slot2[2], slot2[3]
end

function slot0.getSummonItemIcon(slot0, slot1)
	if not ItemModel.instance:getItemConfig(tonumber(slot0), tonumber(slot1)) then
		logError(string.format("getSummonItemIcon no config itemType:%s,id:%s", slot0, slot1))

		return
	end

	slot3 = nil

	return (slot0 ~= MaterialEnum.MaterialType.Item or ItemModel.instance:getItemSmallIcon(slot1)) and (slot0 ~= MaterialEnum.MaterialType.Currency or ResUrl.getCurrencyItemIcon(slot2.icon)) and ResUrl.getSpecialPropItemIcon(slot2.icon)
end

function slot0.getResultType(slot0)
	return SummonEnum.Type2Result[slot0.type] or SummonEnum.ResultType.Char
end

function slot0.getResultTypeById(slot0)
	if slot0 then
		if SummonConfig.instance:getSummonPool(slot0) then
			return uv0.getResultType(slot1)
		else
			logError("can't find summon pool config : [" .. tostring(slot0) .. "]")
		end
	end

	return SummonEnum.ResultType.Char
end

function slot0.isProbUp(slot0)
	return uv0.getADPageTabIndex(slot0) == SummonEnum.TabContentIndex.CharProbUp or slot1 == SummonEnum.TabContentIndex.EquipProbUp
end

function slot0.getCostCurrencyParam(slot0)
	if slot0 then
		uv0.addCurrencyByCostStr({}, slot0.cost1, {})
	else
		table.insert(slot1, {
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = uv0.jumpToSummonCostShop
		})
		table.insert(slot1, {
			id = 140002,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = uv0.jumpToSummonCostShop
		})
	end

	table.insert(slot1, CurrencyEnum.CurrencyType.Diamond)
	table.insert(slot1, CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	return slot1
end

function slot0.jumpToSummonCostShop()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.SummonCost)
end

function slot0.addCurrencyByCostStr(slot0, slot1, slot2)
	if not string.nilorempty(slot1) then
		for slot7, slot8 in ipairs(string.split(slot1, "|")) do
			slot9 = string.splitToNumber(slot8, "#")
			slot12 = slot9[3]

			if not slot2[slot9[2]] then
				table.insert(slot0, {
					isIcon = true,
					id = slot11,
					type = slot9[1],
					jumpFunc = uv0.jumpToSummonCostShop
				})

				slot2[slot11] = true
			end
		end
	end
end

function slot0.entryNeedReddot(slot0)
	if slot0:getServerMOMap() then
		for slot5, slot6 in pairs(slot1) do
			if uv0.needShowReddot(slot6) then
				return true
			end
		end
	end

	return false
end

function slot0.needShowReddot(slot0)
	if not slot0:isOpening() then
		return false
	end

	if slot0.luckyBagMO and slot0.luckyBagMO:isGot() and not slot0.luckyBagMO:isOpened() then
		return true
	end

	if slot0.haveFree then
		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
