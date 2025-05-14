module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuView", package.seeall)

local var_0_0 = class("VersionActivity2_4SudokuView", BaseView)
local var_0_1 = 9
local var_0_2 = 9
local var_0_3 = 9
local var_0_4 = 3
local var_0_5 = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9
}
local var_0_6 = "3025"
local var_0_7 = 24101
local var_0_8 = "girdin"
local var_0_9 = "stage1in"
local var_0_10 = "stage2in"
local var_0_11 = "stage1to2"
local var_0_12 = VersionActivity2_4SudokuController.instance
local var_0_13 = VersionActivity2_4DungeonEvent
local var_0_14 = 1001

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goStage1 = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage1")
	arg_1_0._goStage2 = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage2")
	arg_1_0._goSmallNumGridRoot = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage1/Root/Grid")
	arg_1_0._goSmallNumGridItem = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage1/Root/Grid/#go_Item")
	arg_1_0._goNumGridRoot = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage2/Root/Grid")
	arg_1_0._goNumGridItem = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage2/Root/Grid/#go_Item")
	arg_1_0._goKeyBoardGridRoot = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage2/KeyBoard/Grid")
	arg_1_0._goKeyBoardGridItem = gohelper.findChild(arg_1_0.viewGO, "Rotate/Stage2/KeyBoard/Grid/#go_Item")
	arg_1_0._go_complete = gohelper.findChild(arg_1_0.viewGO, "#go_complete")
	arg_1_0._btnExit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_exit")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btnUndo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_return")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_signature")
	arg_1_0._go_topleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnExit:AddClickListener(arg_2_0._onEscBtnClick, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._onResetBtnClick, arg_2_0)
	arg_2_0._btnUndo:AddClickListener(arg_2_0._onUndoBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnExit:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
	arg_3_0._btnUndo:RemoveClickListener()
end

function var_0_0._onEscBtnClick(arg_4_0)
	var_0_12:dispatchEvent(var_0_13.SudokuCompleted)
	arg_4_0:closeThis()
end

function var_0_0._onResetBtnClick(arg_5_0)
	var_0_12:resetGame()
end

function var_0_0._onUndoBtnClick(arg_6_0)
	var_0_12:excuteLastCmd()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._numItems = {}
	arg_7_0._smallNumItems = {}
	arg_7_0._curEditItem = nil
	arg_7_0._keyboardItems = {}
	arg_7_0._curKeyboardItem = nil
	arg_7_0._curIdx = 0
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:onOpen()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(var_0_12, var_0_13.SudokuSelectItem, arg_9_0._onSelectedNumItem, arg_9_0)
	arg_9_0:addEventCb(var_0_12, var_0_13.SudokuSelectKeyboard, arg_9_0._onSelectedKeyboard, arg_9_0)
	arg_9_0:addEventCb(var_0_12, var_0_13.DoSudokuCmd, arg_9_0._doSudokuCmd, arg_9_0)
	arg_9_0:addEventCb(var_0_12, var_0_13.SudokuReset, arg_9_0._doSudokuReset, arg_9_0)
	arg_9_0:addEventCb(var_0_12, var_0_13.SudokuViewAni, arg_9_0._doViewAnimation, arg_9_0)

	if GuideModel.instance:isGuideFinish(var_0_7) or GuideController.instance:isForbidGuides() then
		gohelper.setActive(arg_9_0._goStage2, true)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_mln_page_turn)
		arg_9_0._viewAnimator:Play(var_0_10, 0, 0)
	else
		arg_9_0._viewAnimator:Play(var_0_9, 0, 0)

		arg_9_0._inGuide = true
	end

	arg_9_0:_createNumItems()
	arg_9_0:_createKeyboardItems()
	arg_9_0:_createSmallNumItems(arg_9_0._allNum)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagesignature:UnLoadImage()
end

function var_0_0._createSmallNumItems(arg_12_0, arg_12_1)
	gohelper.CreateObjList(arg_12_0, arg_12_0._createSmallNumItem, arg_12_1, arg_12_0._goSmallNumGridRoot, arg_12_0._goSmallNumGridItem, VersionActivity2_4SudokuNumItem, 1)
end

function var_0_0._createSmallNumItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._smallNumItems[arg_13_3] = arg_13_1

	arg_13_1:setItemData(arg_13_2, arg_13_3, nil, nil)

	if arg_13_0._inGuide then
		arg_13_1:refreshGuideView(true)
	end
