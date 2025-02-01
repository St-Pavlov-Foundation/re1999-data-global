module("modules.logic.dungeon.view.DungeonViewMainStory", package.seeall)

slot0 = class("DungeonViewMainStory", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollchapter = gohelper.findChildScrollRect(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter/content")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_story/#go_mainstorytip")
	slot0._btntip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_story/#go_mainstorytip/#btn_tip")
	slot0._txttipname = gohelper.findChildText(slot0.viewGO, "#go_story/#go_mainstorytip/#txt_tipname")
	slot0._txttipnameen = gohelper.findChildText(slot0.viewGO, "#go_story/#go_mainstorytip/#txt_tipname_en")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntip:AddClickListener(slot0._btntipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntip:RemoveClickListener()
end

function slot0._btntipOnClick(slot0)
	if slot0._curSelectedSectionItem then
		slot0._curSelectedSectionItem:externalClickTip()
	end
end

function slot0._setSelectedSectionItem(slot0, slot1)
	slot0._curSelectedSectionItem = slot1

	if not slot1 then
		gohelper.setActive(slot0._gotip, false)
	else
		slot0:_updateNames()
	end
end

function slot0._updateNames(slot0)
	slot0._txttipname.text = slot0._curSelectedSectionItem:getSectionName()
	slot0._txttipnameen.text = slot0._curSelectedSectionItem:getSectionNameEn()
end

function slot0._editableInitView(slot0)
	slot0._sectionList = slot0:getUserDataTb_()
	slot0._chapterList = slot0:getUserDataTb_()
	slot0._curSelectedSectionItem = nil
	slot0._showChapterItemList = slot0:getUserDataTb_()
	slot0._posX = 0
	slot0._anchorVec = Vector2(0, 1)
	slot0._targetSectionId = -1
	slot0._gocontenttransform = slot0._gocontent.transform
	slot1 = slot0._gocontenttransform
	slot2 = slot0._anchorVec
	slot1.pivot = slot2
	slot1.anchorMin = slot2
	slot1.anchorMax = slot2
	slot1.anchoredPosition = Vector2.zero

	recthelper.setHeight(slot1, 748)

	slot0._gotemplatecell = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter/content/templatecell")

	gohelper.setActive(slot0._gotemplatecell, false)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.SelectMainStorySection, slot0._onSelectMainStorySection, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnFocusNormalChapter, slot0._onOnFocusNormalChapter, slot0)
end

function slot0.onScrollChange(slot0)
	if not slot0._curSelectedSectionItem then
		slot0._showFlowTipBtn = false

		gohelper.setActive(slot0._gotip, false)

		return
	end

	slot3 = recthelper.getAnchorX(slot0._gocontenttransform) <= -(slot0._curSelectedSectionItem:getPosX() + DungeonMainStoryEnum.FlowTipOffsetX)

	recthelper.setWidth(slot0._btntip.transform, slot0._curSelectedSectionItem:getLineWidth() - math.abs(slot2 - slot1) + DungeonMainStoryEnum.FlowLineOffsetWidth)
	gohelper.setActive(slot0._gotip, slot3)
	slot0._curSelectedSectionItem:setTipVisible(not slot3)

	if not slot0._showFlowTipBtn then
		slot0._showFlowTipBtn = true

		slot0:_updateNames()
	end
end

function slot0._onSelectMainStorySection(slot0)
	if DungeonMainStoryModel.instance:getChapterList(DungeonMainStoryModel.instance:getSelectedSectionId()) and #slot2 > 0 then
		slot0:_selectFocusNormalChapter(slot2[#slot2].id)

		return
	end

	slot0:_selectFocusNormalChapter()
end

function slot0._selectFocusNormalChapter(slot0, slot1)
	slot0:_beFocusChapter(slot1)
end

function slot0.onOpen(slot0)
end

function slot0._onOnFocusNormalChapter(slot0, slot1)
	slot0:_beFocusChapter(slot1)
end

function slot0._beFocusChapter(slot0, slot1)
	slot2 = slot1 and DungeonConfig.instance:getChapterDivideSectionId(slot1)
	slot0._sameSectionId = slot2 == slot0._targetSectionId
	slot0._beFocusChapterId = slot1
	slot0._targetSectionId = slot2

	slot0:_playChapterFocusEffect()
end

function slot0._killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0._tweenHorizontalPosition(slot0)
	slot0:_killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._scrollchapter.horizontalNormalizedPosition, 0, DungeonMainStoryEnum.AnimTime, slot0._tweenFrameCallback, nil, slot0)
end

function slot0._tweenFrameCallback(slot0, slot1)
	slot0._scrollchapter.horizontalNormalizedPosition = slot1
end

function slot0._playChapterFocusEffect(slot0)
	slot0._hasOldSelectedSectionItem = nil

	if #slot0._showChapterItemList > 0 then
		slot0:_tweenHorizontalPosition()

		for slot4, slot5 in ipairs(slot0._showChapterItemList) do
			slot5:playCloseAnim()
		end

		for slot4, slot5 in pairs(slot0._sectionList) do
			slot5:moveToUnFoldPosX()
		end

		if slot0._curSelectedSectionItem and not slot0._sameSectionId then
			slot0._hasOldSelectedSectionItem = true

			slot0._curSelectedSectionItem:playAnimName("close")
		end

		TaskDispatcher.cancelTask(slot0._applyFocusChapter, slot0)
		TaskDispatcher.runDelay(slot0._applyFocusChapter, slot0, DungeonMainStoryEnum.AnimTime)
		slot0:_startBlock(DungeonMainStoryEnum.AnimTime)

		return
	end

	slot0:_applyFocusChapter()
end

function slot0._applyFocusChapter(slot0)
	slot0:_focusNormalChapter(slot0._beFocusChapterId)
end

function slot0._focusNormalChapter(slot0, slot1)
	slot0._curFocusChapterId = nil
	slot0._curFocusChapterPosX = nil

	if slot1 and DungeonConfig.instance:getChapterDivideSectionId(slot1) then
		DungeonMainStoryModel.instance:setSectionSelected(slot2)

		slot0._curFocusChapterId = slot1
	end

	slot0:_showAllChapterList()

	if slot0._curFocusChapterPosX then
		slot0._scrollchapter.movementType = 2

		recthelper.setAnchorX(slot0._gocontent.transform, -(slot0._curFocusChapterPosX - recthelper.getWidth(slot0._scrollchapter.transform) / 2))
		TaskDispatcher.cancelTask(slot0._resetMovementType, slot0)
		TaskDispatcher.runDelay(slot0._resetMovementType, slot0, 0)
	end

	TaskDispatcher.cancelTask(slot0.onScrollChange, slot0)
	TaskDispatcher.runDelay(slot0.onScrollChange, slot0, 0)
	slot0:onScrollChange()
end

slot1 = "DungeonViewMainStoryBlock"

function slot0._startBlock(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._endBlock, slot0)
	TaskDispatcher.runDelay(slot0._endBlock, slot0, slot1 + DungeonMainStoryEnum.SectionAnimTime)
	UIBlockMgr.instance:startBlock(uv0)
end

function slot0._endBlock(slot0)
	UIBlockMgr.instance:endBlock(uv0)
end

function slot0._resetMovementType(slot0)
	slot0._scrollchapter.movementType = 1
end

function slot0._initSectionSelected(slot0)
	for slot4, slot5 in ipairs(lua_chapter_divide.configList) do
		if DungeonMainStoryModel.instance:getChapterList(slot5.sectionId) and #slot7 > 0 and not DungeonModel.instance:chapterIsLock(slot7[1].id) then
			DungeonMainStoryModel.instance:setSectionSelected(slot6)
		end
	end
end

function slot0._showAllChapterList(slot0)
	tabletool.clear(slot0._showChapterItemList)
	slot0:_setSelectedSectionItem(nil)

	slot0._startPosX = 147.5
	slot0._posX = slot0._startPosX
	slot0._sectionPosX = slot0._startPosX
	slot1 = 0

	for slot5, slot6 in ipairs(lua_chapter_divide.configList) do
		if DungeonMainStoryModel.instance:getChapterList(slot6.sectionId) and #slot8 > 0 then
			slot0:_showOneSectionChapterList(slot7, slot8, slot1)

			slot1 = slot1 + #slot8
		end

		slot0._posX = slot0._posX + DungeonMainStoryEnum.SectionSpace
	end

	recthelper.setWidth(slot0._gocontent.transform, slot0._posX)
end

function slot0._getSectionItem(slot0, slot1)
	if not slot0._sectionList[slot1] then
		slot4 = gohelper.cloneInPlace(slot0._gotemplatecell, "section")

		gohelper.setActive(slot4, true)

		slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes.section_item, slot4, tostring(slot1)), DungeonSectionItem)
		slot0._sectionList[slot1] = slot2
		slot6 = slot2.viewGO.transform
		slot7 = Vector2(0, 1)
		slot6.pivot = slot7
		slot6.anchorMin = slot7
		slot6.anchorMax = slot7

		recthelper.setWidth(slot6, DungeonMainStoryEnum.ChapterWidth.Section)
	end

	return slot2
