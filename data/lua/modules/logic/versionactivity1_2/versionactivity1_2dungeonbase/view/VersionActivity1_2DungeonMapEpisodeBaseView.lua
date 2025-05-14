module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapEpisodeBaseView", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapEpisodeBaseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_versionActivityBg/#simage_bg")
	arg_1_0._simagehardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_versionActivityBg/#simage_hardbg")
	arg_1_0._gobgcanvas = gohelper.findChild(arg_1_0.viewGO, "bgcanvas")
	arg_1_0._gobgcontainerold = gohelper.findChild(arg_1_0.viewGO, "bgcanvas/#go_bgcontainerold")
	arg_1_0._gobgcontainer = gohelper.findChild(arg_1_0.viewGO, "bgcanvas/#go_bgcontainer")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
	arg_1_0._gochaptercontentitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/#go_chaptercontentitem")
	arg_1_0._btnstorymode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#btn_storyMode")
	arg_1_0._btnhardmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#btn_hardMode")
	arg_1_0._imgstorymode = gohelper.findChildImage(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon")
	arg_1_0._txtstorymodeCn = gohelper.findChildText(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/txt")
	arg_1_0._txtstorymodeEn = gohelper.findChildText(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_storymode/#image_storyModeIcon/txten")
	arg_1_0._imghardmode = gohelper.findChildImage(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon")
	arg_1_0._txthardmodeCn = gohelper.findChildText(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txt")
	arg_1_0._txthardmodeEn = gohelper.findChildText(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txten")
	arg_1_0._aniExcessive = gohelper.findChildComponent(arg_1_0.viewGO, "#go_excessive", typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstorymode:AddClickListener(arg_2_0.btnStoryModeClick, arg_2_0)
	arg_2_0._btnhardmode:AddClickListener(arg_2_0.btnHardModeClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstorymode:RemoveClickListener()
	arg_3_0._btnhardmode:RemoveClickListener()
end

var_0_0.ModeSelectColor = Color.white
var_0_0.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)

function var_0_0.btnStoryModeClick(arg_4_0)
	arg_4_0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Story)
end

function var_0_0.btnHardModeClick(arg_5_0)
	local var_5_0, var_5_1 = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)

	if not var_5_0 then
		GameFacade.showToast(ToastEnum.ActivityHardDugeonLockedWithOpenTime)

		return
	end

	if not VersionActivityDungeonController.instance:isOpenHardModeFirstEpisode() then
		GameFacade.showToast(ToastEnum.ActivityHardDugeonLockedWithPassNormal)

		return
	end

	arg_5_0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function var_0_0.changeEpisodeMode(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0._mode then
		return
	end

	if arg_6_0.waitChangeMode == arg_6_1 then
		return
	end

	if not arg_6_0._chapterLayout then
		return
	end

	arg_6_0._aniExcessive:Play(arg_6_1 == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "hard" or "story", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)

	arg_6_0.waitChangeMode = arg_6_1

	TaskDispatcher.cancelTask(arg_6_0._startChangeModel, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._startChangeModel, arg_6_0, 0.4)

	return true
end

function var_0_0._startChangeModel(arg_7_0)
	if arg_7_0.waitChangeMode then
		arg_7_0._mode = arg_7_0.waitChangeMode
		arg_7_0._transferShowChapterId = arg_7_0:getChangedModel2ChapterId()
		arg_7_0._transferShowEpisodeId = VersionActivity1_2DungeonController.instance:_getDefaultFocusEpisode(arg_7_0._transferShowChapterId)

		arg_7_0._chapterLayout:onRefresh(arg_7_0._transferShowChapterId, arg_7_0._transferShowEpisodeId)
		arg_7_0._chapterLayout:playAnimation("switch")
		arg_7_0:refreshModeNode()
		arg_7_0:refreshSceneMode()
		arg_7_0.viewContainer.mapScene:changeMap(VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(arg_7_0._transferShowEpisodeId), true)
		arg_7_0:_directClickOneItem()

		arg_7_0.waitChangeMode = nil
	end
end

function var_0_0.getChangedModel2ChapterId(arg_8_0)
	return VersionActivity1_2DungeonEnum.DungeonChapterIdChangeModel[arg_8_0._transferShowChapterId]
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simagebg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	arg_9_0._simagehardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("lvjing_kunnan"))

	DungeonModel.instance.chapterBgTweening = false
	arg_9_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_9_0._scrollcontent.gameObject, DungeonMapEpisodeAudio, arg_9_0._scrollcontent)
	arg_9_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_9_0._scrollcontent.gameObject)

	arg_9_0._drag:AddDragBeginListener(arg_9_0._onDragBeginHandler, arg_9_0)
	arg_9_0._drag:AddDragEndListener(arg_9_0._onDragEndHandler, arg_9_0)

	arg_9_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_9_0._scrollcontent.gameObject)

	arg_9_0._touch:AddClickDownListener(arg_9_0._onClickDownHandler, arg_9_0)

	arg_9_0._scrollcontent:GetComponent(typeof(ZProj.LimitedScrollRect)).scrollSpeed = 0.5

	gohelper.setActive(arg_9_0._gochaptercontentitem, false)

	arg_9_0._bgCanvas = arg_9_0._gobgcontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_9_0._olgBgCanvas = arg_9_0._gobgcontainerold:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_9_0._realscrollcontent = arg_9_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_9_0.goVersionActivity = gohelper.findChild(arg_9_0.viewGO, "#go_tasklist/#go_versionActivity")
	arg_9_0.animator = arg_9_0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._fadeTime = 1
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

function var_0_0._initChapterItem(arg_13_0)
	arg_13_0:_loadNewLayout()
end

function var_0_0._loadNewLayout(arg_14_0)
	arg_14_0._uiLoader = MultiAbLoader.New()

	local var_14_0 = "ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab"

	arg_14_0._uiLoader:addPath(var_14_0)
	arg_14_0._uiLoader:startLoad(function(arg_15_0)
		local var_15_0 = arg_14_0._uiLoader:getAssetItem(var_14_0):GetResource(var_14_0)

		arg_14_0._gochaptercontent = gohelper.cloneInPlace(arg_14_0._gochaptercontentitem, "#go_chaptercontent")

		gohelper.setAsLastSibling(arg_14_0._gochaptercontent)
		gohelper.setActive(arg_14_0._gochaptercontent, true)

		arg_14_0._realscrollcontent.content = arg_14_0._gochaptercontent.transform
		arg_14_0._realscrollcontent.velocity = Vector2(0, 0)
		arg_14_0._scrollcontent.horizontalNormalizedPosition = 0

		local var_15_1 = gohelper.clone(var_15_0, arg_14_0._gochaptercontent)
		local var_15_2 = arg_14_0:getLayoutClass()

		var_15_2.viewContainer = arg_14_0.viewContainer

		var_15_2:initView(var_15_1, {
			arg_14_0._gochaptercontent
		})

		arg_14_0._chapterLayout = var_15_2

		arg_14_0._chapterLayout:onRefresh(arg_14_0._transferShowChapterId, arg_14_0._transferShowEpisodeId)
		arg_14_0:playOnOpenAnimation()

		arg_14_0._layoutCanvas = arg_14_0._gochaptercontent:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_14_0._targetTrans = var_15_1.transform

		arg_14_0:_layoutTweenFinish()
		arg_14_0:_directClickOneItem()

		local var_15_3 = DungeonConfig.instance:getEpisodeCO(arg_14_0._transferShowEpisodeId)

		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, var_15_3)
		arg_14_0.viewContainer.mapScene:changeMap(VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(arg_14_0._transferShowEpisodeId), true)
	end)
end

function var_0_0._directClickOneItem(arg_16_0)
	if arg_16_0.viewParam.showMapLevelView then
		arg_16_0.viewParam.showMapLevelView = nil

		arg_16_0._chapterLayout._episodeItemDict[arg_16_0._transferShowEpisodeId]:onClick(arg_16_0.viewParam.episodeId)
	end
end

function var_0_0._onEnterFight(arg_17_0, arg_17_1)
	var_0_0.setlastBattleEpisodeId(arg_17_0._transferShowChapterId, arg_17_1)
end

function var_0_0.getlastBattleEpisodeId(arg_18_0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleChapterId2EpisodeId .. "_" .. arg_18_0, 0)
end

function var_0_0.setlastBattleEpisodeId(arg_19_0, arg_19_1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleChapterId2EpisodeId .. "_" .. arg_19_0, arg_19_1)
end

function var_0_0.getLayoutClass(arg_20_0)
	return VersionActivity1_2DungeonMapChapterBaseLayout.New()
end

function var_0_0._layoutTweenFrame(arg_21_0, arg_21_1)
	if arg_21_1 > 0.4 then
		arg_21_0._layoutCanvas.alpha = (arg_21_1 - 0.4) / 0.6
	else
		arg_21_0._layoutCanvas.alpha = 0
	end

	if arg_21_0._oldLayoutCanvas then
		if arg_21_1 >= 0.6 then
			arg_21_0._oldLayoutCanvas.alpha = 0
		else
			arg_21_0._oldLayoutCanvas.alpha = (0.6 - arg_21_1) / 0.6
		end
	end
end

function var_0_0._layoutTweenFinish(arg_22_0)
	arg_22_0._layoutCanvas.alpha = 1
end

function var_0_0._bgTweenFrame(arg_23_0, arg_23_1)
	if arg_23_1 > 0.4 then
		arg_23_0._bgCanvas.alpha = (arg_23_1 - 0.4) / 0.6
	else
		arg_23_0._bgCanvas.alpha = 0
	end

	if arg_23_1 >= 0.6 then
		arg_23_0._olgBgCanvas.alpha = 0
	else
		arg_23_0._olgBgCanvas.alpha = (0.6 - arg_23_1) / 0.6
	end
end

function var_0_0._bgTweenFinish(arg_24_0)
	DungeonModel.instance.chapterBgTweening = false
	arg_24_0._bgCanvas.alpha = 1
	arg_24_0._olgBgCanvas.alpha = 0
end

function var_0_0._setEpisodeListVisible(arg_25_0, arg_25_1)
	if not arg_25_0._chapterLayout then
		return
	end

	local var_25_0 = 0.2

	if arg_25_1 then
		arg_25_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_25_0._chapterLayout.viewGO.transform, arg_25_0._chapterLayout.defaultY, var_25_0)
	else
		arg_25_0._episodeListTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_25_0._chapterLayout.viewGO.transform, -260, var_25_0)
	end
