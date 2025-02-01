module("modules.logic.dungeon.view.map.DungeonMapEpisode", package.seeall)

slot0 = class("DungeonMapEpisode", BaseView)

function slot0.onInitView(slot0)
	slot0._gobgcanvas = gohelper.findChild(slot0.viewGO, "bgcanvas")
	slot0._gobgcontainerold = gohelper.findChild(slot0.viewGO, "bgcanvas/#go_bgcontainerold")
	slot0._gobgcontainer = gohelper.findChild(slot0.viewGO, "bgcanvas/#go_bgcontainer")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._gochaptercontentitem = gohelper.findChild(slot0.viewGO, "#scroll_content/#go_chaptercontentitem")
	slot0._gochapterlist = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist")
	slot0._gochapterlineItem = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_chapterlineItem")
	slot0._goitemline = gohelper.findChild(slot0.viewGO, "#go_res/chapter/#go_chapterlist/#go_itemline")
	slot0._goBgCg = gohelper.findChild(slot0.viewGO, "bgcanvas/#go_bgcg")
	slot0.bgCgCtrl = slot0._goBgCg:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	slot0.animBgCg = slot0._goBgCg:GetComponent(typeof(UnityEngine.Animator))
	slot0._goUnlockedBg = gohelper.findChild(slot0._goBgCg, "unlocked")
	slot0._unlocksimagecgbg = gohelper.findChildSingleImage(slot0._goUnlockedBg, "#simage_cgbg")
	slot0._unlockimagecgbg = gohelper.findChildImage(slot0._goUnlockedBg, "#simage_cgbg")
	slot0._goLockedBg = gohelper.findChild(slot0._goBgCg, "locked")
	slot0._locksimagecgbg = gohelper.findChildSingleImage(slot0._goLockedBg, "bgmask/#simage_cgbg")
	slot0._lockimagecgbg = gohelper.findChildImage(slot0._goLockedBg, "bgmask/#simage_cgbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	DungeonModel.instance.chapterBgTweening = false
	slot0._chapterLineItemList = slot0:getUserDataTb_()
	slot0._chapterLineList = slot0:getUserDataTb_()
	slot0._rectmask2D = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._scrollcontent.gameObject, DungeonMapEpisodeAudio, slot0._scrollcontent)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollcontent.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._scrollcontent.gameObject)

	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)

	slot0._scrollcontent:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = 0.5

	gohelper.setActive(slot0._gochaptercontentitem, false)

	slot0._bgCanvas = slot0._gobgcontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._olgBgCanvas = slot0._gobgcontainerold:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._realscrollcontent = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0._fadeTime = 1
end

function slot0._onScrollValueChanged(slot0, slot1, slot2)
	slot0:_checkEpisodeVision(slot1, slot2)
end

function slot0._checkEpisodeVision(slot0, slot1, slot2)
	if not slot0._scrollPosX or math.abs(slot0._scrollPosX - slot1) >= 0.01 then
		if slot0._scrollPosX then
			slot0:_onCheckVision()
		end

		slot0._scrollPosX = slot1
	end

	TaskDispatcher.cancelTask(slot0._onEndScroll, slot0)
	TaskDispatcher.runDelay(slot0._onEndScroll, slot0, 0.1)
end

function slot0._onCheckVision(slot0)
	if slot0._chapterLayout then
		slot0._chapterLayout:CheckVision()
	end
end

function slot0._onEndScroll(slot0)
	slot0._scrollPosX = nil

	slot0:_onCheckVision()
end

function slot0._initChapterItem(slot0)
	slot0:_updateChapterList()
	slot0:changeChapter(DungeonModel.instance.curLookChapterId)
end

