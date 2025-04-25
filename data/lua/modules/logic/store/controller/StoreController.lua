module("modules.logic.store.controller.StoreController", package.seeall)

slot0 = class("StoreController", BaseController)

function slot0.getRecommendStoreTime_overseas(slot0, slot1)
	if not slot1 then
		return ""
	end

	slot6 = os.date("*t", TimeUtil.stringToTimestamp(string.nilorempty(slot1.showOnlineTime) and slot1.onlineTime or slot1.showOnlineTime))
	slot7 = os.date("*t", TimeUtil.stringToTimestamp(string.nilorempty(slot1.showOfflineTime) and slot1.offlineTime or slot1.showOfflineTime))

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime_overseas"), {
		string.format("%02d", slot6.month),
		string.format("%02d", slot6.day),
		string.format("%02d", slot7.month),
		string.format("%02d", slot7.day)
	})
end

function slot0.saveInt(slot0, slot1, slot2)
	GameUtil.playerPrefsSetNumberByUserId(slot1, slot2)
end

function slot0.getInt(slot0, slot1, slot2)
	return GameUtil.playerPrefsGetNumberByUserId(slot1, slot2)
end

slot1 = "EventPackage_WhispersOfTheSnow"

function slot0.setIsOpenedEventPackage(slot0, slot1)
	slot0:saveInt(uv0, slot1 and 1 or 0)
end

function slot0.getIsOpenedEventPackage(slot0)
	return slot0:getInt(uv0, 0) ~= 0
end

function slot0.onInit(slot0)
	slot0._lastViewStoreId = 0
	slot0._viewTime = nil
	slot0._tabTime = nil
	slot0._lastViewGoodsId = 0
	slot0._goodsTime = nil
end

function slot0.onInitFinish(slot0)
	slot0._lastViewStoreId = 0
	slot0._viewTime = nil
	slot0._tabTime = nil
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0.enteredRecommendStoreIdList = nil
end

function slot0.checkAndOpenStoreView(slot0, slot1, slot2)
	slot3 = false

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		slot0:openStoreView(slot1, slot2)

		slot3 = true
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end

	return slot3
end

function slot0.openStoreView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.StoreView, {
		jumpTab = slot1,
		jumpGoodsId = slot2
	})
end

function slot0.openNormalGoodsView(slot0, slot1)
	if slot1.belongStoreId == StoreEnum.SubRoomNew or slot1.belongStoreId == StoreEnum.SubRoomOld then
		RoomController.instance:openStoreGoodsTipView(slot1)
	else
		ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, slot1)
	end
end

function slot0.openChargeGoodsView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.ChargeStoreGoodsView, slot1)
end

function slot0.openPackageStoreGoodsView(slot0, slot1)
	if slot1.config.type == StoreEnum.StoreChargeType.Optional then
		ViewMgr.instance:openView(ViewName.OptionalChargeView, slot1)
	else
		ViewMgr.instance:openView(ViewName.PackageStoreGoodsView, slot1)
	end
end

function slot0.openDecorateStoreGoodsView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.DecorateStoreGoodsView, slot1)
end

function slot0.openSummonStoreGoodsView(slot0, slot1)
	if slot1.belongStoreId == StoreEnum.Room then
		RoomController.instance:openStoreGoodsTipView(slot1)
	else
		ViewMgr.instance:openView(ViewName.SummonStoreGoodsView, slot1)
	end
end

function slot0.buyGoods(slot0, slot1, slot2, slot3, slot4, slot5)
	StoreRpc.instance:sendBuyGoodsRequest(slot1.belongStoreId, slot1.goodsId, slot2, slot3, slot4, slot5)
end

function slot0.forceReadTab(slot0, slot1)
	slot0:_readTab(StoreModel.instance:jumpTabIdToStoreId(slot1))
end

function slot0.readTab(slot0, slot1)
	if StoreModel.instance:jumpTabIdToStoreId(slot1) == slot0._lastViewStoreId then
		return
	end

	slot0:_readTab(slot2)
end

function slot0._readTab(slot0, slot1)
	if slot1 == StoreEnum.StoreId.EventPackage and not slot0:getIsOpenedEventPackage() then
		slot0:setIsOpenedEventPackage(true)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
	end

	if RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead) then
		slot4 = {}

		for slot8, slot9 in pairs(slot2.infos) do
			if StoreModel.instance:getGoodsMO(slot9.uid) and slot1 == slot10.belongStoreId then
				table.insert(slot4, slot9.uid)
			end
		end

		if #slot4 > 0 then
			StoreRpc.instance:sendReadStoreNewRequest(slot4)
		end
	end

	if RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead) then
		slot4 = {}

		for slot8, slot9 in pairs(slot2.infos) do
			if StoreModel.instance:getGoodsMO(slot9.uid) and slot1 == slot10.belongStoreId then
				table.insert(slot4, slot9.uid)
			end
		end

		if #slot4 > 0 then
			ChargeRpc.instance:sendReadChargeNewRequest(slot4)
		end
	end
end

