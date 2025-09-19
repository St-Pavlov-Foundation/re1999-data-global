module("modules.logic.dungeon.view.map.DungeonMapEpisode", package.seeall)

local var_0_0 = class("DungeonMapEpisode", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobgcanvas = gohelper.findChild(arg_1_0.viewGO, "bgcanvas")
	arg_1_0._gobgcontainerold = gohelper.findChild(arg_1_0.viewGO, "bgcanvas/#go_bgcontainerold")
	arg_1_0._gobgcontainer = gohelper.findChild(arg_1_0.viewGO, "bgcanvas/#go_bgcontainer")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
	arg_1_0._gochaptercontentitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/#go_chaptercontentitem")
	arg_1_0._gochapterlist = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist")
	arg_1_0._gochapterlineItem = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem")
	arg_1_0._goitemline = gohelper.findChild(arg_1_0.viewGO, "#go_res/chapter/#go_chapterlist/#go_itemline")
	arg_1_0._goBgCg = gohelper.findChild(arg_1_0.viewGO, "bgcanvas/#go_bgcg")
	arg_1_0.bgCgCtrl = arg_1_0._goBgCg:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_1_0.animBgCg = arg_1_0._goBgCg:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goUnlockedBg = gohelper.findChild(arg_1_0._goBgCg, "unlocked")
	arg_1_0._unlocksimagecgbg = gohelper.findChildSingleImage(arg_1_0._goUnlockedBg, "#simage_cgbg")
	arg_1_0._unlockimagecgbg = gohelper.findChildImage(arg_1_0._goUnlockedBg, "#simage_cgbg")
	arg_1_0._goLockedBg = gohelper.findChild(arg_1_0._goBgCg, "locked")
	arg_1_0._locksimagecgbg = gohelper.findChildSingleImage(arg_1_0._goLockedBg, "bgmask/#simage_cgbg")
	arg_1_0._lockimagecgbg = gohelper.findChildImage(arg_1_0._goLockedBg, "bgmask/#simage_cgbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	DungeonModel.instance.chapterBgTweening = false
	arg_4_0._chapterLineItemList = arg_4_0:getUserDataTb_()
	arg_4_0._chapterLineList = arg_4_0:getUserDataTb_()
	arg_4_0._rectmask2D = arg_4_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_4_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_4_0._scrollcontent.gameObject, DungeonMapEpisodeAudio, arg_4_0._scrollcontent)
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._scrollcontent.gameObject)

	arg_4_0._drag:AddDragBeginListener(arg_4_0._onDragBeginHandler, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0._onDragEndHandler, arg_4_0)

	arg_4_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_4_0._scrollcontent.gameObject)

	arg_4_0._touch:AddClickDownListener(arg_4_0._onClickDownHandler, arg_4_0)

	arg_4_0._scrollcontent:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = 0.5

	gohelper.setActive(arg_4_0._gochaptercontentitem, false)

	arg_4_0._bgCanvas = arg_4_0._gobgcontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._olgBgCanvas = arg_4_0._gobgcontainerold:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._realscrollcontent = arg_4_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_4_0._fadeTime = 1
end

function var_0_0._onScrollValueChanged(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:_checkEpisodeVision(arg_5_1, arg_5_2)
end

function var_0_0._checkEpisodeVision(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._scrollPosX or math.abs(arg_6_0._scrollPosX - arg_6_1) >= 0.01 then
		if arg_6_0._scrollPosX then
			arg_6_0:_onCheckVision()
		end

		arg_6_0._scrollPosX = arg_6_1
	end

	TaskDispatcher.cancelTask(arg_6_0._onEndScroll, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._onEndScroll, arg_6_0, 0.1)
end

function var_0_0._onCheckVision(arg_7_0)
	if arg_7_0._chapterLayout then
		arg_7_0._chapterLayout:CheckVision()
	end
end

function var_0_0._onEndScroll(arg_8_0)
	arg_8_0._scrollPosX = nil

	arg_8_0:_onCheckVision()
end

function var_0_0._initChapterItem(arg_9_0)
	arg_9_0:_updateChapterList()
	arg_9_0:changeChapter(DungeonModel.instance.curLookChapterId)
end

function var_0_0._onDragBeginHandler(arg_10_0)
	arg_10_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_11_0)
	arg_11_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_12_0)
	arg_12_0._audioScroll:onClickDown()
