module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapEpisodeBaseView", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapEpisodeBaseView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_versionActivityBg/#simage_bg")
	slot0._simagehardbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_versionActivityBg/#simage_hardbg")
	slot0._gobgcanvas = gohelper.findChild(slot0.viewGO, "bgcanvas")
	slot0._gobgcontainerold = gohelper.findChild(slot0.viewGO, "bgcanvas/#go_bgcontainerold")
	slot0._gobgcontainer = gohelper.findChild(slot0.viewGO, "bgcanvas/#go_bgcontainer")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._gochaptercontentitem = gohelper.findChild(slot0.viewGO, "#scroll_content/#go_chaptercontentitem")
	slot0._btnstorymode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#btn_storyMode")
	slot0._btnhardmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#btn_hardMode")
	slot0._imgstorymode = gohelper.findChildImage(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon")
	slot0._txtstorymodeCn = gohelper.findChildText(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/txt")
	slot0._txtstorymodeEn = gohelper.findChildText(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/txten")
	slot0._imghardmode = gohelper.findChildImage(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon")
	slot0._txthardmodeCn = gohelper.findChildText(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txt")
	slot0._txthardmodeEn = gohelper.findChildText(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txten")
	slot0._aniExcessive = gohelper.findChildComponent(slot0.viewGO, "#go_excessive", typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstorymode:AddClickListener(slot0.btnStoryModeClick, slot0)
	slot0._btnhardmode:AddClickListener(slot0.btnHardModeClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstorymode:RemoveClickListener()
	slot0._btnhardmode:RemoveClickListener()
end

slot0.ModeSelectColor = Color.white
slot0.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)

function slot0.btnStoryModeClick(slot0)
	slot0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Story)
end

function slot0.btnHardModeClick(slot0)
	slot1, slot2 = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)

	if not slot1 then
		GameFacade.showToast(ToastEnum.ActivityHardDugeonLockedWithOpenTime)

		return
	end

	if not VersionActivityDungeonController.instance:isOpenHardModeFirstEpisode() then
		GameFacade.showToast(ToastEnum.ActivityHardDugeonLockedWithPassNormal)

		return
	end

	slot0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function slot0.changeEpisodeMode(slot0, slot1)
	if slot1 == slot0._mode then
		return
	end

	if slot0.waitChangeMode == slot1 then
		return
	end

	if not slot0._chapterLayout then
		return
	end

	slot0._aniExcessive:Play(slot1 == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "hard" or "story", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)

	slot0.waitChangeMode = slot1

	TaskDispatcher.cancelTask(slot0._startChangeModel, slot0)
	TaskDispatcher.runDelay(slot0._startChangeModel, slot0, 0.4)

	return true
end

function slot0._startChangeModel(slot0)
	if slot0.waitChangeMode then
		slot0._mode = slot0.waitChangeMode
		slot0._transferShowChapterId = slot0:getChangedModel2ChapterId()
		slot0._transferShowEpisodeId = VersionActivity1_2DungeonController.instance:_getDefaultFocusEpisode(slot0._transferShowChapterId)

		slot0._chapterLayout:onRefresh(slot0._transferShowChapterId, slot0._transferShowEpisodeId)
		slot0._chapterLayout:playAnimation("switch")
		slot0:refreshModeNode()
		slot0:refreshSceneMode()
		slot0.viewContainer.mapScene:changeMap(VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(slot0._transferShowEpisodeId), true)
		slot0:_directClickOneItem()

		slot0.waitChangeMode = nil
	end
end

function slot0.getChangedModel2ChapterId(slot0)
	return VersionActivity1_2DungeonEnum.DungeonChapterIdChangeModel[slot0._transferShowChapterId]
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	slot0._simagehardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("lvjing_kunnan"))

	DungeonModel.instance.chapterBgTweening = false
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
	slot0.goVersionActivity = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity")
	slot0.animator = slot0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	slot0._fadeTime = 1
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

function slot0._initChapterItem(slot0)
	slot0:_loadNewLayout()
end

function slot0._loadNewLayout(slot0)
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
		slot4 = uv0:getLayoutClass()
		slot4.viewContainer = uv0.viewContainer

		slot4:initView(slot3, {
			uv0._gochaptercontent
		})

		uv0._chapterLayout = slot4

		uv0._chapterLayout:onRefresh(uv0._transferShowChapterId, uv0._transferShowEpisodeId)
		uv0:playOnOpenAnimation()

		uv0._layoutCanvas = uv0._gochaptercontent:GetComponent(typeof(UnityEngine.CanvasGroup))
		uv0._targetTrans = slot3.transform

		uv0:_layoutTweenFinish()
		uv0:_directClickOneItem()
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, DungeonConfig.instance:getEpisodeCO(uv0._transferShowEpisodeId))
		uv0.viewContainer.mapScene:changeMap(VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(uv0._transferShowEpisodeId), true)
	end)
end

function slot0._directClickOneItem(slot0)
	if slot0.viewParam.showMapLevelView then
		slot0.viewParam.showMapLevelView = nil

		slot0._chapterLayout._episodeItemDict[slot0._transferShowEpisodeId]:onClick(slot0.viewParam.episodeId)
	end
end

function slot0._onEnterFight(slot0, slot1)
	uv0.setlastBattleEpisodeId(slot0._transferShowChapterId, slot1)
end

function slot0.getlastBattleEpisodeId(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleChapterId2EpisodeId .. "_" .. slot0, 0)
end

function slot0.setlastBattleEpisodeId(slot0, slot1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleChapterId2EpisodeId .. "_" .. slot0, slot1)
end

function slot0.getLayoutClass(slot0)
	return VersionActivity1_2DungeonMapChapterBaseLayout.New()
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
end

function slot0._setEpisodeListVisible(slot0, slot1)
	if not slot0._chapterLayout then
		return
	end

	if slot1 then
		slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0._chapterLayout.viewGO.transform, slot0._chapterLayout.defaultY, 0.2)
	else
		slot0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(slot0._chapterLayout.viewGO.transform, -260, slot2)
	end
end

function slot0.playOnOpenAnimation(slot0)
	if not slot0.viewParam.isBgView then
		slot0._chapterLayout:playAnimation("open")
		slot0._chapterLayout:playEpisodeItemAnimation("in")
		slot0.animator:Play("versionactivity_story_open", 0, 0)
	end
end

function slot0.onUpdateParam(slot0)
	slot0:playOnOpenAnimation()
end

function slot0.reopenViewParamPrecessed(slot0)
	if not slot0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[slot0.viewParam.chapterId]) then
		slot0._transferShowEpisodeId = DungeonConfig.instance:get1_2VersionActivityFirstLevelEpisodeId(slot0.viewParam.episodeId)

		slot0:_directClickOneItem()
	end