function slot0.statSwitchStore(slot0, slot1)
	if StoreModel.instance:jumpTabIdToStoreId(slot1) == slot0._lastViewStoreId then
		return
	end

	if not slot0._viewTime then
		StatController.instance:track(StatEnum.EventName.StoreEnter, {
			[StatEnum.EventProperties.StoreId] = tostring(slot2)
		})

		slot0._viewTime = ServerTime.now()
	else
		slot3 = 0

		if slot0._tabTime then
			slot3 = ServerTime.now() - slot0._tabTime
		end

		StatController.instance:track(StatEnum.EventName.SwitchStore, {
			[StatEnum.EventProperties.BeforeStoreId] = tostring(slot0._lastViewStoreId),
			[StatEnum.EventProperties.AfterStoreId] = tostring(slot2),
			[StatEnum.EventProperties.Time] = slot3
		})
	end

	slot0._tabTime = ServerTime.now()
	slot0._lastViewStoreId = slot2
end

function slot0.statExitStore(slot0)
	slot1 = 0

	if slot0._viewTime then
		slot1 = ServerTime.now() - slot0._viewTime
	end

	StatController.instance:track(StatEnum.EventName.StoreExit, {
		[StatEnum.EventProperties.StoreId] = tostring(slot0._lastViewStoreId),
		[StatEnum.EventProperties.Time] = slot1
	})

	slot0._lastViewStoreId = 0
	slot0._viewTime = nil
	slot0._tabTime = nil
end

function slot0.statOpenGoods(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	slot0._lastViewGoodsId = slot2.id
	slot0._goodsTime = ServerTime.now()
	slot4 = string.split(slot2.product, "#")

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(slot1),
		[StatEnum.EventProperties.GoodsId] = slot2.id,
		[StatEnum.EventProperties.MaterialName] = ItemModel.instance:getItemConfig(tonumber(slot4[1]), tonumber(slot4[2])) and slot8.name or "",
		[StatEnum.EventProperties.MaterialNum] = tonumber(slot4[3])
	})
end

function slot0.statOpenChargeGoods(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	slot0._lastViewGoodsId = slot2.id
	slot0._goodsTime = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(slot1),
		[StatEnum.EventProperties.GoodsId] = slot2.id,
		[StatEnum.EventProperties.MaterialName] = slot2 and slot2.name or "",
		[StatEnum.EventProperties.MaterialNum] = 1
	})
end

function slot0.statCloseGoods(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._lastViewGoodsId ~= slot1.id then
		logError("打开和关闭时商品不一致， 不应该发生")

		return
	end

	slot2 = 0

	if slot0._goodsTime then
		slot2 = ServerTime.now() - slot0._goodsTime
	end

	slot0._lastViewGoodsId = 0
end

function slot0.recordExchangeSkinDiamond(slot0, slot1)
	slot0.exchangeDiamondQuantity = slot1
end

function slot0.statBuyGoods(slot0, slot1, slot2, slot3, slot4, slot5)
	slot5 = slot5 or 1
	slot7 = StoreConfig.instance:getGoodsConfig(slot2).product
	slot8 = nil

	if slot1 == StoreEnum.Room then
		slot7 = slot0.roomStoreCanBuyGoodsStr
		slot8 = slot0:_itemsMultipleWithBuyCount(slot0.recordCostItem, slot3, slot4)
	elseif slot1 == StoreEnum.StoreId.Skin and slot0.exchangeDiamondQuantity and slot0.exchangeDiamondQuantity > 0 then
		slot9 = string.splitToNumber(slot6.cost, "#")
		slot8 = slot0:_generateItemListJson({
			{
				type = MaterialEnum.MaterialType.Currency,
				id = CurrencyEnum.CurrencyType.Diamond,
				quantity = slot0.exchangeDiamondQuantity
			},
			{
				type = slot9[1],
				id = slot9[2],
				quantity = slot9[3] - slot0.exchangeDiamondQuantity
			}
		})
		slot0.exchangeDiamondQuantity = 0
	else
		slot8 = slot0:_itemsMultipleWithBuyCount(slot6.cost, slot3, slot4)
	end
end

function slot0.statVersionActivityBuyGoods(slot0, slot1, slot2, slot3, slot4)
end

function slot0.recordRoomStoreCurrentCanBuyGoods(slot0, slot1, slot2, slot3)
	if slot2 == 1 then
		slot0.recordCostItem = StoreConfig.instance:getGoodsConfig(slot1).cost
	elseif slot2 == 2 then
		slot0.recordCostItem = slot4.cost2
	else
		slot0.recordCostItem = slot4.cost
	end

	slot0.roomStoreCanBuyGoodsStr = slot4.product

	if #string.split(slot4.product, "|") > 1 then
		slot7 = {}
		string.split(slot0.recordCostItem, "#")[3] = slot3

		for slot11, slot12 in ipairs(slot5) do
			slot13 = string.splitToNumber(slot12, "#")
			slot14 = ItemModel.instance:getItemQuantity(slot13[1], slot13[2])

			if (ItemModel.instance:getItemConfig(slot13[1], slot13[2]) and slot15.numLimit or 1) == 0 or slot14 < slot16 then
				table.insert(slot7, string.format("%s#%s#%s", slot13[1], slot13[2], slot16 - slot14))
			end
		end

		slot0.recordCostItem = table.concat(slot6, "#")
		slot0.roomStoreCanBuyGoodsStr = table.concat(slot7, "|")
	end
end

function slot0._itemsMultiple(slot0, slot1, slot2)
	if string.nilorempty(slot1) or slot2 <= 0 then
		return {}
	end

	slot4 = {}

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot1, true)) do
		table.insert(slot4, {
			type = slot9[1],
			id = slot9[2],
			quantity = slot9[3] * slot2
		})
	end

	return slot0:_generateItemListJson(slot4)
