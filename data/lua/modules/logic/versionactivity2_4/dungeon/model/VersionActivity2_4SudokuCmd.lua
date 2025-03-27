module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuCmd", package.seeall)

slot0 = class("VersionActivity2_4SudokuCmd")

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0._idx = slot1
	slot0._oriNum = slot2
	slot0._newNum = slot3
	slot0._undo = false
end

function slot0.getIdx(slot0)
	return slot0._idx
end

function slot0.getOriNum(slot0)
	return slot0._oriNum
end

function slot0.getNewNum(slot0)
	return slot0._newNum
end

function slot0.isUndo(slot0)
	return slot0._undo
end

function slot0.undo(slot0)
	slot0._oriNum = slot0._newNum
	slot0._newNum = slot0._oriNum
	slot0._undo = true
end

return slot0
