module("modules.logic.store.model.StoreModel", package.seeall)

local var_0_0 = class("StoreModel", BaseModel)

function var_0_0.isRedTabReadOnceClient(arg_1_0, arg_1_1)
	if arg_1_1 == StoreEnum.StoreId.EventPackage and not StoreController.instance:getIsOpenedEventPackage() then
		local var_1_0 = var_0_0.instance:getPackageGoodValidList(arg_1_1)

		if not var_1_0 or #var_1_0 == 0 then
			return false
		end

		return true
	end

	return false
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._storeMODict = {}
	arg_2_0._chargeStoreDic = {}
	arg_2_0._allPackageDic = {}
	arg_2_0._chargePackageStoreDic = {}
	arg_2_0._versionChargePackageDict = {}
	arg_2_0._onceTimeChargePackageDict = {}
	arg_2_0._eventChargePackageDict = {}
	arg_2_0._recommendPackageList = {}
	arg_2_0._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = arg_2_0._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = arg_2_0._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = arg_2_0._chargePackageStoreDic,
		[StoreEnum.StoreId.EventPackage] = arg_2_0._eventChargePackageDict
	}
	arg_2_0._curPackageStore = StoreEnum.StoreId.NormalPackage
	arg_2_0.monthCardInfo = nil
	arg_2_0._packageStoreRpcLeftNum = 0
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:onInit()
end

