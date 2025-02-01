module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameTileMO", package.seeall)

slot0 = pureTable("Va3ChessGameTileMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1 or slot0.id or 1
	slot0.tileType = 0
	slot0.triggerTypeList = {}
	slot0.finishList = {}
	slot0.triggerStatusDict = {}
end

function slot0.addTrigger(slot0, slot1)
	if slot1 and slot1 > 0 and tabletool.indexOf(slot0.triggerTypeList, slot1) == nil then
		table.insert(slot0.triggerTypeList, slot1)
	end
end

function slot0.updateTrigger(slot0, slot1, slot2)
	if slot0.triggerStatusDict[slot1] ~= slot2 then
		slot0.triggerStatusDict[slot1] = slot2
	end
end

function slot0.getTriggerBrokenStatus(slot0)
	return slot0:getTriggerStatus(Va3ChessEnum.TileTrigger.Broken) or Va3ChessEnum.TriggerStatus[Va3ChessEnum.TileTrigger.Broken].Normal
end

function slot0.getTriggerStatus(slot0, slot1)
	if slot0.triggerStatusDict then
		return slot0.triggerStatusDict[slot1]
	end
end

function slot0.removeTrigger(slot0, slot1)
	tabletool.removeValue(slot0.triggerTypeList, slot1)
end

function slot0.isHasTrigger(slot0, slot1)
	if tabletool.indexOf(slot0.triggerTypeList, slot1) then
		return true
	end

	return false
end

function slot0.addFinishTrigger(slot0, slot1)
	if tabletool.indexOf(slot0.finishList, slot1) == nil then
		table.insert(slot0.finishList, slot1)
	end
end

function slot0.isFinishTrigger(slot0, slot1)
	slot2 = false

	if tabletool.indexOf(slot0.finishList, slot1) then
		slot2 = true
	end

	slot3 = Va3ChessEnum.TileTrigger.Broken

	if slot0:isHasTrigger(slot1) and slot1 == slot3 then
		slot2 = slot2 or slot0:getTriggerBrokenStatus() == Va3ChessEnum.TriggerStatus[slot3].Broken
	end

	return slot2
end

function slot0.resetFinish(slot0)
	if #slot0.finishList > 0 then
		slot0.finishList = {}
	end
end

function slot0.setParamStr(slot0, slot1)
	if string.find(slot1, "|") then
		slot3 = string.split(slot1, "|") or {}
		slot1 = slot3[1]
		slot0.baffleTypeData = slot3[2]
	end

	slot3 = string.splitToNumber(slot1, "#") or {}
	slot4 = slot3[1] or 0
	slot0.originalTileType = slot4
	slot0.tileType = slot4 > 0 and Va3ChessEnum.TileBaseType.Normal or Va3ChessEnum.TileBaseType.None
	slot0.triggerTypeList = {}

	if slot3 and #slot3 > 1 then
		for slot8 = 2, #slot3 do
			table.insert(slot0.triggerTypeList, slot3[slot8])
		end
	end

	slot0:resetFinish()
end

function slot0.getBaffleDataList(slot0)
	return Activity142Helper.getBaffleDataList(slot0.originalTileType, slot0.baffleTypeData)
end

function slot0.getOriginalTileType(slot0)
	return slot0.originalTileType
end

function slot0.isHasBaffleInDir(slot0, slot1)
	slot2 = false

	return Activity142Helper.isHasBaffleInDir(slot0.originalTileType, slot1)
end

function slot0.getParamStr(slot0)
	slot1 = tostring(slot0.tileType)

	if slot0.triggerTypeList then
		for slot5 = 1, #slot0.triggerTypeList do
			slot1 = string.format("%s#%s", slot1, slot0.triggerTypeList[slot5])
		end
	end

	return slot1
end

return slot0
