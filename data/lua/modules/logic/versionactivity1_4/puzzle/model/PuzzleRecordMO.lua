module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordMO", package.seeall)

slot0 = pureTable("PuzzleRecordMO")

function slot0.init(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.desc = slot2
end

function slot0.GetIndex(slot0)
	return slot0.index
end

function slot0.GetRecord(slot0)
	return slot0.desc
end

return slot0