function var_0_0.getStoreInfosReply(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.storeInfos

	if var_4_0 and #var_4_0 > 0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			local var_4_1 = StoreMO.New()

			var_4_1:init(iter_4_1)

			arg_4_0._storeMODict[var_4_1.id] = var_4_1

			if StoreConfig.instance:isPackageStore(var_4_1.id) then
				local var_4_2 = arg_4_0:getCurPackageStore()

				if var_4_2 ~= 0 and var_4_2 == var_4_1.id then
					arg_4_0:updatePackageStoreList(var_4_1.id)
				end
			elseif var_4_1.id == StoreEnum.StoreId.Skin then
				StoreClothesGoodsItemListModel.instance:setMOList(var_4_1:getGoodsList())
			end
		end
	end
end

function var_0_0.buyGoodsReply(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._storeMODict[arg_5_1.storeId]

	if var_5_0 then
		var_5_0:buyGoodsReply(arg_5_1.goodsId, arg_5_1.num)
	end
end

function var_0_0.initChargeInfo(arg_6_0, arg_6_1)
	arg_6_0._chargeStoreDic = {}
	arg_6_0._allPackageDic = {}
	arg_6_0._chargePackageStoreDic = {}
	arg_6_0._versionChargePackageDict = {}
	arg_6_0._onceTimeChargePackageDict = {}
	arg_6_0._skinChargeDict = {}
	arg_6_0._recommendPackageList = {}
	arg_6_0._packageType2GoodsDict = {
		[StoreEnum.StoreId.VersionPackage] = arg_6_0._versionChargePackageDict,
		[StoreEnum.StoreId.OneTimePackage] = arg_6_0._onceTimeChargePackageDict,
		[StoreEnum.StoreId.NormalPackage] = arg_6_0._chargePackageStoreDic,
		[StoreEnum.StoreId.RecommendPackage] = arg_6_0._recommendPackageList,
		[StoreEnum.StoreId.EventPackage] = arg_6_0._eventChargePackageDict
	}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_1 = StoreConfig.instance:getChargeGoodsConfig(iter_6_1.id, true)

		if var_6_1 then
			if var_6_1.belongStoreId == StoreEnum.StoreId.Charge or var_6_1.belongStoreId == StoreEnum.StoreId.PubbleCharge or var_6_1.belongStoreId == StoreEnum.StoreId.GlowCharge then
				local var_6_2 = StoreChargeGoodsMO.New()

				var_6_2:init(StoreEnum.StoreId.Charge, iter_6_1)

				arg_6_0._chargeStoreDic[iter_6_1.id] = var_6_2
			elseif var_6_1.belongStoreId == StoreEnum.StoreId.Skin then
				table.insert(var_6_0, iter_6_1)
			else
				local var_6_3 = StorePackageGoodsMO.New()

				var_6_3:initCharge(var_6_1.belongStoreId, iter_6_1)

				arg_6_0._allPackageDic[iter_6_1.id] = var_6_3

				if var_6_1.belongStoreId == StoreEnum.StoreId.NormalPackage then
					arg_6_0._chargePackageStoreDic[iter_6_1.id] = var_6_3
				elseif var_6_1.belongStoreId == StoreEnum.StoreId.VersionPackage then
					arg_6_0._versionChargePackageDict[iter_6_1.id] = var_6_3
				elseif var_6_1.belongStoreId == StoreEnum.StoreId.OneTimePackage then
					arg_6_0._onceTimeChargePackageDict[iter_6_1.id] = var_6_3
				elseif var_6_1.belongStoreId == StoreEnum.StoreId.EventPackage then
					arg_6_0._eventChargePackageDict[iter_6_1.id] = var_6_3
				end
			end
		end
	end

	arg_6_0:_updateSkinChargePackage(var_6_0)
	arg_6_0:updatePackageStoreList(arg_6_0._curPackageStore)
end

function var_0_0._updateSkinChargePackage(arg_7_0, arg_7_1)
	if not arg_7_0._skinChargeDict then
		arg_7_0._skinChargeDict = {}
	end

	arg_7_1 = arg_7_1 or {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0:_addSkinChargePackage(iter_7_1)
	end

	StoreController.instance:dispatchEvent(StoreEvent.SkinChargePackageUpdate)
end

function var_0_0._addSkinChargePackage(arg_8_0, arg_8_1)
	if not arg_8_0._skinChargeDict then
		arg_8_0._skinChargeDict = {}
	end

	local var_8_0 = StoreSkinChargeMo.New()

	var_8_0:init(StoreEnum.StoreId.Skin, arg_8_1)

	arg_8_0._skinChargeDict[arg_8_1.id] = var_8_0
end

function var_0_0.chargeOrderComplete(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._chargeStoreDic[arg_9_1]

	arg_9_0.updateChargeStore = false

	if var_9_0 == nil then
		if arg_9_1 == StoreEnum.LittleMonthCardGoodsId then
			var_9_0 = arg_9_0._allPackageDic[arg_9_1]
		else
			var_9_0 = arg_9_0._chargePackageStoreDic[arg_9_1] or arg_9_0._versionChargePackageDict[arg_9_1] or arg_9_0._onceTimeChargePackageDict[arg_9_1]
		end
	else
		arg_9_0.updateChargeStore = true
	end

	if var_9_0 then
		var_9_0.buyCount = var_9_0.buyCount + 1

		local var_9_1 = var_9_0.config.id

		if var_9_1 == StoreEnum.MonthCardGoodsId or var_9_1 == StoreEnum.LittleMonthCardGoodsId or var_9_1 == StoreEnum.SeasonCardGoodsId then
			ChargeRpc.instance:sendGetMonthCardInfoRequest(arg_9_0.updateGoodsInfo, arg_9_0)
		else
			arg_9_0:updateGoodsInfo()
		end
	end
end

function var_0_0.updateGoodsInfo(arg_10_0)
	if arg_10_0.updateChargeStore then
		local var_10_0 = arg_10_0:getCurChargetStoreId()

		StoreChargeGoodsItemListModel.instance:setMOList(arg_10_0._chargeStoreDic, var_10_0)
	else
		arg_10_0:updatePackageStoreList(arg_10_0._curPackageStore)
	end
end

function var_0_0.getCurChargetStoreId(arg_11_0)
	return arg_11_0._curChargeStoreId or 0
end

function var_0_0.setCurChargeStoreId(arg_12_0, arg_12_1)
	arg_12_0._curChargeStoreId = arg_12_1
end

function var_0_0.setCurPackageStore(arg_13_0, arg_13_1)
	arg_13_0._curPackageStore = arg_13_1
end

function var_0_0.getCurPackageStore(arg_14_0)
	return arg_14_0._curPackageStore or 0
end

function var_0_0.setPackageStoreRpcNum(arg_15_0, arg_15_1)
	arg_15_0._packageStoreRpcLeftNum = arg_15_1
end

function var_0_0.setCurBuyPackageId(arg_16_0, arg_16_1)
	arg_16_0._curBuyPackageId = arg_16_1
end

function var_0_0.getCurBuyPackageId(arg_17_0)
	return arg_17_0._curBuyPackageId
end

function var_0_0.updatePackageStoreList(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 or StoreEnum.StoreId.Package

	arg_18_0._packageStoreRpcLeftNum = arg_18_0._packageStoreRpcLeftNum - 1

	if arg_18_0._packageStoreRpcLeftNum < 1 then
		if not arg_18_1 or arg_18_1 == StoreEnum.StoreId.RecommendPackage then
			local var_18_1 = arg_18_0:getRecommendPackageList(true)

			StorePackageGoodsItemListModel.instance:setMOList(nil, var_18_1)
		else
			local var_18_2 = arg_18_0._packageType2GoodsDict[arg_18_1]

			StorePackageGoodsItemListModel.instance:setMOList(arg_18_0:getStoreMO(var_18_0), var_18_2)
		end

		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end
end

function var_0_0.getStoreMO(arg_19_0, arg_19_1)
	return arg_19_0._storeMODict[arg_19_1]
end

function var_0_0.getGoodsMO(arg_20_0, arg_20_1)
	if arg_20_0._allPackageDic[arg_20_1] then
		return arg_20_0._allPackageDic[arg_20_1]
	else
		for iter_20_0, iter_20_1 in pairs(arg_20_0._storeMODict) do
			local var_20_0 = iter_20_1:getGoodsMO(arg_20_1)

			if var_20_0 then
				return var_20_0
			end
		end
	end
end

function var_0_0.getChargeGoods(arg_21_0)
	return arg_21_0._chargeStoreDic
end

function var_0_0.getChargeGoodsMo(arg_22_0, arg_22_1)
	return arg_22_0._chargeStoreDic[arg_22_1]
end

function var_0_0.isStoreSkinChargePackageValid(arg_23_0, arg_23_1)
	local var_23_0 = false
	local var_23_1 = StoreConfig.instance:getSkinChargeGoodsId(arg_23_1)

	if arg_23_0._skinChargeDict and arg_23_0._skinChargeDict[var_23_1] then
		var_23_0 = true
	end

	return var_23_0
end

function var_0_0.isStoreDecorateGoodsValid(arg_24_0, arg_24_1)
	local var_24_0 = false
	local var_24_1 = StoreConfig.instance:getDecorateGoodsIdById(arg_24_1)

	if arg_24_0:getGoodsMO(var_24_1) then
		var_24_0 = true
	end

	return var_24_0
end

function var_0_0.getRecommendPackageList(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return arg_25_0._recommendPackageList
	end

	arg_25_0._recommendPackageList = {}

	local var_25_0 = CommonConfig.instance:getConstNum(ConstEnum.RecommendStoreCount) or 5

	if var_25_0 == 0 then
		return arg_25_0._recommendPackageList
	end

	local var_25_1 = {}
	local var_25_2 = arg_25_0:getPackageGoodList(StoreEnum.StoreId.VersionPackage)
	local var_25_3 = arg_25_0:getPackageGoodList(StoreEnum.StoreId.OneTimePackage)
	local var_25_4 = arg_25_0:getPackageGoodList(StoreEnum.StoreId.NormalPackage)
	local var_25_5 = arg_25_0:getPackageGoodList(StoreEnum.StoreId.EventPackage)

	for iter_25_0, iter_25_1 in pairs(var_25_2) do
		var_25_1[#var_25_1 + 1] = iter_25_1
	end

	for iter_25_2, iter_25_3 in pairs(var_25_3) do
		var_25_1[#var_25_1 + 1] = iter_25_3
	end

	for iter_25_4, iter_25_5 in pairs(var_25_4) do
		var_25_1[#var_25_1 + 1] = iter_25_5
	end

	for iter_25_6, iter_25_7 in pairs(var_25_5) do
		var_25_1[#var_25_1 + 1] = iter_25_7
	end

	if #var_25_1 > 1 then
		table.sort(var_25_1, arg_25_0._packageSortFunction)
	end

	local var_25_6 = 1

	for iter_25_8 = 1, #var_25_1 do
		local var_25_7 = var_25_1[iter_25_8]

		if arg_25_0:checkShowInRecommand(var_25_7, var_25_7.isChargeGoods) then
			arg_25_0._recommendPackageList[var_25_6] = var_25_7

			if var_25_6 == var_25_0 then
				break
			end

			var_25_6 = var_25_6 + 1
		end
	end

	return arg_25_0._recommendPackageList
end

function var_0_0.isGoodInRecommendList(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getRecommendPackageList(false)

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if iter_26_1.goodsId == arg_26_1 then
			return true
		end
	end
end

function var_0_0.getPackageGoodList(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1 = arg_27_0._packageType2GoodsDict[arg_27_1]

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		var_27_0[iter_27_1.id] = iter_27_1
	end

	local var_27_2 = arg_27_0:getStoreMO(arg_27_1)

	if var_27_2 then
		local var_27_3 = var_27_2:getGoodsList()

		for iter_27_2, iter_27_3 in pairs(var_27_3) do
			local var_27_4 = StorePackageGoodsMO.New()

			var_27_4:init(arg_27_1, iter_27_3.goodsId, iter_27_3.buyCount, iter_27_3.offlineTime)

			var_27_0[iter_27_3.goodsId] = var_27_4
		end
	end

	return var_27_0
end

function var_0_0.getPackageGoodValidList(arg_28_0, arg_28_1)
	local var_28_0 = {}

	if arg_28_1 == StoreEnum.StoreId.RecommendPackage then
		var_28_0 = arg_28_0:getRecommendPackageList(true)
	else
		local var_28_1 = arg_28_0:getPackageGoodList(arg_28_1)

		for iter_28_0, iter_28_1 in pairs(var_28_1) do
			if arg_28_0:checkValid(iter_28_1, iter_28_1.isChargeGoods) then
				var_28_0[#var_28_0 + 1] = iter_28_1
			end
		end
	end

	return var_28_0
end

function var_0_0.checkValid(arg_29_0, arg_29_1, arg_29_2)
	arg_29_2 = arg_29_2 or false

	local var_29_0 = true

	if arg_29_1:isSoldOut() then
		if arg_29_2 and arg_29_1.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			var_29_0 = false
		end

		if arg_29_2 == false and arg_29_1.config.refreshTime == StoreEnum.RefreshTime.Forever then
			var_29_0 = false
		end
	end

	var_29_0 = var_29_0 and arg_29_0:checkPreGoodsId(arg_29_1.config.preGoodsId)

	return var_29_0
end

function var_0_0.checkShowInRecommand(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1.config.notShowInRecommend then
		return false
	end

	if arg_30_1.config.id == StoreEnum.MonthCardGoodsId then
		if not arg_30_0:hasPurchaseMonthCard() then
			return true
		else
			return not var_0_0.instance:IsMonthCardDaysEnough()
		end
	end

	arg_30_2 = arg_30_2 or false

	local var_30_0 = true

	if arg_30_1:isSoldOut() then
		var_30_0 = false
	end

	var_30_0 = var_30_0 and arg_30_0:checkPreGoodsId(arg_30_1.config.preGoodsId)

	return var_30_0
end

function var_0_0.checkPreGoodsId(arg_31_0, arg_31_1)
	if arg_31_1 == 0 then
		return true
	end

	local var_31_0 = arg_31_0:getGoodsMO(arg_31_1)

	return var_31_0 and var_31_0:isSoldOut()
end

function var_0_0.getBuyCount(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0._storeMODict[arg_32_1]

	if not var_32_0 then
		return 0
	end

	return var_32_0:getBuyCount(arg_32_2)
end

function var_0_0.isTabMainRedDotShow(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getAllRedDotInfo()

	if arg_33_1 == StoreEnum.StoreId.Package and arg_33_0:isRedTabReadOnceClient(StoreEnum.StoreId.EventPackage) then
		return true
	end

	if var_33_0 then
		for iter_33_0, iter_33_1 in pairs(var_33_0) do
			local var_33_1
			local var_33_2 = false
			local var_33_3 = arg_33_0:getGoodsMO(iter_33_1.uid)

			if var_33_3 then
				var_33_1 = StoreConfig.instance:getTabConfig(var_33_3.belongStoreId)
			else
				var_33_1 = StoreConfig.instance:getTabConfig(iter_33_1.uid)
				var_33_2 = true
			end

			if var_33_1 then
				local var_33_4 = var_33_1.belongFirstTab

				if var_33_4 == 0 then
					local var_33_5 = var_33_1.belongSecondTab

					if var_33_5 ~= 0 then
						var_33_4 = StoreConfig.instance:getTabConfig(var_33_5).belongFirstTab
					end
				end

				if var_33_4 == 0 then
					var_33_4 = var_33_1.id
				end

				if iter_33_1.value > 0 and arg_33_1 == var_33_4 then
					return true, var_33_2
				end
			end
		end
	end

	return false
end

function var_0_0.isTabFirstRedDotShow(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getAllRedDotInfo()

	if var_34_0 then
		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			local var_34_1 = arg_34_0:getGoodsMO(iter_34_1.uid)

			if var_34_1 then
				local var_34_2 = var_34_1.goodsId
				local var_34_3 = arg_34_1 == StoreEnum.StoreId.RecommendPackage
				local var_34_4 = var_34_1.refreshTime == StoreEnum.ChargeRefreshTime.Month
				local var_34_5 = var_34_1.refreshTime == StoreEnum.ChargeRefreshTime.Week

				if var_34_3 and arg_34_0:isGoodInRecommendList(var_34_2) and not var_34_5 and not var_34_4 then
					return true
				else
					local var_34_6 = StoreConfig.instance:getTabConfig(var_34_1.belongStoreId).belongSecondTab

					if iter_34_1.value > 0 and arg_34_1 == var_34_6 then
						return true
					end
				end
			end

			if iter_34_1.value > 0 and iter_34_1.uid == arg_34_1 then
				return true, true
			end
		end
	end

	return false
end

function var_0_0.isTabSecondRedDotShow(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getAllRedDotInfo()

	if var_35_0 then
		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			local var_35_1 = arg_35_0:getGoodsMO(iter_35_1.uid)

			if var_35_1 and iter_35_1.value > 0 and arg_35_1 == var_35_1.belongStoreId then
				return true
			end
		end
	end

	return false
end

function var_0_0.isPackageStoreTabRedDotShow(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getAllRedDotInfo()

	if arg_36_0:isRedTabReadOnceClient(arg_36_1) then
		return true
	end

	if var_36_0 then
		for iter_36_0, iter_36_1 in pairs(var_36_0) do
			local var_36_1 = arg_36_0:getGoodsMO(iter_36_1.uid)

			if var_36_1 then
				local var_36_2 = var_36_1.goodsId

				if arg_36_1 == StoreEnum.StoreId.RecommendPackage and arg_36_0:isGoodInRecommendList(var_36_2) then
					return true
				elseif iter_36_1.value > 0 and arg_36_1 == var_36_1.belongStoreId then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.getAllRedDotInfo(arg_37_0)
	local var_37_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab)
	local var_37_1 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)
	local var_37_2 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)
	local var_37_3 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a6FurnaceTreasure)
	local var_37_4 = {}

	if var_37_0 then
		for iter_37_0, iter_37_1 in pairs(var_37_0.infos) do
			table.insert(var_37_4, iter_37_1)
		end
	end

	if var_37_1 then
		for iter_37_2, iter_37_3 in pairs(var_37_1.infos) do
			table.insert(var_37_4, iter_37_3)
		end
	end

	if var_37_2 then
		for iter_37_4, iter_37_5 in pairs(var_37_2.infos) do
			table.insert(var_37_4, iter_37_5)
		end
	end

	if var_37_3 then
		for iter_37_6, iter_37_7 in pairs(var_37_3.infos) do
			table.insert(var_37_4, iter_37_7)
		end
	end

	return var_37_4
end

function var_0_0.isGoodsItemRedDotShow(arg_38_0, arg_38_1)
	local var_38_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreTab)

	if var_38_0 then
		local var_38_1 = var_38_0.infos

		for iter_38_0, iter_38_1 in pairs(var_38_1) do
			if iter_38_1.uid == arg_38_1 and iter_38_1.value > 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isStoreTabLock(arg_39_0, arg_39_1)
	local var_39_0 = StoreConfig.instance:getStoreConfig(arg_39_1)

	if var_39_0 and var_39_0.needClearStore > 0 then
		local var_39_1 = arg_39_0._storeMODict[var_39_0.needClearStore].goodsInfos

		for iter_39_0, iter_39_1 in pairs(var_39_1) do
			if iter_39_1.goodsId then
				local var_39_2 = StoreConfig.instance:getGoodsConfig(iter_39_1.goodsId)

				if var_39_2 and iter_39_1.buyCount < var_39_2.maxBuyCount then
					return true
				end
			end
		end
	end

	return false
end

var_0_0.ignoreStoreTab = {
	StoreEnum.BossRushStore,
	StoreEnum.TowerStore
}

function var_0_0.checkContainIgnoreStoreTab(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in pairs(arg_40_0.ignoreStoreTab) do
		if LuaUtil.tableContains(iter_40_1, arg_40_1) then
			return true
		end
	end

	return false
end

function var_0_0.getFirstTabs(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(lua_store_entrance.configList) do
		if not StoreConfig.instance:hasTab(iter_41_1.belongFirstTab) and not StoreConfig.instance:hasTab(iter_41_1.belongSecondTab) then
			local var_41_1 = arg_41_0:checkContainIgnoreStoreTab(iter_41_1.id)

			if iter_41_1.id == StoreEnum.StoreId.DecorateStore and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) == 0 and #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.OldDecorateStore) == 0 then
				var_41_1 = true
			end

			if not var_41_1 and (not arg_41_1 or arg_41_0:isTabOpen(iter_41_1.id)) then
				table.insert(var_41_0, iter_41_1)
			end
		end
	end

	if arg_41_2 and #var_41_0 > 1 then
		table.sort(var_41_0, arg_41_0._tabSortFunction)
	end

	return var_41_0
end

function var_0_0.getSecondTabs(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(iter_42_1.belongFirstTab) and iter_42_1.belongFirstTab == arg_42_1 and (not arg_42_2 or arg_42_0:isTabOpen(iter_42_1.id)) then
			table.insert(var_42_0, iter_42_1)
		end
	end

	if arg_42_3 and #var_42_0 > 1 then
		table.sort(var_42_0, arg_42_0._tabSortFunction)
	end

	return var_42_0
end

function var_0_0.getRecommendSecondTabs(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(iter_43_1.belongFirstTab) and iter_43_1.belongFirstTab == arg_43_1 and (not arg_43_2 or arg_43_0:isTabOpen(iter_43_1.id)) then
			table.insert(var_43_0, iter_43_1)
		end
	end

	for iter_43_2, iter_43_3 in ipairs(lua_store_recommend.configList) do
		if iter_43_3.type == 0 then
			table.insert(var_43_0, iter_43_3)
		end
	end

	return var_43_0
end

function var_0_0.getThirdTabs(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(lua_store_entrance.configList) do
		if StoreConfig.instance:hasTab(iter_44_1.belongSecondTab) and iter_44_1.belongSecondTab == arg_44_1 and (not arg_44_2 or arg_44_0:isTabOpen(iter_44_1.id)) then
			table.insert(var_44_0, iter_44_1)
		end
	end

	if arg_44_3 and #var_44_0 > 1 then
		table.sort(var_44_0, arg_44_0._tabSortFunction)
	end

	return var_44_0
end

function var_0_0.isTabOpen(arg_45_0, arg_45_1)
	local var_45_0 = StoreConfig.instance:getTabConfig(arg_45_1)

	if var_45_0 then
		if var_45_0.openId and var_45_0.openId ~= 0 and not OpenModel.instance:isFunctionUnlock(var_45_0.openId) then
			return false
		end

		if var_45_0.openHideId and var_45_0.openHideId ~= 0 and OpenModel.instance:isFunctionUnlock(var_45_0.openHideId) then
			return false
		end

		local var_45_1
		local var_45_2

		if not string.nilorempty(var_45_0.openTime) then
			var_45_1 = TimeUtil.stringToTimestamp(var_45_0.openTime)
		end

		if not string.nilorempty(var_45_0.endTime) then
			var_45_2 = TimeUtil.stringToTimestamp(var_45_0.endTime)
		end

		if string.nilorempty(var_45_0.openTime) and string.nilorempty(var_45_0.endTime) then
			-- block empty
		elseif string.nilorempty(var_45_0.endTime) then
			if var_45_1 >= ServerTime.now() then
				return false
			end
		elseif string.nilorempty(var_45_0.openTime) then
			if var_45_2 <= ServerTime.now() then
				return false
			end
		else
			local var_45_3 = var_45_1
			local var_45_4 = var_45_2

			if StoreConfig.instance:getOpenTimeDiff(var_45_3, var_45_4, ServerTime.now()) <= 0 then
				return false
			end
		end

		if var_45_0.storeId == StoreEnum.StoreId.Package and GameFacade.isKOLTest() then
			return false
		end

		if StoreConfig.instance:getTabHierarchy(var_45_0.id) == 2 then
			if var_45_0.storeId and var_45_0.storeId ~= 0 then
				return true
			else
				local var_45_5 = arg_45_0:getThirdTabs(var_45_0.id, true, false)

				if var_45_5 and #var_45_5 > 0 then
					return true
				end
			end
		else
			return true
		end
	end

	return false
end

function var_0_0._tabSortFunction(arg_46_0, arg_46_1)
	return arg_46_0.order > arg_46_1.order
end

function var_0_0._packageSortFunction(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0.config
	local var_47_1 = arg_47_1.config

	return var_47_0.order < var_47_1.order
end

function var_0_0.jumpTabIdToSelectTabId(arg_48_0, arg_48_1)
	local var_48_0 = 0
	local var_48_1 = 0
	local var_48_2 = 0
	local var_48_3 = StoreConfig.instance:getTabHierarchy(arg_48_1)

	if var_48_3 == 3 then
		var_48_2 = arg_48_1

		local var_48_4 = StoreConfig.instance:getTabConfig(var_48_2)

		var_48_1 = var_48_4 and var_48_4.belongSecondTab or 0

		local var_48_5 = StoreConfig.instance:getTabConfig(var_48_1)

		var_48_0 = var_48_5 and var_48_5.belongFirstTab or 0
	elseif var_48_3 == 2 then
		var_48_1 = arg_48_1

		local var_48_6 = arg_48_0:getThirdTabs(var_48_1, true, true)

		if var_48_6 and #var_48_6 > 0 then
			var_48_2 = var_48_6[1].id
		end

		local var_48_7 = StoreConfig.instance:getTabConfig(var_48_1)

		var_48_0 = var_48_7 and var_48_7.belongFirstTab or 0
	else
		var_48_0 = arg_48_1

		local var_48_8 = arg_48_0:getSecondTabs(var_48_0, true, true)

		if var_48_0 == StoreEnum.StoreId.Package then
			for iter_48_0 = 1, #var_48_8 do
				if #arg_48_0:getPackageGoodValidList(var_48_8[iter_48_0].id) > 0 then
					var_48_1 = var_48_8[iter_48_0].id

					break
				end
			end

			var_48_2 = 0
		elseif var_48_0 == StoreEnum.StoreId.DecorateStore then
			for iter_48_1 = 1, #var_48_8 do
				if #DecorateStoreModel.instance:getDecorateGoodList(var_48_8[iter_48_1].id) > 0 then
					var_48_1 = var_48_8[iter_48_1].id

					break
				end
			end

			var_48_2 = 0
		elseif var_48_8 and #var_48_8 > 0 then
			var_48_1 = var_48_8[1].id

			local var_48_9 = arg_48_0:getThirdTabs(var_48_1, true, true)

			if var_48_9 and #var_48_9 > 0 then
				var_48_2 = var_48_9[1].id
			end
		else
			var_48_1 = var_48_0
		end
	end

	return var_48_0, var_48_1, var_48_2
end

function var_0_0.jumpTabIdToStoreId(arg_49_0, arg_49_1)
	local var_49_0 = 0
	local var_49_1, var_49_2, var_49_3 = arg_49_0:jumpTabIdToSelectTabId(arg_49_1)
	local var_49_4 = StoreConfig.instance:getTabConfig(var_49_3)
	local var_49_5 = StoreConfig.instance:getTabConfig(var_49_2)
	local var_49_6 = StoreConfig.instance:getTabConfig(var_49_1)
	local var_49_7 = var_49_4 and var_49_4.storeId or 0

	if var_49_7 == 0 then
		var_49_7 = var_49_5 and var_49_5.storeId or 0
	end

	if var_49_7 == 0 then
		var_49_7 = var_49_6 and var_49_6.storeId or 0
	end

	return var_49_7
end

function var_0_0.updateMonthCardInfo(arg_50_0, arg_50_1)
	if arg_50_1 then
		if arg_50_0.monthCardInfo then
			arg_50_0.monthCardInfo:update(arg_50_1)
		else
			arg_50_0.monthCardInfo = StoreMonthCardInfoMO.New()

			arg_50_0.monthCardInfo:init(arg_50_1)
		end
	end
end

function var_0_0.getMonthCardInfo(arg_51_0)
	return arg_51_0.monthCardInfo
end

function var_0_0.hasPurchaseMonthCard(arg_52_0)
	return arg_52_0.monthCardInfo ~= nil
end

function var_0_0.IsMonthCardDaysEnough(arg_53_0)
	local var_53_0 = false

	if arg_53_0:hasPurchaseMonthCard() then
		var_53_0 = arg_53_0:getMonthCardInfo():getRemainDay() > CommonConfig.instance:getConstNum(ConstEnum.MonthCardPurchaseRemindDay)
	end

	return var_53_0
end

function var_0_0.getCostStr(arg_54_0, arg_54_1)
	return "", arg_54_1
end

function var_0_0.getCostSymbolAndPrice(arg_55_0, arg_55_1)
	local var_55_0 = PayModel.instance:getProductOriginPriceSymbol(arg_55_1)
	local var_55_1, var_55_2 = PayModel.instance:getProductOriginPriceNum(arg_55_1)
	local var_55_3 = ""

	if string.nilorempty(var_55_0) then
		local var_55_4 = string.reverse(var_55_2)
		local var_55_5 = string.find(var_55_4, "%d")
		local var_55_6 = string.len(var_55_4) - var_55_5 + 1

		var_55_3 = string.sub(var_55_2, var_55_6 + 1, string.len(var_55_2))
		var_55_2 = string.sub(var_55_2, 1, var_55_6)
	end

	return var_55_0, var_55_2, var_55_3
end

function var_0_0.storeId2PackageGoodMoList(arg_56_0, arg_56_1)
	return arg_56_0._packageType2GoodsDict[arg_56_1] or {}
end

function var_0_0.checkTabShowNewTag(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:getStoreMO(arg_57_1)

	if var_57_0 then
		local var_57_1 = var_57_0:getGoodsList()

		for iter_57_0, iter_57_1 in pairs(var_57_1) do
			if iter_57_1:needShowNew() then
				return true
			end
		end
	end

	return false
end

function var_0_0.setNewRedDotKey(arg_58_0, arg_58_1)
	local var_58_0 = PlayerPrefsKey.StoreViewShowNew .. arg_58_1

	GameUtil.playerPrefsSetStringByUserId(var_58_0, arg_58_1)
end

function var_0_0.checkShowNewRedDot(arg_59_0, arg_59_1)
	local var_59_0 = PlayerPrefsKey.StoreViewShowNew .. arg_59_1

	if GameUtil.playerPrefsGetStringByUserId(var_59_0, nil) then
		return false
	end

	return true
end

function var_0_0.isSkinGoodsCanRepeatBuy(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_1

	if not var_60_0 then
		return false
	end

	local var_60_1 = arg_60_2 == nil

	if arg_60_2 == nil then
		arg_60_2 = string.splitToNumber(var_60_0.config.product, "#")[2]
	end

	local var_60_2 = SkinConfig.instance:getSkinCo(arg_60_2)

	if not var_60_2 then
		return false
	end

	local var_60_3 = var_60_0.config.storeId
	local var_60_4 = var_60_2.unavailableStore

	if not string.nilorempty(var_60_4) then
		local var_60_5 = string.split(var_60_4, "#")

		for iter_60_0, iter_60_1 in ipairs(var_60_5 or {}) do
			if var_60_3 == iter_60_1 then
				return false
			end
		end
	end

	if string.nilorempty(var_60_2.repeatBuyTime) then
		return false
	end

	if ServerTime.now() > TimeUtil.stringToTimestamp(var_60_2.repeatBuyTime) then
		return false
	end

	local var_60_6 = var_60_0:isSoldOut()

	if not var_60_6 and var_60_1 then
		local var_60_7 = StoreConfig.instance:getSkinChargeGoodsId(arg_60_2)

		if var_60_7 then
			local var_60_8 = arg_60_0._skinChargeDict[var_60_7]

			var_60_6 = var_60_8 and var_60_8:isSoldOut()
		end
	end

	return HeroModel.instance:checkHasSkin(arg_60_2) and not var_60_6
end

function var_0_0.isSkinCanShowMessageBox(arg_61_0, arg_61_1)
	if not arg_61_1 then
		return
	end

	local var_61_0 = lua_skin.configDict[arg_61_1]

	if not var_61_0 then
		return
	end

	local var_61_1 = ServerTime.now()

	if not string.nilorempty(var_61_0.repeatBuyTime) and var_61_1 > TimeUtil.stringToTimestamp(var_61_0.repeatBuyTime) then
		return
	end

	local var_61_2 = var_61_0.skinStoreId

	if var_61_2 == 0 then
		return
	end

	local var_61_3 = arg_61_0:getGoodsMO(var_61_2)

	if not var_61_3 then
		return
	end

	local var_61_4 = var_61_3.config
	local var_61_5 = string.nilorempty(var_61_4.onlineTime) and var_61_1 or TimeUtil.stringToTimestamp(var_61_4.onlineTime) - ServerTime.clientToServerOffset()
	local var_61_6 = string.nilorempty(var_61_4.offlineTime) and var_61_1 or TimeUtil.stringToTimestamp(var_61_4.offlineTime) - ServerTime.clientToServerOffset()

	if var_61_4.isOnline and var_61_5 <= var_61_1 and var_61_1 <= var_61_6 and not var_61_3:isSoldOut() then
		local var_61_7 = PlayerPrefsKey.SkinCanShowMessageBox
		local var_61_8 = GameUtil.playerPrefsGetStringByUserId(var_61_7, "")
		local var_61_9 = string.splitToNumber(var_61_8, "#")

		if not (tabletool.indexOf(var_61_9, arg_61_1) ~= nil) then
			table.insert(var_61_9, arg_61_1)
			GameUtil.playerPrefsSetStringByUserId(var_61_7, table.concat(var_61_9, "#"))

			return true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