function slot0._onDragBeginHandler(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEndHandler(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDownHandler(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0._updateChapterList(slot0)
	slot0._chapterId = slot0.viewParam.chapterId
	slot0._isResChapter = DungeonConfig.instance:getChapterCO(slot0._chapterId).type ~= DungeonEnum.ChapterType.Normal

	if not slot0._isResChapter then
		return
	end

	if slot0._isResChapter then
		gohelper.setActive(slot0._gochapterlist, false)

		return
	end

	for slot5 = 1, #slot0._chapterLineItemList do
		slot0._chapterLineItemList[slot5]:destroyView()

		slot0._chapterLineItemList[slot5] = nil
	end

	for slot5 = 1, #slot0._chapterLineList do
		gohelper.destroy(slot0._chapterLineList[slot5])

		slot0._chapterLineList[slot5] = nil
	end

	if #DungeonChapterListModel.instance:getChapterList(slot0._chapterId) <= 1 then
		return
	end

	for slot6 = 1, #slot2 do
		if slot6 == 1 then
			slot0:_addLine()
		end

		slot0:_addChapterItem(slot6, slot2[slot6])
		slot0:_addLine()
	end
end

function slot0._addChapterItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._gochapterlineItem, slot0._gochapterlist, "ChapterLineItem")

	gohelper.setActive(slot3, true)

	slot4 = DungeonMapChapterLineItem.New()

	slot4:initView(slot3, {
		index = slot1,
		config = slot2
	})
	table.insert(slot0._chapterLineItemList, slot4)
end

function slot0._addLine(slot0)
	slot1 = gohelper.clone(slot0._goitemline, slot0._gochapterlist, "itemline")

	gohelper.setActive(slot1, true)
	table.insert(slot0._chapterLineList, slot1)
end

function slot0.changeChapter(slot0, slot1)
	slot2 = slot0._curChapter == slot1
	slot0._curChapter = slot1
	DungeonModel.instance.curLookChapterId = slot1

	for slot6, slot7 in ipairs(slot0._chapterLineItemList) do
		slot7:updateStatus()
	end

	if slot2 then
		return
	end

	slot0:_clearEpisodeListTween()

	if slot1 ~= slot0._curChapterId then
		if slot0._curChapterId then
			DungeonAudio.instance:closeChapterAmbientSound(slot0._curChapterId)
		end

		slot0._curChapterId = slot1

		DungeonAudio.instance:openChapterAmbientSound()
	end

	slot0._isResChapter = DungeonConfig.instance:getChapterCO(slot0._curChapterId).type ~= DungeonEnum.ChapterType.Normal

	slot0:_switchLayout(slot1)

	if slot0._isResChapter then
		slot0:_switchBg(slot1)
	end

	slot0:_loadNewLayout(slot1)

	if slot0._isResChapter and slot3.type ~= DungeonEnum.ChapterType.RoleStory then
		slot0:_loadNewBg(slot1)
	end

	slot0:refreshRoleStoryBg()
	gohelper.setActive(slot0._gobgcanvas, slot0._isResChapter)
end

function slot0.refreshRoleStoryBg(slot0)
	if DungeonConfig.instance:getChapterCO(slot0._curChapterId).type ~= DungeonEnum.ChapterType.RoleStory then
		gohelper.setActive(slot0._goBgCg, false)

		return
	end

	gohelper.setActive(slot0._goBgCg, true)

	if (RoleStoryConfig.instance:getStoryById(RoleStoryModel.instance:getCurStoryId()).cgUnlockEpisodeId == 0 or DungeonModel.instance:hasPassLevel(slot4)) and RoleStoryModel.instance:canPlayDungeonUnlockAnim(slot2) then
		if ViewMgr.instance:isOpen(ViewName.StoryView) then
			gohelper.setActive(slot0._goUnlockedBg, false)
			gohelper.setActive(slot0._goLockedBg, true)
			slot0.animBgCg:Play("idle")
			slot0:refreshRoleStoryLockBg(slot3)
		else
			RoleStoryModel.instance:setPlayDungeonUnlockAnimFlag(slot2)
			gohelper.setActive(slot0._goUnlockedBg, true)
			gohelper.setActive(slot0._goLockedBg, true)
			slot0:refreshRoleStoryUnlockBg(slot3)
			slot0:refreshRoleStoryLockBg(slot3)
			slot0.animBgCg:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	else
		gohelper.setActive(slot0._goUnlockedBg, slot5)
		gohelper.setActive(slot0._goLockedBg, not slot5)
		slot0.animBgCg:Play("idle")

		if slot5 then
			slot0:refreshRoleStoryUnlockBg(slot3)
		else
			slot0:refreshRoleStoryLockBg(slot3)
		end
	end
end

function slot0.refreshRoleStoryUnlockBg(slot0, slot1)
	slot0._unlocksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", slot1.cgBg), slot0._onLoadUnlockCgCallback, slot0)
	recthelper.setAnchor(slot0._unlockimagecgbg.transform, slot0._cgTargetPos or 0, 0)
	transformhelper.setLocalScale(slot0._unlockimagecgbg.transform, 1, 1, 1)
end

function slot0.refreshRoleStoryLockBg(slot0, slot1)
	slot0._locksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", slot1.cgBg), slot0._onLoadLockCgCallback, slot0)
	recthelper.setAnchor(slot0._lockimagecgbg.transform, string.splitToNumber(slot1.cgPos, "#")[1] or 0, slot2[2] or 0)
	transformhelper.setLocalScale(slot0._lockimagecgbg.transform, tonumber(slot1.cgScale) or 1, tonumber(slot1.cgScale) or 1, 1)
end

function slot0._onLoadUnlockCgCallback(slot0)
	slot0._unlockimagecgbg:SetNativeSize()
end

function slot0._onLoadLockCgCallback(slot0)
	slot0._lockimagecgbg:SetNativeSize()
end

function slot0._switchLayout(slot0, slot1)
	slot0:_disposeOldLayout()

	if slot0._chapterLayout then
		slot0._oldChapterLayout = slot0._chapterLayout
		slot0._chapterLayout = nil
	end

	if slot0._gochaptercontent then
		slot0._oldChapterContent = slot0._gochaptercontent
		slot0._gochaptercontent = nil
		slot0._oldChapterContent.name = "old"
	end

	if slot0._uiLoader then
		slot0._prevUILoader = slot0._uiLoader
		slot0._uiLoader = nil
	end

	if slot0._layoutCanvas then
		slot0._oldLayoutCanvas = slot0._layoutCanvas
		slot0._oldLayoutCanvas.blocksRaycasts = false
		slot0._oldLayoutCanvas.interactable = false
		slot0._layoutCanvas = nil
	end
end

function slot0._loadNewLayout(slot0, slot1)
	slot0._uiLoader = MultiAbLoader.New()

	slot0._uiLoader:addPath("ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab")
	slot0._uiLoader:startLoad(function (slot0)
		uv0._gochaptercontent = gohelper.cloneInPlace(uv0._gochaptercontentitem, "#go_chaptercontent")

		gohelper.setAsLastSibling(uv0._gochaptercontent)
		gohelper.setActive(uv0._gochaptercontent, true)

		uv0._realscrollcontent.content = uv0._gochaptercontent.transform
		uv0._realscrollcontent.velocity = Vector2(0, 0)
		uv0._scrollcontent.horizontalNormalizedPosition = 0
		slot3 = gohelper.clone(uv0._uiLoader:getAssetItem(uv1):GetResource(uv1), uv0._gochaptercontent)
		slot4 = DungeonMapChapterLayout.New()

		slot4:initView(slot3, {
			uv0._gochaptercontent,
			uv0.viewContainer:getMapTaskInfo(),
			uv0._scrollcontent,
			uv0,
			uv0._curChapter
		})

		uv0._chapterLayout = slot4

		uv0._chapterLayout:onRefresh(uv0._jumpEpisodeId)

		uv0._jumpEpisodeId = nil
		uv0._layoutCanvas = uv0._gochaptercontent:GetComponent(typeof(UnityEngine.CanvasGroup))
		uv0._targetTrans = slot3.transform

		uv0:_layoutTweenFinish()
	end)
end

function slot0._layoutTweenFrame(slot0, slot1)
	if slot1 > 0.4 then
		slot0._layoutCanvas.alpha = (slot1 - 0.4) / 0.6
	else
		slot0._layoutCanvas.alpha = 0
	end

	if slot0._oldLayoutCanvas then
		if slot1 >= 0.6 then
			slot0._oldLayoutCanvas.alpha = 0
		else
			slot0._oldLayoutCanvas.alpha = (0.6 - slot1) / 0.6
		end
	end
end

function slot0._layoutTweenFinish(slot0)
	slot0._layoutCanvas.alpha = 1

	slot0:_disposeOldLayout()
end

function slot0._switchBg(slot0, slot1)
	slot3 = false

	if not slot0._bgUrl or slot0._bgUrl ~= ResUrl.getDungeonChapterBg("chapter_" .. slot1) then
		slot3 = true
	end

	if not slot3 then
		return
	end

	slot0:_disposeOldBg()

	DungeonModel.instance.chapterBgTweening = true
	slot0._olgBgCanvas.alpha = slot0._bgCanvas.alpha

	if slot0._bgGO then
		slot0._oldBgGO = slot0._bgGO
		slot0._bgGO = nil

		gohelper.addChild(slot0._gobgcontainerold, slot0._oldBgGO)
	end

	if slot0._bgCtrl then
		slot0._oldBgCtrl = slot0._bgCtrl
		slot0._bgCtrl = nil
	end

	if slot0._bgLoader then
		slot0._prevBgLoader = slot0._bgLoader
		slot0._bgLoader = nil
	end
end

function slot0._loadNewBg(slot0, slot1)
	slot0._bgLoader = MultiAbLoader.New()

	slot0._bgLoader:addPath(ResUrl.getDungeonChapterBg("chapter_" .. slot1))
	slot0._bgLoader:startLoad(function (slot0)
		uv0._bgGO = gohelper.clone(uv0._bgLoader:getAssetItem(uv1):GetResource(uv1), uv0._gobgcontainer, "bg")
		uv0._bgCtrl = uv0._bgGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		uv0._bgUrl = uv1

		if uv0._oldBgGO then
			uv0._bgCanvas.alpha = 0
			uv0._bgTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, uv0._fadeTime, uv0._bgTweenFrame, uv0._bgTweenFinish, uv0, nil, EaseType.Linear)
		else
			uv0:_bgTweenFinish()
		end
	end)
end

function slot0._bgTweenFrame(slot0, slot1)
	if slot1 > 0.4 then
		slot0._bgCanvas.alpha = (slot1 - 0.4) / 0.6
	else
		slot0._bgCanvas.alpha = 0
	end

	if slot1 >= 0.6 then
		slot0._olgBgCanvas.alpha = 0
	else
		slot0._olgBgCanvas.alpha = (0.6 - slot1) / 0.6
	end
end

function slot0._bgTweenFinish(slot0)
	DungeonModel.instance.chapterBgTweening = false
	slot0._bgCanvas.alpha = 1
	slot0._olgBgCanvas.alpha = 0

	slot0:_disposeOldBg()
end

function slot0._setEpisodeListVisible(slot0, slot1, slot2)
	if not slot0._chapterLayout then
		return
	end

	if slot2 == DungeonEnum.EpisodeListVisibleSource.ToughBattle then
		return
	end

	slot0:_clearEpisodeListTween()

	if slot1 then
		slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0._chapterLayout.viewGO.transform, slot0._chapterLayout.defaultY, 0.2)
	else
		slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0._chapterLayout.viewGO.transform, -260, slot3)
	end
