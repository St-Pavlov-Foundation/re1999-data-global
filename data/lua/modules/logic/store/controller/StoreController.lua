-- chunkname: @modules/logic/store/controller/StoreController.lua

module("modules.logic.store.controller.StoreController", package.seeall)

local StoreController = class("StoreController", BaseController)

function StoreController:getRecommendStoreTime_overseas(config)
	if not config then
		return ""
	end

	local configStartTime = string.nilorempty(config.showOnlineTime) and config.onlineTime or config.showOnlineTime
	local configEndTime = string.nilorempty(config.showOfflineTime) and config.offlineTime or config.showOfflineTime
	local onlineTimeStamp = TimeUtil.stringToTimestamp(configStartTime)
	local offlineTimeStamp = TimeUtil.stringToTimestamp(configEndTime)
	local startDate = os.date("*t", onlineTimeStamp)
	local endDate = os.date("*t", offlineTimeStamp)
	local startMonth = string.format("%02d", startDate.month)
	local startDay = string.format("%02d", startDate.day)
	local endMonth = string.format("%02d", endDate.month)
	local endDay = string.format("%02d", endDate.day)

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime_overseas"), {
		startMonth,
		startDay,
		endMonth,
		endDay
	})
end

function StoreController:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function StoreController:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

local kOpenedEventPackageKey = "EventPackage_WhispersOfTheSnow"

function StoreController:setIsOpenedEventPackage(isOpened)
	self:saveInt(kOpenedEventPackageKey, isOpened and 1 or 0)
end

function StoreController:getIsOpenedEventPackage()
	return self:getInt(kOpenedEventPackageKey, 0) ~= 0
end

function StoreController:onInit()
	self._lastViewStoreId = 0
	self._viewTime = nil
	self._tabTime = nil
	self._lastViewGoodsId = 0
	self._goodsTime = nil
end

function StoreController:onInitFinish()
	self._lastViewStoreId = 0
	self._viewTime = nil
	self._tabTime = nil
end

function StoreController:addConstEvents()
	return
end

function StoreController:reInit()
	self.enteredRecommendStoreIdList = nil
end

function StoreController:checkAndOpenStoreView(jumpTab, jumpGoodsId, isFocus)
	local isCanOpen = false

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		self:openStoreView(jumpTab, jumpGoodsId, isFocus)

		isCanOpen = true
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end

	return isCanOpen
end

function StoreController:openStoreView(jumpTab, jumpGoodsId, isFocus)
	local param = {}

	param.jumpTab = jumpTab
	param.jumpGoodsId = jumpGoodsId
	param.isFocus = isFocus

	ViewMgr.instance:openView(ViewName.StoreView, param)
end

function StoreController:openNormalGoodsView(normalGoodsMO)
	if normalGoodsMO.belongStoreId == StoreEnum.StoreId.NewRoomStore or normalGoodsMO.belongStoreId == StoreEnum.StoreId.OldRoomStore then
		if self:isRoomBlockGift(normalGoodsMO) then
			ViewMgr.instance:openView(ViewName.RoomBlockGiftStoreGoodsView, normalGoodsMO)
		else
			RoomController.instance:openStoreGoodsTipView(normalGoodsMO)
		end
	else
		ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, normalGoodsMO)
	end
end

function StoreController:isRoomBlockGift(normalGoodsMO)
	if string.nilorempty(normalGoodsMO.config.product) then
		return
	end

	local productArr = GameUtil.splitString2(normalGoodsMO.config.product, true)
	local itemType = productArr[1][1]
	local itemId = productArr[1][2]
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	return config.subType == ItemEnum.SubType.RoomBlockGift or config.subType == ItemEnum.SubType.RoomBlockGiftNew
end

function StoreController:openChargeGoodsView(chargeGoodsMO)
	ViewMgr.instance:openView(ViewName.ChargeStoreGoodsView, chargeGoodsMO)
end

