module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuView", package.seeall)

slot0 = class("VersionActivity2_4SudokuView", BaseView)
slot1 = 9
slot2 = 9
slot3 = 9
slot4 = 3
slot5 = {
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
slot6 = "3025"
slot7 = 24101
slot8 = "girdin"
slot9 = "stage1in"
slot10 = "stage2in"
slot11 = "stage1to2"
slot12 = VersionActivity2_4SudokuController.instance
slot13 = VersionActivity2_4DungeonEvent
slot14 = 1001

function slot0.onInitView(slot0)
	slot0._goStage1 = gohelper.findChild(slot0.viewGO, "Rotate/Stage1")
	slot0._goStage2 = gohelper.findChild(slot0.viewGO, "Rotate/Stage2")
	slot0._goSmallNumGridRoot = gohelper.findChild(slot0.viewGO, "Rotate/Stage1/Root/Grid")
	slot0._goSmallNumGridItem = gohelper.findChild(slot0.viewGO, "Rotate/Stage1/Root/Grid/#go_Item")
	slot0._goNumGridRoot = gohelper.findChild(slot0.viewGO, "Rotate/Stage2/Root/Grid")
	slot0._goNumGridItem = gohelper.findChild(slot0.viewGO, "Rotate/Stage2/Root/Grid/#go_Item")
	slot0._goKeyBoardGridRoot = gohelper.findChild(slot0.viewGO, "Rotate/Stage2/KeyBoard/Grid")
	slot0._goKeyBoardGridItem = gohelper.findChild(slot0.viewGO, "Rotate/Stage2/KeyBoard/Grid/#go_Item")
	slot0._go_complete = gohelper.findChild(slot0.viewGO, "#go_complete")
	slot0._btnExit = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_exit")
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._btnUndo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_return")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "#simage_signature")
	slot0._go_topleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnExit:AddClickListener(slot0._onEscBtnClick, slot0)
	slot0._btnReset:AddClickListener(slot0._onResetBtnClick, slot0)
	slot0._btnUndo:AddClickListener(slot0._onUndoBtnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnExit:RemoveClickListener()
	slot0._btnReset:RemoveClickListener()
	slot0._btnUndo:RemoveClickListener()
end

function slot0._onEscBtnClick(slot0)
	uv0:dispatchEvent(uv1.SudokuCompleted)
	slot0:closeThis()
end

function slot0._onResetBtnClick(slot0)
	uv0:resetGame()
end

function slot0._onUndoBtnClick(slot0)
	uv0:excuteLastCmd()
end

function slot0._editableInitView(slot0)
	slot0._numItems = {}
	slot0._smallNumItems = {}
	slot0._curEditItem = nil
	slot0._keyboardItems = {}
	slot0._curKeyboardItem = nil
	slot0._curIdx = 0
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(uv0, uv1.SudokuSelectItem, slot0._onSelectedNumItem, slot0)
	slot0:addEventCb(uv0, uv1.SudokuSelectKeyboard, slot0._onSelectedKeyboard, slot0)
	slot0:addEventCb(uv0, uv1.DoSudokuCmd, slot0._doSudokuCmd, slot0)
	slot0:addEventCb(uv0, uv1.SudokuReset, slot0._doSudokuReset, slot0)
	slot0:addEventCb(uv0, uv1.SudokuViewAni, slot0._doViewAnimation, slot0)

	if GuideModel.instance:isGuideFinish(uv2) or GuideController.instance:isForbidGuides() then
		gohelper.setActive(slot0._goStage2, true)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_mln_page_turn)
		slot0._viewAnimator:Play(uv3, 0, 0)
	else
		slot0._viewAnimator:Play(uv4, 0, 0)

		slot0._inGuide = true
	end

	slot0:_createNumItems()
	slot0:_createKeyboardItems()
	slot0:_createSmallNumItems(slot0._allNum)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagesignature:UnLoadImage()
end

function slot0._createSmallNumItems(slot0, slot1)
	gohelper.CreateObjList(slot0, slot0._createSmallNumItem, slot1, slot0._goSmallNumGridRoot, slot0._goSmallNumGridItem, VersionActivity2_4SudokuNumItem, 1)
end

function slot0._createSmallNumItem(slot0, slot1, slot2, slot3)
	slot0._smallNumItems[slot3] = slot1

	slot1:setItemData(slot2, slot3, nil, )

	if slot0._inGuide then
		slot1:refreshGuideView(true)
	end
end

function slot0._createNumItems(slot0)
	slot0._allNum = {}
	slot0._rowItems = {}
	slot0._colItems = {}
	slot0._groupItems = {}
	slot0._idx2CellIdx = {}
	slot0._idx2GroupIdx = {}
	slot0._emptyItem2Vaild = {}
	slot0._sameNumItems = {}
	slot0._conflictItems = {}
	slot0._sudukuCfg = VersionActivity2_4SudokuModel.instance:getSudokuCfg(uv0)

	for slot4, slot5 in ipairs(slot0._sudukuCfg) do
		for slot9, slot10 in ipairs(slot5) do
			slot11 = slot0:_groupCellIdx2Idx(slot4, slot9)
			slot0._allNum[slot11] = slot10
			slot0._idx2CellIdx[slot11] = slot9
			slot0._idx2GroupIdx[slot11] = slot4

			if slot10 == 0 then
				slot0._emptyItem2Vaild[slot11] = false
			end
		end
	end

	gohelper.CreateObjList(slot0, slot0._createNumItem, slot0._allNum, slot0._goNumGridRoot, slot0._goNumGridItem, VersionActivity2_4SudokuNumItem, 1)
end

function slot0._createNumItem(slot0, slot1, slot2, slot3)
	slot4, slot5 = slot0:_idx2GroupCellIdx(slot3)
	slot6, slot7 = slot0:_idx2RowCol(slot3)
	slot0._numItems[slot3] = slot1
	slot0._rowItems[slot6] = slot0._rowItems[slot6] or {}
	slot0._colItems[slot7] = slot0._colItems[slot7] or {}
	slot0._rowItems[slot6][slot7] = slot1
	slot0._colItems[slot7][slot6] = slot1
	slot0._groupItems[slot4] = slot0._groupItems[slot4] or {}
	slot0._groupItems[slot4][slot5] = slot1

	slot1:setItemData(slot0._allNum[slot3], slot3, slot4, slot5)
end

function slot0._resetItemState(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot1 or slot0._numItems) do
		if slot2 then
			slot8:refreshSameNumView(false)
		end

		if slot3 then
			slot8:refreshValidView(slot8:isEditable() and slot0._emptyItem2Vaild[slot8:getItemIdx()] or false, false)
		end
	end
end

function slot0._getConflictItems(slot0, slot1)
	slot4, slot5 = slot0:_idx2RowCol(slot1)
	slot6 = {
		[slot12:getItemIdx()] = slot12
	}

	for slot11, slot12 in ipairs(slot0._rowItems[slot4]) do
		if slot12:getItemNum() == slot0._numItems[slot1]:getItemNum() and slot11 ~= slot5 then
			-- Nothing
		end
	end

	for slot12, slot13 in ipairs(slot0._colItems[slot5]) do
		if slot13:getItemNum() == slot3 and slot12 ~= slot4 then
			slot6[slot13:getItemIdx()] = slot13
		end
	end

	slot9, slot10 = slot0:_idx2GroupCellIdx(slot1)

	for slot15, slot16 in ipairs(slot0._groupItems[slot9]) do
		if slot16:getItemNum() == slot3 and slot15 ~= slot10 then
			slot6[slot16:getItemIdx()] = slot16
		end
	end

	return slot6
end

function slot0._getSameNumItems(slot0, slot1)
	slot4 = {}

	if slot0._numItems[slot1]:getItemNum() ~= 0 then
		for slot8, slot9 in ipairs(slot0._numItems) do
			if slot9:getItemNum() == slot3 and slot8 ~= slot1 then
				slot4[slot8] = slot9
			end
		end
	end

	return slot4
end

function slot0._getAllConflictItems(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._emptyItem2Vaild) do
		if not slot6 and slot0._numItems[slot5]:getItemNum() > 0 then
			slot8 = slot0:_getConflictItems(slot5)
			slot8[slot5] = slot7

			for slot12, slot13 in pairs(slot8) do
				slot1[slot12] = slot13
			end
		end
	end

	return slot1
end

function slot0._createKeyboardItems(slot0)
	gohelper.CreateObjList(slot0, slot0._createKeyboardNumItem, uv0, slot0._goKeyBoardGridRoot, slot0._goKeyBoardGridItem, VersionActivity2_4SudokuKeyboardItem, 1)
end

function slot0._createKeyboardNumItem(slot0, slot1, slot2, slot3)
	slot1:setItemData(uv0[slot3], slot3, nil, )

	slot0._keyboardItems[slot3] = slot1
end

function slot0._onSelectedKeyboard(slot0, slot1)
	if slot0._curKeyboardItem then
		slot0._curKeyboardItem:resetState()
	end

	slot0._curKeyboardItem = slot0._keyboardItems[slot1]

	if VersionActivity2_4SudokuModel.instance:getSelectedItem() then
		if not slot0._numItems[slot2]:isEditable() then
			return
		end

		VersionActivity2_4SudokuController.instance:excuteNewCmd(VersionActivity2_4SudokuCmd.New(slot2, slot3:getItemNum(), slot1))
	end
end

function slot0._onSelectedNumItem(slot0, slot1)
	if slot1 == slot0._curIdx then
		return
	end

	slot0._curIdx = slot1

	slot0:_resetItemState(slot0._sameNumItems, true)

	if slot0._curEditItem then
		if slot0._curEditItem:isEditable() and slot0._emptyItem2Vaild[slot0._curEditItem:getItemIdx()] then
			slot0._curEditItem:refreshValidView(true, false)
		end

		slot0._curEditItem:refreshSelectView(false)
	end

	slot0._curEditItem = slot0._numItems[slot1]

	if slot0._curEditItem then
		slot0._curEditItem:refreshSelectView(true)

		if slot0._curEditItem:isEditable() and slot0._emptyItem2Vaild[slot0._curEditItem:getItemIdx()] then
			slot0._curEditItem:refreshValidView(true, true)
		end
	end

	slot3 = false

	if slot0._curEditItem:getItemNum() > 0 then
		slot3 = slot0:_checkValid(slot1)
	end

	if slot0._curEditItem:isEditable() then
		if not slot0._curKeyboardItem then
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(slot2)

			slot0._curKeyboardItem = slot0._keyboardItems[slot2]

			if slot0._curKeyboardItem then
				slot0._curKeyboardItem:refreshValidView(slot3)
			end
		elseif slot2 == slot0._curKeyboardItem:getItemNum() then
			slot0._curKeyboardItem:refreshValidView(slot3)
		else
			slot0._curKeyboardItem:resetState()
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(slot2)

			slot0._curKeyboardItem = slot0._keyboardItems[slot2]

			if slot0._curKeyboardItem then
				slot0._curKeyboardItem:refreshValidView(slot3)
			end
		end
	end

	if slot2 > 0 then
		if slot0._sameNumItems and #slot0._sameNumItems > 0 then
			for slot7, slot8 in pairs(slot0._sameNumItems) do
				slot8:refreshSameNumView(false)
			end
		end

		slot0._sameNumItems = slot0:_getSameNumItems(slot1)

		for slot7, slot8 in pairs(slot0._sameNumItems) do
			slot8:refreshSameNumView(slot0._conflictItems[slot7] == nil)
		end
	end
end

function slot0._doSudokuCmd(slot0, slot1)
	slot5 = slot1:getNewNum()
	slot6 = slot1:isUndo()

	if slot3 and (slot0._numItems[slot1:getIdx()] and slot3:getItemNum()) ~= slot5 then
		slot0:_resetItemState(slot0._sameNumItems, true)
		slot3:setItemNum(slot5)
		slot3:refreshUI()

		if not slot0:_checkValid(slot2) and not slot6 then
			uv0:addErrorCount()
		end

		slot3:setItemVaild(slot7)

		slot0._emptyItem2Vaild[slot2] = slot7

		if slot7 then
			for slot11, slot12 in pairs(slot0._emptyItem2Vaild) do
				if slot11 ~= slot2 then
					slot14 = slot0:_checkValid(slot11)
					slot0._emptyItem2Vaild[slot11] = slot14

					slot0._numItems[slot11]:setItemVaild(slot14)
				end
			end
		end

		slot8 = slot0._conflictItems
		slot0._conflictItems = slot0:_getAllConflictItems()

		if not slot0._curKeyboardItem then
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(slot5)

			slot0._curKeyboardItem = slot0._keyboardItems[slot5]

			if slot0._curKeyboardItem then
				slot0._curKeyboardItem:refreshValidView(slot7, slot6)
			end
		elseif slot5 == slot0._curKeyboardItem:getItemNum() then
			slot0._curKeyboardItem:refreshValidView(slot7, slot6)
		else
			slot0._curKeyboardItem:resetState()
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(slot5)

			slot0._curKeyboardItem = slot0._keyboardItems[slot5]

			if slot0._curKeyboardItem then
				slot0._curKeyboardItem:refreshValidView(slot7, slot6)
			end
		end

		for slot12, slot13 in pairs(slot0._conflictItems) do
			slot8[slot12] = nil

			slot13:refreshValidView(false, true, slot6)
		end

		slot12 = false
		slot13 = true

		slot0:_resetItemState(slot8, slot12, slot13, slot6)

		slot0._sameNumItems = slot0:_getSameNumItems(slot2)

		for slot12, slot13 in pairs(slot0._sameNumItems) do
			slot13:refreshSameNumView(slot0._conflictItems[slot12] == nil, slot6)
		end

		slot3:refreshValidView(slot7, slot5 ~= 0, slot6)
	elseif slot0._curKeyboardItem then
		slot0._curKeyboardItem:refreshUI()
	end

	if slot0:_checkPass() then
		slot0:_refreshPassView()
		VersionActivity2_4SudokuController.instance:setStatResult("done")
		VersionActivity2_4SudokuController.instance:sendStat()
	end
end

function slot0._doSudokuReset(slot0)
	slot0:_resetItemState(slot0._conflictItems, false, true)
	slot0:_resetItemState(slot0._sameNumItems, true)

	if slot0._curKeyboardItem then
		slot0._curKeyboardItem:resetState()
	end

	for slot4, slot5 in pairs(slot0._emptyItem2Vaild) do
		slot6 = slot0._numItems[slot4]

		slot6:setItemNum(0)
		slot6:refreshUI()
		slot6:refreshSelectView(false)
		slot6:refreshValidView(false, false)

		slot0._emptyItem2Vaild[slot4] = false
	end

	slot0._curIdx = nil
end

function slot0._refreshPassView(slot0)
	gohelper.setActive(slot0._go_complete, true)
	gohelper.setActive(slot0._btnExit.gameObject, true)
	gohelper.setActive(slot0._simagesignature.gameObject, true)
	gohelper.setActive(slot0._go_topleft, false)
	gohelper.setActive(slot0._btnUndo.gameObject, false)
	gohelper.setActive(slot0._btnReset.gameObject, false)
	slot0._simagesignature:UnLoadImage()
	slot0._simagesignature:LoadImage(ResUrl.getSignature(uv0))
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	slot0:_resetItemState(slot0._conflictItems, false, true)
	slot0:_resetItemState(slot0._sameNumItems, true)

	if slot0._curKeyboardItem then
		slot0._curKeyboardItem:resetState()
	end

	for slot4, slot5 in pairs(slot0._emptyItem2Vaild) do
		slot0._numItems[slot4]:refreshValidView(true, false)

		slot0._emptyItem2Vaild[slot4] = false
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_diqiu_complete)
	slot0._curEditItem:refreshSelectView(false)