end

function var_0_0._updateChapterList(arg_13_0)
	arg_13_0._chapterId = arg_13_0.viewParam.chapterId
	arg_13_0._isResChapter = DungeonConfig.instance:getChapterCO(arg_13_0._chapterId).type ~= DungeonEnum.ChapterType.Normal

	if not arg_13_0._isResChapter then
		return
	end

	if arg_13_0._isResChapter then
		gohelper.setActive(arg_13_0._gochapterlist, false)

		return
	end

	for iter_13_0 = 1, #arg_13_0._chapterLineItemList do
		arg_13_0._chapterLineItemList[iter_13_0]:destroyView()

		arg_13_0._chapterLineItemList[iter_13_0] = nil
	end

	for iter_13_1 = 1, #arg_13_0._chapterLineList do
		gohelper.destroy(arg_13_0._chapterLineList[iter_13_1])

		arg_13_0._chapterLineList[iter_13_1] = nil
	end

	local var_13_0 = DungeonChapterListModel.instance:getChapterList(arg_13_0._chapterId)

	if #var_13_0 <= 1 then
		return
	end

	for iter_13_2 = 1, #var_13_0 do
		if iter_13_2 == 1 then
			arg_13_0:_addLine()
		end

		arg_13_0:_addChapterItem(iter_13_2, var_13_0[iter_13_2])
		arg_13_0:_addLine()
	end
end

function var_0_0._addChapterItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = gohelper.clone(arg_14_0._gochapterlineItem, arg_14_0._gochapterlist, "ChapterLineItem")

	gohelper.setActive(var_14_0, true)

	local var_14_1 = DungeonMapChapterLineItem.New()

	var_14_1:initView(var_14_0, {
		index = arg_14_1,
		config = arg_14_2
	})
	table.insert(arg_14_0._chapterLineItemList, var_14_1)
end

function var_0_0._addLine(arg_15_0)
	local var_15_0 = gohelper.clone(arg_15_0._goitemline, arg_15_0._gochapterlist, "itemline")

	gohelper.setActive(var_15_0, true)
	table.insert(arg_15_0._chapterLineList, var_15_0)
end

function var_0_0.changeChapter(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._curChapter == arg_16_1

	arg_16_0._curChapter = arg_16_1
	DungeonModel.instance.curLookChapterId = arg_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._chapterLineItemList) do
		iter_16_1:updateStatus()
	end

	if var_16_0 then
		return
	end

	arg_16_0:_clearEpisodeListTween()

	if arg_16_1 ~= arg_16_0._curChapterId then
		if arg_16_0._curChapterId then
			DungeonAudio.instance:closeChapterAmbientSound(arg_16_0._curChapterId)
		end

		arg_16_0._curChapterId = arg_16_1

		DungeonAudio.instance:openChapterAmbientSound()
	end

	local var_16_1 = DungeonConfig.instance:getChapterCO(arg_16_0._curChapterId)

	arg_16_0._isResChapter = var_16_1.type ~= DungeonEnum.ChapterType.Normal

	arg_16_0:_switchLayout(arg_16_1)

	if arg_16_0._isResChapter then
		arg_16_0:_switchBg(arg_16_1)
	end

	arg_16_0:_loadNewLayout(arg_16_1)

	if arg_16_0._isResChapter and var_16_1.type ~= DungeonEnum.ChapterType.RoleStory then
		arg_16_0:_loadNewBg(arg_16_1)
	end

	arg_16_0:refreshRoleStoryBg()
	gohelper.setActive(arg_16_0._gobgcanvas, arg_16_0._isResChapter)
end

