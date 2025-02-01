module("modules.logic.versionactivity1_3.armpipe.model.ArmPuzzlePipeMO", package.seeall)

slot0 = pureTable("ArmPuzzlePipeMO")

function slot0.init(slot0, slot1, slot2)
	slot0.x = slot1
	slot0.y = slot2
	slot0.typeId = 0
	slot0.value = 0
	slot0.pathIndex = 0
	slot0.pathType = 0
	slot0.numIndex = 0
	slot0.connectSet = {}
	slot0.entryConnect = {}
	slot0.entryCount = 0
	slot0.connectPathIndex = 0
end

slot1 = {}

function slot0.getConnectValue(slot0)
	slot1 = 0
	slot2 = 0

	if slot0.entryConnect then
		for slot6, slot7 in pairs(slot0.entryConnect) do
			table.insert(uv0, slot6)

			slot1 = slot1 + 1
		end

		table.sort(uv0)

		for slot6, slot7 in ipairs(uv0) do
			slot2 = slot2 * 10 + slot7
		end

		for slot6 = 1, slot1 do
			uv0[slot6] = nil
		end
	end

	return slot2
end

function slot0.getBackgroundRes(slot0)
	return ArmPuzzleHelper.getBackgroundRes(slot0.typeId)
end

function slot0.getConnectRes(slot0)
	return ArmPuzzleHelper.getConnectRes(slot0.typeId)
end

function slot0.getRotation(slot0)
	return ArmPuzzleHelper.getRotation(slot0.typeId, slot0.value)
end

function slot0.cleanEntrySet(slot0)
	for slot4, slot5 in pairs(slot0.entryConnect) do
		slot0.entryConnect[slot4] = nil
	end

	slot0.entryCount = 0
	slot0.connectPathIndex = 0
end

function slot0.getEntryCount(slot0, slot1, slot2)
end

function slot0.isEntry(slot0)
	return ArmPuzzlePipeEnum.entry[slot0.typeId]
end

function slot0.setParamStr(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#") or {}
	slot0.typeId = slot2[1] or 0
	slot0.value = slot2[2] or 0
	slot0.pathIndex = slot2[3] or 0
	slot0.pathType = slot2[4] or 0
	slot0.numIndex = slot2[5] or 0
end

function slot0.getParamStr(slot0)
	return string.format("%s#%s#%s#%s#%s", slot0.typeId, slot0.value, slot0.pathIndex, slot0.pathType, slot0.numIndex)
end

return slot0