end

function slot0._clearEpisodeListTween(slot0)
	if slot0._episodeListTweenId then
		ZProj.TweenHelper.KillById(slot0._episodeListTweenId)

		slot0._episodeListTweenId = nil
	end
end

function slot0.onUpdateParam(slot0)
	slot0._jumpEpisodeId = slot0.viewParam and slot0.viewParam.episodeId

	if slot0._chapterLayout then
		slot0._chapterLayout:setFocusEpisodeId(slot0._jumpEpisodeId, false, false)
	end

	slot0:_initChapterItem()
end

function slot0.onOpen(slot0)
	slot0._jumpEpisodeId = slot0.viewParam and slot0.viewParam.episodeId

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeChapter, slot0._onChangeChapter, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnJumpChangeFocusEpisodeItem, slot0._OnJumpChangeFocusEpisodeItem, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnClickFocusEpisode, slot0._onClickFocusEpisode, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, slot0._startUnlockNewChapter, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:_initChapterItem()
	slot0:_startUnlockNewChapter()
end

function slot0.onOpenFinish(slot0)
	slot0._scrollcontent:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
end

function slot0._tryShowFirstHelp(slot0, slot1)
	if not slot1 and slot0.viewParam and slot0.viewParam.notOpenHelp then
		return
	end

	if DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.Dungeon)
	end
