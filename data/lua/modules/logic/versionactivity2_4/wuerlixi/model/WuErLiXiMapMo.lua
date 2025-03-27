module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapMo", package.seeall)

slot0 = pureTable("WuErLiXiMapMo")

function slot0.ctor(slot0)
	slot0.mapId = 0
	slot0.mapOffset = {}
	slot0.actUnitDict = {}
	slot0.nodeDict = {}
end

function slot0.init(slot0, slot1)
	slot0.mapId = tonumber(slot1[1])
	slot0.mapOffset = slot1[2]
	slot0.actUnitDict = slot0._toActUnits(slot1[3])
	slot0.nodeDict = slot0._toNodes(slot1[5])
	slot0.lineCount = slot0:_getLineCount()
	slot0.rowCount = slot0:_getRowCount()

	slot0:_setNodeUnits(slot1[4])
end

function slot0._toActUnits(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(string.split(slot0, "|")) do
		slot8 = WuErLiXiMapActUnitMo.New()

		slot8:init(slot7)
		table.insert(slot1, slot8)
	end

	return slot1
end

function slot0._toNodes(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		slot7 = WuErLiXiMapNodeMo.New()

		slot7:init(slot6)

		if not slot1[slot7.y] then
			slot1[slot7.y] = {}
		end

		slot1[slot7.y][slot7.x] = slot7
	end

	return slot1
end

function slot0._setNodeUnits(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.nodeDict[slot6[3]][slot6[2]]:setUnit(slot6)

		if slot0.nodeDict[slot6[3]][slot6[2]]:getNodeUnit().unitType == WuErLiXiEnum.UnitType.SignalMulti then
			if slot7.dir == WuErLiXiEnum.Dir.Up or slot7.dir == WuErLiXiEnum.Dir.Down then
				slot0.nodeDict[slot6[3]][slot6[2] - 1]:setUnit(slot6)
				slot0.nodeDict[slot6[3]][slot6[2] + 1]:setUnit(slot6)
			else
				slot0.nodeDict[slot6[3] - 1][slot6[2]]:setUnit(slot6)
				slot0.nodeDict[slot6[3] + 1][slot6[2]]:setUnit(slot6)
			end
		end
	end
end

function slot0._getLineCount(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.nodeDict) do
		if slot1 < slot5 then
			slot1 = slot5 or slot1
		end
	end

	return slot1
end

function slot0._getRowCount(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.nodeDict[1]) do
		if slot1 < slot5 then
			slot1 = slot5 or slot1
		end
	end

	return slot1
end

function slot0.getNodeMo(slot0, slot1, slot2)
	if not slot0.nodeDict[slot1] then
		return
	end

	return slot0.nodeDict[slot1][slot2]
end

return slot0
