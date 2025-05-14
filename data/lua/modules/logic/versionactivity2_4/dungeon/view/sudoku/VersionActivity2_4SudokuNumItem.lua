module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuNumItem", package.seeall)

local var_0_0 = class("VersionActivity2_4SudokuNumItem", ListScrollCellExtend)
local var_0_1 = "#615448"
local var_0_2 = "#22402d"
local var_0_3 = "#a86363"
local var_0_4 = "#991d1d"
local var_0_5 = typeof(UnityEngine.Animation)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._numText = gohelper.findChildText(arg_1_0.viewGO, "#txt_Num")
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "clickArea")
	arg_1_0._go_UnFilledBG = gohelper.findChild(arg_1_0.viewGO, "#go_UnFilledBG")
	arg_1_0._go_Same = gohelper.findChild(arg_1_0.viewGO, "#go_Same")
	arg_1_0._go_WrongCircle = gohelper.findChild(arg_1_0.viewGO, "#go_WrongCircle")
	arg_1_0._go_WrongBG = gohelper.findChild(arg_1_0.viewGO, "#go_WrongBG")
	arg_1_0._go_CorrectBG = gohelper.findChild(arg_1_0.viewGO, "#go_CorrectBG")
	arg_1_0._wrongBGAnim = arg_1_0._go_WrongBG:GetComponent(var_0_5)
	arg_1_0._correctAnim = arg_1_0._go_CorrectBG:GetComponent(var_0_5)
	arg_1_0._sameAnim = arg_1_0._go_Same:GetComponent(var_0_5)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._clickItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0._clickItem(arg_4_0)
	VersionActivity2_4SudokuModel.instance:selectItem(arg_4_0._idx)
	VersionActivity2_4SudokuController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuSelectItem, arg_4_0._idx)
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._go_Same, false)
	gohelper.setActive(arg_5_0._go_WrongCircle, false)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.setItemData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0._num = arg_8_1
	arg_8_0._idx = arg_8_2
	arg_8_0._cellIdx = arg_8_3
	arg_8_0._groupIdx = arg_8_4
	arg_8_0._editable = not arg_8_0._num or arg_8_0._num == 0

	arg_8_0:refreshUI()
	gohelper.setActive(arg_8_0._go_UnFilledBG, not arg_8_0._num or arg_8_0._num == 0)
end

function var_0_0.setItemVaild(arg_9_0, arg_9_1)
	arg_9_0._valid = arg_9_1
end

function var_0_0.setItemNum(arg_10_0, arg_10_1)
	arg_10_0._num = arg_10_1
end

function var_0_0.getItemNum(arg_11_0)
	return arg_11_0._num
end

function var_0_0.getItemIdx(arg_12_0)
	return arg_12_0._idx
end

function var_0_0.isEditable(arg_13_0)
	return arg_13_0._editable
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0._numText.text = arg_14_0._num
end

function var_0_0.refreshSelectView(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._go_WrongCircle, arg_15_1)

	local var_15_0 = arg_15_0._editable and var_0_4 or var_0_3
	local var_15_1 = var_0_1

	if arg_15_0._editable then
		var_15_1 = arg_15_0._valid and var_0_2 or var_15_0
	else
		var_15_1 = var_0_1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._numText, var_15_1)

	if not arg_15_0._editable then
		gohelper.setActive(arg_15_0._go_CorrectBG, false)
		gohelper.setActive(arg_15_0._go_UnFilledBG, false)
	elseif arg_15_0._num == 0 or arg_15_0._valid then
		gohelper.setActive(arg_15_0._go_CorrectBG, arg_15_1)
		gohelper.setActive(arg_15_0._go_UnFilledBG, not arg_15_1)
	else
		gohelper.setActive(arg_15_0._go_CorrectBG, false)
		gohelper.setActive(arg_15_0._go_UnFilledBG, false)
	end
end

function var_0_0.refreshValidView(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._wrongBGAnim.enabled = not arg_16_3
	arg_16_0._correctAnim.enabled = not arg_16_3

	gohelper.setActive(arg_16_0._go_CorrectBG, arg_16_1 and arg_16_2)
	gohelper.setActive(arg_16_0._go_WrongBG, not arg_16_1 and arg_16_2)
	gohelper.setActive(arg_16_0._go_UnFilledBG, arg_16_0._editable and not arg_16_2)

	local var_16_0 = arg_16_0._editable and var_0_4 or var_0_3
	local var_16_1 = var_0_1

	if arg_16_0._editable then
		var_16_1 = arg_16_1 and var_0_2 or var_16_0
	else
		var_16_1 = var_0_1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._numText, var_16_1)
end

function var_0_0.refreshSameNumView(arg_17_0, arg_17_1, arg_17_2)
	gohelper.setActive(arg_17_0._go_Same, arg_17_1)

	arg_17_0._sameAnim.enabled = not arg_17_2
end

function var_0_0.refreshGuideView(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._go_UnFilledBG, arg_18_0._editable and not arg_18_1)
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
