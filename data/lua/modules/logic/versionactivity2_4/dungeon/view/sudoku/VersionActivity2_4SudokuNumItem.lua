module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuNumItem", package.seeall)

slot0 = class("VersionActivity2_4SudokuNumItem", ListScrollCellExtend)
slot1 = "#615448"
slot2 = "#22402d"
slot3 = "#a86363"
slot4 = "#991d1d"
slot5 = typeof(UnityEngine.Animation)

function slot0.onInitView(slot0)
	slot0._numText = gohelper.findChildText(slot0.viewGO, "#txt_Num")
	slot0._btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "clickArea")
	slot0._go_UnFilledBG = gohelper.findChild(slot0.viewGO, "#go_UnFilledBG")
	slot0._go_Same = gohelper.findChild(slot0.viewGO, "#go_Same")
	slot0._go_WrongCircle = gohelper.findChild(slot0.viewGO, "#go_WrongCircle")
	slot0._go_WrongBG = gohelper.findChild(slot0.viewGO, "#go_WrongBG")
	slot0._go_CorrectBG = gohelper.findChild(slot0.viewGO, "#go_CorrectBG")
	slot0._wrongBGAnim = slot0._go_WrongBG:GetComponent(uv0)
	slot0._correctAnim = slot0._go_CorrectBG:GetComponent(uv0)
	slot0._sameAnim = slot0._go_Same:GetComponent(uv0)

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
	VersionActivity2_4SudokuModel.instance:selectItem(slot0._idx)
	VersionActivity2_4SudokuController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuSelectItem, slot0._idx)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._go_Same, false)
	gohelper.setActive(slot0._go_WrongCircle, false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.setItemData(slot0, slot1, slot2, slot3, slot4)
	slot0._num = slot1
	slot0._idx = slot2
	slot0._cellIdx = slot3
	slot0._groupIdx = slot4
	slot0._editable = not slot0._num or slot0._num == 0

	slot0:refreshUI()
	gohelper.setActive(slot0._go_UnFilledBG, not slot0._num or slot0._num == 0)
end

function slot0.setItemVaild(slot0, slot1)
	slot0._valid = slot1
end

function slot0.setItemNum(slot0, slot1)
	slot0._num = slot1
end

function slot0.getItemNum(slot0)
	return slot0._num
end

function slot0.getItemIdx(slot0)
	return slot0._idx
end

function slot0.isEditable(slot0)
	return slot0._editable
end

function slot0.refreshUI(slot0)
	slot0._numText.text = slot0._num
end

function slot0.refreshSelectView(slot0, slot1)
	gohelper.setActive(slot0._go_WrongCircle, slot1)

	slot3 = uv2

	SLFramework.UGUI.GuiHelper.SetColor(slot0._numText, slot0._editable and (slot0._valid and uv3 or (slot0._editable and uv0 or uv1)) or uv2)

	if not slot0._editable then
		gohelper.setActive(slot0._go_CorrectBG, false)
		gohelper.setActive(slot0._go_UnFilledBG, false)
	elseif slot0._num == 0 or slot0._valid then
		gohelper.setActive(slot0._go_CorrectBG, slot1)
		gohelper.setActive(slot0._go_UnFilledBG, not slot1)
	else
		gohelper.setActive(slot0._go_CorrectBG, false)
		gohelper.setActive(slot0._go_UnFilledBG, false)
	end
end

function slot0.refreshValidView(slot0, slot1, slot2, slot3)
	slot0._wrongBGAnim.enabled = not slot3
	slot0._correctAnim.enabled = not slot3

	gohelper.setActive(slot0._go_CorrectBG, slot1 and slot2)
	gohelper.setActive(slot0._go_WrongBG, not slot1 and slot2)
	gohelper.setActive(slot0._go_UnFilledBG, slot0._editable and not slot2)

	slot5 = uv2

	SLFramework.UGUI.GuiHelper.SetColor(slot0._numText, slot0._editable and (slot1 and uv3 or (slot0._editable and uv0 or uv1)) or uv2)
end

function slot0.refreshSameNumView(slot0, slot1, slot2)
	gohelper.setActive(slot0._go_Same, slot1)

	slot0._sameAnim.enabled = not slot2
end

function slot0.refreshGuideView(slot0, slot1)
	gohelper.setActive(slot0._go_UnFilledBG, slot0._editable and not slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