function StoreController:openPackageStoreGoodsView(packageGoodsMO)
	local goodsType = packageGoodsMO.config.type
	local belongStoreId = packageGoodsMO.belongStoreId

	if goodsType == StoreEnum.StoreChargeType.Optional then
		local optionalTypeView = {
			[StoreEnum.chargeOptionalType.PosOption] = ViewName.OptionalChargeView,
			[StoreEnum.chargeOptionalType.GroupOption] = ViewName.OptionalGroupChargeView
		}
		local chargeOptionCoList = StoreConfig.instance:getChargeOptionalGroup(packageGoodsMO.config.id)
		local viewName = chargeOptionCoList and optionalTypeView[chargeOptionCoList[1].type]

		if not viewName then
			logError("充值商品" .. packageGoodsMO.config.id .. "对应的自选礼包或类型配置错误")

			return
		end

		ViewMgr.instance:openView(viewName, packageGoodsMO)
	elseif goodsType == StoreEnum.StoreChargeType.LinkGiftGoods then
		ViewMgr.instance:openView(ViewName.StoreLinkGiftGoodsView, packageGoodsMO)
	elseif goodsType == StoreEnum.StoreChargeType.NationalGift then
		local param = {}

		param.goodMo = packageGoodsMO

		NationalGiftController.instance:openNationalGiftBuyTipView(param)
	elseif belongStoreId == StoreEnum.StoreId.Skin then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
			index = 1,
			goodsMO = packageGoodsMO
		})
	else
		ViewMgr.instance:openView(ViewName.PackageStoreGoodsView, packageGoodsMO)
	end
end

function StoreController:openDecorateStoreGoodsView(decorateGoodsMO)
	local products = string.splitToNumber(decorateGoodsMO.config.product, "#")
	local itemCo = ItemModel.instance:getItemConfig(products[1], products[2])

	if itemCo.subType == ItemEnum.SubType.PlayerBg then
		local param = {
			goodsMo = decorateGoodsMO
		}

		ViewMgr.instance:openView(ViewName.DecorateStoreGoodsBuyView, param)
	else
		ViewMgr.instance:openView(ViewName.DecorateStoreGoodsView, decorateGoodsMO)
	end
end

function StoreController:openSummonStoreGoodsView(goodsMO)
	if goodsMO.belongStoreId == StoreEnum.StoreId.RoomStore then
		RoomController.instance:openStoreGoodsTipView(goodsMO)
	else
		ViewMgr.instance:openView(ViewName.SummonStoreGoodsView, goodsMO)
	end
end

function StoreController:buyGoods(storeGoodsMO, quantity, callback, callbackObj, selectCost)
	StoreRpc.instance:sendBuyGoodsRequest(storeGoodsMO.belongStoreId, storeGoodsMO.goodsId, quantity, callback, callbackObj, selectCost)
end

function StoreController:forceReadTab(jumpTab)
	local storeId = StoreModel.instance:jumpTabIdToStoreId(jumpTab)

	self:_readTab(storeId)
end

function StoreController:readTab(jumpTab)
	local storeId = StoreModel.instance:jumpTabIdToStoreId(jumpTab)

	if storeId == self._lastViewStoreId then
		return
	end

	self:_readTab(storeId)
end

function StoreController:_readTab(storeId)
	if storeId == StoreEnum.StoreId.EventPackage and not self:getIsOpenedEventPackage() then
		self:setIsOpenedEventPackage(true)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
	end

	local dotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)

	if dotInfo then
		local storedotinfos = dotInfo.infos
		local goodsIds = {}

		for _, v in pairs(storedotinfos) do
			local goodsMo = StoreModel.instance:getGoodsMO(v.uid)

			if goodsMo and storeId == goodsMo.belongStoreId then
				table.insert(goodsIds, v.uid)
			end
		end

		if #goodsIds > 0 then
			StoreRpc.instance:sendReadStoreNewRequest(goodsIds)
		end
	end

	dotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)

	if dotInfo then
		local storedotinfos = dotInfo.infos
		local goodsIds = {}

		for _, v in pairs(storedotinfos) do
			local goodsMo = StoreModel.instance:getGoodsMO(v.uid)

			if goodsMo and storeId == goodsMo.belongStoreId then
				table.insert(goodsIds, v.uid)
			end
		end

		if #goodsIds > 0 then
			local isPackageStore = StoreConfig.instance:isPackageStore(storeId)

			if not isPackageStore then
				ChargeRpc.instance:sendReadChargeNewRequest(goodsIds)
			else
				local ids = {}

				for _, goodsId in pairs(goodsIds) do
					local storePackageGoodsMO = StoreModel.instance:getGoodsMO(goodsId)
					local serverTime = ServerTime.now()
					local inTime = serverTime >= storePackageGoodsMO.newStartTime and serverTime <= storePackageGoodsMO.newEndTime

					if not inTime then
						table.insert(ids, goodsId)
					end
				end

				ChargeRpc.instance:sendReadChargeNewRequest(ids)
			end
		end
	end