end

function slot0.onOpen(slot0)
	slot0._transferShowChapterId = VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[slot0.viewParam.chapterId] or slot0.viewParam.chapterId
	slot0._transferShowEpisodeId = DungeonConfig.instance:get1_2VersionActivityFirstLevelEpisodeId(slot0.viewParam.episodeId)
	slot0._mode = VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[slot0._transferShowChapterId]

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:_initChapterItem()
	slot0:refreshModeNode()
	slot0:refreshSceneMode()
end

function slot0.refreshModeNode(slot0)
	slot0._imgstorymode.color = slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and uv0.ModeSelectColor or uv0.ModeDisSelectColor
	slot0._imghardmode.color = slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and uv0.ModeSelectColor or uv0.ModeDisSelectColor

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtstorymodeCn, slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and "#ACD087" or "#556644")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtstorymodeEn, slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and "#ACD087" or "#556644")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txthardmodeCn, slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "#EBB7B6" or "#6F5252")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txthardmodeEn, slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "#EBB7B6" or "#6F5252")
	gohelper.setActive(slot0._simagehardbg.gameObject, slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function slot0.refreshSceneMode(slot0)
	slot0.viewContainer.mapScene:changeDungeonMode(slot0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function slot0._onUpdateDungeonInfo(slot0, slot1)
	if slot0._chapterLayout then
		slot0._chapterLayout:onRefresh(slot0._transferShowChapterId, VersionActivity1_2DungeonController.instance:getDungeonSelectedEpisodeId())
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._startChangeModel, slot0)
	slot0._scrollcontent:RemoveOnValueChanged()
end

function slot0.onDestroyView(slot0)
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

	slot0._simagebg:UnLoadImage()
	slot0._simagehardbg:UnLoadImage()
end

return slot0
