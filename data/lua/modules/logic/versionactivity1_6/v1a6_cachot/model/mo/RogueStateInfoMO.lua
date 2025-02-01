module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueStateInfoMO", package.seeall)

slot0 = pureTable("RogueStateInfoMO")

function slot0.init(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.start = slot1.start
	slot0.weekScore = slot1.weekScore
	slot0.totalScore = slot1.totalScore
	slot0.scoreLimit = slot1.scoreLimit
	slot0.stage = slot1.stage
	slot0.nextStageSecond = slot1.nextStageSecond
	slot0.difficulty = slot1.difficulty
	slot0.layer = slot1.layer
	slot0.hasCollections = {}

	for slot5, slot6 in ipairs(slot1.hasCollections) do
		table.insert(slot0.hasCollections, slot6)
	end

	slot0.unlockCollections = {}

	for slot5, slot6 in ipairs(slot1.unlockCollections) do
		table.insert(slot0.unlockCollections, slot6)
	end

	slot0.getRewards = {}

	for slot5, slot6 in ipairs(slot1.getRewards) do
		table.insert(slot0.getRewards, slot6)
	end

	slot0.passDifficulty = {}

	for slot5, slot6 in ipairs(slot1.passDifficulty) do
		table.insert(slot0.passDifficulty, slot6)
	end

	slot0:updateUnlockCollectionsNew(slot1.unlockCollectionsNew)

	slot0.lastGroup = RogueGroupInfoMO.New()

	slot0.lastGroup:init(slot1.lastGroup)

	slot0.lastBackupGroup = RogueGroupInfoMO.New()

	slot0.lastBackupGroup:init(slot1.lastBackupGroup)
end

function slot0.getLastGroupInfo(slot0, slot1)
	tabletool.addValues({}, slot0.lastGroup.heroList)
	tabletool.addValues({}, slot0.lastGroup.equips)

	for slot7, slot8 in ipairs(slot0.lastBackupGroup.heroList) do
		if slot7 <= (slot1 or 0) then
			table.insert(slot2, slot8)
		end
	end

	for slot7, slot8 in ipairs(slot0.lastBackupGroup.equips) do
		if slot7 <= slot1 then
			table.insert(slot3, slot8)
		end
	end

	for slot8, slot9 in ipairs(slot3) do
		slot9.index = slot8 - 1
	end

	return slot2, {
		[slot8 - 1] = slot9
	}
end

function slot0.isStart(slot0)
	return slot0.start
end

function slot0.updateUnlockCollectionsNew(slot0, slot1)
	slot0.unlockCollectionsNew = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.unlockCollectionsNew[slot6] = true
	end
end

return slot0
