-- chunkname: @modules/logic/store/controller/StoreHelper.lua

module("modules.logic.store.controller.StoreHelper", package.seeall)

local StoreHelper = class("StoreHelper", BaseController)

function StoreHelper.getRecommendStoreSecondTabConfig()
	local secondTabConfigs = StoreModel.instance:getRecommendSecondTabs(StoreEnum.StoreId.RecommendStore, true)
	local showSecondTabConfigs = {}
	local relationStoreIdsDic = {}

	if secondTabConfigs and #secondTabConfigs > 0 then
		local SummonPools = SummonMainModel.getValidPools()
		local openSummonPoolDic = {}

		for i, v in ipairs(SummonPools) do
			openSummonPoolDic[v.id] = v
		end

		for i = 1, #secondTabConfigs do
			local co = StoreConfig.instance:getStoreRecommendConfig(secondTabConfigs[i].id)

			if co == nil then
				table.insert(showSecondTabConfigs, secondTabConfigs[i])
			elseif StoreHelper._inOpenTime(co) then
				local pass, _, storeIdsDic = StoreHelper._checkRelations(co.relations, secondTabConfigs, openSummonPoolDic)

				for storeId, _ in pairs(storeIdsDic) do
					relationStoreIdsDic[storeId] = true
				end

				if pass then
					table.insert(showSecondTabConfigs, secondTabConfigs[i])
				end
			end
		end
	end

	local storeIds = {}

	for i, v in pairs(relationStoreIdsDic) do
		table.insert(storeIds, i)
	end

	return showSecondTabConfigs, storeIds
end

function StoreHelper._inOpenTime(co)
	local serverTime = ServerTime.now()
	local onlineTime = TimeUtil.stringToTimestamp(co.onlineTime)
	local offlineTime = TimeUtil.stringToTimestamp(co.offlineTime)
	local openTime = string.nilorempty(co.onlineTime) and serverTime or onlineTime
	local endTime = string.nilorempty(co.offlineTime) and serverTime or offlineTime

	return co.isOffline == 0 and openTime <= serverTime and serverTime <= endTime
end

function StoreHelper._inRecommendGroupBTopTime(co)
	local serverTime = ServerTime.now()
	local openTime = string.nilorempty(co.onlineTime) and serverTime or TimeUtil.stringToTimestamp(co.onlineTime) - ServerTime.clientToServerOffset()
	local registerTime = ServerTime.timeInLocal(PlayerModel.instance:getPlayerRegisterTime() / 1000)

	if openTime <= registerTime then
		return false
	end

	local turnBackMo = TurnbackModel.instance:getCurTurnbackMo()

	if turnBackMo and turnBackMo:isInOpenTime() and openTime <= ServerTime.timeInLocal(turnBackMo.startTime) then
		return false
	end

	local duration = co.topDay == nil and 0 or co.topDay * TimeUtil.OneDaySecond
	local endTime = openTime + duration

	return co.isOffline == 0 and openTime <= serverTime and serverTime <= endTime
end

function StoreHelper.getRecommendStoreGroup(co, includeGroupD)
	if includeGroupD then
		local type = co.topType

		if type == StoreEnum.AdjustOrderType.MonthCard then
			if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 0) == 0 or SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
				return StoreEnum.GroupOrderType.GroupA
			end

			local monthCardInfo = StoreModel.instance:getMonthCardInfo()

			if monthCardInfo ~= nil and monthCardInfo:getRemainDay() >= StoreEnum.MonthCardStatus.NotPurchase then
				return StoreEnum.GroupOrderType.GroupD
			end
		elseif type == StoreEnum.AdjustOrderType.SeasonCard then
			if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 0) == 0 or SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
				return StoreEnum.GroupOrderType.GroupA
			end

			local monthCardInfo = StoreModel.instance:getMonthCardInfo()

			if monthCardInfo ~= nil and monthCardInfo:getRemainDay() >= StoreEnum.MonthCardStatus.NotPurchase then
				return StoreEnum.GroupOrderType.GroupD
			end
		elseif type == StoreEnum.AdjustOrderType.BattlePass and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
			return StoreEnum.GroupOrderType.GroupD
		end
	end

	if co.topDay < 0 then
		return StoreEnum.GroupOrderType.GroupA
	elseif co.topDay == 0 then
		return StoreEnum.GroupOrderType.GroupC
	elseif not StoreHelper._inRecommendGroupBTopTime(co) then
		return StoreEnum.GroupOrderType.GroupC
	end

	return StoreEnum.GroupOrderType.GroupB
end

function StoreHelper.getRecommendStoreGroupAndOrder(co, includeGroupD)
	local group = StoreHelper.getRecommendStoreGroup(co, includeGroupD)

	if not string.nilorempty(co.adjustOrder) then
		local groupOrderData = string.split(co.adjustOrder, "|")

		for _, data in ipairs(groupOrderData) do
			local info = string.split(data, "#")

			if group == tonumber(info[2]) then
				return group, tonumber(info[1])
			end
		end
	end

	return group, co.order
end

function StoreHelper.checkMonthCardLevelUpTagOpen()
	local serverTime = ServerTime.now()
	local offtime = CommonConfig.instance:getConstStr(ConstEnum.MonthCardLevelUpTime)
	local endTime = string.nilorempty(offtime) and serverTime or TimeUtil.stringToTimestamp(offtime)

	return serverTime <= endTime
end

