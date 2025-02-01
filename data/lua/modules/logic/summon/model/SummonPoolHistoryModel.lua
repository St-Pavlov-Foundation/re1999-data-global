module("modules.logic.summon.model.SummonPoolHistoryModel", package.seeall)

slot0 = class("SummonPoolHistoryModel", BaseModel)

function slot0.onInit(slot0)
	slot0._dataList = {}
	slot0._allMaxNum = 0
	slot0._getNextTime = 0
	slot0._typeNums = {}
	slot0._requestPools = {}
	slot0._token = nil
	slot0._tokenEndTime = 0
	slot0._summonShowTypeDic = nil
end

function slot0.reInit(slot0)
	slot0._dataList = {}
	slot0._allMaxNum = 0
	slot0._getNextTime = 0
	slot0._typeNums = {}
	slot0._requestPools = {}
	slot0._token = nil
	slot0._tokenEndTime = 0
	slot0._summonShowTypeDic = nil
end

function slot0.isDataValidity(slot0)
	if Time.time < slot0._getNextTime then
		return true
	end

	return false
end

function slot0.onGetInfo(slot0, slot1)
	if slot1 == nil or slot1.pageData == nil or #slot1.pageData < 1 then
		if slot0._allMaxNum > 0 then
			slot0:reInit()
		end

		return
	end

	slot0._dataList = slot1.pageData
	slot2 = 0
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._dataList) do
		slot8.gainIds = slot8.gainIds or {}
		slot8.gainHeroList = slot8.gainHeroList or {}

		if slot8.luckyBagIds ~= nil and #slot8.luckyBagIds > 0 then
			slot8.luckyBagIdSet = {}

			for slot12, slot13 in ipairs(slot8.luckyBagIds) do
				slot8.luckyBagIdSet[slot13] = true
			end
		end

		if slot0:_getShowPoolType(slot8.poolId, slot8.poolType) then
			slot2 = slot2 + #slot8.gainIds

			if not slot3[slot9] then
				slot3[slot9] = 0
			end

			slot3[slot9] = slot3[slot9] + #slot8.gainIds
		end
	end

	slot0._allMaxNum = slot2
	slot0._typeNums = slot3
	slot0._getNextTime = Time.time + 600
end

function slot0.getShowPoolTypeByPoolId(slot0, slot1)
	return SummonConfig.instance:getSummonPool(slot1) and slot0:_getShowPoolType(slot1, slot2.type)
end

function slot0._getShowPoolType(slot0, slot1, slot2)
	if not slot0._summonShowTypeDic then
		slot0._summonShowTypeDic = {}

		for slot7 = 1, #SummonConfig.instance:getSummonPoolList() do
			if slot3[slot7].historyShowType and slot8.historyShowType ~= 0 and SummonConfig.instance:getPoolDetailConfig(slot8.historyShowType) then
				slot0._summonShowTypeDic[slot8.id] = slot8.historyShowType
			end
		end
	end

	return slot0._summonShowTypeDic[slot1] or slot2
end

function slot0.getNumByPoolId(slot0, slot1)
	if slot1 == nil then
		return 0
	end

	return slot0._typeNums[slot1] or 0
end

function slot0.updateSummonResult(slot0, slot1)
	if slot1 and #slot1 > 0 then
		slot2 = Time.time + 300

		if slot0._getNextTime == nil or slot2 < slot0._getNextTime then
			slot0._getNextTime = slot2
		end
	end
end

function slot0.getHistoryListByIndexOf(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = 0

	for slot9, slot10 in ipairs(slot0._dataList) do
		if slot3 == slot0:_getShowPoolType(slot10.poolId, slot10.poolType) then
			if slot1 <= slot5 then
				slot0:_addHistoryToList(slot4, slot10, 1 - slot1, slot2 - #slot4)
			elseif slot5 < slot1 and slot1 <= slot5 + #slot10.gainIds then
				slot0:_addHistoryToList(slot4, slot10, slot1 - slot5, slot2 - #slot4)
			end

			slot5 = slot5 + #slot10.gainIds
		end

		if slot2 <= #slot4 then
			break
		end
	end

	return slot4
end

function slot0._addHistoryToList(slot0, slot1, slot2, slot3, slot4)
	if not slot2.gainIds or #slot2.gainIds < 1 then
		return
	end

	slot5 = #slot2.gainIds
	slot1 = slot1 or {}
	slot3 = math.max(1, slot3)

	for slot10 = slot3, math.min(slot3 + slot4, slot5) do
		if SummonConfig.poolTypeIsLuckyBag(slot2.poolType) and slot2.luckyBagIdSet and slot2.luckyBagIdSet[slot12] then
			-- Nothing
		end

		table.insert(slot1, {
			createTime = slot2.createTime,
			summonType = slot2.summonType,
			poolName = slot2.poolName,
			gainId = slot2.gainIds[slot5 - slot10 + 1],
			poolId = slot2.poolId,
			poolType = slot2.poolType,
			isLuckyBag = true
		})
	end

	return slot1
end

function slot0.getHistoryValidPools(slot0)
	slot1 = slot0._typeNums

	for slot8, slot9 in ipairs(SummonConfig.instance:getPoolDetailConfigList()) do
		if slot9.historyShowType == 1 then
			slot0:_addHistoryValidPools({}, {}, slot9.id)
		end
	end

	for slot9, slot10 in ipairs(SummonMainModel.getValidPools()) do
		slot0:_addHistoryValidPools(slot2, slot3, slot0:_getShowPoolType(slot10.id, slot10.type))
	end

	for slot10, slot11 in pairs(slot0._requestPools) do
		if Time.time <= slot11 then
			if SummonConfig.instance:getSummonPool(slot10) then
				slot0:_addHistoryValidPools(slot2, slot3, slot0:_getShowPoolType(slot12.id, slot12.type))
			else
				logNormal(string.format("配置表找不到id为%s的卡池", slot10))
			end
		end
	end

	for slot10, slot11 in pairs(slot1) do
		slot0:_addHistoryValidPools(slot2, slot3, slot10)
	end

	if #slot2 > 1 then
		table.sort(slot2, function (slot0, slot1)
			if slot0.order ~= slot1.order then
				return slot0.order < slot1.order
			end
		end)
	end

	return slot2
end

function slot0._addHistoryValidPools(slot0, slot1, slot2, slot3)
	if slot3 == nil or slot2[slot3] then
		return
	end

	if slot0:isCanShowByPoolTypeId(slot3) then
		slot2[slot3] = true

		table.insert(slot1, SummonConfig.instance:getPoolDetailConfig(slot3))
	end
end

function slot0.isCanShowByPoolTypeId(slot0, slot1)
	if SummonConfig.instance:getPoolDetailConfig(slot1) and slot2.historyShowType ~= 99 and (slot2.openId == nil or slot2.openId == 0 or OpenModel.instance:isFunctionUnlock(slot2.openId)) then
		return true
	end

	return false
end

function slot0.addRequestHistoryPool(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._requestPools[slot1] = Time.time + 3600
end

function slot0.getToken(slot0, slot1)
	return slot0._token
end

function slot0.setToken(slot0, slot1)
	slot0._token = slot1
	slot0._tokenEndTime = Time.time + 300 - 10
end

function slot0.isTokenValidity(slot0)
	return Time.time < slot0._tokenEndTime
end

slot0.instance = slot0.New()

return slot0