end

function slot0._itemsMultipleWithBuyCount(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot1) or slot2 <= 0 then
		return {}
	end

	slot4 = {}
	slot5 = string.split(slot1, "|")

	for slot9 = slot3 + 1, slot3 + slot2 do
		slot11 = string.splitToNumber(slot5[slot9] or slot5[#slot5], "#")

		if slot9 >= #slot5 then
			table.insert(slot4, {
				type = slot11[1],
				id = slot11[2],
				quantity = slot11[3] * (slot3 + slot2 - slot9 + 1)
			})

			break
		else
			table.insert(slot4, {
				type = slot11[1],
				id = slot11[2],
				quantity = slot11[3]
			})
		end
	end

	if #slot4 <= 0 then
		return {}
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot4) do
		slot6[slot11.type] = slot6[slot11.type] or {}
		slot6[slot11.type][slot11.id] = (slot6[slot11.type][slot11.id] or 0) + slot11.quantity
	end

	slot4 = {}

	for slot10, slot11 in pairs(slot6) do
		for slot15, slot16 in pairs(slot11) do
			table.insert(slot4, {
				type = slot10,
				id = slot15,
				quantity = slot16
			})
		end
	end

	return slot0:_generateItemListJson(slot4)
end

function slot0._generateItemListJson(slot0, slot1)
	if not slot1 or #slot1 <= 0 then
		return {}
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, {
			materialname = ItemModel.instance:getItemConfig(slot7.type, slot7.id) and slot8.name or "",
			materialtype = slot7.type,
			materialnum = slot7.quantity
		})
	end

	return slot2
end

function slot0.isNeedShowRedDotNewTag(slot0, slot1)
	return slot1 and slot1.type == 0 and not string.nilorempty(slot1.onlineTime)
end

function slot0.initEnteredRecommendStoreList(slot0)
	if string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId(), "")) then
		slot0.enteredRecommendStoreIdList = {}

		return
	end

	slot0.enteredRecommendStoreIdList = string.splitToNumber(slot2, ";")
end

function slot0.enterRecommendStore(slot0, slot1)
	if not slot0.enteredRecommendStoreIdList then
		slot0:initEnteredRecommendStoreList()
	end

	if tabletool.indexOf(slot0.enteredRecommendStoreIdList, slot1) then
		return
	end

	table.insert(slot0.enteredRecommendStoreIdList, slot1)
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)
	PlayerPrefsHelper.setString(PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId(), table.concat(slot0.enteredRecommendStoreIdList, ";"))
end

function slot0.isEnteredRecommendStore(slot0, slot1)
	if not slot0.enteredRecommendStoreIdList then
		slot0:initEnteredRecommendStoreList()
	end

	return tabletool.indexOf(slot0.enteredRecommendStoreIdList, slot1)
end

function slot0.getRecommendStoreTime(slot0, slot1)
	return slot0:getRecommendStoreTime_overseas(slot1)

	if not slot1 then
		return
	end

	slot4 = TimeUtil.stringToTimestamp(string.nilorempty(slot1.showOnlineTime) and slot1.onlineTime or slot1.showOnlineTime)
	slot5 = TimeUtil.stringToTimestamp(string.nilorempty(slot1.showOfflineTime) and slot1.offlineTime or slot1.showOfflineTime)

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime"), {
		tonumber(os.date("%m", slot4)),
		tonumber(os.date("%d", slot4)),
		tonumber(os.date("%H", slot4)),
		string.format("%02d", tonumber(os.date("%M", slot4))),
		tonumber(os.date("%m", slot5)),
		tonumber(os.date("%d", slot5)),
		tonumber(os.date("%H", slot5)),
		string.format("%02d", tonumber(os.date("%M", slot5)))
	})
end

function slot0.onUseItemInStore(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.entry and slot1.entry[1].materialId and (slot1.entry[1].materialId == StoreEnum.NormalRoomTicket or slot1.entry[1].materialId == StoreEnum.TopRoomTicket) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		uv0.instance:dispatchEvent(StoreEvent.GoodsModelChanged, tonumber(slot1.targetId))
	end
end

function slot0.statOnClickPowerPotion(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotion, {
		[StatEnum.EventProperties.WindowName] = slot1
	})
end

function slot0.statOnClickPowerPotionJump(slot0, slot1, slot2)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotionJump, {
		[StatEnum.EventProperties.WindowName] = slot1,
		[StatEnum.EventProperties.JumpName] = slot2
	})
end

slot0.instance = slot0.New()

return slot0