end

function var_0_0.playOnOpenAnimation(arg_26_0)
	if not arg_26_0.viewParam.isBgView then
		arg_26_0._chapterLayout:playAnimation("open")
		arg_26_0._chapterLayout:playEpisodeItemAnimation("in")
		arg_26_0.animator:Play("versionactivity_story_open", 0, 0)
	end
end

function var_0_0.onUpdateParam(arg_27_0)
	arg_27_0:playOnOpenAnimation()
end

function var_0_0.reopenViewParamPrecessed(arg_28_0)
	if not arg_28_0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[arg_28_0.viewParam.chapterId]) then
		arg_28_0._transferShowEpisodeId = DungeonConfig.instance:get1_2VersionActivityFirstLevelEpisodeId(arg_28_0.viewParam.episodeId)

		arg_28_0:_directClickOneItem()
	end
end

function var_0_0.onOpen(arg_29_0)
	arg_29_0._transferShowChapterId = VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[arg_29_0.viewParam.chapterId] or arg_29_0.viewParam.chapterId
	arg_29_0._transferShowEpisodeId = DungeonConfig.instance:get1_2VersionActivityFirstLevelEpisodeId(arg_29_0.viewParam.episodeId)
	arg_29_0._mode = VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[arg_29_0._transferShowChapterId]

	arg_29_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_29_0._onUpdateDungeonInfo, arg_29_0)
	arg_29_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_29_0._setEpisodeListVisible, arg_29_0)
	arg_29_0:_initChapterItem()
	arg_29_0:refreshModeNode()
	arg_29_0:refreshSceneMode()
