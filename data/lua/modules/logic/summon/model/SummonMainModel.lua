module("modules.logic.summon.model.SummonMainModel", package.seeall)

local var_0_0 = class("SummonMainModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:releaseViewData()

	arg_1_0.flagModel = SummonFlagSubModel.New()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:releaseViewData()
	arg_2_0:releaseServerData()

	arg_2_0.flagModel = SummonFlagSubModel.New()
end

function var_0_0.releaseServerData(arg_3_0)
	arg_3_0._hasNewbiePool = nil
	arg_3_0._newbieProgress = nil
	arg_3_0._curPoolIndex = nil
	arg_3_0._curPoolId = nil
	arg_3_0._curPool = nil
	arg_3_0._validServerPoolMap = nil
end

function var_0_0.releaseViewData(arg_4_0)
	arg_4_0:clear()

	arg_4_0._poolList = nil
	arg_4_0._isFirstTimeOpen = true
end

function var_0_0.initCategory(arg_5_0, arg_5_1)
	arg_5_0:releaseViewData()

	arg_5_0._poolList = var_0_0.getValidPools()

	arg_5_0:setList(arg_5_0._poolList)

	if arg_5_0:getCount() > 0 then
		arg_5_0._curPoolIndex = 1
		arg_5_0._curPool = arg_5_0:getByIndex(1)
		arg_5_0._curPoolId = arg_5_0._curPool.id
	else
		logError("summon pool config is empty!")
	end

	arg_5_0:_updateSummonDiamondStatus()
end

function var_0_0.updateByServerData(arg_6_0)
	arg_6_0:releaseViewData()

	arg_6_0._poolList = var_0_0.getValidPools()

	arg_6_0:setList(arg_6_0._poolList)

	if arg_6_0:getCount() > 0 then
		if arg_6_0._curPoolId == nil or not arg_6_0:trySetSelectPoolId(arg_6_0._curPoolId) then
			arg_6_0._curPoolIndex = 1
			arg_6_0._curPool = arg_6_0:getByIndex(1)
			arg_6_0._curPoolId = arg_6_0._curPool.id
		end
	else
		logError("no summon pool available!")
	end

	SummonMainCategoryListModel.instance:initCategory()
end

function var_0_0.updateLastPoolId(arg_7_0)
	if arg_7_0._curPoolId then
		SummonController.instance:setLastPoolId(arg_7_0._curPoolId)
	end
end

function var_0_0.getPoolsWithServer(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		callback = arg_8_1,
		callbackObj = arg_8_2
	}

	SummonRpc.instance:sendGetSummonInfoRequest(var_0_0.onGetPoolsWithServer, var_8_0)
end

function var_0_0.onGetPoolsWithServer(arg_9_0)
	local var_9_0 = arg_9_0.callback
	local var_9_1 = arg_9_0.callbackObj

	if var_9_0 then
		local var_9_2 = var_0_0.getValidPools()

		if var_9_1 then
			var_9_0(var_9_1, var_9_2)
		else
			var_9_0(var_9_2)
		end
	end
end

function var_0_0.equipPoolIsValid()
	local var_10_0 = SummonConfig.instance:getValidPoolList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if var_0_0.getResultType(iter_10_1) == SummonEnum.ResultType.Equip and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SummonEquip) then
			return true
		end
	end
end

function var_0_0.getValidPools()
	local var_11_0 = SummonConfig.instance:getValidPoolList()
	local var_11_1 = {}
	local var_11_2 = false

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_3 = var_0_0.instance:getPoolServerMO(iter_11_1.id)

		if var_11_3 and var_11_3:isOpening() then
			local var_11_4 = true

			if var_0_0.getResultType(iter_11_1) == SummonEnum.ResultType.Equip and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SummonEquip) then
				var_11_4 = false
			elseif var_0_0.getADPageTabIndex(iter_11_1) == SummonEnum.TabContentIndex.CharNewbie and not var_0_0.instance:getNewbiePoolExist() then
				var_11_4 = false
			end

			if var_11_4 then
				table.insert(var_11_1, iter_11_1)
			end
		end
	end

	table.sort(var_11_1, var_0_0.sortSummonCategory)

	return var_11_1
end

