module("modules.logic.room.model.map.path.RoomMapVehicleMO", package.seeall)

slot0 = pureTable("RoomMapVehicleMO")

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1
	slot0.vehicleId = slot3
	slot0.resourceId = slot2.resourceId
	slot0.resId = slot2.resourceId
	slot0.pathPlanMO = slot2
	slot0.config = RoomConfig.instance:getVehicleConfig(slot3)
	slot0._areaNodeList = {}
	slot0._initAreaNodeList = {}

	tabletool.addValues(slot0._initAreaNodeList, slot4)

	slot0.startMO = slot0._initAreaNodeList[1] or slot0:_findMaxNodeNum(slot2:getNodeList())
	slot0.curPathNodeMO = slot0.startMO
	slot0.enterDirection = 4
	slot0.moveOffsetDirs = {
		3,
		4,
		2,
		5,
		1,
		0
	}
	slot0.mapHexPointDic = slot0:_getHexPiontDic(slot2:getNodeList())
	slot0._areaNodeNum = math.max(1, #slot0._initAreaNodeList)
	slot0._recentHistoryNum = 10
	slot0._recentHistory = {}
	slot0.vehicleType = 0
	slot0.ownerType = 0
	slot0.owerId = 0
	slot0._replaceType = RoomVehicleEnum.ReplaceType.None

	if not slot0.config then
		logError(string.format("找不到交通工具配置,id:%s ", slot0.vehicleId))
	end

	if #slot0._initAreaNodeList > 1 then
		for slot8 = #slot0._initAreaNodeList, 1, -1 do
			slot0:moveToNode(slot0._initAreaNodeList[slot8], slot0.enterDirection)
		end
	else
		slot0:moveToNode(slot0.startMO, slot0.enterDirection)
	end
end

function slot0.setReplaceType(slot0, slot1)
	if slot0.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		slot0._replaceType = slot1
	else
		slot0._replaceType = RoomVehicleEnum.ReplaceType.None
	end
end

function slot0.getReplaceDefideCfg(slot0)
	if slot0.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		slot0:_initReplaceDefideCfg()

		return slot0._replacConfigMap[slot0._replaceType] or slot0.config
	end

	return slot0.config
end

function slot0._initReplaceDefideCfg(slot0)
	if slot0._replacConfigMap and slot0._lasetDefideId == slot0.vehicleId then
		return
	end

	slot0._replacConfigMap = {}

	if not slot0.config or string.nilorempty(slot0.config.replaceConditionStr) then
		return
	end

	for slot5, slot6 in ipairs(GameUtil.splitString2(slot0.config.replaceConditionStr, true)) do
		if slot6 and #slot6 > 1 and RoomConfig.instance:getVehicleConfig(slot6[2]) then
			slot0._replacConfigMap[slot6[1]] = slot7
		end
	end
end

function slot0._findSideNode(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6:isSideNode() then
			return slot6
		end
	end

	return slot1[1]
end

function slot0._findMaxNodeNum(slot0, slot1)
	slot2, slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		if not slot8.hasBuilding and (slot2 == nil or slot2.connectNodeNum < slot8.connectNodeNum) then
			slot2 = slot8
		end

		if slot8:isSideNode() and (slot3 == nil or slot3.connectNodeNum < slot8.connectNodeNum) then
			slot3 = slot8
		end
	end

	return slot2 or slot3 or slot1[1]
end

function slot0._getHexPiontDic(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot2[slot7.hexPoint.x] == nil then
			slot2[slot7.hexPoint.x] = {}
		end

		slot8[slot7.hexPoint.y] = 0
	end

	return slot2
end

function slot0.resetHistory(slot0)
	for slot5, slot6 in pairs(slot0.mapHexPointDic) do
		for slot10, slot11 in pairs(slot6) do
			slot6[slot10] = 0
		end
	end
end

function slot0.getHistoryCount(slot0, slot1, slot2)
	return slot0.mapHexPointDic[slot1] and slot0.mapHexPointDic[slot1][slot2] or 0
end

function slot0.setHistoryCount(slot0, slot1, slot2, slot3)
	if not slot0.mapHexPointDic[slot1] then
		slot0.mapHexPointDic[slot1] = {}
	end

	slot0.mapHexPointDic[slot1][slot2] = slot3
end

function slot0._isNextStar(slot0)
	if slot0.curPathNodeMO.hexPoint == slot0.startMO.hexPoint and slot0:getHistoryCount(slot1.hexPoint.x, slot1.hexPoint.y) >= 5 then
		return true
	end

	slot2 = false

	for slot6 = 1, 6 do
		if slot1:getConnctNode(slot6) and slot0:getHistoryCount(slot7.hexPoint.x, slot7.hexPoint.y) >= 5 then
			slot2 = true
		end
	end

	return slot2
end

function slot0.getCurNode(slot0)
	return slot0.curPathNodeMO
end

function slot0.findNextWeightNode(slot0)
	slot1 = slot0.curPathNodeMO
	slot2 = slot0.enterDirection or 4
	slot5 = slot2
	slot6 = slot2

	for slot11 = 1, #slot0.moveOffsetDirs do
		if slot1:getConnctNode((slot2 + slot0.moveOffsetDirs[slot11] - 1) % 6 + 1) then
			slot7 = 0 + 1

			if 0 < slot0:_getWeight(slot13, slot11) or nil == nil then
				slot3 = slot13
				slot4 = slot14
				slot6 = slot12
				slot5 = slot1:getConnectDirection(slot12)
			end
		end
	end

	return slot3 or slot1, slot5, slot6
end

function slot0.moveToNode(slot0, slot1, slot2, slot3)
	if slot1 then
		if slot1:isEndNode() then
			slot4 = slot0:getHistoryCount(slot1.hexPoint.x, slot1.hexPoint.y) + 1 + 1
		end

		slot0:setHistoryCount(slot1.hexPoint.x, slot1.hexPoint.y, slot4)

		if slot3 ~= true then
			slot0.enterDirection = slot2
			slot0.curPathNodeMO = slot1

			slot0:_addAreaNode(slot1)
		end

		slot0:_addRecentHistory(slot1.id)
	end

	return slot0.curPathNodeMO
end

function slot0._getWeight(slot0, slot1, slot2)
	if slot1:isSideNode() then
		slot3 = (7 - slot2) * 30 - slot0:getHistoryCount(slot1.hexPoint.x, slot1.hexPoint.y) * 200 + 1000
	end

	if slot0:_getRecentHistoryIndexOf(slot1.id) then
		slot3 = slot3 - slot5 * 1000
	end

	return slot3
end

function slot0._addRecentHistory(slot0, slot1)
	table.insert(slot0._recentHistory, slot1)

	if slot0._recentHistoryNum < #slot0._recentHistory then
		table.remove(slot0._recentHistory, 1)
	end
end

function slot0._getRecentHistoryIndexOf(slot0, slot1)
	for slot5 = #slot0._recentHistory, 1, -1 do
		if slot0._recentHistory[slot5] == slot1 then
			return slot5
		end
	end
end

function slot0.findEndDir(slot0, slot1, slot2)
	if not slot1 then
		return slot2
	end

	for slot6 = 1, #slot0.moveOffsetDirs do
		if tabletool.indexOf(slot1.directionList, (slot2 + slot0.moveOffsetDirs[slot6] - 1) % 6 + 1) then
			return slot7
		end
	end

	return slot2
end

function slot0._addAreaNode(slot0, slot1)
	table.insert(slot0._areaNodeList, 1, slot1)

	while slot0._areaNodeNum < #slot0._areaNodeList do
		table.remove(slot0._areaNodeList, #slot0._areaNodeList)
	end
end

function slot0.getAreaNode(slot0)
	return slot0._areaNodeList
end

function slot0.getInitAreaNode(slot0)
	return slot0._initAreaNodeList
end

return slot0