end

function var_0_0.refreshModeNode(arg_30_0)
	arg_30_0._imgstorymode.color = arg_30_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and var_0_0.ModeSelectColor or var_0_0.ModeDisSelectColor
	arg_30_0._imghardmode.color = arg_30_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and var_0_0.ModeSelectColor or var_0_0.ModeDisSelectColor

	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._txtstorymodeCn, arg_30_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and "#ACD087" or "#556644")
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._txtstorymodeEn, arg_30_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Story and "#ACD087" or "#556644")
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._txthardmodeCn, arg_30_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "#EBB7B6" or "#6F5252")
	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._txthardmodeEn, arg_30_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and "#EBB7B6" or "#6F5252")
	gohelper.setActive(arg_30_0._simagehardbg.gameObject, arg_30_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function var_0_0.refreshSceneMode(arg_31_0)
	arg_31_0.viewContainer.mapScene:changeDungeonMode(arg_31_0._mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function var_0_0._onUpdateDungeonInfo(arg_32_0, arg_32_1)
	if arg_32_0._chapterLayout then
		arg_32_0._chapterLayout:onRefresh(arg_32_0._transferShowChapterId, VersionActivity1_2DungeonController.instance:getDungeonSelectedEpisodeId())
	end
end

function var_0_0.onClose(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._startChangeModel, arg_33_0)
	arg_33_0._scrollcontent:RemoveOnValueChanged()
end

function var_0_0.onDestroyView(arg_34_0)
	if arg_34_0._uiLoader then
		arg_34_0._uiLoader:dispose()
	end

	if arg_34_0._bgLoader then
		arg_34_0._bgLoader:dispose()
	end

	if arg_34_0._chapterLayout then
		arg_34_0._chapterLayout:destroyView()

		arg_34_0._chapterLayout = nil
	end

	if arg_34_0._audioScroll then
		arg_34_0._audioScroll:dispose()

		arg_34_0._audioScroll = nil
	end

	if arg_34_0._drag then
		arg_34_0._drag:RemoveDragBeginListener()
		arg_34_0._drag:RemoveDragEndListener()

		arg_34_0._drag = nil
	end

	if arg_34_0._touch then
		arg_34_0._touch:RemoveClickDownListener()

		arg_34_0._touch = nil
	end

	if arg_34_0._scrollTouchEventMgr then
		arg_34_0._scrollTouchEventMgr:ClearAllCallback()

		arg_34_0._scrollTouchEventMgr = nil
	end

	arg_34_0._simagebg:UnLoadImage()
	arg_34_0._simagehardbg:UnLoadImage()
end

return var_0_0
