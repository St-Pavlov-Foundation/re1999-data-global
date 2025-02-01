module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordListModel", package.seeall)

slot0 = class("PuzzleRecordListModel", ListScrollModel)

function slot0.init(slot0)
	slot0:setList({})
end

function slot0.setRecordList(slot0, slot1)
	slot0:clear()

	for slot5, slot6 in ipairs(slot1) do
		if slot5 < 10 then
			slot7 = "0" .. slot7
		end

		slot8 = PuzzleRecordMO.New()

		slot8:init(slot7, slot6)
		slot0:addAtLast(slot8)
	end

	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RecordCntChange, slot0:getCount())
end

function slot0.clearRecord(slot0)
	slot0:clear()
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RecordCntChange, slot0:getCount())
end

slot0.instance = slot0.New()

return slot0