end

function StoreController:statSwitchStore(jumpTab)
	local storeId = StoreModel.instance:jumpTabIdToStoreId(jumpTab)

	if storeId == self._lastViewStoreId then
		return
	end

	if not self._viewTime then
		StatController.instance:track(StatEnum.EventName.StoreEnter, {
			[StatEnum.EventProperties.StoreId] = tostring(storeId)
		})

		self._viewTime = ServerTime.now()
	else
		local duration = 0

		if self._tabTime then
			duration = ServerTime.now() - self._tabTime
		end

		StatController.instance:track(StatEnum.EventName.SwitchStore, {
			[StatEnum.EventProperties.BeforeStoreId] = tostring(self._lastViewStoreId),
			[StatEnum.EventProperties.AfterStoreId] = tostring(storeId),
			[StatEnum.EventProperties.Time] = duration
		})
	end

	self._tabTime = ServerTime.now()
	self._lastViewStoreId = storeId
end

function StoreController:statExitStore()
	local duration = 0

	if self._viewTime then
		duration = ServerTime.now() - self._viewTime
	end

	StatController.instance:track(StatEnum.EventName.StoreExit, {
		[StatEnum.EventProperties.StoreId] = tostring(self._lastViewStoreId),
		[StatEnum.EventProperties.Time] = duration
	})

	self._lastViewStoreId = 0
	self._viewTime = nil
	self._tabTime = nil
end

function StoreController:statOpenGoods(storeId, goodsConfig)
	if not goodsConfig then
		return
	end

	if ChargePushStatController.instance:statClick(goodsConfig.id) then
		return
	end

	self._lastViewGoodsId = goodsConfig.id
	self._goodsTime = ServerTime.now()

	local product = goodsConfig.product
	local productInfo = string.split(product, "#")
	local itemType = tonumber(productInfo[1])
	local itemId = tonumber(productInfo[2])
	local itemQuantity = tonumber(productInfo[3])
	local itemConfig = ItemModel.instance:getItemConfig(itemType, itemId)

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(storeId),
		[StatEnum.EventProperties.GoodsId] = goodsConfig.id,
		[StatEnum.EventProperties.MaterialName] = itemConfig and itemConfig.name or "",
		[StatEnum.EventProperties.MaterialNum] = itemQuantity
	})
end

function StoreController:statOpenChargeGoods(storeId, goodsConfig)
	if not goodsConfig then
		return
	end

	if ChargePushStatController.instance:statClick(goodsConfig.id) then
		return
	end

	self._lastViewGoodsId = goodsConfig.id
	self._goodsTime = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(storeId),
		[StatEnum.EventProperties.GoodsId] = goodsConfig.id,
		[StatEnum.EventProperties.MaterialName] = goodsConfig and goodsConfig.name or "",
		[StatEnum.EventProperties.MaterialNum] = 1
	})
end

function StoreController:statCloseGoods(goodsConfig)
	if not goodsConfig then
		return
	end

	if self._lastViewGoodsId ~= goodsConfig.id then
		return
	end

	local duration = 0

	if self._goodsTime then
		duration = ServerTime.now() - self._goodsTime
	end

	self._lastViewGoodsId = 0
end

function StoreController:recordExchangeSkinDiamond(diamondQuantity)
	self.exchangeDiamondQuantity = diamondQuantity
end

