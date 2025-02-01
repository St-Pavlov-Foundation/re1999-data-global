module("modules.logic.versionactivity1_4.puzzle.view.PuzzleRecordViewItem", package.seeall)

slot0 = class("PuzzleRecordViewItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.txtRecord = gohelper.findChildText(slot0.viewGO, "")
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.txtRecord.text = slot1:GetIndex() .. "." .. slot1:GetRecord()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