end

function slot0._startUnlockNewChapter(slot0)
	if DungeonModel.instance.chapterTriggerNewChapter then
		return
	end

	if DungeonModel.instance.unlockNewChapterId then
		TaskDispatcher.runDelay(slot0._readyUnlockNewChapter, slot0, 0.3)
	end
end

function slot0._readyUnlockNewChapter(slot0)
	DungeonModel.instance.chapterTriggerNewChapter = true
end

function slot0._OnUnlockNewChapter(slot0)
end

function slot0.onClose(slot0)
	slot0._scrollcontent:RemoveOnValueChanged()
	DungeonAudio.instance:closeChapterAmbientSound(slot0._curChapterId)

	if slot0.viewContainer:isManualClose() then
		DungeonAudio.instance:closeChapter()
	end

	slot0:_clearEpisodeListTween()
end

function slot0._onOpenView(slot0, slot1)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		TaskDispatcher.runDelay(slot0.refreshRoleStoryBg, slot0, 0.3)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.DungeonStoryEntranceView then
		-- Nothing
	end
end

function slot0._OnJumpChangeFocusEpisodeItem(slot0, slot1)
	if slot0._chapterLayout then
		slot0._chapterLayout:changeFocusEpisodeItem(slot1)
	end
end

function slot0._onChangeChapter(slot0, slot1)
	slot0:changeChapter(slot1)
end

function slot0._onUpdateDungeonInfo(slot0, slot1)
	if slot0._chapterLayout then
		slot0._chapterLayout:onRefresh()
	end

	slot0:refreshRoleStoryBg()
end

