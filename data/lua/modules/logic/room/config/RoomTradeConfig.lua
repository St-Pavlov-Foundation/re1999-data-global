module("modules.logic.room.config.RoomTradeConfig", package.seeall)

slot0 = class("RoomTradeConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._constConfig = nil
	slot0._qualityConfig = nil
	slot0._refreshConfig = nil
	slot0._barrageConfig = nil
	slot0._taskConfig = nil
	slot0._supportBonusConfig = nil
	slot0._levelUnlockConfig = nil
	slot0._levelConfig = nil
	slot0._qualityDic = nil
	slot0._refreshDic = nil
	slot0._barrageDic = nil
	slot0._taskDic = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"room_order_const",
		"room_order_quality",
		"room_order_refresh",
		"room_trade_barrage",
		"trade_task",
		"trade_support_bonus",
		"trade_level_unlock",
		"trade_level"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "room_order_const" then
		slot0._constConfig = slot2
	elseif slot1 == "room_order_quality" then
		slot0._qualityConfig = slot2

		slot0:_initOrderQualityCo()
	elseif slot1 == "room_order_refresh" then
		slot0._refreshConfig = slot2

		slot0:_initOrderRefreshCo()
	elseif slot1 == "room_trade_barrage" then
		slot0._barrageConfig = slot2

		slot0:_initBarrageCo()
	elseif slot1 == "trade_task" then
		slot0._taskConfig = slot2

		slot0:_initTaskCo()
	elseif slot1 == "trade_support_bonus" then
		slot0._supportBonusConfig = slot2
	elseif slot1 == "trade_level_unlock" then
		slot0._levelUnlockConfig = slot2
	elseif slot1 == "trade_level" then
		slot0._levelConfig = slot2
	end
end

function slot0.getConstValue(slot0, slot1, slot2)
	if slot0._constConfig and slot0._constConfig.configDict[slot1] then
		if slot2 then
			return tonumber(slot3.value)
		end

		return slot3.value
	end
end

function slot0._initOrderRefreshCo(slot0)
	slot0._refreshDic = {}

	for slot4, slot5 in pairs(slot0._refreshConfig.configList) do
		table.insert(slot0._refreshDic, {
			daily = GameUtil.splitString2(slot5.qualityWeight, true),
			wholesale = GameUtil.splitString2(slot5.wholesaleGoodsWeight, true),
			co = slot5
		})
	end
end

function slot0.getOrderRefreshInfo(slot0, slot1)
	return slot0._refreshDic[slot1]
end

function slot0._initOrderQualityCo(slot0)
	slot0._qualityDic = {}

	for slot4, slot5 in pairs(slot0._qualityConfig.configList) do
		table.insert(slot0._qualityDic, {
			co = slot5,
			goodsWeight = GameUtil.splitString2(slot5.goodsWeight, true),
			typeCount = string.split(slot5.typeCount, "|")
		})
	end
end

function slot0.getOrderQualityInfo(slot0, slot1)
	return slot0._qualityDic[slot1]
end

function slot0._initBarrageCo(slot0)
	if not slot0._barrageDic then
		slot0._barrageDic = {}
	end

	if not slot0._barrageTypeCount then
		slot0._barrageTypeCount = {}
	end

	for slot4, slot5 in ipairs(slot0._barrageConfig.configList) do
		if not slot0._barrageDic[slot5.type] then
			slot0._barrageDic[slot6] = {}
		end

		table.insert(slot7, slot5)
	end

	for slot4, slot5 in pairs(RoomTradeEnum.BarrageType) do
		slot0._barrageTypeCount[slot5] = slot0._barrageDic[slot5] and #slot0._barrageDic[slot5]
	end
end

function slot0.getBarrageCosByType(slot0, slot1)
	if not slot0._barrageDic then
		return {}
	end

	return slot0._barrageDic[slot1]
end

function slot0.getBarrageCoByTypeIndex(slot0, slot1, slot2)
	if not slot0._barrageDic or not slot0._barrageDic[slot1] then
		return
	end

	return slot0._barrageDic[slot1][slot2]
end

function slot0.getBarrageTypeCount(slot0, slot1)
	return slot0._barrageTypeCount[slot1] or 0
end

function slot0._initTaskCo(slot0)
	slot0._taskDic = {}
	slot0._taskMaxLevel = 0

	for slot4, slot5 in ipairs(slot0._taskConfig.configList) do
		if not slot0._taskDic[slot5.tradeLevel] then
			slot0._taskDic[slot6] = {}
		end

		slot0._taskMaxLevel = math.max(slot0._taskMaxLevel, slot6)

		table.insert(slot7, slot5)
	end
end

function slot0.getTaskCosByLevel(slot0, slot1)
	return slot0._taskDic[slot1]
end

function slot0.getTaskCoById(slot0, slot1)
	return slot0._taskConfig.configDict[slot1]
end

function slot0.getSupportBonusById(slot0, slot1)
	return slot0._supportBonusConfig.configDict[slot1]
end

function slot0.getSupportBonusConfig(slot0)
	return slot0._supportBonusConfig.configList
end

function slot0.getTaskMaxLevel(slot0)
	return slot0._taskMaxLevel
end

function slot0.getLevelUnlockCo(slot0, slot1)
	return slot0._levelUnlockConfig.configDict[slot1]
end

function slot0.getLevelCo(slot0, slot1)
	return slot0._levelConfig.configDict[slot1]
end

function slot0.getMaxLevel(slot0)
	for slot5, slot6 in ipairs(slot0._levelConfig.configList) do
		slot1 = math.max(0, slot6.level)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