end

function slot0._getChapterItem(slot0, slot1, slot2)
	if not slot0._chapterList[slot1] then
		slot6 = gohelper.cloneInPlace(slot0._gotemplatecell, "cell" .. slot2 - 1)

		gohelper.setActive(slot6, true)

		slot0._chapterList[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(DungeonModel.instance:isSpecialMainPlot(slot1) and slot0.viewContainer:getSetting().otherRes.mini_item or slot0.viewContainer:getSetting().otherRes[1], slot6, slot4 and "mini_item" or LuaListScrollView.PrefabInstName), slot4 and DungeonChapterMiniItem or DungeonChapterItem)

		if slot4 then
			recthelper.setWidth(slot6.transform, DungeonMainStoryEnum.ChapterWidth.Special)
			recthelper.setWidth(slot3.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Special)
		else
			recthelper.setWidth(slot6.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
			recthelper.setWidth(slot3.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
		end

		slot8 = slot3.viewGO.transform
		slot9 = slot0._anchorVec
		slot8.pivot = slot9
		slot8.anchorMin = slot9
		slot8.anchorMax = slot9
	end

	return slot3
end

function slot0._showSectionItem(slot0, slot1)
	slot0:_getSectionItem(slot1):onUpdateMO(lua_chapter_divide.configDict[slot1])

	if DungeonMainStoryModel.instance:sectionIsSelected(slot1) then
		slot0:_setSelectedSectionItem(slot2)
		slot2:playAnimName("unfold")
	end

	slot3 = slot0._posX

	recthelper.setAnchor(slot2.viewGO.transform.parent, slot3, DungeonMainStoryEnum.ChapterPosY.Section)
	slot2:setPosX(slot3)
	slot2:setUnFoldPosX(slot0._sectionPosX)

	slot0._posX = slot0._posX + DungeonMainStoryEnum.ChapterWidth.Section
	slot0._sectionPosX = slot0._sectionPosX + DungeonMainStoryEnum.ChapterWidth.Section

	if slot0._posX ~= slot0._sectionPosX then
		recthelper.setAnchor(slot2.viewGO.transform.parent, slot0._sectionPosX, DungeonMainStoryEnum.ChapterPosY.Section)
		slot2:moveToPosX()
	end
end

function slot0._hideChpaterList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0._chapterList[slot6.id] then
			recthelper.setAnchorY(slot7.viewGO.transform.parent, 2000)
		end
	end
end

function slot0._showOneSectionChapterList(slot0, slot1, slot2, slot3)
	slot0:_showSectionItem(slot1)

	if not DungeonMainStoryModel.instance:sectionIsSelected(slot1) then
		slot0:_hideChpaterList(slot2)

		return
	end

	slot0._posX = slot0._posX + DungeonMainStoryEnum.ChapterStartPosX

	for slot7, slot8 in ipairs(slot2) do
		slot9 = DungeonModel.instance:isSpecialMainPlot(slot8.id)
		slot10 = slot0:_getChapterItem(slot8.id, slot3 + slot7)

		slot10:onUpdateMO(slot8)

		slot0._showChapterItemList[slot7] = slot10

		if slot10:getIsPlayCloseAnim() then
			slot10:playIdleAnim()
		end

		if slot8.id == slot0._curFocusChapterId then
			slot0._curFocusChapterPosX = slot0._posX
		end

		if slot9 then
			recthelper.setAnchor(slot10.viewGO.transform.parent, slot11, DungeonMainStoryEnum.ChapterPosY.Special)

			slot0._posX = slot0._posX + DungeonMainStoryEnum.ChapterWidth.Special
		else
			recthelper.setAnchor(slot10.viewGO.transform.parent, slot11, DungeonMainStoryEnum.ChapterPosY.Normal)

			slot0._posX = slot0._posX + DungeonMainStoryEnum.ChapterWidth.Normal
		end

		if slot7 ~= #slot2 then
			slot0._posX = slot0._posX + DungeonMainStoryEnum.ChapterSpace
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._resetMovementType, slot0)
	TaskDispatcher.cancelTask(slot0._applyFocusChapter, slot0)
	TaskDispatcher.cancelTask(slot0.onScrollChange, slot0)
	slot0:_endBlock()
end

return slot0
