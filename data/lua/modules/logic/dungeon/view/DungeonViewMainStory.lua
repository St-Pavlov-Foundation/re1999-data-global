module("modules.logic.dungeon.view.DungeonViewMainStory", package.seeall)

local var_0_0 = class("DungeonViewMainStory", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollchapter = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter/content")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_story/#go_mainstorytip")
	arg_1_0._btntip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/#go_mainstorytip/#btn_tip")
	arg_1_0._btnfirst = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/#btn_first")
	arg_1_0._txttipname = gohelper.findChildText(arg_1_0.viewGO, "#go_story/#go_mainstorytip/#txt_tipname")
	arg_1_0._txttipnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_story/#go_mainstorytip/#txt_tipname_en")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntip:AddClickListener(arg_2_0._btntipOnClick, arg_2_0)
	arg_2_0._btnfirst:AddClickListener(arg_2_0._btnfirstOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntip:RemoveClickListener()
	arg_3_0._btnfirst:RemoveClickListener()
end

function var_0_0._btnfirstOnClick(arg_4_0)
	if arg_4_0._previewChapterId then
		arg_4_0:_onOnFocusNormalChapter(arg_4_0._previewChapterId)
	end
end

function var_0_0._btntipOnClick(arg_5_0)
	if arg_5_0._curSelectedSectionItem then
		arg_5_0._curSelectedSectionItem:externalClickTip()
	end
end

function var_0_0._setSelectedSectionItem(arg_6_0, arg_6_1)
	arg_6_0._curSelectedSectionItem = arg_6_1

	if not arg_6_1 then
		gohelper.setActive(arg_6_0._gotip, false)
	else
		arg_6_0:_updateNames()
	end
end

function var_0_0._updateNames(arg_7_0)
	arg_7_0._txttipname.text = arg_7_0._curSelectedSectionItem:getSectionName()

	if arg_7_0._txttipnameen then
		arg_7_0._txttipnameen.text = arg_7_0._curSelectedSectionItem:getSectionNameEn()
	end
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.addUIClickAudio(arg_8_0._btntip.gameObject, AudioEnum.UI.Play_UI_Copies)

	arg_8_0._tipAnimator = arg_8_0._gotip:GetComponent("Animator")
	arg_8_0._initTipPosX = recthelper.getAnchorX(arg_8_0._gotip.transform)
	arg_8_0._sectionList = arg_8_0:getUserDataTb_()
	arg_8_0._chapterList = arg_8_0:getUserDataTb_()
	arg_8_0._chapterPosMap = {}
	arg_8_0._curSelectedSectionItem = nil
	arg_8_0._showChapterItemList = arg_8_0:getUserDataTb_()
	arg_8_0._posX = 0
	arg_8_0._anchorVec = Vector2(0, 1)
	arg_8_0._targetSectionId = -1
	arg_8_0._gocontenttransform = arg_8_0._gocontent.transform

	local var_8_0 = arg_8_0._gocontenttransform
	local var_8_1 = arg_8_0._anchorVec

	var_8_0.pivot = var_8_1
	var_8_0.anchorMin = var_8_1
	var_8_0.anchorMax = var_8_1
	var_8_0.anchoredPosition = Vector2.zero

	recthelper.setHeight(var_8_0, 748)

	arg_8_0._gotemplatecell = gohelper.findChild(arg_8_0.viewGO, "#go_story/chapterlist/#scroll_chapter/content/templatecell")

	gohelper.setActive(arg_8_0._gotemplatecell, false)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.SelectMainStorySection, arg_8_0._onSelectMainStorySection, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.UnfoldMainStorySection, arg_8_0._onUnfoldMainStorySection, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.FakeUnfoldMainStorySection, arg_8_0._onFakeUnfoldMainStorySection, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnFocusNormalChapter, arg_8_0._onOnFocusNormalChapter, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnCheckChapterUnlock, arg_8_0._onCheckChapterUnlock, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnFocusLastEarlyAccessChapter, arg_8_0._onFocusLastEarlyAccessChapter, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_8_0._onUpdateDungeonInfo, arg_8_0)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_8_0._onRefreshActivity, arg_8_0)
	gohelper.setActive(arg_8_0._btnfirst, false)
