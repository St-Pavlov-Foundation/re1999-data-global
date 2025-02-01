module("modules.logic.room.model.map.RoomProductionLineMO", package.seeall)

slot0 = pureTable("RoomProductionLineMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.config = RoomConfig.instance:getProductionLineConfig(slot0.id)
	slot0.finishCount = 0
	slot0.reserve = slot0.config.reserve
	slot0.useReserve = 0
	slot0.level = 0

	if slot0.config.levelGroup > 0 then
		slot0.levelGroupCO = RoomConfig.instance:getProductionLineLevelGroupIdConfig(slot0.config.levelGroup)
	end

	slot0:updateMaxLevel()
end

function slot0.updateMaxLevel(slot0)
	slot1 = RoomModel.instance:getRoomLevel()
	slot0.maxLevel = 0
	slot0.maxConfigLevel = 0

	if slot0.config.levelGroup > 0 and slot0.levelGroupCO then
		for slot5, slot6 in ipairs(slot0.levelGroupCO) do
			if slot6.needRoomLevel <= slot1 then
				slot0.maxLevel = math.max(slot6.id, slot0.maxLevel)
			end

			slot0.maxConfigLevel = math.max(slot6.id, slot0.maxConfigLevel)
		end
	end
end

function slot0.updateInfo(slot0, slot1)
	slot0.formulaId = slot1.formulaId
	slot0.finishCount = slot1.finishCount or 0
	slot0.nextFinishTime = slot1.nextFinishTime
	slot0.pauseTime = slot1.pauseTime
	slot0.reserve = slot0.config.reserve
	slot0.useReserve = 0

	slot0:updateLevel(slot1.level or 1)
end

function slot0.updateLevel(slot0, slot1)
	slot0.level = slot1

	if slot0.config.levelGroup > 0 then
		slot0.levelCO = RoomConfig.instance:getProductionLineLevelConfig(slot0.config.levelGroup, slot0.level)
		slot3 = 0

		if GameUtil.splitString2(slot0.levelCO.effect, true) then
			for slot7, slot8 in ipairs(slot2) do
				if slot8[1] == RoomBuildingEnum.EffectType.Reserve then
					slot0.reserve = slot0.reserve + slot8[2]
				elseif slot8[1] == RoomBuildingEnum.EffectType.Time then
					slot3 = slot3 + slot8[2]
				end
			end
		end

		slot0.formulaCO = RoomConfig.instance:getFormulaConfig(slot0.formulaId)

		if not slot0.formulaCO then
			return
		end

		slot0.useReserve = slot0.formulaCO.costReserve * slot0.finishCount
		slot0.costTime = math.floor(slot0.formulaCO.costTime * math.max(0, 1000 - slot3) / 1000)
		slot0.produceSpeed = string.splitToNumber(slot0.formulaCO.produce, "#")[3]
		slot0.allFinishTime = slot0.nextFinishTime

		if slot0.reserve - (slot0.useReserve + slot0.formulaCO.costReserve) > 0 then
			slot0.allFinishTime = slot0.allFinishTime + math.ceil(slot7 / slot0.formulaCO.costReserve) * slot0.costTime
		elseif slot7 < 0 then
			slot0.allFinishTime = 0
		end
	end
end

function slot0.isCanGain(slot0)
	return slot0.useReserve > 0
end

function slot0.isLock(slot0)
	return slot0.level == 0
end

function slot0.isRoomLevelUnLockNext(slot0)
	return slot0.config.needRoomLevel == RoomModel.instance:getRoomLevel() + 1
end

function slot0.isPause(slot0)
	return slot0.pauseTime and slot0.pauseTime > 0
end

function slot0.getReservePer(slot0)
	slot2 = 0

	if math.min(1, slot0.useReserve / slot0.reserve) ~= 0 then
		slot2 = math.max(1, math.floor(slot1 * 100))
	end

	return slot1, slot2
end

function slot0.isFull(slot0)
	return slot0.reserve <= slot0.useReserve
end

function slot0.isIdle(slot0)
	return not slot0.formulaId or slot0.formulaId <= 0
end

function slot0.getGathericon(slot0)
	if RoomProductionHelper.getFormulaProduceItem(slot0.formulaId) then
		slot3 = nil

		return (slot2.type ~= MaterialEnum.MaterialType.Currency or ResUrl.getCurrencyItemIcon(CurrencyConfig.instance:getCurrencyCo(slot2.id).icon .. "_room")) and ResUrl.getCurrencyItemIcon(slot2.id .. "_room")
	end
end

return slot0
