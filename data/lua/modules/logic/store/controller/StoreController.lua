module("modules.logic.store.controller.StoreController", package.seeall)

local var_0_0 = class("StoreController", BaseController)

function var_0_0.getRecommendStoreTime_overseas(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return ""
	end

	local var_1_0 = string.nilorempty(arg_1_1.showOnlineTime) and arg_1_1.onlineTime or arg_1_1.showOnlineTime
	local var_1_1 = string.nilorempty(arg_1_1.showOfflineTime) and arg_1_1.offlineTime or arg_1_1.showOfflineTime
	local var_1_2 = TimeUtil.stringToTimestamp(var_1_0)
	local var_1_3 = TimeUtil.stringToTimestamp(var_1_1)
	local var_1_4 = os.date("*t", var_1_2)
	local var_1_5 = os.date("*t", var_1_3)
	local var_1_6 = string.format("%02d", var_1_4.month)
	local var_1_7 = string.format("%02d", var_1_4.day)
	local var_1_8 = string.format("%02d", var_1_5.month)
	local var_1_9 = string.format("%02d", var_1_5.day)

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime_overseas"), {
		var_1_6,
		var_1_7,
		var_1_8,
		var_1_9
	})
end

function var_0_0.saveInt(arg_2_0, arg_2_1, arg_2_2)
	GameUtil.playerPrefsSetNumberByUserId(arg_2_1, arg_2_2)
end

function var_0_0.getInt(arg_3_0, arg_3_1, arg_3_2)
	return GameUtil.playerPrefsGetNumberByUserId(arg_3_1, arg_3_2)
end

local var_0_1 = "EventPackage_WhispersOfTheSnow"

function var_0_0.setIsOpenedEventPackage(arg_4_0, arg_4_1)
	arg_4_0:saveInt(var_0_1, arg_4_1 and 1 or 0)
end

function var_0_0.getIsOpenedEventPackage(arg_5_0)
	return arg_5_0:getInt(var_0_1, 0) ~= 0
end

function var_0_0.onInit(arg_6_0)
	arg_6_0._lastViewStoreId = 0
	arg_6_0._viewTime = nil
	arg_6_0._tabTime = nil
	arg_6_0._lastViewGoodsId = 0
	arg_6_0._goodsTime = nil
end

function var_0_0.onInitFinish(arg_7_0)
	arg_7_0._lastViewStoreId = 0
	arg_7_0._viewTime = nil
	arg_7_0._tabTime = nil
end

function var_0_0.addConstEvents(arg_8_0)
	return
end

function var_0_0.reInit(arg_9_0)
	arg_9_0.enteredRecommendStoreIdList = nil
end