end

function var_0_0._createNumItems(arg_14_0)
	arg_14_0._allNum = {}
	arg_14_0._rowItems = {}
	arg_14_0._colItems = {}
	arg_14_0._groupItems = {}
	arg_14_0._idx2CellIdx = {}
	arg_14_0._idx2GroupIdx = {}
	arg_14_0._emptyItem2Vaild = {}
	arg_14_0._sameNumItems = {}
	arg_14_0._conflictItems = {}
	arg_14_0._sudukuCfg = VersionActivity2_4SudokuModel.instance:getSudokuCfg(var_0_14)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._sudukuCfg) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			local var_14_0 = arg_14_0:_groupCellIdx2Idx(iter_14_0, iter_14_2)

			arg_14_0._allNum[var_14_0] = iter_14_3
			arg_14_0._idx2CellIdx[var_14_0] = iter_14_2
			arg_14_0._idx2GroupIdx[var_14_0] = iter_14_0

			if iter_14_3 == 0 then
				arg_14_0._emptyItem2Vaild[var_14_0] = false
			end
		end
	end

	gohelper.CreateObjList(arg_14_0, arg_14_0._createNumItem, arg_14_0._allNum, arg_14_0._goNumGridRoot, arg_14_0._goNumGridItem, VersionActivity2_4SudokuNumItem, 1)
end

function var_0_0._createNumItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0, var_15_1 = arg_15_0:_idx2GroupCellIdx(arg_15_3)
	local var_15_2, var_15_3 = arg_15_0:_idx2RowCol(arg_15_3)

	arg_15_0._numItems[arg_15_3] = arg_15_1
	arg_15_0._rowItems[var_15_2] = arg_15_0._rowItems[var_15_2] or {}
	arg_15_0._colItems[var_15_3] = arg_15_0._colItems[var_15_3] or {}
	arg_15_0._rowItems[var_15_2][var_15_3] = arg_15_1
	arg_15_0._colItems[var_15_3][var_15_2] = arg_15_1
	arg_15_0._groupItems[var_15_0] = arg_15_0._groupItems[var_15_0] or {}
	arg_15_0._groupItems[var_15_0][var_15_1] = arg_15_1

	local var_15_4 = arg_15_0._allNum[arg_15_3]

	arg_15_1:setItemData(var_15_4, arg_15_3, var_15_0, var_15_1)
end