function slot0._onClickFocusEpisode(slot0, slot1)
	slot0._realscrollcontent.enabled = false
	slot0._realscrollcontent.enabled = true

	if slot0._chapterLayout then
		slot0._chapterLayout:setFocusEpisodeItem(slot1, true)
	end

	slot0:_onChangeFocusEpisodeItem(slot1, true)
end

function slot0._onChangeFocusEpisodeItem(slot0, slot1, slot2)
	if not DungeonModel.instance:chapterListIsRoleStory() then
		return
	end

	if not slot1 or not slot0._chapterLayout then
		return
	end

	slot0:setCgIndex(slot1:getIndex(), slot0._chapterLayout:getEpisodeCount(), slot2)
end

function slot0.setCgIndex(slot0, slot1, slot2, slot3)
	if not slot2 or slot2 <= 1 then
		slot2 = 2
	end

	slot6 = math.abs(recthelper.getWidth(slot0._unlockimagecgbg.transform) - recthelper.getWidth(ViewMgr.instance:getUIRoot().transform))

	if slot6 / 2 - math.max(slot6 * (slot1 - 1) / (slot2 - 1), 0) == slot0._cgTargetPos then
		return
	end

	slot0._cgTargetPos = slot9

	if slot0.cgTweenId then
		ZProj.TweenHelper.KillById(slot0.cgTweenId)

		slot0.cgTweenId = nil
	end

	slot0.bgCgCtrl:GetIndexProp(0, 2)

	slot11 = slot0.bgCgCtrl.vector_03
	slot0.bgCgCtrl.vector_03 = Vector4.New(slot11.x, slot11.y, -math.max(0.35 * (slot1 - 1) / (slot2 - 1), 0), slot11.w)

	slot0.bgCgCtrl:SetIndexProp(0, 2)

	if slot3 then
		slot0.cgTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._unlockimagecgbg.transform, slot9, 0.8)
	else
		recthelper.setAnchorX(slot0._unlockimagecgbg.transform, slot9)
	end
end

function slot0.onDestroyView(slot0)
	if slot0.cgTweenId then
		ZProj.TweenHelper.KillById(slot0.cgTweenId)

		slot0.cgTweenId = nil
	end

	if slot0._uiLoader then
		slot0._uiLoader:dispose()
	end

	if slot0._bgLoader then
		slot0._bgLoader:dispose()
	end

	if slot0._chapterLayout then
		slot0._chapterLayout:destroyView()

		slot0._chapterLayout = nil
	end

	if slot0._audioScroll then
		slot0._audioScroll:dispose()

		slot0._audioScroll = nil
	end

	slot0:_disposeOldLayout()
	slot0:_disposeOldBg()

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end

	if slot0._scrollTouchEventMgr then
		slot0._scrollTouchEventMgr:ClearAllCallback()

		slot0._scrollTouchEventMgr = nil
	end

	for slot4, slot5 in ipairs(slot0._chapterLineItemList) do
		slot5:destroyView()
	end

	TaskDispatcher.cancelTask(slot0._onCheckVision, slot0)
	TaskDispatcher.cancelTask(slot0._onEndScroll, slot0)
	TaskDispatcher.cancelTask(slot0.refreshRoleStoryBg, slot0)

	if slot0._unlocksimagecgbg then
		slot0._unlocksimagecgbg:UnLoadImage()
	end

	if slot0._locksimagecgbg then
		slot0._locksimagecgbg:UnLoadImage()
	end
end

function slot0._disposeOldLayout(slot0)
	slot0._rectmask2D.enabled = false

	if slot0._prevUILoader then
		slot0._prevUILoader:dispose()

		slot0._prevUILoader = nil
	end

	if slot0._oldChapterLayout then
		slot0._oldChapterLayout:destroyView()

		slot0._oldChapterLayout = nil
	end

	if slot0._layoutTweenId then
		ZProj.TweenHelper.KillById(slot0._layoutTweenId)
	end

	if slot0._oldChapterContent then
		gohelper.destroy(slot0._oldChapterContent)

		slot0._oldChapterContent = nil
	end

	slot0._rectmask2D.enabled = true
end

function slot0._disposeOldBg(slot0)
	if slot0._prevBgLoader then
		slot0._prevBgLoader:dispose()

		slot0._prevBgLoader = nil
	end

	if slot0._oldBgGO then
		gohelper.destroy(slot0._oldBgGO)

		slot0._oldBgGO = nil
	end

	slot0._oldBgCtrl = nil

	if slot0._bgTweenId then
		ZProj.TweenHelper.KillById(slot0._bgTweenId)
	end
end

return slot0