function var_0_0.checkAndOpenStoreView(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = false

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		arg_10_0:openStoreView(arg_10_1, arg_10_2)

		var_10_0 = true
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end

	return var_10_0
end

function var_0_0.openStoreView(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {
		jumpTab = arg_11_1,
		jumpGoodsId = arg_11_2
	}

	ViewMgr.instance:openView(ViewName.StoreView, var_11_0)
end

function var_0_0.openNormalGoodsView(arg_12_0, arg_12_1)
	if arg_12_1.belongStoreId == StoreEnum.SubRoomNew or arg_12_1.belongStoreId == StoreEnum.SubRoomOld then
		RoomController.instance:openStoreGoodsTipView(arg_12_1)
	else
		ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, arg_12_1)
	end
end

function var_0_0.openChargeGoodsView(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.ChargeStoreGoodsView, arg_13_1)
end

function var_0_0.openPackageStoreGoodsView(arg_14_0, arg_14_1)
	if arg_14_1.config.type == StoreEnum.StoreChargeType.Optional then
		ViewMgr.instance:openView(ViewName.OptionalChargeView, arg_14_1)
	else
		ViewMgr.instance:openView(ViewName.PackageStoreGoodsView, arg_14_1)
	end
end

function var_0_0.openDecorateStoreGoodsView(arg_15_0, arg_15_1)
	ViewMgr.instance:openView(ViewName.DecorateStoreGoodsView, arg_15_1)
end

function var_0_0.openSummonStoreGoodsView(arg_16_0, arg_16_1)
	if arg_16_1.belongStoreId == StoreEnum.Room then
		RoomController.instance:openStoreGoodsTipView(arg_16_1)
	else
		ViewMgr.instance:openView(ViewName.SummonStoreGoodsView, arg_16_1)
	end
end

function var_0_0.buyGoods(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	StoreRpc.instance:sendBuyGoodsRequest(arg_17_1.belongStoreId, arg_17_1.goodsId, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
end

function var_0_0.forceReadTab(arg_18_0, arg_18_1)
	local var_18_0 = StoreModel.instance:jumpTabIdToStoreId(arg_18_1)

	arg_18_0:_readTab(var_18_0)
end

function var_0_0.readTab(arg_19_0, arg_19_1)
	local var_19_0 = StoreModel.instance:jumpTabIdToStoreId(arg_19_1)

	if var_19_0 == arg_19_0._lastViewStoreId then
		return
	end

	arg_19_0:_readTab(var_19_0)
end

function var_0_0._readTab(arg_20_0, arg_20_1)
	if arg_20_1 == StoreEnum.StoreId.EventPackage and not arg_20_0:getIsOpenedEventPackage() then
		arg_20_0:setIsOpenedEventPackage(true)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
	end

	local var_20_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)

	if var_20_0 then
		local var_20_1 = var_20_0.infos
		local var_20_2 = {}

		for iter_20_0, iter_20_1 in pairs(var_20_1) do
			local var_20_3 = StoreModel.instance:getGoodsMO(iter_20_1.uid)

			if var_20_3 and arg_20_1 == var_20_3.belongStoreId then
				table.insert(var_20_2, iter_20_1.uid)
			end
		end

		if #var_20_2 > 0 then
			StoreRpc.instance:sendReadStoreNewRequest(var_20_2)
		end
	end

	local var_20_4 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)

	if var_20_4 then
		local var_20_5 = var_20_4.infos
		local var_20_6 = {}

		for iter_20_2, iter_20_3 in pairs(var_20_5) do
			local var_20_7 = StoreModel.instance:getGoodsMO(iter_20_3.uid)

			if var_20_7 and arg_20_1 == var_20_7.belongStoreId then
				table.insert(var_20_6, iter_20_3.uid)
			end
		end

		if #var_20_6 > 0 then
			ChargeRpc.instance:sendReadChargeNewRequest(var_20_6)
		end
	end
end

function var_0_0.statSwitchStore(arg_21_0, arg_21_1)
	local var_21_0 = StoreModel.instance:jumpTabIdToStoreId(arg_21_1)

	if var_21_0 == arg_21_0._lastViewStoreId then
		return
	end

	if not arg_21_0._viewTime then
		StatController.instance:track(StatEnum.EventName.StoreEnter, {
			[StatEnum.EventProperties.StoreId] = tostring(var_21_0)
		})

		arg_21_0._viewTime = ServerTime.now()
	else
		local var_21_1 = 0

		if arg_21_0._tabTime then
			var_21_1 = ServerTime.now() - arg_21_0._tabTime
		end

		StatController.instance:track(StatEnum.EventName.SwitchStore, {
			[StatEnum.EventProperties.BeforeStoreId] = tostring(arg_21_0._lastViewStoreId),
			[StatEnum.EventProperties.AfterStoreId] = tostring(var_21_0),
			[StatEnum.EventProperties.Time] = var_21_1
		})
	end

	arg_21_0._tabTime = ServerTime.now()
	arg_21_0._lastViewStoreId = var_21_0
end

function var_0_0.statExitStore(arg_22_0)
	local var_22_0 = 0

	if arg_22_0._viewTime then
		var_22_0 = ServerTime.now() - arg_22_0._viewTime
	end

	StatController.instance:track(StatEnum.EventName.StoreExit, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_22_0._lastViewStoreId),
		[StatEnum.EventProperties.Time] = var_22_0
	})

	arg_22_0._lastViewStoreId = 0
	arg_22_0._viewTime = nil
	arg_22_0._tabTime = nil