function var_0_0._resetItemState(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1 = arg_16_1 or arg_16_0._numItems

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		if arg_16_2 then
			iter_16_1:refreshSameNumView(false)
		end

		if arg_16_3 then
			iter_16_1:refreshValidView(iter_16_1:isEditable() and arg_16_0._emptyItem2Vaild[iter_16_1:getItemIdx()] or false, false)
		end
	end
end

function var_0_0._getConflictItems(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._numItems[arg_17_1]:getItemNum()
	local var_17_1, var_17_2 = arg_17_0:_idx2RowCol(arg_17_1)
	local var_17_3 = {}
	local var_17_4 = arg_17_0._rowItems[var_17_1]

	for iter_17_0, iter_17_1 in ipairs(var_17_4) do
		if iter_17_1:getItemNum() == var_17_0 and iter_17_0 ~= var_17_2 then
			var_17_3[iter_17_1:getItemIdx()] = iter_17_1
		end
	end

	local var_17_5 = arg_17_0._colItems[var_17_2]

	for iter_17_2, iter_17_3 in ipairs(var_17_5) do
		if iter_17_3:getItemNum() == var_17_0 and iter_17_2 ~= var_17_1 then
			var_17_3[iter_17_3:getItemIdx()] = iter_17_3
		end
	end

	local var_17_6, var_17_7 = arg_17_0:_idx2GroupCellIdx(arg_17_1)
	local var_17_8 = arg_17_0._groupItems[var_17_6]

	for iter_17_4, iter_17_5 in ipairs(var_17_8) do
		if iter_17_5:getItemNum() == var_17_0 and iter_17_4 ~= var_17_7 then
			var_17_3[iter_17_5:getItemIdx()] = iter_17_5
		end
	end

	return var_17_3
end

function var_0_0._getSameNumItems(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._numItems[arg_18_1]:getItemNum()
	local var_18_1 = {}

	if var_18_0 ~= 0 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._numItems) do
			if iter_18_1:getItemNum() == var_18_0 and iter_18_0 ~= arg_18_1 then
				var_18_1[iter_18_0] = iter_18_1
			end
		end
	end

	return var_18_1
end

function var_0_0._getAllConflictItems(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0._emptyItem2Vaild) do
		if not iter_19_1 then
			local var_19_1 = arg_19_0._numItems[iter_19_0]

			if var_19_1:getItemNum() > 0 then
				local var_19_2 = arg_19_0:_getConflictItems(iter_19_0)

				var_19_2[iter_19_0] = var_19_1

				for iter_19_2, iter_19_3 in pairs(var_19_2) do
					var_19_0[iter_19_2] = iter_19_3
				end
			end
		end
	end

	return var_19_0
end

function var_0_0._createKeyboardItems(arg_20_0)
	gohelper.CreateObjList(arg_20_0, arg_20_0._createKeyboardNumItem, var_0_5, arg_20_0._goKeyBoardGridRoot, arg_20_0._goKeyBoardGridItem, VersionActivity2_4SudokuKeyboardItem, 1)
end

function var_0_0._createKeyboardNumItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = var_0_5[arg_21_3]

	arg_21_1:setItemData(var_21_0, arg_21_3, nil, nil)

	arg_21_0._keyboardItems[arg_21_3] = arg_21_1
end

function var_0_0._onSelectedKeyboard(arg_22_0, arg_22_1)
	if arg_22_0._curKeyboardItem then
		arg_22_0._curKeyboardItem:resetState()
	end

	arg_22_0._curKeyboardItem = arg_22_0._keyboardItems[arg_22_1]

	local var_22_0 = VersionActivity2_4SudokuModel.instance:getSelectedItem()

	if var_22_0 then
		local var_22_1 = arg_22_0._numItems[var_22_0]

		if not var_22_1:isEditable() then
			return
		end

		local var_22_2 = var_22_1:getItemNum()
		local var_22_3 = VersionActivity2_4SudokuCmd.New(var_22_0, var_22_2, arg_22_1)

		VersionActivity2_4SudokuController.instance:excuteNewCmd(var_22_3)
	end
end

function var_0_0._onSelectedNumItem(arg_23_0, arg_23_1)
	if arg_23_1 == arg_23_0._curIdx then
		return
	end

	arg_23_0._curIdx = arg_23_1

	arg_23_0:_resetItemState(arg_23_0._sameNumItems, true)

	if arg_23_0._curEditItem then
		if arg_23_0._curEditItem:isEditable() and arg_23_0._emptyItem2Vaild[arg_23_0._curEditItem:getItemIdx()] then
			arg_23_0._curEditItem:refreshValidView(true, false)
		end

		arg_23_0._curEditItem:refreshSelectView(false)
	end

	arg_23_0._curEditItem = arg_23_0._numItems[arg_23_1]

	if arg_23_0._curEditItem then
		arg_23_0._curEditItem:refreshSelectView(true)

		if arg_23_0._curEditItem:isEditable() and arg_23_0._emptyItem2Vaild[arg_23_0._curEditItem:getItemIdx()] then
			arg_23_0._curEditItem:refreshValidView(true, true)
		end
	end

	local var_23_0 = arg_23_0._curEditItem:getItemNum()
	local var_23_1 = false

	if var_23_0 > 0 then
		var_23_1 = arg_23_0:_checkValid(arg_23_1)
	end

	if arg_23_0._curEditItem:isEditable() then
		if not arg_23_0._curKeyboardItem then
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(var_23_0)

			arg_23_0._curKeyboardItem = arg_23_0._keyboardItems[var_23_0]

			if arg_23_0._curKeyboardItem then
				arg_23_0._curKeyboardItem:refreshValidView(var_23_1)
			end
		elseif var_23_0 == arg_23_0._curKeyboardItem:getItemNum() then
			arg_23_0._curKeyboardItem:refreshValidView(var_23_1)
		else
			arg_23_0._curKeyboardItem:resetState()
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(var_23_0)

			arg_23_0._curKeyboardItem = arg_23_0._keyboardItems[var_23_0]

			if arg_23_0._curKeyboardItem then
				arg_23_0._curKeyboardItem:refreshValidView(var_23_1)
			end
		end
	end

	if var_23_0 > 0 then
		if arg_23_0._sameNumItems and #arg_23_0._sameNumItems > 0 then
			for iter_23_0, iter_23_1 in pairs(arg_23_0._sameNumItems) do
				iter_23_1:refreshSameNumView(false)
			end
		end

		arg_23_0._sameNumItems = arg_23_0:_getSameNumItems(arg_23_1)

		for iter_23_2, iter_23_3 in pairs(arg_23_0._sameNumItems) do
			iter_23_3:refreshSameNumView(arg_23_0._conflictItems[iter_23_2] == nil)
		end
	end
end

function var_0_0._doSudokuCmd(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:getIdx()
	local var_24_1 = arg_24_0._numItems[var_24_0]
	local var_24_2 = var_24_1 and var_24_1:getItemNum()
	local var_24_3 = arg_24_1:getNewNum()
	local var_24_4 = arg_24_1:isUndo()

	if var_24_1 and var_24_2 ~= var_24_3 then
		arg_24_0:_resetItemState(arg_24_0._sameNumItems, true)
		var_24_1:setItemNum(var_24_3)
		var_24_1:refreshUI()

		local var_24_5 = arg_24_0:_checkValid(var_24_0)

		if not var_24_5 and not var_24_4 then
			var_0_12:addErrorCount()
		end

		var_24_1:setItemVaild(var_24_5)

		arg_24_0._emptyItem2Vaild[var_24_0] = var_24_5

		if var_24_5 then
			for iter_24_0, iter_24_1 in pairs(arg_24_0._emptyItem2Vaild) do
				if iter_24_0 ~= var_24_0 then
					local var_24_6 = arg_24_0._numItems[iter_24_0]
					local var_24_7 = arg_24_0:_checkValid(iter_24_0)

					arg_24_0._emptyItem2Vaild[iter_24_0] = var_24_7

					var_24_6:setItemVaild(var_24_7)
				end
			end
		end

		local var_24_8 = arg_24_0._conflictItems

		arg_24_0._conflictItems = arg_24_0:_getAllConflictItems()

		if not arg_24_0._curKeyboardItem then
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(var_24_3)

			arg_24_0._curKeyboardItem = arg_24_0._keyboardItems[var_24_3]

			if arg_24_0._curKeyboardItem then
				arg_24_0._curKeyboardItem:refreshValidView(var_24_5, var_24_4)
			end
		elseif var_24_3 == arg_24_0._curKeyboardItem:getItemNum() then
			arg_24_0._curKeyboardItem:refreshValidView(var_24_5, var_24_4)
		else
			arg_24_0._curKeyboardItem:resetState()
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(var_24_3)

			arg_24_0._curKeyboardItem = arg_24_0._keyboardItems[var_24_3]

			if arg_24_0._curKeyboardItem then
				arg_24_0._curKeyboardItem:refreshValidView(var_24_5, var_24_4)
			end
		end

		for iter_24_2, iter_24_3 in pairs(arg_24_0._conflictItems) do
			var_24_8[iter_24_2] = nil

			iter_24_3:refreshValidView(false, true, var_24_4)
		end

		arg_24_0:_resetItemState(var_24_8, false, true, var_24_4)

		arg_24_0._sameNumItems = arg_24_0:_getSameNumItems(var_24_0)

		for iter_24_4, iter_24_5 in pairs(arg_24_0._sameNumItems) do
			iter_24_5:refreshSameNumView(arg_24_0._conflictItems[iter_24_4] == nil, var_24_4)
		end

		var_24_1:refreshValidView(var_24_5, var_24_3 ~= 0, var_24_4)
	elseif arg_24_0._curKeyboardItem then
		arg_24_0._curKeyboardItem:refreshUI()
	end

	if arg_24_0:_checkPass() then
		arg_24_0:_refreshPassView()
		VersionActivity2_4SudokuController.instance:setStatResult("done")
		VersionActivity2_4SudokuController.instance:sendStat()
	end
end

function var_0_0._doSudokuReset(arg_25_0)
	arg_25_0:_resetItemState(arg_25_0._conflictItems, false, true)
	arg_25_0:_resetItemState(arg_25_0._sameNumItems, true)

	if arg_25_0._curKeyboardItem then
		arg_25_0._curKeyboardItem:resetState()
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0._emptyItem2Vaild) do
		local var_25_0 = arg_25_0._numItems[iter_25_0]

		var_25_0:setItemNum(0)
		var_25_0:refreshUI()
		var_25_0:refreshSelectView(false)
		var_25_0:refreshValidView(false, false)

		arg_25_0._emptyItem2Vaild[iter_25_0] = false
	end

	arg_25_0._curIdx = nil
end

function var_0_0._refreshPassView(arg_26_0)
	gohelper.setActive(arg_26_0._go_complete, true)
	gohelper.setActive(arg_26_0._btnExit.gameObject, true)
	gohelper.setActive(arg_26_0._simagesignature.gameObject, true)
	gohelper.setActive(arg_26_0._go_topleft, false)
	gohelper.setActive(arg_26_0._btnUndo.gameObject, false)
	gohelper.setActive(arg_26_0._btnReset.gameObject, false)
	arg_26_0._simagesignature:UnLoadImage()
	arg_26_0._simagesignature:LoadImage(ResUrl.getSignature(var_0_6))
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	arg_26_0:_resetItemState(arg_26_0._conflictItems, false, true)
	arg_26_0:_resetItemState(arg_26_0._sameNumItems, true)

	if arg_26_0._curKeyboardItem then
		arg_26_0._curKeyboardItem:resetState()
	end

	for iter_26_0, iter_26_1 in pairs(arg_26_0._emptyItem2Vaild) do
		arg_26_0._numItems[iter_26_0]:refreshValidView(true, false)

		arg_26_0._emptyItem2Vaild[iter_26_0] = false
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_diqiu_complete)
	arg_26_0._curEditItem:refreshSelectView(false)
end

function var_0_0._doViewAnimation(arg_27_0, arg_27_1)
	if arg_27_1 == var_0_8 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_lvhu_clue_write_2)
	elseif arg_27_1 == var_0_11 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_mln_page_turn)
	end

	arg_27_0._viewAnimator:Play(arg_27_1, 0, 0)
