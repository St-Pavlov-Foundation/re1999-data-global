module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuKeyboardItem", package.seeall)

slot0 = class("VersionActivity2_4SudokuKeyboardItem", ListScrollCellExtend)
slot1 = typeof(UnityEngine.Animation)

function slot0.onInitView(slot0)
	slot0._numText = gohelper.findChildText(slot0.viewGO, "#txt_Num")
	slot0._btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "clickArea")
	slot0._go_CorrectBG = gohelper.findChild(slot0.viewGO, "#go_CorrectBG")
	slot0._go_UnFilledBG = gohelper.findChild(slot0.viewGO, "#go_UnFilledBG")
	slot0._go_Same = gohelper.findChild(slot0.viewGO, "#go_Same")
	slot0._go_WrongBG = gohelper.findChild(slot0.viewGO, "#go_WrongBG")
	slot0._go_WrongCircle = gohelper.findChild(slot0.viewGO, "#go_WrongCircle")
	slot0._wrongBGAnim = slot0._go_WrongBG:GetComponent(uv0)
	slot0._correctAnim = slot0._go_CorrectBG:GetComponent(uv0)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0._clickItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0._clickItem(slot0)
	VersionActivity2_4SudokuController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuSelectKeyboard, slot0._idx)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._go_Same, false)
	gohelper.setActive(slot0._go_CorrectBG, false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.setItemData(slot0, slot1, slot2)
	slot0._num = slot1
	slot0._idx = slot2

	slot0:refreshUI()
end

function slot0.getItemNum(slot0)
	return slot0._num
end

function slot0.refreshUI(slot0)
	slot0._numText.text = slot0._num
end

function slot0.refreshValidView(slot0, slot1, slot2)
	slot0._wrongBGAnim.enabled = not slot2
	slot0._correctAnim.enabled = not slot2

	if slot1 then
		gohelper.setActive(slot0._go_WrongBG, false)
		gohelper.setActive(slot0._go_CorrectBG, true)
	else
		gohelper.setActive(slot0._go_WrongBG, true)
		gohelper.setActive(slot0._go_CorrectBG, false)
	end
end

function slot0.resetState(slot0)
	gohelper.setActive(slot0._go_WrongBG, false)
	gohelper.setActive(slot0._go_CorrectBG, false)
end

function slot0.onDestroyView(slot0)
end

return slot0
