﻿module("modules.logic.dungeon.view.DungeonViewMainStory", package.seeall)

local var_0_0 = class("DungeonViewMainStory", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollchapter = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter/content")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_story/#go_mainstorytip")
	arg_1_0._btntip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/#go_mainstorytip/#btn_tip")
	arg_1_0._txttipname = gohelper.findChildText(arg_1_0.viewGO, "#go_story/#go_mainstorytip/#txt_tipname")
	arg_1_0._txttipnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_story/#go_mainstorytip/#txt_tipname_en")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntip:AddClickListener(arg_2_0._btntipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntip:RemoveClickListener()
end

function var_0_0._btntipOnClick(arg_4_0)
	if arg_4_0._curSelectedSectionItem then
		arg_4_0._curSelectedSectionItem:externalClickTip()
	end
end

function var_0_0._setSelectedSectionItem(arg_5_0, arg_5_1)
	arg_5_0._curSelectedSectionItem = arg_5_1

	if not arg_5_1 then
		gohelper.setActive(arg_5_0._gotip, false)
	else
		arg_5_0:_updateNames()
	end
end

function var_0_0._updateNames(arg_6_0)
	arg_6_0._txttipname.text = arg_6_0._curSelectedSectionItem:getSectionName()
	arg_6_0._txttipnameen.text = arg_6_0._curSelectedSectionItem:getSectionNameEn()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._sectionList = arg_7_0:getUserDataTb_()
	arg_7_0._chapterList = arg_7_0:getUserDataTb_()
	arg_7_0._curSelectedSectionItem = nil
	arg_7_0._showChapterItemList = arg_7_0:getUserDataTb_()
	arg_7_0._posX = 0
	arg_7_0._anchorVec = Vector2(0, 1)
	arg_7_0._targetSectionId = -1
	arg_7_0._gocontenttransform = arg_7_0._gocontent.transform

	local var_7_0 = arg_7_0._gocontenttransform
	local var_7_1 = arg_7_0._anchorVec

	var_7_0.pivot = var_7_1
	var_7_0.anchorMin = var_7_1
	var_7_0.anchorMax = var_7_1
	var_7_0.anchoredPosition = Vector2.zero

	recthelper.setHeight(var_7_0, 748)

	arg_7_0._gotemplatecell = gohelper.findChild(arg_7_0.viewGO, "#go_story/chapterlist/#scroll_chapter/content/templatecell")

	gohelper.setActive(arg_7_0._gotemplatecell, false)
	arg_7_0:addEventCb(DungeonController.instance, DungeonEvent.SelectMainStorySection, arg_7_0._onSelectMainStorySection, arg_7_0)
	arg_7_0:addEventCb(DungeonController.instance, DungeonEvent.OnFocusNormalChapter, arg_7_0._onOnFocusNormalChapter, arg_7_0)
end

function var_0_0.onScrollChange(arg_8_0)
	if not arg_8_0._curSelectedSectionItem then
		arg_8_0._showFlowTipBtn = false

		gohelper.setActive(arg_8_0._gotip, false)

		return
	end

	local var_8_0 = recthelper.getAnchorX(arg_8_0._gocontenttransform)
	local var_8_1 = arg_8_0._curSelectedSectionItem:getPosX() + DungeonMainStoryEnum.FlowTipOffsetX
	local var_8_2 = var_8_0 <= -var_8_1
	local var_8_3 = math.abs(var_8_1 - var_8_0)
	local var_8_4 = arg_8_0._curSelectedSectionItem:getLineWidth() - var_8_3 + DungeonMainStoryEnum.FlowLineOffsetWidth

	recthelper.setWidth(arg_8_0._btntip.transform, var_8_4)
	gohelper.setActive(arg_8_0._gotip, var_8_2)
	arg_8_0._curSelectedSectionItem:setTipVisible(not var_8_2)

	if not arg_8_0._showFlowTipBtn then
		arg_8_0._showFlowTipBtn = true

		arg_8_0:_updateNames()
	end
end