function var_0_0.refreshRoleStoryBg(arg_17_0)
	if DungeonConfig.instance:getChapterCO(arg_17_0._curChapterId).type ~= DungeonEnum.ChapterType.RoleStory then
		gohelper.setActive(arg_17_0._goBgCg, false)

		return
	end

	gohelper.setActive(arg_17_0._goBgCg, true)

	local var_17_0 = RoleStoryModel.instance:getCurStoryId()
	local var_17_1 = RoleStoryConfig.instance:getStoryById(var_17_0)
	local var_17_2 = var_17_1.cgUnlockEpisodeId
	local var_17_3 = var_17_2 == 0 or DungeonModel.instance:hasPassLevel(var_17_2)

	if var_17_3 and RoleStoryModel.instance:canPlayDungeonUnlockAnim(var_17_0) then
		if ViewMgr.instance:isOpen(ViewName.StoryView) then
			gohelper.setActive(arg_17_0._goUnlockedBg, false)
			gohelper.setActive(arg_17_0._goLockedBg, true)
			arg_17_0.animBgCg:Play("idle")
			arg_17_0:refreshRoleStoryLockBg(var_17_1)
		else
			RoleStoryModel.instance:setPlayDungeonUnlockAnimFlag(var_17_0)
			gohelper.setActive(arg_17_0._goUnlockedBg, true)
			gohelper.setActive(arg_17_0._goLockedBg, true)
			arg_17_0:refreshRoleStoryUnlockBg(var_17_1)
			arg_17_0:refreshRoleStoryLockBg(var_17_1)
			arg_17_0.animBgCg:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	else
		gohelper.setActive(arg_17_0._goUnlockedBg, var_17_3)
		gohelper.setActive(arg_17_0._goLockedBg, not var_17_3)
		arg_17_0.animBgCg:Play("idle")

		if var_17_3 then
			arg_17_0:refreshRoleStoryUnlockBg(var_17_1)
		else
			arg_17_0:refreshRoleStoryLockBg(var_17_1)
		end
	end
end

function var_0_0.refreshRoleStoryUnlockBg(arg_18_0, arg_18_1)
	arg_18_0._unlocksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", arg_18_1.cgBg), arg_18_0._onLoadUnlockCgCallback, arg_18_0)
	recthelper.setAnchor(arg_18_0._unlockimagecgbg.transform, arg_18_0._cgTargetPos or 0, 0)
	transformhelper.setLocalScale(arg_18_0._unlockimagecgbg.transform, 1, 1, 1)
end

function var_0_0.refreshRoleStoryLockBg(arg_19_0, arg_19_1)
	arg_19_0._locksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", arg_19_1.cgBg), arg_19_0._onLoadLockCgCallback, arg_19_0)

	local var_19_0 = string.splitToNumber(arg_19_1.cgPos, "#")

	recthelper.setAnchor(arg_19_0._lockimagecgbg.transform, var_19_0[1] or 0, var_19_0[2] or 0)
	transformhelper.setLocalScale(arg_19_0._lockimagecgbg.transform, tonumber(arg_19_1.cgScale) or 1, tonumber(arg_19_1.cgScale) or 1, 1)
end

function var_0_0._onLoadUnlockCgCallback(arg_20_0)
	arg_20_0._unlockimagecgbg:SetNativeSize()
end

function var_0_0._onLoadLockCgCallback(arg_21_0)
	arg_21_0._lockimagecgbg:SetNativeSize()
end

function var_0_0._switchLayout(arg_22_0, arg_22_1)
	arg_22_0:_disposeOldLayout()

	if arg_22_0._chapterLayout then
		arg_22_0._oldChapterLayout = arg_22_0._chapterLayout
		arg_22_0._chapterLayout = nil
	end

	if arg_22_0._gochaptercontent then
		arg_22_0._oldChapterContent = arg_22_0._gochaptercontent
		arg_22_0._gochaptercontent = nil
		arg_22_0._oldChapterContent.name = "old"
	end

	if arg_22_0._uiLoader then
		arg_22_0._prevUILoader = arg_22_0._uiLoader
		arg_22_0._uiLoader = nil
	end

	if arg_22_0._layoutCanvas then
		arg_22_0._oldLayoutCanvas = arg_22_0._layoutCanvas
		arg_22_0._oldLayoutCanvas.blocksRaycasts = false
		arg_22_0._oldLayoutCanvas.interactable = false
		arg_22_0._layoutCanvas = nil
	end
