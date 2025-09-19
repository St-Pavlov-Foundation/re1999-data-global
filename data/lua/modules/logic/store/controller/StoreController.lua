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

function var_0_0.openStoreView(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {
		jumpTab = arg_11_1,
		jumpGoodsId = arg_11_2,
		isFocus = arg_11_3
	}

	ViewMgr.instance:openView(ViewName.StoreView, var_11_0)
end

function var_0_0.openNormalGoodsView(arg_12_0, arg_12_1)
	if arg_12_1.belongStoreId == StoreEnum.StoreId.NewRoomStore or arg_12_1.belongStoreId == StoreEnum.StoreId.OldRoomStore then
		if arg_12_0:isRoomBlockGift(arg_12_1) then
			ViewMgr.instance:openView(ViewName.RoomBlockGiftStoreGoodsView, arg_12_1)
		else
			RoomController.instance:openStoreGoodsTipView(arg_12_1)
		end
	else
		ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, arg_12_1)
	end
end

function var_0_0.isRoomBlockGift(arg_13_0, arg_13_1)
	if string.nilorempty(arg_13_1.config.product) then
		return
	end

	local var_13_0 = GameUtil.splitString2(arg_13_1.config.product, true)
	local var_13_1 = var_13_0[1][1]
	local var_13_2 = var_13_0[1][2]
	local var_13_3 = ItemModel.instance:getItemConfig(var_13_1, var_13_2)

	return var_13_3.subType == ItemEnum.SubType.RoomBlockGift or var_13_3.subType == ItemEnum.SubType.RoomBlockGiftNew
end

function var_0_0.openChargeGoodsView(arg_14_0, arg_14_1)
	ViewMgr.instance:openView(ViewName.ChargeStoreGoodsView, arg_14_1)
end