function var_0_0._onSelectMainStorySection(arg_9_0)
	local var_9_0 = DungeonMainStoryModel.instance:getSelectedSectionId()
	local var_9_1 = DungeonMainStoryModel.instance:getChapterList(var_9_0)

	if var_9_1 and #var_9_1 > 0 then
		arg_9_0:_selectFocusNormalChapter(var_9_1[#var_9_1].id)

		return
	end

	arg_9_0:_selectFocusNormalChapter()
end

function var_0_0._selectFocusNormalChapter(arg_10_0, arg_10_1)
	arg_10_0:_beFocusChapter(arg_10_1)
end

function var_0_0.onOpen(arg_11_0)
	return
end

function var_0_0._onOnFocusNormalChapter(arg_12_0, arg_12_1)
	arg_12_0:_beFocusChapter(arg_12_1)
end

function var_0_0._beFocusChapter(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and DungeonConfig.instance:getChapterDivideSectionId(arg_13_1)

	arg_13_0._sameSectionId = var_13_0 == arg_13_0._targetSectionId
	arg_13_0._beFocusChapterId = arg_13_1
	arg_13_0._targetSectionId = var_13_0

	arg_13_0:_playChapterFocusEffect()
end

function var_0_0._killTween(arg_14_0)
	if arg_14_0.tweenId then
		ZProj.TweenHelper.KillById(arg_14_0.tweenId)

		arg_14_0.tweenId = nil
	end
end

function var_0_0._tweenHorizontalPosition(arg_15_0)
	arg_15_0:_killTween()

	arg_15_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_15_0._scrollchapter.horizontalNormalizedPosition, 0, DungeonMainStoryEnum.AnimTime, arg_15_0._tweenFrameCallback, nil, arg_15_0)
end

function var_0_0._tweenFrameCallback(arg_16_0, arg_16_1)
	arg_16_0._scrollchapter.horizontalNormalizedPosition = arg_16_1
end

function var_0_0._playChapterFocusEffect(arg_17_0)
	arg_17_0._hasOldSelectedSectionItem = nil

	if #arg_17_0._showChapterItemList > 0 then
		arg_17_0:_tweenHorizontalPosition()

		for iter_17_0, iter_17_1 in ipairs(arg_17_0._showChapterItemList) do
			iter_17_1:playCloseAnim()
		end

		for iter_17_2, iter_17_3 in pairs(arg_17_0._sectionList) do
			iter_17_3:moveToUnFoldPosX()
		end

		if arg_17_0._curSelectedSectionItem and not arg_17_0._sameSectionId then
			arg_17_0._hasOldSelectedSectionItem = true

			arg_17_0._curSelectedSectionItem:playAnimName("close")
		end

		TaskDispatcher.cancelTask(arg_17_0._applyFocusChapter, arg_17_0)
		TaskDispatcher.runDelay(arg_17_0._applyFocusChapter, arg_17_0, DungeonMainStoryEnum.AnimTime)
		arg_17_0:_startBlock(DungeonMainStoryEnum.AnimTime)

		return
	end

	arg_17_0:_applyFocusChapter()
end

function var_0_0._applyFocusChapter(arg_18_0)
	arg_18_0:_focusNormalChapter(arg_18_0._beFocusChapterId)
end

function var_0_0._focusNormalChapter(arg_19_0, arg_19_1)
	arg_19_0._curFocusChapterId = nil
	arg_19_0._curFocusChapterPosX = nil

	if arg_19_1 then
		local var_19_0 = DungeonConfig.instance:getChapterDivideSectionId(arg_19_1)

		if var_19_0 then
			DungeonMainStoryModel.instance:setSectionSelected(var_19_0)

			arg_19_0._curFocusChapterId = arg_19_1
		end
	end

	arg_19_0:_showAllChapterList()

	if arg_19_0._curFocusChapterPosX then
		arg_19_0._scrollchapter.movementType = 2

		local var_19_1 = arg_19_0._curFocusChapterPosX - recthelper.getWidth(arg_19_0._scrollchapter.transform) / 2

		recthelper.setAnchorX(arg_19_0._gocontent.transform, -var_19_1)
		TaskDispatcher.cancelTask(arg_19_0._resetMovementType, arg_19_0)
		TaskDispatcher.runDelay(arg_19_0._resetMovementType, arg_19_0, 0)
	end

	TaskDispatcher.cancelTask(arg_19_0.onScrollChange, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0.onScrollChange, arg_19_0, 0)
	arg_19_0:onScrollChange()
end

local var_0_1 = "DungeonViewMainStoryBlock"

function var_0_0._startBlock(arg_20_0, arg_20_1)
	TaskDispatcher.cancelTask(arg_20_0._endBlock, arg_20_0)
	TaskDispatcher.runDelay(arg_20_0._endBlock, arg_20_0, arg_20_1 + DungeonMainStoryEnum.SectionAnimTime)
	UIBlockMgr.instance:startBlock(var_0_1)
end

function var_0_0._endBlock(arg_21_0)
	UIBlockMgr.instance:endBlock(var_0_1)
end

function var_0_0._resetMovementType(arg_22_0)
	arg_22_0._scrollchapter.movementType = 1
end

function var_0_0._initSectionSelected(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(lua_chapter_divide.configList) do
		local var_23_0 = iter_23_1.sectionId
		local var_23_1 = DungeonMainStoryModel.instance:getChapterList(var_23_0)

		if var_23_1 and #var_23_1 > 0 and not DungeonModel.instance:chapterIsLock(var_23_1[1].id) then
			DungeonMainStoryModel.instance:setSectionSelected(var_23_0)
		end
	end
end

function var_0_0._showAllChapterList(arg_24_0)
	tabletool.clear(arg_24_0._showChapterItemList)
	arg_24_0:_setSelectedSectionItem(nil)

	arg_24_0._startPosX = 147.5
	arg_24_0._posX = arg_24_0._startPosX
	arg_24_0._sectionPosX = arg_24_0._startPosX

	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(lua_chapter_divide.configList) do
		local var_24_1 = iter_24_1.sectionId
		local var_24_2 = DungeonMainStoryModel.instance:getChapterList(var_24_1)

		if var_24_2 and #var_24_2 > 0 then
			arg_24_0:_showOneSectionChapterList(var_24_1, var_24_2, var_24_0)

			var_24_0 = var_24_0 + #var_24_2
		end

		arg_24_0._posX = arg_24_0._posX + DungeonMainStoryEnum.SectionSpace
	end

	recthelper.setWidth(arg_24_0._gocontent.transform, arg_24_0._posX)
end

function var_0_0._getSectionItem(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._sectionList[arg_25_1]

	if not var_25_0 then
		local var_25_1 = arg_25_0.viewContainer:getSetting().otherRes.section_item
		local var_25_2 = gohelper.cloneInPlace(arg_25_0._gotemplatecell, "section")

		gohelper.setActive(var_25_2, true)

		local var_25_3 = arg_25_0:getResInst(var_25_1, var_25_2, tostring(arg_25_1))

		var_25_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_25_3, DungeonSectionItem)
		arg_25_0._sectionList[arg_25_1] = var_25_0

		local var_25_4 = var_25_0.viewGO.transform
		local var_25_5 = Vector2(0, 1)

		var_25_4.pivot = var_25_5
		var_25_4.anchorMin = var_25_5
		var_25_4.anchorMax = var_25_5

		recthelper.setWidth(var_25_4, DungeonMainStoryEnum.ChapterWidth.Section)
	end

	return var_25_0
end

function var_0_0._getChapterItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._chapterList[arg_26_1]

	if not var_26_0 then
		local var_26_1 = DungeonModel.instance:isSpecialMainPlot(arg_26_1)
		local var_26_2 = var_26_1 and arg_26_0.viewContainer:getSetting().otherRes.mini_item or arg_26_0.viewContainer:getSetting().otherRes[1]
		local var_26_3 = gohelper.cloneInPlace(arg_26_0._gotemplatecell, "cell" .. arg_26_2 - 1)

		gohelper.setActive(var_26_3, true)

		local var_26_4 = arg_26_0:getResInst(var_26_2, var_26_3, var_26_1 and "mini_item" or LuaListScrollView.PrefabInstName)

		var_26_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_26_4, var_26_1 and DungeonChapterMiniItem or DungeonChapterItem)
		arg_26_0._chapterList[arg_26_1] = var_26_0

		if var_26_1 then
			recthelper.setWidth(var_26_3.transform, DungeonMainStoryEnum.ChapterWidth.Special)
			recthelper.setWidth(var_26_0.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Special)
		else
			recthelper.setWidth(var_26_3.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
			recthelper.setWidth(var_26_0.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
		end

		local var_26_5 = var_26_0.viewGO.transform
		local var_26_6 = arg_26_0._anchorVec

		var_26_5.pivot = var_26_6
		var_26_5.anchorMin = var_26_6
		var_26_5.anchorMax = var_26_6
	end

	return var_26_0
end

function var_0_0._showSectionItem(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:_getSectionItem(arg_27_1)

	var_27_0:onUpdateMO(lua_chapter_divide.configDict[arg_27_1])

	if DungeonMainStoryModel.instance:sectionIsSelected(arg_27_1) then
		arg_27_0:_setSelectedSectionItem(var_27_0)
		var_27_0:playAnimName("unfold")
	end

	local var_27_1 = arg_27_0._posX

	recthelper.setAnchor(var_27_0.viewGO.transform.parent, var_27_1, DungeonMainStoryEnum.ChapterPosY.Section)
	var_27_0:setPosX(var_27_1)
	var_27_0:setUnFoldPosX(arg_27_0._sectionPosX)

	arg_27_0._posX = arg_27_0._posX + DungeonMainStoryEnum.ChapterWidth.Section
	arg_27_0._sectionPosX = arg_27_0._sectionPosX + DungeonMainStoryEnum.ChapterWidth.Section

	if arg_27_0._posX ~= arg_27_0._sectionPosX then
		recthelper.setAnchor(var_27_0.viewGO.transform.parent, arg_27_0._sectionPosX, DungeonMainStoryEnum.ChapterPosY.Section)
		var_27_0:moveToPosX()
	end
end

function var_0_0._hideChpaterList(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		local var_28_0 = arg_28_0._chapterList[iter_28_1.id]

		if var_28_0 then
			recthelper.setAnchorY(var_28_0.viewGO.transform.parent, 2000)
		end
	end
end

function var_0_0._showOneSectionChapterList(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0:_showSectionItem(arg_29_1)

	if not DungeonMainStoryModel.instance:sectionIsSelected(arg_29_1) then
		arg_29_0:_hideChpaterList(arg_29_2)

		return
	end

	arg_29_0._posX = arg_29_0._posX + DungeonMainStoryEnum.ChapterStartPosX

	for iter_29_0, iter_29_1 in ipairs(arg_29_2) do
		local var_29_0 = DungeonModel.instance:isSpecialMainPlot(iter_29_1.id)
		local var_29_1 = arg_29_0:_getChapterItem(iter_29_1.id, arg_29_3 + iter_29_0)

		var_29_1:onUpdateMO(iter_29_1)

		arg_29_0._showChapterItemList[iter_29_0] = var_29_1

		if var_29_1:getIsPlayCloseAnim() then
			var_29_1:playIdleAnim()
		end

		local var_29_2 = arg_29_0._posX

		if iter_29_1.id == arg_29_0._curFocusChapterId then
			arg_29_0._curFocusChapterPosX = var_29_2
		end

		if var_29_0 then
			recthelper.setAnchor(var_29_1.viewGO.transform.parent, var_29_2, DungeonMainStoryEnum.ChapterPosY.Special)

			arg_29_0._posX = arg_29_0._posX + DungeonMainStoryEnum.ChapterWidth.Special
		else
			recthelper.setAnchor(var_29_1.viewGO.transform.parent, var_29_2, DungeonMainStoryEnum.ChapterPosY.Normal)

			arg_29_0._posX = arg_29_0._posX + DungeonMainStoryEnum.ChapterWidth.Normal
		end

		if iter_29_0 ~= #arg_29_2 then
			arg_29_0._posX = arg_29_0._posX + DungeonMainStoryEnum.ChapterSpace
		end
	end
end

function var_0_0.onClose(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._resetMovementType, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._applyFocusChapter, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.onScrollChange, arg_30_0)
	arg_30_0:_endBlock()
end

return var_0_0
