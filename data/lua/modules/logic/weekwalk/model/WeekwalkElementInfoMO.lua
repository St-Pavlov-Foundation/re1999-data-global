module("modules.logic.weekwalk.model.WeekwalkElementInfoMO", package.seeall)

slot0 = pureTable("WeekwalkElementInfoMO")

function slot0.init(slot0, slot1)
	slot0.elementId = slot1.elementId
	slot0.isFinish = slot1.isFinish
	slot0.index = slot1.index
	slot0.historylist = slot1.historylist
	slot0.visible = slot1.visible
	slot0.config = WeekWalkConfig.instance:getElementConfig(slot0.elementId)

	if not slot0.config then
		logError(string.format("WeekwalkElementInfoMO no config id:%s", slot0.elementId))

		return
	end

	slot0.typeList = string.splitToNumber(slot0.config.type, "#")
	slot0.paramList = string.split(slot0.config.param, "|")
end

function slot0.getRes(slot0)
	if WeekWalkEnum.FirstDeepLayer <= slot0._mapInfo:getLayer() and slot0.config.roundId ~= 0 then
		slot2 = slot0._mapInfo:getMapConfig()

		if (slot0.config.roundId == WeekWalkEnum.OneDeepLayerFirstBattle and slot2.resIdFront or slot2.resIdRear) > 0 and lua_weekwalk_element_res.configDict[slot3] then
			return slot4.res
		end
	end

	return slot0.config.res
end

function slot0.setMapInfo(slot0, slot1)
	slot0._mapInfo = slot1
end

function slot0.isAvailable(slot0)
	return not slot0.isFinish and slot0.visible
end

function slot0.updateHistoryList(slot0, slot1)
	slot0.historylist = slot1
end

function slot0.getType(slot0)
	return slot0.typeList[slot0.index + 1]
end

function slot0.getNextType(slot0)
	return slot0.typeList[slot0.index + 2]
end

function slot0.getParam(slot0)
	return slot0.paramList[slot0.index + 1]
end

function slot0.getPrevParam(slot0)
	return slot0.paramList[slot0.index]
end

function slot0.getBattleId(slot0)
	return slot0:_getBattleId()
end

function slot0._getBattleId(slot0)
	if WeekWalkEnum.FirstDeepLayer <= slot0._mapInfo:getLayer() and slot0.config.roundId ~= 0 then
		slot2 = slot0._mapInfo:getMapConfig()

		if slot0:_checkBattleId(slot0.config.roundId == WeekWalkEnum.OneDeepLayerFirstBattle and slot2.fightIdFront or slot2.fightIdRear, true) then
			return slot3
		end
	end

	return tonumber(slot0:getParam())
end

function slot0._checkBattleId(slot0, slot1, slot2)
	if slot1 and slot1 > 0 then
		if not slot0._mapInfo:getBattleInfo(slot1) then
			logError(string.format("WeekwalkElementInfoMO no battleInfo mapId:%s elementId:%s battleId:%s isFromMap:%s", slot0._mapInfo.id, slot0.elementId, slot1, slot2))

			return false
		end

		return true
	end
end

function slot0.getConfigBattleId(slot0)
	for slot4, slot5 in ipairs(slot0.typeList) do
		if slot5 == WeekWalkEnum.ElementType.Battle then
			return tonumber(slot0.paramList[slot4])
		end
	end
end

function slot0._isBattleElement(slot0)
	for slot4, slot5 in ipairs(slot0.typeList) do
		if slot5 == WeekWalkEnum.ElementType.Battle then
			return true
		end
	end
end

return slot0