function var_0_0.openPackageStoreGoodsView(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.config.type

	if var_15_0 == StoreEnum.StoreChargeType.Optional then
		ViewMgr.instance:openView(ViewName.OptionalChargeView, arg_15_1)
	elseif var_15_0 == StoreEnum.StoreChargeType.LinkGiftGoods then
		ViewMgr.instance:openView(ViewName.StoreLinkGiftGoodsView, arg_15_1)
	elseif var_15_0 == StoreEnum.StoreChargeType.NationalGift then
		local var_15_1 = {
			goodMo = arg_15_1
		}

		NationalGiftController.instance:openNationalGiftBuyTipView(var_15_1)
	else
		ViewMgr.instance:openView(ViewName.PackageStoreGoodsView, arg_15_1)
	end
end

function var_0_0.openDecorateStoreGoodsView(arg_16_0, arg_16_1)
	local var_16_0 = string.splitToNumber(arg_16_1.config.product, "#")
	local var_16_1 = ItemModel.instance:getItemConfig(var_16_0[1], var_16_0[2])
	local var_16_2 = DecorateStoreEnum.SpecialGoodsId

	if var_16_1.subType == ItemEnum.SubType.PlayerBg and var_16_1.id == var_16_2 then
		local var_16_3 = {
			goodsMo = arg_16_1
		}

		ViewMgr.instance:openView(ViewName.DecorateStoreGoodsBuyView, var_16_3)
	else
		ViewMgr.instance:openView(ViewName.DecorateStoreGoodsView, arg_16_1)
	end
end

function var_0_0.openSummonStoreGoodsView(arg_17_0, arg_17_1)
	if arg_17_1.belongStoreId == StoreEnum.StoreId.RoomStore then
		RoomController.instance:openStoreGoodsTipView(arg_17_1)
	else
		ViewMgr.instance:openView(ViewName.SummonStoreGoodsView, arg_17_1)
	end
end

function var_0_0.buyGoods(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	StoreRpc.instance:sendBuyGoodsRequest(arg_18_1.belongStoreId, arg_18_1.goodsId, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
end

function var_0_0.forceReadTab(arg_19_0, arg_19_1)
	local var_19_0 = StoreModel.instance:jumpTabIdToStoreId(arg_19_1)

	arg_19_0:_readTab(var_19_0)
end

function var_0_0.readTab(arg_20_0, arg_20_1)
	local var_20_0 = StoreModel.instance:jumpTabIdToStoreId(arg_20_1)

	if var_20_0 == arg_20_0._lastViewStoreId then
		return
	end

	arg_20_0:_readTab(var_20_0)
end

function var_0_0._readTab(arg_21_0, arg_21_1)
	if arg_21_1 == StoreEnum.StoreId.EventPackage and not arg_21_0:getIsOpenedEventPackage() then
		arg_21_0:setIsOpenedEventPackage(true)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
	end

	local var_21_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)

	if var_21_0 then
		local var_21_1 = var_21_0.infos
		local var_21_2 = {}

		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			local var_21_3 = StoreModel.instance:getGoodsMO(iter_21_1.uid)

			if var_21_3 and arg_21_1 == var_21_3.belongStoreId then
				table.insert(var_21_2, iter_21_1.uid)
			end
		end

		if #var_21_2 > 0 then
			StoreRpc.instance:sendReadStoreNewRequest(var_21_2)
		end
	end

	local var_21_4 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)

	if var_21_4 then
		local var_21_5 = var_21_4.infos
		local var_21_6 = {}

		for iter_21_2, iter_21_3 in pairs(var_21_5) do
			local var_21_7 = StoreModel.instance:getGoodsMO(iter_21_3.uid)

			if var_21_7 and arg_21_1 == var_21_7.belongStoreId then
				table.insert(var_21_6, iter_21_3.uid)
			end
		end

		if #var_21_6 > 0 then
			if not StoreConfig.instance:isPackageStore(arg_21_1) then
				ChargeRpc.instance:sendReadChargeNewRequest(var_21_6)
			else
				local var_21_8 = {}

				for iter_21_4, iter_21_5 in pairs(var_21_6) do
					local var_21_9 = StoreModel.instance:getGoodsMO(iter_21_5)
					local var_21_10 = ServerTime.now()

					if not (var_21_10 >= var_21_9.newStartTime and var_21_10 <= var_21_9.newEndTime) then
						table.insert(var_21_8, iter_21_5)
					end
				end

				ChargeRpc.instance:sendReadChargeNewRequest(var_21_8)
			end
		end
	end
end

function var_0_0.statSwitchStore(arg_22_0, arg_22_1)
	local var_22_0 = StoreModel.instance:jumpTabIdToStoreId(arg_22_1)

	if var_22_0 == arg_22_0._lastViewStoreId then
		return
	end

	if not arg_22_0._viewTime then
		StatController.instance:track(StatEnum.EventName.StoreEnter, {
			[StatEnum.EventProperties.StoreId] = tostring(var_22_0)
		})

		arg_22_0._viewTime = ServerTime.now()
	else
		local var_22_1 = 0

		if arg_22_0._tabTime then
			var_22_1 = ServerTime.now() - arg_22_0._tabTime
		end

		StatController.instance:track(StatEnum.EventName.SwitchStore, {
			[StatEnum.EventProperties.BeforeStoreId] = tostring(arg_22_0._lastViewStoreId),
			[StatEnum.EventProperties.AfterStoreId] = tostring(var_22_0),
			[StatEnum.EventProperties.Time] = var_22_1
		})
	end

	arg_22_0._tabTime = ServerTime.now()
	arg_22_0._lastViewStoreId = var_22_0
end

function var_0_0.statExitStore(arg_23_0)
	local var_23_0 = 0

	if arg_23_0._viewTime then
		var_23_0 = ServerTime.now() - arg_23_0._viewTime
	end

	StatController.instance:track(StatEnum.EventName.StoreExit, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_23_0._lastViewStoreId),
		[StatEnum.EventProperties.Time] = var_23_0
	})

	arg_23_0._lastViewStoreId = 0
	arg_23_0._viewTime = nil
	arg_23_0._tabTime = nil
end

