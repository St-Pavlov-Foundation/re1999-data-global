module("modules.logic.versionactivity1_4.puzzle.view.PuzzleRecordItem", package.seeall)

slot0 = class("PuzzleRecordItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtRecord = gohelper.findChildText(slot1, "")
	slot0._txtRecordNum = gohelper.findChildTextMesh(slot1, "txt_RecordNum")
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._txtRecordNum.text = slot1:GetIndex()
	slot0._txtRecord.text = slot1:GetRecord()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
