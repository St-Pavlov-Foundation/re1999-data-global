module("modules.logic.rouge.model.RougeGameRecordInfoMO", package.seeall)

slot0 = pureTable("RougeGameRecordInfoMO")

function slot0.init(slot0, slot1)
	slot0.maxDifficulty = slot1.maxDifficulty
	slot0.passEndIdMap = slot0:_listToMap(slot1.passEndId)
	slot0.passLayerIdMap = slot0:_listToMap(slot1.passLayerId)
	slot0.passEventIdMap = slot0:_listToMap(slot1.passEventId)
	slot0.passEndIdMap = slot0:_listToMap(slot1.passEndId)
	slot0.passEntrustMap = slot0:_listToMap(slot1.passEntrustId)
	slot0.lastGameTime = math.ceil((tonumber(slot1.lastGameTime) or 0) / 1000)
	slot0.passCollections = slot0:_listToMap(slot1.passCollections)
	slot0.unlockStoryIds = slot0:_listToMap(slot1.unlockStoryIds)

	slot0:_updateVersionIds(slot1.dlcVersionIds)

	slot0.unlockSkillMap = GameUtil.rpcInfosToMap(slot1.unlockSkills, RougeUnlockSkillMO, "type")
end

function slot0._listToMap(slot0, slot1)
	if not slot1 then
		return {}
	end

	for slot6, slot7 in ipairs(slot1) do
		-- Nothing
	end

	return {
		[slot7] = slot7
	}
end

function slot0.collectionIsPass(slot0, slot1)
	return slot0.passCollections[slot1]
end

function slot0.storyIsPass(slot0, slot1)
	return slot0.unlockStoryIds[slot1]
end

function slot0.passedLayerId(slot0, slot1)
	return slot0.passLayerIdMap and slot0.passLayerIdMap[slot1]
end

function slot0.passedEventId(slot0, slot1)
	return slot0.passEventIdMap and slot0.passEventIdMap[slot1]
end

function slot0.passAnyOneEnd(slot0)
	return tabletool.len(slot0.passEndIdMap) > 0
end

function slot0.passEndId(slot0, slot1)
	return slot0.passEndIdMap and slot0.passEndIdMap[slot1]
end

function slot0.passEntrustId(slot0, slot1)
	return slot0.passEntrustMap and slot0.passEntrustMap[slot1]
end

function slot0.passLayerId(slot0, slot1)
	return slot0.passLayerIdMap and slot0.passLayerIdMap[slot1]
end

function slot0.lastGameEndTimestamp(slot0)
	return slot0.lastGameTime
end

function slot0.isSelectDLC(slot0, slot1)
	return slot0.versionIds and slot0.versionIds[slot1] ~= nil
end

function slot0._updateVersionIds(slot0, slot1)
	slot0.versionIds = slot0:_listToMap(slot1)
end

function slot0.getVersionIds(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.versionIds) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot0.isSkillUnlock(slot0, slot1, slot2)
	slot3 = slot0.unlockSkillMap and slot0.unlockSkillMap[slot1]

	return slot3 and slot3:isSkillUnlock(slot2)
end

function slot0.updateSkillUnlockInfo(slot0, slot1, slot2)
	if not slot1 and slot2 then
		return
	end

	if not (slot0.unlockSkillMap and slot0.unlockSkillMap[slot1]) then
		slot3 = RougeUnlockSkillMO.New()

		slot3:init({
			type = slot1,
			ids = {}
		})

		slot0.unlockSkillMap[slot1] = slot3
	end

	slot3:onNewSkillUnlock(slot2)
end

return slot0