function var_0_0.statOpenGoods(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_2 then
		return
	end

	arg_24_0._lastViewGoodsId = arg_24_2.id
	arg_24_0._goodsTime = ServerTime.now()

	local var_24_0 = arg_24_2.product
	local var_24_1 = string.split(var_24_0, "#")
	local var_24_2 = tonumber(var_24_1[1])
	local var_24_3 = tonumber(var_24_1[2])
	local var_24_4 = tonumber(var_24_1[3])
	local var_24_5 = ItemModel.instance:getItemConfig(var_24_2, var_24_3)

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_24_1),
		[StatEnum.EventProperties.GoodsId] = arg_24_2.id,
		[StatEnum.EventProperties.MaterialName] = var_24_5 and var_24_5.name or "",
		[StatEnum.EventProperties.MaterialNum] = var_24_4
	})
end

function var_0_0.statOpenChargeGoods(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_2 then
		return
	end

	arg_25_0._lastViewGoodsId = arg_25_2.id
	arg_25_0._goodsTime = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.ClickGoods, {
		[StatEnum.EventProperties.StoreId] = tostring(arg_25_1),
		[StatEnum.EventProperties.GoodsId] = arg_25_2.id,
		[StatEnum.EventProperties.MaterialName] = arg_25_2 and arg_25_2.name or "",
		[StatEnum.EventProperties.MaterialNum] = 1
	})
end