end

function var_0_0._loadNewLayout(arg_23_0, arg_23_1)
	arg_23_0._uiLoader = MultiAbLoader.New()

	local var_23_0 = "ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab"

	arg_23_0._uiLoader:addPath(var_23_0)
	arg_23_0._uiLoader:startLoad(function(arg_24_0)
		local var_24_0 = arg_23_0._uiLoader:getAssetItem(var_23_0):GetResource(var_23_0)

		arg_23_0._gochaptercontent = gohelper.cloneInPlace(arg_23_0._gochaptercontentitem, "#go_chaptercontent")

		gohelper.setAsLastSibling(arg_23_0._gochaptercontent)
		gohelper.setActive(arg_23_0._gochaptercontent, true)

		arg_23_0._realscrollcontent.content = arg_23_0._gochaptercontent.transform
		arg_23_0._realscrollcontent.velocity = Vector2(0, 0)
		arg_23_0._scrollcontent.horizontalNormalizedPosition = 0

		local var_24_1 = gohelper.clone(var_24_0, arg_23_0._gochaptercontent)
		local var_24_2 = DungeonMapChapterLayout.New()

		var_24_2:initView(var_24_1, {
			arg_23_0._gochaptercontent,
			arg_23_0.viewContainer:getMapTaskInfo(),
			arg_23_0._scrollcontent,
			arg_23_0,
			arg_23_0._curChapter
		})

		arg_23_0._chapterLayout = var_24_2

		arg_23_0._chapterLayout:onRefresh(arg_23_0._jumpEpisodeId)

		arg_23_0._jumpEpisodeId = nil
		arg_23_0._layoutCanvas = arg_23_0._gochaptercontent:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_23_0._targetTrans = var_24_1.transform

		arg_23_0:_layoutTweenFinish()
	end)
end

function var_0_0._layoutTweenFrame(arg_25_0, arg_25_1)
	if arg_25_1 > 0.4 then
		arg_25_0._layoutCanvas.alpha = (arg_25_1 - 0.4) / 0.6
	else
		arg_25_0._layoutCanvas.alpha = 0
	end

	if arg_25_0._oldLayoutCanvas then
		if arg_25_1 >= 0.6 then
			arg_25_0._oldLayoutCanvas.alpha = 0
		else
			arg_25_0._oldLayoutCanvas.alpha = (0.6 - arg_25_1) / 0.6
		end
	end
end

function var_0_0._layoutTweenFinish(arg_26_0)
	arg_26_0._layoutCanvas.alpha = 1

	arg_26_0:_disposeOldLayout()
end

function var_0_0._switchBg(arg_27_0, arg_27_1)
	local var_27_0 = ResUrl.getDungeonChapterBg("chapter_" .. arg_27_1)
	local var_27_1 = false

	if not arg_27_0._bgUrl or arg_27_0._bgUrl ~= var_27_0 then
		var_27_1 = true
	end

	if not var_27_1 then
		return
	end

	arg_27_0:_disposeOldBg()

	DungeonModel.instance.chapterBgTweening = true
	arg_27_0._olgBgCanvas.alpha = arg_27_0._bgCanvas.alpha

	if arg_27_0._bgGO then
		arg_27_0._oldBgGO = arg_27_0._bgGO
		arg_27_0._bgGO = nil

		gohelper.addChild(arg_27_0._gobgcontainerold, arg_27_0._oldBgGO)
	end

	if arg_27_0._bgCtrl then
		arg_27_0._oldBgCtrl = arg_27_0._bgCtrl
		arg_27_0._bgCtrl = nil
	end

	if arg_27_0._bgLoader then
		arg_27_0._prevBgLoader = arg_27_0._bgLoader
		arg_27_0._bgLoader = nil
	end
end