function StoreController:statBuyGoods(storeId, goodsId, buyCount, existBuyCount, selectCost)
	selectCost = selectCost or 1

	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)
	local productItem = goodsConfig.product
	local cost

	if storeId == StoreEnum.StoreId.RoomStore then
		productItem = self.roomStoreCanBuyGoodsStr
		cost = self:_itemsMultipleWithBuyCount(self.recordCostItem, buyCount, existBuyCount)
	elseif storeId == StoreEnum.StoreId.Skin and self.exchangeDiamondQuantity and self.exchangeDiamondQuantity > 0 then
		local arr = string.splitToNumber(goodsConfig.cost, "#")
		local srcType, srcId, costTotalQuantity = arr[1], arr[2], arr[3]
		local cost1 = {
			type = MaterialEnum.MaterialType.Currency,
			id = CurrencyEnum.CurrencyType.Diamond,
			quantity = self.exchangeDiamondQuantity
		}
		local cost2 = {
			type = srcType,
			id = srcId,
			quantity = costTotalQuantity - self.exchangeDiamondQuantity
		}

		cost = self:_generateItemListJson({
			cost1,
			cost2
		})
		self.exchangeDiamondQuantity = 0
	else
		cost = self:_itemsMultipleWithBuyCount(goodsConfig.cost, buyCount, existBuyCount)
	end
end

function StoreController:statVersionActivityBuyGoods(activityId, goodsId, buyCount, existBuyCount)
	return
end

function StoreController:recordRoomStoreCurrentCanBuyGoods(goodsId, selectCost, costNum)
	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)

	if selectCost == 1 then
		self.recordCostItem = goodsConfig.cost
	elseif selectCost == 2 then
		self.recordCostItem = goodsConfig.cost2
	else
		self.recordCostItem = goodsConfig.cost
	end

	self.roomStoreCanBuyGoodsStr = goodsConfig.product

	local productList = string.split(goodsConfig.product, "|")

	if #productList > 1 then
		local costTab = string.split(self.recordCostItem, "#")
		local canBuyItemList = {}

		costTab[3] = costNum

		for index, product in ipairs(productList) do
			local productArr = string.splitToNumber(product, "#")
			local hasQuantity = ItemModel.instance:getItemQuantity(productArr[1], productArr[2])
			local itemConfig = ItemModel.instance:getItemConfig(productArr[1], productArr[2])
			local numLimit = itemConfig and itemConfig.numLimit or 1

			if numLimit == 0 or hasQuantity < numLimit then
				table.insert(canBuyItemList, string.format("%s#%s#%s", productArr[1], productArr[2], numLimit - hasQuantity))
			end
		end

		self.recordCostItem = table.concat(costTab, "#")
		self.roomStoreCanBuyGoodsStr = table.concat(canBuyItemList, "|")
	end
end

function StoreController:_itemsMultiple(item, buyCount)
	if string.nilorempty(item) or buyCount <= 0 then
		return {}
	end

	local items = GameUtil.splitString2(item, true)
	local result = {}

	for i, itemParams in ipairs(items) do
		local item = {
			type = itemParams[1],
			id = itemParams[2],
			quantity = itemParams[3] * buyCount
		}

		table.insert(result, item)
	end

	return self:_generateItemListJson(result)
end