end

function slot0._doViewAnimation(slot0, slot1)
	if slot1 == uv0 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_lvhu_clue_write_2)
	elseif slot1 == uv1 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_mln_page_turn)
	end

	slot0._viewAnimator:Play(slot1, 0, 0)
end

function slot0._checkValid(slot0, slot1)
	if slot0._numItems[slot1]:getItemNum() == 0 then
		return false
	end

	slot4, slot5 = slot0:_idx2RowCol(slot1)

	for slot10, slot11 in ipairs(slot0._rowItems[slot4]) do
		if slot11:getItemNum() == slot3 and slot10 ~= slot5 then
			return false
		end
	end

	for slot11, slot12 in ipairs(slot0._colItems[slot5]) do
		if slot12:getItemNum() == slot3 and slot11 ~= slot4 then
			return false
		end
	end

	slot8, slot9 = slot0:_idx2GroupCellIdx(slot1)

	for slot14, slot15 in ipairs(slot0._groupItems[slot8]) do
		if slot15:getItemNum() == slot3 and slot14 ~= slot9 then
			return false
		end
	end

	return true
end

function slot0._checkPass(slot0)
	slot1 = true

	for slot5, slot6 in pairs(slot0._emptyItem2Vaild) do
		if not slot6 then
			return false
		end
	end

	return true
end

function slot0._idx2GroupCellIdx(slot0, slot1)
	return slot0._idx2GroupIdx[slot1], slot0._idx2CellIdx[slot1]
end

function slot0._groupCellIdx2Idx(slot0, slot1, slot2)
	return math.floor((slot1 - 1) / uv0) * uv1 * uv0 + (slot1 - 1) % uv0 * uv0 + math.floor((slot2 - 1) / uv0) * uv1 + (slot2 - 1) % uv0 + 1
end

function slot0._idx2RowCol(slot0, slot1)
	return math.floor((slot1 - 1) / uv0) + 1, math.floor((slot1 - 1) % uv0) + 1
end

return slot0