function var_0_0._loadNewBg(arg_28_0, arg_28_1)
	local var_28_0 = ResUrl.getDungeonChapterBg("chapter_" .. arg_28_1)

	arg_28_0._bgLoader = MultiAbLoader.New()

	arg_28_0._bgLoader:addPath(var_28_0)
	arg_28_0._bgLoader:startLoad(function(arg_29_0)
		local var_29_0 = arg_28_0._bgLoader:getAssetItem(var_28_0):GetResource(var_28_0)

		arg_28_0._bgGO = gohelper.clone(var_29_0, arg_28_0._gobgcontainer, "bg")
		arg_28_0._bgCtrl = arg_28_0._bgGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		arg_28_0._bgUrl = var_28_0

		if arg_28_0._oldBgGO then
			arg_28_0._bgCanvas.alpha = 0
			arg_28_0._bgTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_28_0._fadeTime, arg_28_0._bgTweenFrame, arg_28_0._bgTweenFinish, arg_28_0, nil, EaseType.Linear)
		else
			arg_28_0:_bgTweenFinish()
		end
	end)
end

function var_0_0._bgTweenFrame(arg_30_0, arg_30_1)
	if arg_30_1 > 0.4 then
		arg_30_0._bgCanvas.alpha = (arg_30_1 - 0.4) / 0.6
	else
		arg_30_0._bgCanvas.alpha = 0
	end

	if arg_30_1 >= 0.6 then
		arg_30_0._olgBgCanvas.alpha = 0
	else
		arg_30_0._olgBgCanvas.alpha = (0.6 - arg_30_1) / 0.6
	end
end

function var_0_0._bgTweenFinish(arg_31_0)
	DungeonModel.instance.chapterBgTweening = false
	arg_31_0._bgCanvas.alpha = 1
	arg_31_0._olgBgCanvas.alpha = 0

	arg_31_0:_disposeOldBg()
end

function var_0_0._setEpisodeListVisible(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0._chapterLayout then
		return
	end

	if arg_32_2 == DungeonEnum.EpisodeListVisibleSource.ToughBattle then
		return
	end

	arg_32_0:_clearEpisodeListTween()

	local var_32_0 = 0.2

	if arg_32_1 then
		arg_32_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_32_0._chapterLayout.viewGO.transform, arg_32_0._chapterLayout.defaultY, var_32_0)
	else
		arg_32_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_32_0._chapterLayout.viewGO.transform, -260, var_32_0)
	end
end

function var_0_0._clearEpisodeListTween(arg_33_0)
	if arg_33_0._episodeListTweenId then
		ZProj.TweenHelper.KillById(arg_33_0._episodeListTweenId)

		arg_33_0._episodeListTweenId = nil
	end
end

function var_0_0.onUpdateParam(arg_34_0)
	arg_34_0._jumpEpisodeId = arg_34_0.viewParam and arg_34_0.viewParam.episodeId

	if arg_34_0._chapterLayout then
		arg_34_0._chapterLayout:setFocusEpisodeId(arg_34_0._jumpEpisodeId, false, false)
	end

	arg_34_0:_initChapterItem()
end

function var_0_0.onOpen(arg_35_0)
	arg_35_0._jumpEpisodeId = arg_35_0.viewParam and arg_35_0.viewParam.episodeId

	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_35_0._onChangeFocusEpisodeItem, arg_35_0)
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeChapter, arg_35_0._onChangeChapter, arg_35_0)
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_35_0._OnJumpChangeFocusEpisodeItem, arg_35_0)
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_35_0._onUpdateDungeonInfo, arg_35_0)
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnClickFocusEpisode, arg_35_0._onClickFocusEpisode, arg_35_0)
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_35_0._startUnlockNewChapter, arg_35_0)
	arg_35_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_35_0._setEpisodeListVisible, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_35_0._onOpenView, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_35_0._onCloseView, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_35_0._onCloseViewFinish, arg_35_0)
	arg_35_0:_initChapterItem()
	arg_35_0:_startUnlockNewChapter()
end

function var_0_0.onOpenFinish(arg_36_0)
	arg_36_0._scrollcontent:AddOnValueChanged(arg_36_0._onScrollValueChanged, arg_36_0)
end

function var_0_0._tryShowFirstHelp(arg_37_0, arg_37_1)
	if not arg_37_1 and arg_37_0.viewParam and arg_37_0.viewParam.notOpenHelp then
		return
	end

	if DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.Dungeon)
	end
end