function StoreController:_itemsMultipleWithBuyCount(items, buyCount, existBuyCount)
	if string.nilorempty(items) or buyCount <= 0 then
		return {}
	end

	local result = {}
	local costs = string.split(items, "|")

	for index = existBuyCount + 1, existBuyCount + buyCount do
		local costParam = costs[index] or costs[#costs]
		local costInfo = string.splitToNumber(costParam, "#")

		if index >= #costs then
			table.insert(result, {
				type = costInfo[1],
				id = costInfo[2],
				quantity = costInfo[3] * (existBuyCount + buyCount - index + 1)
			})

			break
		else
			table.insert(result, {
				type = costInfo[1],
				id = costInfo[2],
				quantity = costInfo[3]
			})
		end
	end

	if #result <= 0 then
		return {}
	end

	local merged = {}

	for i, item in ipairs(result) do
		merged[item.type] = merged[item.type] or {}
		merged[item.type][item.id] = (merged[item.type][item.id] or 0) + item.quantity
	end

	result = {}

	for type, dict in pairs(merged) do
		for id, quantity in pairs(dict) do
			table.insert(result, {
				type = type,
				id = id,
				quantity = quantity
			})
		end
	end

	return self:_generateItemListJson(result)
end

function StoreController:_generateItemListJson(result)
	if not result or #result <= 0 then
		return {}
	end

	local itemListJson = {}

	for i, item in ipairs(result) do
		local config = ItemModel.instance:getItemConfig(item.type, item.id)

		table.insert(itemListJson, {
			materialname = config and config.name or "",
			materialtype = item.type,
			materialnum = item.quantity
		})
	end

	return itemListJson
end

function StoreController:isNeedShowRedDotNewTag(recommendStoreConfig)
	return recommendStoreConfig and recommendStoreConfig.type == 0 and not string.nilorempty(recommendStoreConfig.onlineTime)
end

function StoreController:initEnteredRecommendStoreList()
	local key = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()
	local str = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(str) then
		self.enteredRecommendStoreIdList = {}

		return
	end

	self.enteredRecommendStoreIdList = string.splitToNumber(str, ";")
end

function StoreController:enterRecommendStore(storeId)
	if not self.enteredRecommendStoreIdList then
		self:initEnteredRecommendStoreList()
	end

	if tabletool.indexOf(self.enteredRecommendStoreIdList, storeId) then
		return
	end

	table.insert(self.enteredRecommendStoreIdList, storeId)
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)

	local key = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()

	PlayerPrefsHelper.setString(key, table.concat(self.enteredRecommendStoreIdList, ";"))
end

function StoreController:isEnteredRecommendStore(storeId)
	if not self.enteredRecommendStoreIdList then
		self:initEnteredRecommendStoreList()
	end

	return tabletool.indexOf(self.enteredRecommendStoreIdList, storeId)
end

function StoreController:getRecommendStoreTime(config)
	do return self:getRecommendStoreTime_overseas(config) end

	if not config then
		return
	end

	local configStartTime = string.nilorempty(config.showOnlineTime) and config.onlineTime or config.showOnlineTime
	local configEndTime = string.nilorempty(config.showOfflineTime) and config.offlineTime or config.showOfflineTime
	local onlineTimeStamp = TimeUtil.stringToTimestamp(configStartTime)
	local offlineTimeStamp = TimeUtil.stringToTimestamp(configEndTime)
	local startMonth = tonumber(os.date("%m", onlineTimeStamp))
	local startDay = tonumber(os.date("%d", onlineTimeStamp))
	local startHour = tonumber(os.date("%H", onlineTimeStamp))
	local startMinute = string.format("%02d", tonumber(os.date("%M", onlineTimeStamp)))
	local endMonth = tonumber(os.date("%m", offlineTimeStamp))
	local endDay = tonumber(os.date("%d", offlineTimeStamp))
	local endHour = tonumber(os.date("%H", offlineTimeStamp))
	local endMinute = string.format("%02d", tonumber(os.date("%M", offlineTimeStamp)))

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime"), {
		startMonth,
		startDay,
		startHour,
		startMinute,
		endMonth,
		endDay,
		endHour,
		endMinute
	})
end

function StoreController:onUseItemInStore(msg)
	if not msg then
		return
	end

	if msg.entry and msg.entry[1].materialId and (msg.entry[1].materialId == StoreEnum.NormalRoomTicket or msg.entry[1].materialId == StoreEnum.TopRoomTicket) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged, tonumber(msg.targetId))
	end
end

function StoreController:statOnClickPowerPotion(powerPotionName)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotion, {
		[StatEnum.EventProperties.WindowName] = powerPotionName
	})
end

function StoreController:statOnClickPowerPotionJump(powerPotionName, jumpName)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotionJump, {
		[StatEnum.EventProperties.WindowName] = powerPotionName,
		[StatEnum.EventProperties.JumpName] = jumpName
	})
end

function StoreController:needHideHome()
	if self._needHideBackHomeViews == nil then
		self._needHideBackHomeViews = {
			ViewName.SummonResultView,
			ViewName.SummonADView
		}
	end

	for i = 1, #self._needHideBackHomeViews do
		if ViewMgr.instance:isOpen(self._needHideBackHomeViews[i]) then
			return true
		end
	end

	return false
end

StoreController.instance = StoreController.New()

return StoreController