function StoreHelper.checkNewMatUpTagOpen(goodsId)
	if not goodsId then
		return false
	end

	local str = CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatChargeGoodIds)

	if string.nilorempty(str) then
		return false
	end

	local ok = false
	local strList = string.split(str, "#")

	for _, id in ipairs(strList or {}) do
		if tonumber(id) == goodsId then
			ok = true

			break
		end
	end

	if not ok then
		return false
	end

	local offtime = CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatTime)

	if string.nilorempty(offtime) then
		return false
	end

	return ServerTime.now() <= TimeUtil.stringToTimestamp(offtime)
end

function StoreHelper._checkRelations(relations, secondTabConfigs, openSummonPoolDic)
	local arr = GameUtil.splitString2(relations, true)
	local needPackageInfo = false
	local show = false
	local relationStoreIdsDic = {}

	if string.nilorempty(relations) == false and arr and #arr > 0 then
		for i, v in ipairs(arr) do
			local pass = true
			local relationType = v[1]
			local relationId = v[2]

			if relationType == StoreEnum.RecommendRelationType.Summon then
				if openSummonPoolDic[relationId] == nil then
					pass = false
				end
			elseif relationType == StoreEnum.RecommendRelationType.PackageStoreGoods then
				local storePackageGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				if storePackageGoodsMO == nil or storePackageGoodsMO:isSoldOut() then
					pass = false
				end

				needPackageInfo = true
			elseif relationType == StoreEnum.RecommendRelationType.StoreGoods then
				local storeGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				if storeGoodsMO == nil or storeGoodsMO:isSoldOut() or storeGoodsMO:alreadyHas() then
					pass = false
				end

				local goodsConfig = StoreConfig.instance:getGoodsConfig(relationId)

				if goodsConfig then
					relationStoreIdsDic[goodsConfig.storeId] = true
				end
			elseif relationType == StoreEnum.RecommendRelationType.OtherRecommendClose then
				local co = StoreConfig.instance:getStoreRecommendConfig(relationId)

				if StoreHelper._inOpenTime(co) and StoreHelper._checkRelations(co.relations, secondTabConfigs, openSummonPoolDic) then
					pass = false
				end
			elseif relationType == StoreEnum.RecommendRelationType.BattlePass then
				if BpModel.instance:isEnd() then
					pass = false
				end
			elseif relationType == StoreEnum.RecommendRelationType.PackageStoreGoodsNoBuy then
				local storePackageGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				if storePackageGoodsMO and not storePackageGoodsMO:isSoldOut() then
					show = false
					pass = false

					break
				end
			end

			show = show or pass
		end
	else
		show = true
	end

	return show, needPackageInfo, relationStoreIdsDic
end

function StoreHelper.getRemainExpireTime(storeEntranceCfg)
	local time = storeEntranceCfg.endTime

	if type(time) == "string" and not string.nilorempty(time) then
		time = TimeUtil.stringToTimestamp(time)

		return time - ServerTime.now()
	elseif type(time) == "number" then
		return time * 0.001 - ServerTime.now()
	end

	return 0
end

function StoreHelper.getRemainExpireTimeDeep(storeEntranceCfg)
	local deadlineTimeSec = StoreHelper.getRemainExpireTime(storeEntranceCfg)

	if deadlineTimeSec == 0 then
		local secondTabs = StoreModel.instance:getSecondTabs(storeEntranceCfg.id, true, true)

		for i = 1, #secondTabs do
			local timeSec = StoreHelper.getRemainExpireTime(secondTabs[i])

			if timeSec > 0 then
				deadlineTimeSec = math.max(timeSec, deadlineTimeSec)
			end
		end
	end

	return deadlineTimeSec
end

function StoreHelper.getRemainExpireTimeByStoreId(storeId)
	local deadlineTimeSec = 0
	local storeMo = StoreModel.instance:getStoreMO(storeId)
	local goods = storeMo:getGoodsList()

	for _, v in pairs(goods) do
		if not string.nilorempty(v.config.offlineTime) and type(v.config.offlineTime) == "string" then
			local curGoodDeadlineTimeSec = TimeUtil.stringToTimestamp(v.config.offlineTime) - ServerTime.now()

			if curGoodDeadlineTimeSec > 0 then
				deadlineTimeSec = deadlineTimeSec == 0 and curGoodDeadlineTimeSec or math.min(curGoodDeadlineTimeSec, deadlineTimeSec)
			end
		end
	end

	return deadlineTimeSec
end

function StoreHelper.getRemainExpireTimeDeepByStoreId(storeId)
	local deadlineTimeSec = 0
	local secondTabs = StoreModel.instance:getSecondTabs(storeId, true, true)

	for i = 1, #secondTabs do
		local timeSec = StoreHelper.getRemainExpireTimeByStoreId(secondTabs[i].id)

		if timeSec > 0 then
			deadlineTimeSec = deadlineTimeSec == 0 and timeSec or math.min(timeSec, deadlineTimeSec)
		end
	end

	return deadlineTimeSec
end

function StoreHelper.checkIsShowCoBrandedTag(goodsId)
	if not goodsId then
		return false
	end

	local str = CommonConfig.instance:getConstStr(ConstEnum.StorePackageShowCoBradedTagGoodIds)

	if string.nilorempty(str) then
		return false
	end

	local strList = string.split(str, "#")

	for _, id in ipairs(strList or {}) do
		if tonumber(id) == goodsId then
			return true
		end
	end

	return false
end

return StoreHelper