end

function var_0_0.statOpenGoods(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 then
		return
	end

	arg_23_0._lastViewGoodsId = arg_23_2.id
	arg_23_0._goodsTime = ServerTime.now()

	local var_23_0 = arg_23_2.product
	local var_23_1 = string.split(var_23_0, "#")
	local var_23_2 = tonumber(var_23_1[1])
	local var_23_3 = tonumber(var_23_1[2])
	local var_23_4 = tonumber(var_23_1[3])
	local var_23_5 = ItemModel.instance:getItemConfig(var_23_2, var_23_3)

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_23_1),
		[StatEnum.EventProperties.GoodsId] = arg_23_2.id,
		[StatEnum.EventProperties.MaterialName] = var_23_5 and var_23_5.name or "",
		[StatEnum.EventProperties.MaterialNum] = var_23_4
	})
end

function var_0_0.statOpenChargeGoods(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_2 then
		return
	end

	arg_24_0._lastViewGoodsId = arg_24_2.id
	arg_24_0._goodsTime = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_24_1),
		[StatEnum.EventProperties.GoodsId] = arg_24_2.id,
		[StatEnum.EventProperties.MaterialName] = arg_24_2 and arg_24_2.name or "",
		[StatEnum.EventProperties.MaterialNum] = 1
	})
end