end

function var_0_0._checkValid(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._numItems[arg_28_1]:getItemNum()

	if var_28_0 == 0 then
		return false
	end

	local var_28_1, var_28_2 = arg_28_0:_idx2RowCol(arg_28_1)
	local var_28_3 = arg_28_0._rowItems[var_28_1]

	for iter_28_0, iter_28_1 in ipairs(var_28_3) do
		if iter_28_1:getItemNum() == var_28_0 and iter_28_0 ~= var_28_2 then
			return false
		end
	end

	local var_28_4 = arg_28_0._colItems[var_28_2]

	for iter_28_2, iter_28_3 in ipairs(var_28_4) do
		if iter_28_3:getItemNum() == var_28_0 and iter_28_2 ~= var_28_1 then
			return false
		end
	end

	local var_28_5, var_28_6 = arg_28_0:_idx2GroupCellIdx(arg_28_1)
	local var_28_7 = arg_28_0._groupItems[var_28_5]

	for iter_28_4, iter_28_5 in ipairs(var_28_7) do
		if iter_28_5:getItemNum() == var_28_0 and iter_28_4 ~= var_28_6 then
			return false
		end
	end

	return true
end

function var_0_0._checkPass(arg_29_0)
	local var_29_0 = true

	for iter_29_0, iter_29_1 in pairs(arg_29_0._emptyItem2Vaild) do
		if not iter_29_1 then
			return false
		end
	end

	return true
end

function var_0_0._idx2GroupCellIdx(arg_30_0, arg_30_1)
	return arg_30_0._idx2GroupIdx[arg_30_1], arg_30_0._idx2CellIdx[arg_30_1]
end

function var_0_0._groupCellIdx2Idx(arg_31_0, arg_31_1, arg_31_2)
	return math.floor((arg_31_1 - 1) / var_0_4) * var_0_1 * var_0_4 + (arg_31_1 - 1) % var_0_4 * var_0_4 + math.floor((arg_31_2 - 1) / var_0_4) * var_0_1 + (arg_31_2 - 1) % var_0_4 + 1
end

function var_0_0._idx2RowCol(arg_32_0, arg_32_1)
	local var_32_0 = math.floor((arg_32_1 - 1) / var_0_2) + 1
	local var_32_1 = math.floor((arg_32_1 - 1) % var_0_2) + 1

	return var_32_0, var_32_1
end

return var_0_0