end

function var_0_0._onUpdateDungeonInfo(arg_9_0)
	arg_9_0:_refreshPreviewFlag()
end

function var_0_0._onRefreshActivity(arg_10_0)
	arg_10_0:_refreshPreviewFlag()
end

function var_0_0._refreshPreviewFlag(arg_11_0)
	if not arg_11_0._previewChapterPosX or not arg_11_0._previewChapterId then
		return
	end

	if not DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_11_0._previewChapterId) then
		arg_11_0._previewChapterPosX = nil
		arg_11_0._previewChapterId = nil

		gohelper.setActive(arg_11_0._btnfirst, false)
	end
end

function var_0_0.onScrollChange(arg_12_0)
	if not arg_12_0._curSelectedSectionItem then
		arg_12_0._showFlowTipBtn = false

		gohelper.setActive(arg_12_0._gotip, false)

		return
	end

	local var_12_0 = recthelper.getAnchorX(arg_12_0._gocontenttransform)
	local var_12_1 = arg_12_0._curSelectedSectionItem:getPosX()
	local var_12_2 = var_12_0 <= -var_12_1

	if arg_12_0._forceHideTip then
		var_12_2 = false
	end

	if var_12_2 then
		local var_12_3 = var_12_1 + var_12_0
		local var_12_4 = UnityEngine.Screen.width / UnityEngine.Screen.height > 2
		local var_12_5 = arg_12_0._curSelectedSectionItem:getLineWidth() + var_12_3 + DungeonMainStoryEnum.FlowLineOffsetWidth + (var_12_4 and DungeonMainStoryEnum.FlowTipOffsetX or 0)
		local var_12_6 = var_12_5 - DungeonMainStoryEnum.FlowLineMinWidth

		recthelper.setAnchorX(arg_12_0._gotip.transform, var_12_6 < 0 and arg_12_0._initTipPosX + var_12_6 or arg_12_0._initTipPosX)
		recthelper.setWidth(arg_12_0._btntip.transform, var_12_5)

		if arg_12_0._lastFrameCount ~= Time.frameCount then
			local var_12_7 = arg_12_0._openSelectedSectionFrame and Time.frameCount - arg_12_0._openSelectedSectionFrame <= 3

			arg_12_0._tipAnimator:Play(var_12_7 and "open" or "idle", 0, 0)

			arg_12_0._lastFrameCount = Time.frameCount
		else
			return
		end
	end

	gohelper.setActive(arg_12_0._gotip, var_12_2)
	arg_12_0._curSelectedSectionItem:setTipVisible(not var_12_2 and not arg_12_0._forceHideTip)

	if not arg_12_0._forceHideTip and arg_12_0:_checkFirstBtnShow() then
		TaskDispatcher.cancelTask(arg_12_0._checkFirstBtnShow, arg_12_0)
		TaskDispatcher.runRepeat(arg_12_0._checkFirstBtnShow, arg_12_0, 0, 10)
	end

	if not arg_12_0._showFlowTipBtn then
		arg_12_0._showFlowTipBtn = true

		arg_12_0:_updateNames()
	end
end

function var_0_0._checkFirstBtnShow(arg_13_0)
	local var_13_0 = recthelper.getAnchorX(arg_13_0._gocontenttransform)
	local var_13_1 = arg_13_0:_getScreenWidth()
	local var_13_2 = arg_13_0._previewChapterPosX and var_13_1 < var_13_0 + arg_13_0._previewChapterPosX

	gohelper.setActive(arg_13_0._btnfirst, var_13_2)

	if not var_13_2 then
		TaskDispatcher.cancelTask(arg_13_0._checkFirstBtnShow, arg_13_0)
	end

	return var_13_2
end

function var_0_0._getScreenWidth(arg_14_0)
	return recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
end

function var_0_0._onUnfoldMainStorySection(arg_15_0)
	local var_15_0 = DungeonMainStoryModel.instance:getSelectedSectionId()

	if var_15_0 and var_15_0 ~= 0 then
		DungeonMainStoryModel.instance:setSectionSelected(nil)
		arg_15_0:_onSelectMainStorySection()
	end