function var_0_0._startUnlockNewChapter(arg_38_0)
	if DungeonModel.instance.chapterTriggerNewChapter then
		return
	end

	if DungeonModel.instance.unlockNewChapterId then
		TaskDispatcher.runDelay(arg_38_0._readyUnlockNewChapter, arg_38_0, 0.3)
	end
end

function var_0_0._readyUnlockNewChapter(arg_39_0)
	DungeonModel.instance.chapterTriggerNewChapter = true
end

function var_0_0._OnUnlockNewChapter(arg_40_0)
	return
end

function var_0_0.onClose(arg_41_0)
	arg_41_0._scrollcontent:RemoveOnValueChanged()
	DungeonAudio.instance:closeChapterAmbientSound(arg_41_0._curChapterId)

	if arg_41_0.viewContainer:isManualClose() then
		DungeonAudio.instance:closeChapter()
	end

	arg_41_0:_clearEpisodeListTween()
end

function var_0_0._onOpenView(arg_42_0, arg_42_1)
	return
end

function var_0_0._onCloseView(arg_43_0, arg_43_1)
	if arg_43_1 == ViewName.StoryView then
		TaskDispatcher.runDelay(arg_43_0.refreshRoleStoryBg, arg_43_0, 0.3)
	end
end

function var_0_0._onCloseViewFinish(arg_44_0, arg_44_1)
	if arg_44_1 == ViewName.DungeonStoryEntranceView then
		-- block empty
	end
end

function var_0_0._OnJumpChangeFocusEpisodeItem(arg_45_0, arg_45_1)
	if arg_45_0._chapterLayout then
		arg_45_0._chapterLayout:changeFocusEpisodeItem(arg_45_1)
	end
end

function var_0_0._onChangeChapter(arg_46_0, arg_46_1)
	arg_46_0:changeChapter(arg_46_1)
end

function var_0_0._onUpdateDungeonInfo(arg_47_0, arg_47_1)
	if arg_47_0._chapterLayout then
		arg_47_0._chapterLayout:onRefresh()
	end

	arg_47_0:refreshRoleStoryBg()
end

function var_0_0._onClickFocusEpisode(arg_48_0, arg_48_1)
	arg_48_0._realscrollcontent.enabled = false
	arg_48_0._realscrollcontent.enabled = true

	if arg_48_0._chapterLayout then
		arg_48_0._chapterLayout:setFocusEpisodeItem(arg_48_1, true)
	end

	arg_48_0:_onChangeFocusEpisodeItem(arg_48_1, true)
end

function var_0_0._onChangeFocusEpisodeItem(arg_49_0, arg_49_1, arg_49_2)
	if not DungeonModel.instance:chapterListIsRoleStory() then
		return
	end

	if not arg_49_1 or not arg_49_0._chapterLayout then
		return
	end

	arg_49_0:setCgIndex(arg_49_1:getIndex(), arg_49_0._chapterLayout:getEpisodeCount(), arg_49_2)
end

function var_0_0.setCgIndex(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	if not arg_50_2 or arg_50_2 <= 1 then
		arg_50_2 = 2
	end

	local var_50_0 = recthelper.getWidth(arg_50_0._unlockimagecgbg.transform)
	local var_50_1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local var_50_2 = math.abs(var_50_0 - var_50_1)
	local var_50_3 = math.max(var_50_2 * ((arg_50_1 - 1) / (arg_50_2 - 1)), 0)
	local var_50_4 = var_50_2 / 2 - var_50_3

	if var_50_4 == arg_50_0._cgTargetPos then
		return
	end

	arg_50_0._cgTargetPos = var_50_4

	if arg_50_0.cgTweenId then
		ZProj.TweenHelper.KillById(arg_50_0.cgTweenId)

		arg_50_0.cgTweenId = nil
	end

	local var_50_5 = math.max(0.35 * ((arg_50_1 - 1) / (arg_50_2 - 1)), 0)

	arg_50_0.bgCgCtrl:GetIndexProp(0, 2)

	local var_50_6 = arg_50_0.bgCgCtrl.vector_03

	arg_50_0.bgCgCtrl.vector_03 = Vector4.New(var_50_6.x, var_50_6.y, -var_50_5, var_50_6.w)

	arg_50_0.bgCgCtrl:SetIndexProp(0, 2)

	if arg_50_3 then
		arg_50_0.cgTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_50_0._unlockimagecgbg.transform, var_50_4, 0.8)
	else
		recthelper.setAnchorX(arg_50_0._unlockimagecgbg.transform, var_50_4)
	end
