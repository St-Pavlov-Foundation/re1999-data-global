module("modules.logic.versionactivity1_7.lantern.model.LanternFestivalPuzzleMo", package.seeall)

slot0 = pureTable("LanternFestivalPuzzleMo")

function slot0.ctor(slot0)
	slot0.puzzleId = 0
	slot0.state = 0
	slot0.answerRecords = {}
end

function slot0.init(slot0, slot1)
	slot0.puzzleId = slot1.puzzleId
	slot0.state = slot1.state
	slot0.answerRecords = {}

	for slot5, slot6 in ipairs(slot1.answerRecords) do
		table.insert(slot0.answerRecords, slot6)
	end
end

function slot0.reset(slot0, slot1)
	slot0.puzzleId = slot1.puzzleId
	slot0.state = slot1.state
	slot0.answerRecords = {}

	for slot5, slot6 in ipairs(slot1.answerRecords) do
		table.insert(slot0.answerRecords, slot6)
	end
end

return slot0