end

function var_0_0._onFakeUnfoldMainStorySection(arg_16_0)
	local var_16_0 = DungeonMainStoryModel.instance:getSelectedSectionId()

	if var_16_0 and var_16_0 ~= 0 then
		DungeonMainStoryModel.instance:clearSectionSelected()

		arg_16_0._isFakeUnfold = true

		arg_16_0:_onSelectMainStorySection()

		arg_16_0._isFakeUnfold = false

		DungeonMainStoryModel.instance:setSectionSelected(var_16_0)
	end
end

function var_0_0._onSelectMainStorySection(arg_17_0)
	local var_17_0 = DungeonMainStoryModel.instance:getSelectedSectionId()
	local var_17_1 = DungeonMainStoryModel.instance:getChapterList(var_17_0)

	if var_17_1 and #var_17_1 > 0 then
		arg_17_0:_selectFocusNormalChapter(var_17_1[#var_17_1].id)

		return
	end

	arg_17_0:_selectFocusNormalChapter()
end

function var_0_0._selectFocusNormalChapter(arg_18_0, arg_18_1)
	arg_18_0:_beFocusChapter(arg_18_1)
end

function var_0_0.onOpen(arg_19_0)
	return
end

function var_0_0._onFocusLastEarlyAccessChapter(arg_20_0)
	local var_20_0 = DungeonConfig.instance:getLastEarlyAccessChapterId()

	arg_20_0:_onOnFocusNormalChapter(var_20_0)
end

function var_0_0._onCheckChapterUnlock(arg_21_0)
	DungeonMainStoryModel.instance:forceUpdateChapterList()
	arg_21_0:_onSelectMainStorySection()
end

function var_0_0._onOnFocusNormalChapter(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 and DungeonConfig.instance:getChapterDivideSectionId(arg_22_1)

	if var_22_0 == arg_22_0._targetSectionId then
		local var_22_1 = arg_22_1 and arg_22_0._chapterPosMap[arg_22_1]

		if var_22_1 then
			arg_22_0:_moveToChapterPos(var_22_1)

			return
		end
	end

	if not var_22_0 then
		arg_22_0:_onSelectMainStorySection()

		return
	end

	arg_22_0:_beFocusChapter(arg_22_1)
end

function var_0_0._beFocusChapter(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 and DungeonConfig.instance:getChapterDivideSectionId(arg_23_1)

	arg_23_0._sameSectionId = var_23_0 == arg_23_0._targetSectionId
	arg_23_0._beFocusChapterId = arg_23_1
	arg_23_0._targetSectionId = var_23_0

	arg_23_0:_playChapterFocusEffect()
end

function var_0_0._killTween(arg_24_0)
	if arg_24_0.tweenId then
		ZProj.TweenHelper.KillById(arg_24_0.tweenId)

		arg_24_0.tweenId = nil
	end
end

function var_0_0._tweenHorizontalPosition(arg_25_0)
	arg_25_0:_killTween()

	arg_25_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_25_0._scrollchapter.horizontalNormalizedPosition, 0, DungeonMainStoryEnum.AnimTime, arg_25_0._tweenFrameCallback, nil, arg_25_0)
end

function var_0_0._tweenFrameCallback(arg_26_0, arg_26_1)
	arg_26_0._scrollchapter.horizontalNormalizedPosition = arg_26_1
end

function var_0_0._playChapterFocusEffect(arg_27_0)
	arg_27_0._previewChapterPosX = nil
	arg_27_0._hasOldSelectedSectionItem = nil

	if #arg_27_0._showChapterItemList > 0 then
		arg_27_0:_tweenHorizontalPosition()

		for iter_27_0, iter_27_1 in ipairs(arg_27_0._showChapterItemList) do
			iter_27_1:playCloseAnim()
		end

		for iter_27_2, iter_27_3 in pairs(arg_27_0._sectionList) do
			iter_27_3:moveToUnFoldPosX()
		end

		if arg_27_0._curSelectedSectionItem and not arg_27_0._sameSectionId then
			arg_27_0._hasOldSelectedSectionItem = true

			arg_27_0._curSelectedSectionItem:playAnimName("close")
		end

		if arg_27_0._isFakeUnfold then
			arg_27_0._isFakeUnfold = false

			arg_27_0:_applyFocusChapter()

			return
		end

		TaskDispatcher.cancelTask(arg_27_0._applyFocusChapter, arg_27_0)
		TaskDispatcher.runDelay(arg_27_0._applyFocusChapter, arg_27_0, DungeonMainStoryEnum.AnimTime)
		arg_27_0:_startBlock(DungeonMainStoryEnum.AnimTime)

		return
	end

	arg_27_0:_applyFocusChapter()
end

function var_0_0._applyFocusChapter(arg_28_0)
	arg_28_0:_focusNormalChapter(arg_28_0._beFocusChapterId)
end

function var_0_0._focusNormalChapter(arg_29_0, arg_29_1)
	arg_29_0._curFocusChapterId = nil

	local var_29_0 = arg_29_0._curSelectedSectionItem ~= nil

	if arg_29_1 then
		local var_29_1 = DungeonConfig.instance:getChapterDivideSectionId(arg_29_1)

		if var_29_1 then
			DungeonMainStoryModel.instance:setSectionSelected(var_29_1)

			arg_29_0._curFocusChapterId = arg_29_1
		end
	end

	arg_29_0:_showAllChapterList()

	local var_29_2 = arg_29_0._curFocusChapterId and arg_29_0._chapterPosMap[arg_29_0._curFocusChapterId]

	arg_29_0:_moveToChapterPos(var_29_2, var_29_0)

	arg_29_0._forceHideTip = true

	arg_29_0:onScrollChange()

	arg_29_0._forceHideTip = false
end

function var_0_0._moveToChapterPos(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 then
		arg_30_0._scrollchapter.movementType = 2

		local var_30_0 = -(arg_30_1 - recthelper.getWidth(arg_30_0._scrollchapter.transform) / 2)

		arg_30_0:_clearTween()
		TaskDispatcher.cancelTask(arg_30_0._resetMovementType, arg_30_0)
		TaskDispatcher.cancelTask(arg_30_0._delaySetContentPos, arg_30_0)

		if not (UnityEngine.Screen.width / UnityEngine.Screen.height > 2) and arg_30_0._curSelectedSectionItem and arg_30_0._curSelectedSectionItem:getSectionId() > DungeonMainStoryEnum.FirstSectionId then
			arg_30_0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(arg_30_0._gocontent.transform, var_30_0, DungeonMainStoryEnum.SectionAnimTime, arg_30_0._moveDone, arg_30_0)

			TaskDispatcher.cancelTask(arg_30_0.onScrollChange, arg_30_0)
			TaskDispatcher.runDelay(arg_30_0.onScrollChange, arg_30_0, 0)
		else
			arg_30_0._contentPos = var_30_0

			recthelper.setAnchorX(arg_30_0._gocontent.transform, var_30_0)
			TaskDispatcher.runDelay(arg_30_0._delaySetContentPos, arg_30_0, 0)
		end
	end
end

function var_0_0._moveDone(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._resetMovementType, arg_31_0)
	TaskDispatcher.runDelay(arg_31_0._resetMovementType, arg_31_0, 0)
end

function var_0_0._delaySetContentPos(arg_32_0)
	recthelper.setAnchorX(arg_32_0._gocontent.transform, arg_32_0._contentPos)
	TaskDispatcher.runDelay(arg_32_0._resetMovementType, arg_32_0, 0)
	TaskDispatcher.runDelay(arg_32_0.onScrollChange, arg_32_0, 0)
end

function var_0_0._clearTween(arg_33_0)
	if arg_33_0._tweenPosX then
		ZProj.TweenHelper.KillById(arg_33_0._tweenPosX)

		arg_33_0._tweenPosX = nil
	end
end

local var_0_1 = "DungeonViewMainStoryBlock"

function var_0_0._startBlock(arg_34_0, arg_34_1)
	TaskDispatcher.cancelTask(arg_34_0._endBlock, arg_34_0)
	TaskDispatcher.runDelay(arg_34_0._endBlock, arg_34_0, arg_34_1 + DungeonMainStoryEnum.SectionAnimTime)
	UIBlockMgr.instance:startBlock(var_0_1)
end

function var_0_0._endBlock(arg_35_0)
	UIBlockMgr.instance:endBlock(var_0_1)
end

function var_0_0._resetMovementType(arg_36_0)
	arg_36_0._scrollchapter.movementType = 1
end

function var_0_0._showAllChapterList(arg_37_0)
	tabletool.clear(arg_37_0._showChapterItemList)
	tabletool.clear(arg_37_0._chapterPosMap)
	arg_37_0:_setSelectedSectionItem(nil)

	arg_37_0._startPosX = 147.5
	arg_37_0._posX = arg_37_0._startPosX
	arg_37_0._sectionPosX = arg_37_0._startPosX
	arg_37_0._previewChapterPosX = nil
	arg_37_0._previewChapterId = nil

	gohelper.setActive(arg_37_0._btnfirst, false)

	local var_37_0 = 0

	for iter_37_0, iter_37_1 in ipairs(lua_chapter_divide.configList) do
		local var_37_1 = iter_37_1.sectionId
		local var_37_2 = DungeonMainStoryModel.instance:getChapterList(var_37_1)

		if var_37_2 and #var_37_2 > 0 then
			arg_37_0:_showOneSectionChapterList(var_37_1, var_37_2, var_37_0)

			var_37_0 = #lua_chapter_divide.configDict[var_37_1].chapterId
		end

		arg_37_0._posX = arg_37_0._posX + DungeonMainStoryEnum.SectionSpace
	end

	recthelper.setWidth(arg_37_0._gocontent.transform, arg_37_0._posX)
end

function var_0_0._getSectionItem(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0._sectionList[arg_38_1]

	if not var_38_0 then
		local var_38_1 = arg_38_0.viewContainer:getSetting().otherRes.section_item
		local var_38_2 = gohelper.cloneInPlace(arg_38_0._gotemplatecell, "section")

		gohelper.setActive(var_38_2, true)

		local var_38_3 = arg_38_0:getResInst(var_38_1, var_38_2, tostring(arg_38_1))

		var_38_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_38_3, DungeonSectionItem)
		arg_38_0._sectionList[arg_38_1] = var_38_0

		local var_38_4 = var_38_0.viewGO.transform
		local var_38_5 = Vector2(0, 1)

		var_38_4.pivot = var_38_5
		var_38_4.anchorMin = var_38_5
		var_38_4.anchorMax = var_38_5

		recthelper.setWidth(var_38_4, DungeonMainStoryEnum.ChapterWidth.Section)
	end

	return var_38_0
end

function var_0_0._getChapterItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0._chapterList[arg_39_1]

	if not var_39_0 then
		local var_39_1 = DungeonModel.instance:isSpecialMainPlot(arg_39_1)
		local var_39_2 = var_39_1 and arg_39_0.viewContainer:getSetting().otherRes.mini_item or arg_39_0.viewContainer:getSetting().otherRes[1]
		local var_39_3 = gohelper.cloneInPlace(arg_39_0._gotemplatecell, "cell" .. arg_39_2 - 1)

		gohelper.setActive(var_39_3, true)

		local var_39_4 = arg_39_0:getResInst(var_39_2, var_39_3, var_39_1 and "mini_item" or LuaListScrollView.PrefabInstName)

		var_39_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_39_4, var_39_1 and DungeonChapterMiniItem or DungeonChapterItem)
		arg_39_0._chapterList[arg_39_1] = var_39_0

		if var_39_1 then
			recthelper.setWidth(var_39_3.transform, DungeonMainStoryEnum.ChapterWidth.Special)
			recthelper.setWidth(var_39_0.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Special)
		else
			recthelper.setWidth(var_39_3.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
			recthelper.setWidth(var_39_0.viewGO.transform, DungeonMainStoryEnum.ChapterWidth.Normal)
		end

		local var_39_5 = var_39_0.viewGO.transform
		local var_39_6 = arg_39_0._anchorVec

		var_39_5.pivot = var_39_6
		var_39_5.anchorMin = var_39_6
		var_39_5.anchorMax = var_39_6
	end

	return var_39_0
end

function var_0_0._showSectionItem(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:_getSectionItem(arg_40_1)

	var_40_0:onUpdateMO(lua_chapter_divide.configDict[arg_40_1])

	if DungeonMainStoryModel.instance:sectionIsSelected(arg_40_1) then
		arg_40_0:_setSelectedSectionItem(var_40_0)
		var_40_0:playAnimName("unfold")
	end

	local var_40_1 = arg_40_0._posX
	local var_40_2 = arg_40_0._sectionPosX

	recthelper.setAnchor(var_40_0.viewGO.transform.parent, var_40_1, DungeonMainStoryEnum.ChapterPosY.Section)
	var_40_0:setPosX(var_40_1)
	var_40_0:setUnFoldPosX(arg_40_0._sectionPosX)

	arg_40_0._posX = arg_40_0._posX + DungeonMainStoryEnum.ChapterWidth.Section
	arg_40_0._sectionPosX = arg_40_0._sectionPosX + DungeonMainStoryEnum.ChapterWidth.Section + DungeonMainStoryEnum.SectionSpace

	if var_40_1 ~= var_40_2 then
		recthelper.setAnchor(var_40_0.viewGO.transform.parent, var_40_2, DungeonMainStoryEnum.ChapterPosY.Section)
		var_40_0:moveToPosX()
	end
end

function var_0_0._hideChpaterList(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		local var_41_0 = arg_41_0._chapterList[iter_41_1.id]

		if var_41_0 then
			recthelper.setAnchorY(var_41_0.viewGO.transform.parent, 2000)
		end
	end
end

function var_0_0._showOneSectionChapterList(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0:_showSectionItem(arg_42_1)

	if not DungeonMainStoryModel.instance:sectionIsSelected(arg_42_1) then
		arg_42_0:_hideChpaterList(arg_42_2)

		return
	end

	arg_42_0._openSelectedSectionFrame = Time.frameCount
	arg_42_0._posX = arg_42_0._posX + DungeonMainStoryEnum.ChapterStartPosX

	for iter_42_0, iter_42_1 in ipairs(arg_42_2) do
		local var_42_0 = DungeonModel.instance:isSpecialMainPlot(iter_42_1.id)
		local var_42_1 = arg_42_0:_getChapterItem(iter_42_1.id, arg_42_3 + iter_42_0)

		var_42_1:onUpdateMO(iter_42_1)

		arg_42_0._showChapterItemList[iter_42_0] = var_42_1

		if var_42_1:getIsPlayCloseAnim() then
			var_42_1:playIdleAnim()
		end

		local var_42_2 = arg_42_0._posX

		arg_42_0._chapterPosMap[iter_42_1.id] = var_42_2

		if DungeonMainStoryModel.instance:showPreviewChapterFlag(iter_42_1.id) then
			arg_42_0._previewChapterPosX = var_42_2 + DungeonMainStoryEnum.PreviewOffsetX
			arg_42_0._previewChapterId = iter_42_1.id
		end

		if var_42_0 then
			recthelper.setAnchor(var_42_1.viewGO.transform.parent, var_42_2, DungeonMainStoryEnum.ChapterPosY.Special)

			arg_42_0._posX = arg_42_0._posX + DungeonMainStoryEnum.ChapterWidth.Special
		else
			recthelper.setAnchor(var_42_1.viewGO.transform.parent, var_42_2, DungeonMainStoryEnum.ChapterPosY.Normal)

			arg_42_0._posX = arg_42_0._posX + DungeonMainStoryEnum.ChapterWidth.Normal
		end

		if iter_42_0 ~= #arg_42_2 then
			arg_42_0._posX = arg_42_0._posX + DungeonMainStoryEnum.ChapterSpace
		end
	end
end

function var_0_0.onClose(arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._delaySetContentPos, arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._resetMovementType, arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._applyFocusChapter, arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0.onScrollChange, arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._checkFirstBtnShow, arg_43_0)
	arg_43_0:_endBlock()
	arg_43_0:_killTween()
	arg_43_0:_clearTween()
end

return var_0_0