function var_0_0.statCloseGoods(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	if arg_26_0._lastViewGoodsId ~= arg_26_1.id then
		logError("打开和关闭时商品不一致， 不应该发生")

		return
	end

	local var_26_0 = 0

	if arg_26_0._goodsTime then
		local var_26_1 = ServerTime.now() - arg_26_0._goodsTime
	end

	arg_26_0._lastViewGoodsId = 0
end

function var_0_0.recordExchangeSkinDiamond(arg_27_0, arg_27_1)
	arg_27_0.exchangeDiamondQuantity = arg_27_1
end

function var_0_0.statBuyGoods(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	arg_28_5 = arg_28_5 or 1

	local var_28_0 = StoreConfig.instance:getGoodsConfig(arg_28_2)
	local var_28_1 = var_28_0.product
	local var_28_2

	if arg_28_1 == StoreEnum.StoreId.RoomStore then
		local var_28_3 = arg_28_0.roomStoreCanBuyGoodsStr
		local var_28_4 = arg_28_0:_itemsMultipleWithBuyCount(arg_28_0.recordCostItem, arg_28_3, arg_28_4)
	elseif arg_28_1 == StoreEnum.StoreId.Skin and arg_28_0.exchangeDiamondQuantity and arg_28_0.exchangeDiamondQuantity > 0 then
		local var_28_5 = string.splitToNumber(var_28_0.cost, "#")
		local var_28_6 = var_28_5[1]
		local var_28_7 = var_28_5[2]
		local var_28_8 = var_28_5[3]
		local var_28_9 = {
			type = MaterialEnum.MaterialType.Currency,
			id = CurrencyEnum.CurrencyType.Diamond,
			quantity = arg_28_0.exchangeDiamondQuantity
		}
		local var_28_10 = {
			type = var_28_6,
			id = var_28_7,
			quantity = var_28_8 - arg_28_0.exchangeDiamondQuantity
		}
		local var_28_11 = arg_28_0:_generateItemListJson({
			var_28_9,
			var_28_10
		})

		arg_28_0.exchangeDiamondQuantity = 0
	else
		local var_28_12 = arg_28_0:_itemsMultipleWithBuyCount(var_28_0.cost, arg_28_3, arg_28_4)
	end
end

function var_0_0.statVersionActivityBuyGoods(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	return
end

function var_0_0.recordRoomStoreCurrentCanBuyGoods(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = StoreConfig.instance:getGoodsConfig(arg_30_1)

	if arg_30_2 == 1 then
		arg_30_0.recordCostItem = var_30_0.cost
	elseif arg_30_2 == 2 then
		arg_30_0.recordCostItem = var_30_0.cost2
	else
		arg_30_0.recordCostItem = var_30_0.cost
	end

	arg_30_0.roomStoreCanBuyGoodsStr = var_30_0.product

	local var_30_1 = string.split(var_30_0.product, "|")

	if #var_30_1 > 1 then
		local var_30_2 = string.split(arg_30_0.recordCostItem, "#")
		local var_30_3 = {}

		var_30_2[3] = arg_30_3

		for iter_30_0, iter_30_1 in ipairs(var_30_1) do
			local var_30_4 = string.splitToNumber(iter_30_1, "#")
			local var_30_5 = ItemModel.instance:getItemQuantity(var_30_4[1], var_30_4[2])
			local var_30_6 = ItemModel.instance:getItemConfig(var_30_4[1], var_30_4[2])
			local var_30_7 = var_30_6 and var_30_6.numLimit or 1

			if var_30_7 == 0 or var_30_5 < var_30_7 then
				table.insert(var_30_3, string.format("%s#%s#%s", var_30_4[1], var_30_4[2], var_30_7 - var_30_5))
			end
		end

		arg_30_0.recordCostItem = table.concat(var_30_2, "#")
		arg_30_0.roomStoreCanBuyGoodsStr = table.concat(var_30_3, "|")
	end
end

function var_0_0._itemsMultiple(arg_31_0, arg_31_1, arg_31_2)
	if string.nilorempty(arg_31_1) or arg_31_2 <= 0 then
		return {}
	end

	local var_31_0 = GameUtil.splitString2(arg_31_1, true)
	local var_31_1 = {}

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		local var_31_2 = {
			type = iter_31_1[1],
			id = iter_31_1[2],
			quantity = iter_31_1[3] * arg_31_2
		}

		table.insert(var_31_1, var_31_2)
	end

	return arg_31_0:_generateItemListJson(var_31_1)
end

function var_0_0._itemsMultipleWithBuyCount(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if string.nilorempty(arg_32_1) or arg_32_2 <= 0 then
		return {}
	end

	local var_32_0 = {}
	local var_32_1 = string.split(arg_32_1, "|")

	for iter_32_0 = arg_32_3 + 1, arg_32_3 + arg_32_2 do
		local var_32_2 = var_32_1[iter_32_0] or var_32_1[#var_32_1]
		local var_32_3 = string.splitToNumber(var_32_2, "#")

		if iter_32_0 >= #var_32_1 then
			table.insert(var_32_0, {
				type = var_32_3[1],
				id = var_32_3[2],
				quantity = var_32_3[3] * (arg_32_3 + arg_32_2 - iter_32_0 + 1)
			})

			break
		else
			table.insert(var_32_0, {
				type = var_32_3[1],
				id = var_32_3[2],
				quantity = var_32_3[3]
			})
		end
	end

	if #var_32_0 <= 0 then
		return {}
	end

	local var_32_4 = {}

	for iter_32_1, iter_32_2 in ipairs(var_32_0) do
		var_32_4[iter_32_2.type] = var_32_4[iter_32_2.type] or {}
		var_32_4[iter_32_2.type][iter_32_2.id] = (var_32_4[iter_32_2.type][iter_32_2.id] or 0) + iter_32_2.quantity
	end

	local var_32_5 = {}

	for iter_32_3, iter_32_4 in pairs(var_32_4) do
		for iter_32_5, iter_32_6 in pairs(iter_32_4) do
			table.insert(var_32_5, {
				type = iter_32_3,
				id = iter_32_5,
				quantity = iter_32_6
			})
		end
	end

	return arg_32_0:_generateItemListJson(var_32_5)
end

function var_0_0._generateItemListJson(arg_33_0, arg_33_1)
	if not arg_33_1 or #arg_33_1 <= 0 then
		return {}
	end

	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		local var_33_1 = ItemModel.instance:getItemConfig(iter_33_1.type, iter_33_1.id)

		table.insert(var_33_0, {
			materialname = var_33_1 and var_33_1.name or "",
			materialtype = iter_33_1.type,
			materialnum = iter_33_1.quantity
		})
	end

	return var_33_0
end

function var_0_0.isNeedShowRedDotNewTag(arg_34_0, arg_34_1)
	return arg_34_1 and arg_34_1.type == 0 and not string.nilorempty(arg_34_1.onlineTime)
end

function var_0_0.initEnteredRecommendStoreList(arg_35_0)
	local var_35_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()
	local var_35_1 = PlayerPrefsHelper.getString(var_35_0, "")

	if string.nilorempty(var_35_1) then
		arg_35_0.enteredRecommendStoreIdList = {}

		return
	end

	arg_35_0.enteredRecommendStoreIdList = string.splitToNumber(var_35_1, ";")
end

function var_0_0.enterRecommendStore(arg_36_0, arg_36_1)
	if not arg_36_0.enteredRecommendStoreIdList then
		arg_36_0:initEnteredRecommendStoreList()
	end

	if tabletool.indexOf(arg_36_0.enteredRecommendStoreIdList, arg_36_1) then
		return
	end

	table.insert(arg_36_0.enteredRecommendStoreIdList, arg_36_1)
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)

	local var_36_0 = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()

	PlayerPrefsHelper.setString(var_36_0, table.concat(arg_36_0.enteredRecommendStoreIdList, ";"))
end

function var_0_0.isEnteredRecommendStore(arg_37_0, arg_37_1)
	if not arg_37_0.enteredRecommendStoreIdList then
		arg_37_0:initEnteredRecommendStoreList()
	end

	return tabletool.indexOf(arg_37_0.enteredRecommendStoreIdList, arg_37_1)
end

function var_0_0.getRecommendStoreTime(arg_38_0, arg_38_1)
	do return arg_38_0:getRecommendStoreTime_overseas(arg_38_1) end

	if not arg_38_1 then
		return
	end

	local var_38_0 = string.nilorempty(arg_38_1.showOnlineTime) and arg_38_1.onlineTime or arg_38_1.showOnlineTime
	local var_38_1 = string.nilorempty(arg_38_1.showOfflineTime) and arg_38_1.offlineTime or arg_38_1.showOfflineTime
	local var_38_2 = TimeUtil.stringToTimestamp(var_38_0)
	local var_38_3 = TimeUtil.stringToTimestamp(var_38_1)
	local var_38_4 = tonumber(os.date("%m", var_38_2))
	local var_38_5 = tonumber(os.date("%d", var_38_2))
	local var_38_6 = tonumber(os.date("%H", var_38_2))
	local var_38_7 = string.format("%02d", tonumber(os.date("%M", var_38_2)))
	local var_38_8 = tonumber(os.date("%m", var_38_3))
	local var_38_9 = tonumber(os.date("%d", var_38_3))
	local var_38_10 = tonumber(os.date("%H", var_38_3))
	local var_38_11 = string.format("%02d", tonumber(os.date("%M", var_38_3)))

	return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime"), {
		var_38_4,
		var_38_5,
		var_38_6,
		var_38_7,
		var_38_8,
		var_38_9,
		var_38_10,
		var_38_11
	})
end

function var_0_0.onUseItemInStore(arg_39_0, arg_39_1)
	if not arg_39_1 then
		return
	end

	if arg_39_1.entry and arg_39_1.entry[1].materialId and (arg_39_1.entry[1].materialId == StoreEnum.NormalRoomTicket or arg_39_1.entry[1].materialId == StoreEnum.TopRoomTicket) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		var_0_0.instance:dispatchEvent(StoreEvent.GoodsModelChanged, tonumber(arg_39_1.targetId))
	end
end

function var_0_0.statOnClickPowerPotion(arg_40_0, arg_40_1)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotion, {
		[StatEnum.EventProperties.WindowName] = arg_40_1
	})
end

function var_0_0.statOnClickPowerPotionJump(arg_41_0, arg_41_1, arg_41_2)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotionJump, {
		[StatEnum.EventProperties.WindowName] = arg_41_1,
		[StatEnum.EventProperties.JumpName] = arg_41_2
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