var_0_0.defaultSettings = {
	[SummonEnum.TabContentIndex.DoubleSsrUp] = {
		"ui/viewres/summon/summonmaincharacterprobup.prefab"
	},
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
var_0_0.defaultUIClzMap = {
	[SummonEnum.TabContentIndex.DoubleSsrUp] = SummonCharacterProbDoubleUpBase,
	SummonMainCharacterView,
	SummonMainEquipView,
	SummonMainCharacterNewbie,
	SummonMainCharacterProbUp,
	SummonMainEquipProbUp
}
var_0_0.defaultUIClzMapByType = {
	[SummonEnum.Type.ProbUp] = SummonMainCharacterProbUp,
	[SummonEnum.Type.Limit] = SummonMainCharacterProbUp,
	[SummonEnum.Type.StrongCustomOnePick] = SummonStrongOneCustomPickView
}

function var_0_0.resetTabResSettings(arg_12_0)
	local var_12_0 = tabletool.copy(var_0_0.defaultSettings)
	local var_12_1 = tabletool.copy(var_0_0.defaultUIClzMap)
	local var_12_2 = SummonConfig.instance:getValidPoolList()

	arg_12_0._poolIDTabMap = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_3 = var_0_0.defaultUIClzMapByType[iter_12_1.type]
		local var_12_4 = var_0_0.getADPageTabIndex(iter_12_1)
		local var_12_5 = var_0_0.defaultUIClzMap[var_12_4]

		if var_12_3 == nil and not string.nilorempty(iter_12_1.customClz) then
			var_12_3 = _G[iter_12_1.customClz]
		end

		var_12_3 = var_12_3 or var_12_5

		local var_12_6 = var_0_0.defaultSettings[var_12_4][1]
		local var_12_7

		if not string.nilorempty(iter_12_1.prefabPath) then
			var_12_7 = string.format("ui/viewres/summon/%s.prefab", iter_12_1.prefabPath)
		end

		var_12_7 = var_12_7 or var_12_6

		if var_12_3 ~= var_12_5 or var_12_7 ~= var_12_6 then
			table.insert(var_12_0, {
				var_12_7
			})
			table.insert(var_12_1, var_12_3)

			arg_12_0._poolIDTabMap[iter_12_1.id] = #var_12_0
		end
	end

	module_views.SummonADView.tabRes[3] = var_12_0
	arg_12_0._tab2UIClassDef = var_12_1
end

function var_0_0.sortSummonCategory(arg_13_0, arg_13_1)
	if arg_13_0.priority ~= arg_13_1.priority then
		return arg_13_0.priority > arg_13_1.priority
	else
		return arg_13_0.id < arg_13_1.id
	end
end

function var_0_0.setFirstTimeSwitch(arg_14_0, arg_14_1)
	arg_14_0._isFirstTimeSwitch = arg_14_1
end

function var_0_0.getFirstTimeSwitch(arg_15_0)
	return arg_15_0._isFirstTimeSwitch
end

function var_0_0.getCurPool(arg_16_0)
	return arg_16_0:getById(arg_16_0._curPoolId)
end

function var_0_0.createUIClassTab(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._tab2UIClassDef) do
		var_17_0[iter_17_0] = iter_17_1.New()
	end

	return var_17_0
end

function var_0_0.getUIClassDef(arg_18_0, arg_18_1)
	return arg_18_0._tab2UIClassDef[arg_18_1]
end

function var_0_0.getCurADPageIndex(arg_19_0)
	local var_19_0 = arg_19_0:getCurPool()

	if var_19_0 == nil then
		return nil
	end

	local var_19_1 = arg_19_0._poolIDTabMap[var_19_0.id]

	if var_19_1 then
		return var_19_1
	else
		return var_0_0.getADPageTabIndex(var_19_0)
	end
end

function var_0_0.getADPageTabIndexForUI(arg_20_0, arg_20_1)
	if arg_20_1 == nil or arg_20_0._poolIDTabMap == nil then
		return nil
	end

	local var_20_0 = arg_20_0._poolIDTabMap[arg_20_1.id]

	if var_20_0 then
		return var_20_0
	else
		return var_0_0.getADPageTabIndex(arg_20_1)
	end
end

function var_0_0.getADPageTabIndex(arg_21_0)
	return SummonEnum.Type2PageIndex[arg_21_0.type] or SummonEnum.TabContentIndex.CharNormal
end

function var_0_0.hasPoolAvailable(arg_22_0, arg_22_1)
	if arg_22_1 == nil then
		return arg_22_0:getCount() > 0
	else
		return arg_22_0:getById(arg_22_1) ~= nil
	end
end

function var_0_0.hasPoolGroupAvailable(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getList()

	if var_23_0 and #var_23_0 > 0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			if iter_23_1.jumpGroupId == arg_23_1 then
				return iter_23_1
			end
		end
	end

	return nil
end

function var_0_0.getPoolServerMO(arg_24_0, arg_24_1)
	if arg_24_0._validServerPoolMap then
		return arg_24_0._validServerPoolMap[arg_24_1]
	end
end

function var_0_0.getServerMOMap(arg_25_0)
	return arg_25_0._validServerPoolMap
end

function var_0_0.trySetSelectPoolIndex(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getCount()

	if var_26_0 == 0 then
		return false
	elseif arg_26_1 < 1 then
		arg_26_1 = var_26_0
	elseif var_26_0 < arg_26_1 then
		arg_26_1 = 1
	end

	local var_26_1 = arg_26_0:getByIndex(arg_26_1)

	arg_26_0._curPoolIndex = arg_26_1
	arg_26_0._curPoolId = var_26_1.id
	arg_26_0._curPool = var_26_1

	SummonController.instance:setLastPoolId(arg_26_0._curPoolId)
	arg_26_0:_updateSummonDiamondStatus()

	return true
end

function var_0_0.trySetSelectPoolId(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getById(arg_27_1)

	if var_27_0 then
		arg_27_0._curPoolIndex = arg_27_0:getIndex(var_27_0)
		arg_27_0._curPoolId = arg_27_1
		arg_27_0._curPool = var_27_0

		SummonController.instance:setLastPoolId(arg_27_0._curPoolId)
		arg_27_0:_updateSummonDiamondStatus()

		return true
	end

	return false
end

function var_0_0._updateSummonDiamondStatus(arg_28_0)
	local var_28_0 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.SingleSummonPer), "#")
	local var_28_1 = var_28_0[1]
	local var_28_2 = var_28_0[2]

	arg_28_0.everyCostCount = var_28_0[3]
	arg_28_0.costCurrencyType = var_28_1
	arg_28_0.costCurrencyId = var_28_2
end

function var_0_0.getOwnCostCurrencyNum(arg_29_0)
	return ItemModel.instance:getItemQuantity(arg_29_0.costCurrencyType, arg_29_0.costCurrencyId)
end

var_0_0.EmptyDetailDict = {}

function var_0_0.getEquipDetailListByPool(arg_30_0, arg_30_1)
	if arg_30_1 then
		return SummonConfig.instance:getEquipDetailByPoolId(arg_30_1.id) or var_0_0.EmptyDetailDict
	else
		return var_0_0.EmptyDetailDict
	end
end

function var_0_0.sortDetailByLocation(arg_31_0, arg_31_1)
	if arg_31_0.detailCo.location ~= arg_31_1.detailCo.location then
		return arg_31_0.detailCo.location < arg_31_1.detailCo.location
	else
		return arg_31_0.detailCo.id < arg_31_1.detailCo.id
	end
end

function var_0_0.getCurIndex(arg_32_0)
	return arg_32_0._curPoolIndex
end

function var_0_0.getCurId(arg_33_0)
	return arg_33_0._curPoolId
end

function var_0_0.setNewbiePoolExist(arg_34_0, arg_34_1)
	arg_34_0._hasNewbiePool = arg_34_1
end

function var_0_0.getNewbiePoolExist(arg_35_0)
	return arg_35_0._hasNewbiePool
end

function var_0_0.setNewbieProgress(arg_36_0, arg_36_1)
	arg_36_0._newbieProgress = arg_36_1
end

function var_0_0.getNewbieProgress(arg_37_0)
	return arg_37_0._newbieProgress
end

function var_0_0.setServerPoolInfos(arg_38_0, arg_38_1)
	arg_38_0._validServerPoolMap = arg_38_0._validServerPoolMap or {}

	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
		var_38_0[iter_38_1.poolId] = iter_38_1

		local var_38_1 = arg_38_0._validServerPoolMap[iter_38_1.poolId]

		if not var_38_1 then
			var_38_1 = SummonMainPoolMO.New()

			var_38_1:init(iter_38_1)

			arg_38_0._validServerPoolMap[iter_38_1.poolId] = var_38_1
		else
			var_38_1:update(iter_38_1)
		end
	end

	for iter_38_2, iter_38_3 in pairs(arg_38_0._validServerPoolMap) do
		if not var_38_0[iter_38_3.id] then
			arg_38_0._validServerPoolMap[iter_38_2] = nil
		end
	end

	arg_38_0:refreshRecord()
end

function var_0_0.getFirstValidPool(arg_39_0)
	if arg_39_0._poolList then
		return arg_39_0._poolList[1]
	end
end

function var_0_0.refreshRecord(arg_40_0)
	local var_40_0 = var_0_0.getValidPools()

	arg_40_0.flagModel:init()
	arg_40_0.flagModel:compareRecord(var_40_0)
end

function var_0_0.categoryHasNew(arg_41_0, arg_41_1)
	local var_41_0 = false

	if arg_41_0.flagModel then
		var_41_0 = arg_41_0.flagModel:isNew(arg_41_1)
	end

	return var_41_0
end

function var_0_0.hasNextDayFree(arg_42_0, arg_42_1)
	if SummonConfig.instance:canShowSingleFree(arg_42_1) then
		local var_42_0 = SummonConfig.instance:getSummonPool(arg_42_1)
		local var_42_1 = arg_42_0:getPoolServerMO(arg_42_1)

		if var_42_1 and var_42_1.usedFreeCount < var_42_0.totalFreeCount then
			return true
		end
	end

	return false
end

function var_0_0.entryHasNew(arg_43_0)
	if arg_43_0.flagModel then
		return arg_43_0.flagModel:hasNew()
	end

	return false
end

function var_0_0.entryHasFree(arg_44_0)
	local var_44_0 = var_0_0.getValidPools()

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		local var_44_1 = arg_44_0:getPoolServerMO(iter_44_1.id)

		if var_44_1 and var_44_1.haveFree then
			return true
		end
	end

	return false
end

function var_0_0.getCustomPickProbability(arg_45_0, arg_45_1)
	local var_45_0 = SummonConfig.instance:getSummonPool(arg_45_1)

	if var_45_0 and var_45_0.type == SummonEnum.Type.CustomPick then
		local var_45_1 = string.split(var_45_0.param, "|")
		local var_45_2 = tonumber(var_45_1[1])
		local var_45_3 = string.splitToNumber(var_45_1[2], "#")
		local var_45_4 = 0

		for iter_45_0 = 1, #var_45_3 do
			var_45_4 = var_45_4 + var_45_3[iter_45_0]
		end

		return var_45_4 * 0.001 / var_45_2 * 100, var_45_0.totalPosibility, false
	end

	if var_45_0 and var_45_0.type == SummonEnum.Type.StrongCustomOnePick then
		if SummonCustomPickModel.instance:isHaveFirstSSR(arg_45_1) then
			return 50, 0, false
		else
			return 100, 0, true
		end
	end

	return 0, 0, false
end

function var_0_0.getDiscountTime10Server(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:getPoolServerMO(arg_46_1)

	if var_46_0 then
		return var_46_0.discountTime
	end

	return 0
end

function var_0_0.getDiscountCostId(arg_47_0, arg_47_1)
	local var_47_0 = SummonConfig.instance:getSummonPool(arg_47_1)

	if var_47_0 then
		local var_47_1 = var_47_0.discountCost10
		local var_47_2 = string.split(var_47_1, "|")

		for iter_47_0, iter_47_1 in ipairs(var_47_2) do
			local var_47_3 = string.splitToNumber(iter_47_1, "#")

			if var_47_3 then
				return var_47_3[2]
			end
		end
	end

	return 0
end

function var_0_0.getDiscountTime10(arg_48_0, arg_48_1)
	local var_48_0 = SummonConfig.instance:getSummonPool(arg_48_1)

	if var_48_0 then
		return var_48_0.discountTime10
	end

	return 0
end

function var_0_0.getDiscountCost10(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0:getDiscountTime10(arg_49_1)
	local var_49_1 = arg_49_0:getDiscountTime10Server(arg_49_1)
	local var_49_2 = arg_49_2 or var_49_0 - var_49_1 + 1

	if var_49_2 <= var_49_0 then
		local var_49_3 = SummonConfig.instance:getSummonPool(arg_49_1)

		if var_49_3 then
			local var_49_4 = var_49_3.discountCost10
			local var_49_5 = string.split(var_49_4, "|")

			for iter_49_0, iter_49_1 in ipairs(var_49_5) do
				local var_49_6 = string.splitToNumber(iter_49_1, "#")

				if var_49_6 and var_49_6[1] == var_49_2 then
					return var_49_6[3]
				end
			end
		end
	end

	return -1
end

function var_0_0.getCostByConfig(arg_50_0)
	if string.nilorempty(arg_50_0) then
		logError("no summon cost config")

		return
	end

	local var_50_0 = string.split(arg_50_0, "|")

	for iter_50_0, iter_50_1 in ipairs(var_50_0) do
		local var_50_1 = string.splitToNumber(iter_50_1, "#")
		local var_50_2 = var_50_1[1]
		local var_50_3 = var_50_1[2]
		local var_50_4 = var_50_1[3]

		if iter_50_0 >= #var_50_0 then
			return var_50_2, var_50_3, var_50_4
		end

		if var_50_4 <= ItemModel.instance:getItemQuantity(var_50_2, var_50_3) then
			return var_50_2, var_50_3, var_50_4
		end
	end
end

function var_0_0.getLastCostByConfig(arg_51_0)
	if string.nilorempty(arg_51_0) then
		logError("no summon cost config")

		return
	end

	local var_51_0 = string.split(arg_51_0, "|")
	local var_51_1 = string.splitToNumber(var_51_0[#var_51_0], "#")
	local var_51_2 = var_51_1[1]
	local var_51_3 = var_51_1[2]
	local var_51_4 = var_51_1[3]

	return var_51_2, var_51_3, var_51_4
end

function var_0_0.getSummonItemIcon(arg_52_0, arg_52_1)
	arg_52_0 = tonumber(arg_52_0)
	arg_52_1 = tonumber(arg_52_1)

	local var_52_0 = ItemModel.instance:getItemConfig(arg_52_0, arg_52_1)

	if not var_52_0 then
		logError(string.format("getSummonItemIcon no config itemType:%s,id:%s", arg_52_0, arg_52_1))

		return
	end

	local var_52_1

	if arg_52_0 == MaterialEnum.MaterialType.Item then
		var_52_1 = ItemModel.instance:getItemSmallIcon(arg_52_1)
	elseif arg_52_0 == MaterialEnum.MaterialType.Currency then
		var_52_1 = ResUrl.getCurrencyItemIcon(var_52_0.icon)
	else
		var_52_1 = ResUrl.getSpecialPropItemIcon(var_52_0.icon)
	end

	return var_52_1
end

function var_0_0.getResultType(arg_53_0)
	return SummonEnum.Type2Result[arg_53_0.type] or SummonEnum.ResultType.Char
end

function var_0_0.getResultTypeById(arg_54_0)
	if arg_54_0 then
		local var_54_0 = SummonConfig.instance:getSummonPool(arg_54_0)

		if var_54_0 then
			return (var_0_0.getResultType(var_54_0))
		else
			logError("can't find summon pool config : [" .. tostring(arg_54_0) .. "]")
		end
	end

	return SummonEnum.ResultType.Char
end

function var_0_0.isProbUp(arg_55_0)
	local var_55_0 = var_0_0.getADPageTabIndex(arg_55_0)

	return var_55_0 == SummonEnum.TabContentIndex.CharProbUp or var_55_0 == SummonEnum.TabContentIndex.EquipProbUp or var_55_0 == SummonEnum.TabContentIndex.DoubleSsrUp
end

function var_0_0.getCostCurrencyParam(arg_56_0)
	local var_56_0 = {}

	if arg_56_0 then
		local var_56_1 = {}

		var_0_0.addCurrencyByCostStr(var_56_0, arg_56_0.cost1, var_56_1)
	else
		table.insert(var_56_0, {
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = var_0_0.jumpToSummonCostShop
		})
		table.insert(var_56_0, {
			id = 140002,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = var_0_0.jumpToSummonCostShop
		})
	end

	table.insert(var_56_0, CurrencyEnum.CurrencyType.Diamond)
	table.insert(var_56_0, CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	return var_56_0
end

function var_0_0.jumpToSummonCostShop()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.SummonCost)
end

function var_0_0.addCurrencyByCostStr(arg_58_0, arg_58_1, arg_58_2)
	if not string.nilorempty(arg_58_1) then
		local var_58_0 = string.split(arg_58_1, "|")

		for iter_58_0, iter_58_1 in ipairs(var_58_0) do
			local var_58_1 = string.splitToNumber(iter_58_1, "#")
			local var_58_2 = var_58_1[1]
			local var_58_3 = var_58_1[2]
			local var_58_4 = var_58_1[3]

			if not arg_58_2[var_58_3] then
				table.insert(arg_58_0, {
					isIcon = true,
					id = var_58_3,
					type = var_58_2,
					jumpFunc = var_0_0.jumpToSummonCostShop
				})

				arg_58_2[var_58_3] = true
			end
		end
	end
end

function var_0_0.entryNeedReddot(arg_59_0)
	local var_59_0 = arg_59_0:getServerMOMap()

	if var_59_0 then
		for iter_59_0, iter_59_1 in pairs(var_59_0) do
			if var_0_0.needShowReddot(iter_59_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.needShowReddot(arg_60_0)
	if not arg_60_0:isOpening() then
		return false
	end

	if arg_60_0.luckyBagMO and arg_60_0.luckyBagMO:isGot() and not arg_60_0.luckyBagMO:isOpened() then
		return true
	end

	if arg_60_0.haveFree then
		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
