module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuKeyboardItem", package.seeall)

local var_0_0 = class("VersionActivity2_4SudokuKeyboardItem", ListScrollCellExtend)
local var_0_1 = typeof(UnityEngine.Animation)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._numText = gohelper.findChildText(arg_1_0.viewGO, "#txt_Num")
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "clickArea")
	arg_1_0._go_CorrectBG = gohelper.findChild(arg_1_0.viewGO, "#go_CorrectBG")
	arg_1_0._go_UnFilledBG = gohelper.findChild(arg_1_0.viewGO, "#go_UnFilledBG")
	arg_1_0._go_Same = gohelper.findChild(arg_1_0.viewGO, "#go_Same")
	arg_1_0._go_WrongBG = gohelper.findChild(arg_1_0.viewGO, "#go_WrongBG")
	arg_1_0._go_WrongCircle = gohelper.findChild(arg_1_0.viewGO, "#go_WrongCircle")
	arg_1_0._wrongBGAnim = arg_1_0._go_WrongBG:GetComponent(var_0_1)
	arg_1_0._correctAnim = arg_1_0._go_CorrectBG:GetComponent(var_0_1)

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
	VersionActivity2_4SudokuController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuSelectKeyboard, arg_4_0._idx)
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._go_Same, false)
	gohelper.setActive(arg_5_0._go_CorrectBG, false)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.setItemData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._num = arg_8_1
	arg_8_0._idx = arg_8_2

	arg_8_0:refreshUI()
end

function var_0_0.getItemNum(arg_9_0)
	return arg_9_0._num
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0._numText.text = arg_10_0._num
end

function var_0_0.refreshValidView(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._wrongBGAnim.enabled = not arg_11_2
	arg_11_0._correctAnim.enabled = not arg_11_2

	if arg_11_1 then
		gohelper.setActive(arg_11_0._go_WrongBG, false)
		gohelper.setActive(arg_11_0._go_CorrectBG, true)
	else
		gohelper.setActive(arg_11_0._go_WrongBG, true)
		gohelper.setActive(arg_11_0._go_CorrectBG, false)
	end
end

function var_0_0.resetState(arg_12_0)
	gohelper.setActive(arg_12_0._go_WrongBG, false)
	gohelper.setActive(arg_12_0._go_CorrectBG, false)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