end

function var_0_0.onDestroyView(arg_51_0)
	if arg_51_0.cgTweenId then
		ZProj.TweenHelper.KillById(arg_51_0.cgTweenId)

		arg_51_0.cgTweenId = nil
	end

	if arg_51_0._uiLoader then
		arg_51_0._uiLoader:dispose()
	end

	if arg_51_0._bgLoader then
		arg_51_0._bgLoader:dispose()
	end

	if arg_51_0._chapterLayout then
		arg_51_0._chapterLayout:destroyView()

		arg_51_0._chapterLayout = nil
	end

	if arg_51_0._audioScroll then
		arg_51_0._audioScroll:dispose()

		arg_51_0._audioScroll = nil
	end

	arg_51_0:_disposeOldLayout()
	arg_51_0:_disposeOldBg()

	if arg_51_0._drag then
		arg_51_0._drag:RemoveDragBeginListener()
		arg_51_0._drag:RemoveDragEndListener()

		arg_51_0._drag = nil
	end

	if arg_51_0._touch then
		arg_51_0._touch:RemoveClickDownListener()

		arg_51_0._touch = nil
	end

	if arg_51_0._scrollTouchEventMgr then
		arg_51_0._scrollTouchEventMgr:ClearAllCallback()

		arg_51_0._scrollTouchEventMgr = nil
	end

	for iter_51_0, iter_51_1 in ipairs(arg_51_0._chapterLineItemList) do
		iter_51_1:destroyView()
	end

	TaskDispatcher.cancelTask(arg_51_0._onCheckVision, arg_51_0)
	TaskDispatcher.cancelTask(arg_51_0._onEndScroll, arg_51_0)
	TaskDispatcher.cancelTask(arg_51_0.refreshRoleStoryBg, arg_51_0)
	TaskDispatcher.cancelTask(arg_51_0._delaySetMask2D, arg_51_0)

	if arg_51_0._unlocksimagecgbg then
		arg_51_0._unlocksimagecgbg:UnLoadImage()
	end

	if arg_51_0._locksimagecgbg then
		arg_51_0._locksimagecgbg:UnLoadImage()
	end
end

function var_0_0._disposeOldLayout(arg_52_0)
	arg_52_0._rectmask2D.enabled = false

	if arg_52_0._prevUILoader then
		arg_52_0._prevUILoader:dispose()

		arg_52_0._prevUILoader = nil
	end

	if arg_52_0._oldChapterLayout then
		arg_52_0._oldChapterLayout:destroyView()

		arg_52_0._oldChapterLayout = nil
	end

	if arg_52_0._layoutTweenId then
		ZProj.TweenHelper.KillById(arg_52_0._layoutTweenId)
	end

	if arg_52_0._oldChapterContent then
		gohelper.destroy(arg_52_0._oldChapterContent)

		arg_52_0._oldChapterContent = nil
	end

	TaskDispatcher.cancelTask(arg_52_0._delaySetMask2D, arg_52_0)
	TaskDispatcher.runDelay(arg_52_0._delaySetMask2D, arg_52_0, 0)
end

function var_0_0._delaySetMask2D(arg_53_0)
	arg_53_0._rectmask2D.enabled = true
end

function var_0_0._disposeOldBg(arg_54_0)
	if arg_54_0._prevBgLoader then
		arg_54_0._prevBgLoader:dispose()

		arg_54_0._prevBgLoader = nil
	end

	if arg_54_0._oldBgGO then
		gohelper.destroy(arg_54_0._oldBgGO)

		arg_54_0._oldBgGO = nil
	end

	arg_54_0._oldBgCtrl = nil

	if arg_54_0._bgTweenId then
		ZProj.TweenHelper.KillById(arg_54_0._bgTweenId)
	end
end

return var_0_0