function var_0_0.statCloseGoods(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	if arg_25_0._lastViewGoodsId ~= arg_25_1.id then
		logError("打开和关闭时商品不一致， 不应该发生")

		return
	end

	local var_25_0 = 0

	if arg_25_0._goodsTime then
		local var_25_1 = ServerTime.now() - arg_25_0._goodsTime
	end

	arg_25_0._lastViewGoodsId = 0
end

function var_0_0.recordExchangeSkinDiamond(arg_26_0, arg_26_1)
	arg_26_0.exchangeDiamondQuantity = arg_26_1
end

function var_0_0.statBuyGoods(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	arg_27_5 = arg_27_5 or 1

	local var_27_0 = StoreConfig.instance:getGoodsConfig(arg_27_2)
	local var_27_1 = var_27_0.product
	local var_27_2

	if arg_27_1 == StoreEnum.Room then
		local var_27_3 = arg_27_0.roomStoreCanBuyGoodsStr
		local var_27_4 = arg_27_0:_itemsMultipleWithBuyCount(arg_27_0.recordCostItem, arg_27_3, arg_27_4)
	elseif arg_27_1 == StoreEnum.StoreId.Skin and arg_27_0.exchangeDiamondQuantity and arg_27_0.exchangeDiamondQuantity > 0 then
		local var_27_5 = string.splitToNumber(var_27_0.cost, "#")
		local var_27_6 = var_27_5[1]
		local var_27_7 = var_27_5[2]
		local var_27_8 = var_27_5[3]
		local var_27_9 = {
			type = MaterialEnum.MaterialType.Currency,
			id = CurrencyEnum.CurrencyType.Diamond,
			quantity = arg_27_0.exchangeDiamondQuantity
		}
		local var_27_10 = {
			type = var_27_6,
			id = var_27_7,
			quantity = var_27_8 - arg_27_0.exchangeDiamondQuantity
		}
		local var_27_11 = arg_27_0:_generateItemListJson({
			var_27_9,
			var_27_10
		})

		arg_27_0.exchangeDiamondQuantity = 0
	else
		local var_27_12 = arg_27_0:_itemsMultipleWithBuyCount(var_27_0.cost, arg_27_3, arg_27_4)
	end
end

function var_0_0.statVersionActivityBuyGoods(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	return
end

function var_0_0.recordRoomStoreCurrentCanBuyGoods(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = StoreConfig.instance:getGoodsConfig(arg_29_1)

	if arg_29_2 == 1 then
		arg_29_0.recordCostItem = var_29_0.cost
	elseif arg_29_2 == 2 then
		arg_29_0.recordCostItem = var_29_0.cost2
	else
		arg_29_0.recordCostItem = var_29_0.cost
	end

	arg_29_0.roomStoreCanBuyGoodsStr = var_29_0.product

	local var_29_1 = string.split(var_29_0.product, "|")

	if #var_29_1 > 1 then
		local var_29_2 = string.split(arg_29_0.recordCostItem, "#")
		local var_29_3 = {}

		var_29_2[3] = arg_29_3

		for iter_29_0, iter_29_1 in ipairs(var_29_1) do
			local var_29_4 = string.splitToNumber(iter_29_1, "#")
			local var_29_5 = ItemModel.instance:getItemQuantity(var_29_4[1], var_29_4[2])
			local var_29_6 = ItemModel.instance:getItemConfig(var_29_4[1], var_29_4[2])
			local var_29_7 = var_29_6 and var_29_6.numLimit or 1

			if var_29_7 == 0 or var_29_5 < var_29_7 then
				table.insert(var_29_3, string.format("%s#%s#%s", var_29_4[1], var_29_4[2], var_29_7 - var_29_5))
			end
		end

		arg_29_0.recordCostItem = table.concat(var_29_2, "#")
		arg_29_0.roomStoreCanBuyGoodsStr = table.concat(var_29_3, "|")
	end
end

function var_0_0._itemsMultiple(arg_30_0, arg_30_1, arg_30_2)
	if string.nilorempty(arg_30_1) or arg_30_2 <= 0 then
		return {}
	end

	local var_30_0 = GameUtil.splitString2(arg_30_1, true)
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		local var_30_2 = {
			type = iter_30_1[1],
			id = iter_30_1[2],
			quantity = iter_30_1[3] * arg_30_2
		}

		table.insert(var_30_1, var_30_2)
	end

	return arg_30_0:_generateItemListJson(var_30_1)
end

function var_0_0._itemsMultipleWithBuyCount(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if string.nilorempty(arg_31_1) or arg_31_2 <= 0 then
		return {}
	end

	local var_31_0 = {}
	local var_31_1 = string.split(arg_31_1, "|")

	for iter_31_0 = arg_31_3 + 1, arg_31_3 + arg_31_2 do
		local var_31_2 = var_31_1[iter_31_0] or var_31_1[#var_31_1]
		local var_31_3 = string.splitToNumber(var_31_2, "#")

		if iter_31_0 >= #var_31_1 then
			table.insert(var_31_0, {
				type = var_31_3[1],
				id = var_31_3[2],
				quantity = var_31_3[3] * (arg_31_3 + arg_31_2 - iter_31_0 + 1)
			})

			break
		else
			table.insert(var_31_0, {
				type = var_31_3[1],
				id = var_31_3[2],
				quantity = var_31_3[3]
			})
		end
	end

	if #var_31_0 <= 0 then
		return {}
	end

	local var_31_4 = {}

	for iter_31_1, iter_31_2 in ipairs(var_31_0) do
		var_31_4[iter_31_2.type] = var_31_4[iter_31_2.type] or {}
		var_31_4[iter_31_2.type][iter_31_2.id] = (var_31_4[iter_31_2.type][iter_31_2.id] or 0) + iter_31_2.quantity
	end

	local var_31_5 = {}

	for iter_31_3, iter_31_4 in pairs(var_31_4) do
		for iter_31_5, iter_31_6 in pairs(iter_31_4) do
			table.insert(var_31_5, {
				type = iter_31_3,
				id = iter_31_5,
				quantity = iter_31_6
			})
		end
	end

	return arg_31_0:_generateItemListJson(var_31_5)
end

function var_0_0._generateItemListJson(arg_32_0, arg_32_1)
	if not arg_32_1 or #arg_32_1 <= 0 then
		return {}
	end

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		local var_32_1 = ItemModel.instance:getItemConfig(iter_32_1.type, iter_32_1.id)

		table.insert(var_32_0, {
			materialname = var_32_1 and var_32_1.name or "",
			materialtype = iter_32_1.type,
			materialnum = iter_32_1.quantity
		})
	end

	return var_32_0
end

function var_0_0.isNeedShowRedDotNewTag(arg_33_0, arg_33_1)
	return arg_33_1 and arg_33_1.type == 0 and not string.nilorempty(arg_33_1.onlineTime)
end

function var_0_0.initEnteredRecommendStoreList(arg_34_0)
	local var_34_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()
	local var_34_1 = PlayerPrefsHelper.getString(var_34_0, "")

	if string.nilorempty(var_34_1) then
		arg_34_0.enteredRecommendStoreIdList = {}

		return
	end

	arg_34_0.enteredRecommendStoreIdList = string.splitToNumber(var_34_1, ";")
end

function var_0_0.enterRecommendStore(arg_35_0, arg_35_1)
	if not arg_35_0.enteredRecommendStoreIdList then
		arg_35_0:initEnteredRecommendStoreList()
	end

	if tabletool.indexOf(arg_35_0.enteredRecommendStoreIdList, arg_35_1) then
		return
	end

	table.insert(arg_35_0.enteredRecommendStoreIdList, arg_35_1)
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)

	local var_35_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()

	PlayerPrefsHelper.setString(var_35_0, table.concat(arg_35_0.enteredRecommendStoreIdList, ";"))
end

function var_0_0.isEnteredRecommendStore(arg_36_0, arg_36_1)
	if not arg_36_0.enteredRecommendStoreIdList then
		arg_36_0:initEnteredRecommendStoreList()
	end

	return tabletool.indexOf(arg_36_0.enteredRecommendStoreIdList, arg_36_1)
end

function var_0_0.getRecommendStoreTime(arg_37_0, arg_37_1)
	do return arg_37_0:getRecommendStoreTime_overseas(arg_37_1) end

	if not arg_37_1 then
		return
	end

	local var_37_0 = string.nilorempty(arg_37_1.showOnlineTime) and arg_37_1.onlineTime or arg_37_1.showOnlineTime
	local var_37_1 = string.nilorempty(arg_37_1.showOfflineTime) and arg_37_1.offlineTime or arg_37_1.showOfflineTime
	local var_37_2 = TimeUtil.stringToTimestamp(var_37_0)
	local var_37_3 = TimeUtil.stringToTimestamp(var_37_1)
	local var_37_4 = tonumber(os.date("%m", var_37_2))
	local var_37_5 = tonumber(os.date("%d", var_37_2))
	local var_37_6 = tonumber(os.date("%H", var_37_2))
	local var_37_7 = string.format("%02d", tonumber(os.date("%M", var_37_2)))
	local var_37_8 = tonumber(os.date("%m", var_37_3))
	local var_37_9 = tonumber(os.date("%d", var_37_3))
	local var_37_10 = tonumber(os.date("%H", var_37_3))
	local var_37_11 = string.format("%02d", tonumber(os.date("%M", var_37_3)))

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime"), {
		var_37_4,
		var_37_5,
		var_37_6,
		var_37_7,
		var_37_8,
		var_37_9,
		var_37_10,
		var_37_11
	})
end

function var_0_0.onUseItemInStore(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return
	end

	if arg_38_1.entry and arg_38_1.entry[1].materialId and (arg_38_1.entry[1].materialId == StoreEnum.NormalRoomTicket or arg_38_1.entry[1].materialId == StoreEnum.TopRoomTicket) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		var_0_0.instance:dispatchEvent(StoreEvent.GoodsModelChanged, tonumber(arg_38_1.targetId))
	end
end

function var_0_0.statOnClickPowerPotion(arg_39_0, arg_39_1)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotion, {
		[StatEnum.EventProperties.WindowName] = arg_39_1
	})
end

function var_0_0.statOnClickPowerPotionJump(arg_40_0, arg_40_1, arg_40_2)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotionJump, {
		[StatEnum.EventProperties.WindowName] = arg_40_1,
		[StatEnum.EventProperties.JumpName] = arg_40_2
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
