module("modules.logic.commandstation.view.CommandStationEnterView", package.seeall)

local var_0_0 = class("CommandStationEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btnmap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_map")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._btnactivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_activity")
	arg_1_0._btnplot = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_plot")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#btn_plot/#txt_Name")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#btn_plot/#txt_Name/#txt_Num")
	arg_1_0._btnwuxiandian = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_wuxiandian")
	arg_1_0._btnbox = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_box")
	arg_1_0._imagebox = gohelper.findChildImage(arg_1_0.viewGO, "#btn_box/#ani/#image_box")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_bottom")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/#txt_ana_en")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._txtmapname = gohelper.findChildText(arg_1_0.viewGO, "#go_map/line/#txt_mapname")
	arg_1_0._txtmapnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_map/#txt_mapnameen")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmap:AddClickListener(arg_2_0._btnmapOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnactivity:AddClickListener(arg_2_0._btnactivityOnClick, arg_2_0)
	arg_2_0._btnplot:AddClickListener(arg_2_0._btnplotOnClick, arg_2_0)
	arg_2_0._btnwuxiandian:AddClickListener(arg_2_0._btnwuxiandianOnClick, arg_2_0)
	arg_2_0._btnbox:AddClickListener(arg_2_0._btnboxOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmap:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnactivity:RemoveClickListener()
	arg_3_0._btnplot:RemoveClickListener()
	arg_3_0._btnwuxiandian:RemoveClickListener()
	arg_3_0._btnbox:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	local var_4_0 = CommandStationConfig.instance:getTotalTaskRewards()
	local var_4_1 = CommandStationConfig.instance:getCurVersionId()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.versionId == var_4_1 and iter_4_1.isBig == 1 then
			local var_4_2 = GameUtil.splitString2(iter_4_1.bonus, true)

			MaterialTipController.instance:showMaterialInfo(var_4_2[1][1], var_4_2[1][2])

			break
		end
	end
end

function var_0_0._btnboxOnClick(arg_5_0)
	arg_5_0._openBox = not arg_5_0._openBox

	arg_5_0:_updateBoxAnim()
end

function var_0_0._btnplotOnClick(arg_6_0)
	JumpController.instance:jumpTo("4#" .. tostring(arg_6_0._showEpisodeId))
	CommandStationController.StatCommandStationButtonClick(arg_6_0.viewName, "_btnplotOnClick")
end

function var_0_0._btnwuxiandianOnClick(arg_7_0)
	local var_7_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Click)

	arg_7_0:_showDialogue(var_7_0)

	if arg_7_0._uiSpine then
		arg_7_0._uiSpine:play("radio_shake")
		TaskDispatcher.cancelTask(arg_7_0._delayPlayIdleAnim, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0._delayPlayIdleAnim, arg_7_0, 1)
	end

	CommandStationController.StatCommandStationButtonClick(arg_7_0.viewName, "_btnwuxiandianOnClick")
end

function var_0_0._delayPlayIdleAnim(arg_8_0)
	arg_8_0:_playIdleAnim()
end

function var_0_0._btnmapOnClick(arg_9_0)
	if arg_9_0._preloadLoader then
		arg_9_0._preloadLoader:dispose()

		arg_9_0._preloadLoader = nil
	end

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_shapan)
	arg_9_0:_afterBoxClose(function()
		arg_9_0._viewAnimatorPlayer:Play("close1", arg_9_0._animDoneForOpenMap, arg_9_0)
	end)
	CommandStationController.StatCommandStationButtonClick(arg_9_0.viewName, "_btnmapOnClick")
end

function var_0_0._animDoneForOpenMap(arg_11_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	module_views_preloader.CommandStationMapViewPreload(function()
		arg_11_0:_preloadDone()
	end)
end

function var_0_0._preloadDone(arg_13_0)
	local var_13_0 = CommandStationMapModel.instance:getCurTimeIdScene()

	if var_13_0 then
		local var_13_1 = var_13_0.scene
		local var_13_2 = "ui/viewres/commandstation/commandstation_mapview.prefab"
		local var_13_3 = MultiAbLoader.New()

		arg_13_0._preloadLoader = var_13_3

		var_13_3:addPath(var_13_1)
		var_13_3:addPath(var_13_2)
		var_13_3:startLoad(function()
			local var_14_0 = var_13_3:getAssetItem(var_13_1)

			if var_14_0 then
				local var_14_1 = var_14_0:GetResource(var_13_1)
				local var_14_2 = gohelper.clone(var_14_1, arg_13_0.viewGO)

				gohelper.setActive(var_14_2, false)
				CommandStationMapModel.instance:setPreloadScene(var_13_3, var_14_2)
			end

			local var_14_3 = var_13_3:getAssetItem(var_13_2)

			if var_14_3 then
				local var_14_4 = var_14_3:GetResource(var_13_2)
				local var_14_5 = ViewMgr.instance:getUILayer("POPUP_TOP")
				local var_14_6 = gohelper.clone(var_14_4, var_14_5, ViewName.CommandStationMapView)

				recthelper.setAnchor(var_14_6.transform, 10000, 10000)
				CommandStationMapModel.instance:setPreloadView(var_14_6)
			end
		end)
	end

	arg_13_0:_openMap()
end

function var_0_0._openMap(arg_15_0)
	arg_15_0._changeVideoViewLayer = true

	local var_15_0 = 3

	UIBlockHelper.instance:startBlock("CommandStationEnterView_openMap", var_15_0)
	VideoController.instance:openFullScreenVideoView(arg_15_0._toMapVedioPath, nil, var_15_0, arg_15_0._onVideoEndForOpenMap, arg_15_0, {
		setVideoPlayer = arg_15_0._setVideoPlayer,
		getVideoPlayer = arg_15_0._getVideoPlayer,
		waitViewOpen = ViewName.CommandStationMapView
	})
end

function var_0_0._getVideoPlayer(arg_16_0)
	return arg_16_0._mapVideoPlayer, arg_16_0._mapDisplayUGUI, arg_16_0._mapVideoGo
end

function var_0_0._setVideoPlayer(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	gohelper.addChild(arg_17_0._mapVideoNode, arg_17_3)

	arg_17_2.enabled = false

	arg_17_1:Pause()
	arg_17_1:Seek(0)
end

function var_0_0._delayOpenMapView(arg_18_0)
	CommandStationController.instance:openCommandStationMapView()
end

function var_0_0._onVideoEndForOpenMap(arg_19_0)
	arg_19_0._changeVideoViewLayer = false

	if not ViewMgr.instance:isOpen(ViewName.CommandStationMapView) then
		TaskDispatcher.cancelTask(arg_19_0._delayOpenMapView, arg_19_0)
		CommandStationController.instance:openCommandStationMapView()
	end
end

function var_0_0._btntaskOnClick(arg_20_0)
	arg_20_0:_afterBoxClose(function()
		arg_20_0._viewAnimatorPlayer:Play("close1", arg_20_0._delayPlayVideo, arg_20_0)
	end)
	UIBlockHelper.instance:startBlock("CommandStationEnterView_taskAnim", 0.2)
	CommandStationController.StatCommandStationButtonClick(arg_20_0.viewName, "_btntaskOnClick")
end

function var_0_0._delayPlayVideo(arg_22_0)
	module_views_preloader._startLoad({
		"ui/viewres/commandstation/commandstation_paperview.prefab"
	}, function()
		arg_22_0._changeVideoViewLayer = true

		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_handian)
		VideoController.instance:openFullScreenVideoView(arg_22_0._toPaperVedioPath, nil, 3, arg_22_0._realOpenPaperView, arg_22_0, {
			noShowBlackBg = true,
			setVideoPlayer = arg_22_0._setVideoPlayer2,
			getVideoPlayer = arg_22_0._getVideoPlayer2,
			waitViewOpen = ViewName.CommandStationPaperView
		})
	end)
end

function var_0_0._getVideoPlayer2(arg_24_0)
	return arg_24_0._paperVideoPlayer, arg_24_0._paperDisplayUGUI, arg_24_0._paperVideoGo
end

function var_0_0._setVideoPlayer2(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	gohelper.addChild(arg_25_0._paperVideoNode, arg_25_3)

	arg_25_2.enabled = false

	arg_25_1:Pause()
	arg_25_1:Seek(0)
end

function var_0_0._realOpenPaperView(arg_26_0)
	arg_26_0._changeVideoViewLayer = false

	arg_26_0.viewContainer:setVisibleInternal(false)

	if ViewMgr.instance:isOpenFinish(ViewName.CommandStationPaperView) then
		local var_26_0 = ViewMgr.instance:getContainer(ViewName.CommandStationPaperView)

		var_26_0:setVisibleInternal(true)
		var_26_0:playOpenTransition()
	else
		CommandStationController.instance:openCommandStationPaperView()
	end
end

function var_0_0._btnactivityOnClick(arg_27_0)
	if not arg_27_0._constActParamConfig then
		return
	end

	local var_27_0 = arg_27_0._constActParamConfig.value2

	_G[var_27_0].instance:openVersionActivityEnterView()
	CommandStationController.StatCommandStationButtonClick(arg_27_0.viewName, "_btnactivityOnClick")
end

function var_0_0._editableInitView(arg_28_0)
	arg_28_0._viewOpenTime = Time.realtimeSinceStartup
	arg_28_0._goActivityRedDot = gohelper.findChild(arg_28_0.viewGO, "#btn_activity/go_reddot")

	gohelper.setActive(arg_28_0._goActivityRedDot, false)

	arg_28_0._goActivityBg = gohelper.findChild(arg_28_0.viewGO, "simage_dec")
	arg_28_0._constChapterListConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ChapterList)

	if arg_28_0._constChapterListConfig then
		arg_28_0._chapterList = string.splitToNumber(arg_28_0._constChapterListConfig.value2, "#")
	end

	arg_28_0._constActParamConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ActParam)
	arg_28_0._constActParamConfig2 = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ActParam2)
	arg_28_0._mapAnimator = arg_28_0._gomap:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_28_0._gomap, false)

	arg_28_0._bottomAnimator = arg_28_0._gobottom:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._viewAnimatorPlayer = SLFramework.AnimatorPlayer.Get(arg_28_0.viewGO)

	local var_28_0 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND")

	gohelper.addChild(var_28_0, arg_28_0.viewGO)

	arg_28_0._openBox = true
	arg_28_0._boxAnimator = gohelper.findChild(arg_28_0.viewGO, "#btn_box/#ani"):GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._actImage = gohelper.findChildSingleImage(arg_28_0.viewGO, "#btn_activity")
	arg_28_0._gotaskred = gohelper.findChild(arg_28_0.viewGO, "#btn_task/go_reddot")
end

function var_0_0._addCacheVideo(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = UnityEngine.GameObject.New(arg_29_1)

	gohelper.addChild(arg_29_0.viewGO, var_29_0)
	transformhelper.setLocalPosXY(var_29_0.transform, 10000, 0)

	local var_29_1, var_29_2, var_29_3 = AvProMgr.instance:getVideoPlayer(var_29_0)

	var_29_1:LoadMedia(arg_29_2)

	return var_29_0, var_29_1, var_29_2, var_29_3
end

function var_0_0._updateBoxAnim(arg_30_0)
	arg_30_0._boxAnimator:Play(arg_30_0._openBox and "open" or "close")
end

function var_0_0._afterBoxClose(arg_31_0, arg_31_1)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_playvideo", true)

	if not arg_31_0._openBox then
		arg_31_1()

		return
	end

	arg_31_0._boxCloseDoneCallback = arg_31_1
	arg_31_0._openBox = false

	arg_31_0:_updateBoxAnim()

	local var_31_0 = 0.33

	TaskDispatcher.cancelTask(arg_31_0._boxCloseDone, arg_31_0)
	TaskDispatcher.runDelay(arg_31_0._boxCloseDone, arg_31_0, var_31_0)
	UIBlockHelper.instance:startBlock("CommandStationEnterView_afterBoxClose", var_31_0)
end

function var_0_0._boxCloseDone(arg_32_0)
	arg_32_0._boxCloseDoneCallback()
end

function var_0_0._getLastEpisodeConfig(arg_33_0)
	local var_33_0 = arg_33_0._chapterList

	for iter_33_0 = #var_33_0, 1, -1 do
		local var_33_1 = var_33_0[iter_33_0]
		local var_33_2 = arg_33_0:_getChapterLastEpisodeConfig(var_33_1)

		if var_33_2 then
			return var_33_2
		end
	end

	local var_33_3 = var_33_0[1]

	return DungeonConfig.instance:getChapterEpisodeCOList(var_33_3)[1]
end

function var_0_0._getChapterLastEpisodeConfig(arg_34_0, arg_34_1)
	local var_34_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_34_1)

	for iter_34_0 = #var_34_0, 1, -1 do
		local var_34_1 = var_34_0[iter_34_0]

		if DungeonModel.instance:hasPassLevelAndStory(var_34_1.id) then
			return var_34_1
		end

		if DungeonModel.instance:isFinishElementList(var_34_1) and (var_34_1.preEpisode == 0 or DungeonModel.instance:hasPassLevelAndStory(var_34_1.preEpisode) or DungeonModel.instance:hasPassLevelAndStory(var_34_1.preEpisode2)) then
			return var_34_1
		end
	end
end

function var_0_0._initSpine(arg_35_0)
	arg_35_0._uiSpine = GuiSpine.Create(arg_35_0._btnwuxiandian.gameObject, true)

	local var_35_0 = "command_radio"
	local var_35_1 = ResUrl.getRolesCgStory(var_35_0, "v3a0_command_radio")

	arg_35_0._uiSpine:setResPath(var_35_1, arg_35_0._onSpineLoaded, arg_35_0)
end

function var_0_0._onSpineLoaded(arg_36_0)
	arg_36_0:_playIdleAnim()
end

function var_0_0._playIdleAnim(arg_37_0)
	if arg_37_0._uiSpine then
		arg_37_0._uiSpine:play("radio_cycle", true)
	end
end

function var_0_0.onOpen(arg_38_0)
	arg_38_0._idleConfig = CommandStationConfig.instance:getDialogByType(CommandStationEnum.DialogueType.Idle)

	arg_38_0:_startIdleDialogue()
	arg_38_0:_showEpisodeInfo()
	arg_38_0:_initSpine()
	arg_38_0:_updateActBtn()
	arg_38_0:_checkRed()
	arg_38_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_38_0._onRefreshActivity, arg_38_0)
	arg_38_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_38_0._onUpdateDungeonInfo, arg_38_0)
	arg_38_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_38_0._OnCloseViewFinish, arg_38_0)
	arg_38_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_38_0._OnOpenView, arg_38_0)
	arg_38_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_38_0._OnCloseFullView, arg_38_0, LuaEventSystem.Low)
	arg_38_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_38_0._checkRed, arg_38_0)
	arg_38_0:addEventCb(VideoController.instance, VideoEvent.OnVideoStarted, arg_38_0._onVideoStarted, arg_38_0)
	arg_38_0:addEventCb(VideoController.instance, VideoEvent.OnVideoFirstFrameReady, arg_38_0._onVideoFirstFrameReady, arg_38_0)
	arg_38_0:addEventCb(CommandStationController.instance, CommandStationEvent.OnPaperUpdate, arg_38_0._onPaperUpdate, arg_38_0)

	if arg_38_0.viewParam and arg_38_0.viewParam.fromDungeonSectionItem then
		arg_38_0:_resetLayer()
	else
		TaskDispatcher.cancelTask(arg_38_0._openPostProcess, arg_38_0)
		TaskDispatcher.runRepeat(arg_38_0._openPostProcess, arg_38_0, 0)
	end

	arg_38_0:_updatePaper()
end

function var_0_0._onPaperUpdate(arg_39_0)
	arg_39_0:_updatePaper()
end

function var_0_0._updatePaper(arg_40_0)
	local var_40_0 = CommandStationModel.instance.paper or 0
	local var_40_1 = Mathf.Clamp(var_40_0, 0, 9)
	local var_40_2 = var_40_1 == 0 and "commandstation_box_empty" or "commandstation_box_0" .. tostring(var_40_1)

	UISpriteSetMgr.instance:setCommandStationSprite(arg_40_0._imagebox, var_40_2)
end

function var_0_0._hideMainScene(arg_41_0)
	local var_41_0 = GameSceneMgr.instance:getCurScene():getSceneContainerGO()

	gohelper.setActive(var_41_0, false)
end

function var_0_0._onVideoStarted(arg_42_0, arg_42_1)
	if arg_42_1 == arg_42_0._toMapVedioPath then
		TaskDispatcher.cancelTask(arg_42_0._delayHideSelf, arg_42_0)
		TaskDispatcher.runDelay(arg_42_0._delayHideSelf, arg_42_0, 0)
	end

	if arg_42_1 == arg_42_0._toPaperVedioPath then
		CommandStationController.instance:openCommandStationPaperView()
		VideoController.instance:openFullScreenVideoView(arg_42_0._toPaperVedioPath, nil, 5, arg_42_0._realOpenPaperView, arg_42_0, ViewName.CommandStationPaperView, true)
	end
end

function var_0_0._onVideoFirstFrameReady(arg_43_0, arg_43_1)
	return
end

function var_0_0._delayHideSelf(arg_44_0)
	arg_44_0.viewContainer:setVisibleInternal(false)
	TaskDispatcher.cancelTask(arg_44_0._delayOpenMapView, arg_44_0)
	TaskDispatcher.runDelay(arg_44_0._delayOpenMapView, arg_44_0, 0.85)
end

function var_0_0._openPostProcess(arg_45_0)
	PostProcessingMgr.instance:setUIActive(true)
end

function var_0_0._resetLayer(arg_46_0)
	local var_46_0 = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.addChild(var_46_0, arg_46_0.viewGO)
end

function var_0_0._checkRed(arg_47_0)
	gohelper.setActive(arg_47_0._gotaskred, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CommandStationPaper))
	gohelper.setActive(arg_47_0._goActivityRedDot, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.VersionActivityEnterRedDot))
end

function var_0_0._OnOpenView(arg_48_0, arg_48_1)
	if arg_48_1 == ViewName.CommandStationMapView or arg_48_1 == ViewName.CommandStationPaperView then
		UIBlockMgrExtend.setNeedCircleMv(true)
		arg_48_0.viewContainer:setVisibleInternal(false)
		GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_playvideo", false)
	end

	if arg_48_0._changeVideoViewLayer and arg_48_1 == ViewName.FullScreenVideoView then
		arg_48_0._changeVideoViewLayer = false

		local var_48_0 = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

		if var_48_0 and not gohelper.isNil(var_48_0.viewGO) then
			local var_48_1 = ViewMgr.instance:getUILayer("HUD")

			gohelper.addChild(var_48_1, var_48_0.viewGO)
		end
	end

	if arg_48_1 == ViewName.CommandStationPaperView and ViewMgr.instance:isOpen(ViewName.FullScreenVideoView) then
		local var_48_2 = ViewMgr.instance:getContainer(ViewName.CommandStationPaperView)

		if var_48_2 and not gohelper.isNil(var_48_2.viewGO) then
			var_48_2:setVisibleInternal(false)
		end
	end
end

function var_0_0._OnCloseViewFinish(arg_49_0, arg_49_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_49_0.viewName) then
		return
	end

	if arg_49_1 == ViewName.CommandStationPaperView then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_fanhui)
	end

	if arg_49_1 == ViewName.CommandStationMapView or arg_49_1 == ViewName.DungeonMapView or arg_49_1 == ViewName.CommandStationPaperView then
		arg_49_0.viewContainer:setVisibleInternal(true)
		arg_49_0._viewAnimatorPlayer:Play("open2", arg_49_0._animDone, arg_49_0)

		arg_49_0._openBox = true

		arg_49_0:_updateBoxAnim()
	end
end

function var_0_0.onUpdateParam(arg_50_0)
	arg_50_0.viewContainer:setVisibleInternal(true)
	arg_50_0._viewAnimatorPlayer:Play("open2", arg_50_0._animDone, arg_50_0)
end

function var_0_0._OnCloseFullView(arg_51_0, arg_51_1)
	if arg_51_1 == ViewName.CommandStationMapView or arg_51_1 == ViewName.DungeonMapView then
		arg_51_0.viewContainer:setVisibleInternal(false)
	end
end

function var_0_0._animDone(arg_52_0)
	return
end

function var_0_0._onUpdateDungeonInfo(arg_53_0)
	arg_53_0:_showEpisodeInfo()
end

function var_0_0._onRefreshActivity(arg_54_0)
	arg_54_0:_updateActBtn()
end

function var_0_0._updateActBtn(arg_55_0)
	local var_55_0, var_55_1 = arg_55_0:_isShowActivity()

	gohelper.setActive(arg_55_0._btnactivity, var_55_0)
	gohelper.setActive(arg_55_0._goActivityBg, var_55_0)

	if var_55_0 then
		arg_55_0._actImage:LoadImage(var_55_1)
	end
end

function var_0_0._isShowActivity(arg_56_0)
	if arg_56_0._constActParamConfig2 then
		local var_56_0 = arg_56_0._constActParamConfig2.value
		local var_56_1 = (var_56_0 > 0 and ActivityHelper.getActivityStatus(var_56_0)) == ActivityEnum.ActivityStatus.Normal

		if var_56_1 then
			return var_56_1, arg_56_0._constActParamConfig2.value3
		end
	end

	if arg_56_0._constActParamConfig then
		local var_56_2 = arg_56_0._constActParamConfig.value
		local var_56_3 = ActivityHelper.getActivityStatus(var_56_2) == ActivityEnum.ActivityStatus.Normal

		if var_56_3 then
			return var_56_3, arg_56_0._constActParamConfig.value3
		end
	end
end

function var_0_0.onOpenFinish(arg_57_0)
	arg_57_0:_resetLayer()
	PostProcessingMgr.instance:setUIActive(false)
	TaskDispatcher.cancelTask(arg_57_0._openPostProcess, arg_57_0)
	arg_57_0:_showEnterDialogue()
	arg_57_0:_showMap()
	arg_57_0:_preloadVideos()
end

function var_0_0._preloadVideos(arg_58_0)
	arg_58_0._toMapVedioPath = "videos/commandstation_tomap.mp4"
	arg_58_0._toPaperVedioPath = "videos/commandstation_tocode.mp4"
	arg_58_0._paperVideoNode, arg_58_0._paperVideoPlayer, arg_58_0._paperDisplayUGUI, arg_58_0._paperVideoGo = arg_58_0:_addCacheVideo("paperVideo", arg_58_0._toPaperVedioPath)
	arg_58_0._mapVideoNode, arg_58_0._mapVideoPlayer, arg_58_0._mapDisplayUGUI, arg_58_0._mapVideoGo = arg_58_0:_addCacheVideo("mapVideo", arg_58_0._toMapVedioPath)
end

function var_0_0._showEpisodeInfo(arg_59_0)
	gohelper.setActive(arg_59_0._btnmap, DungeonModel.instance:hasPassLevelAndStory(CommandStationEnum.FirstEpisodeId))

	if not arg_59_0._chapterList then
		return
	end

	local var_59_0 = arg_59_0:_getLastEpisodeConfig()
	local var_59_1 = DungeonConfig.instance:getEpisodeLevelIndex(var_59_0)
	local var_59_2 = DungeonConfig.instance:getChapterCO(var_59_0.chapterId)

	if LuaUtil.containChinese(var_59_0.name) then
		local var_59_3 = LuaUtil.getCharNum(var_59_0.name)
		local var_59_4 = 8

		if var_59_4 < var_59_3 then
			arg_59_0._txtName.text = LuaUtil.subString(var_59_0.name, 1, var_59_4) .. "..."
		else
			arg_59_0._txtName.text = var_59_0.name
		end
	else
		arg_59_0._txtName.text = var_59_0.name
	end

	arg_59_0._txtNum.text = string.format("%s-%s", var_59_2.chapterIndex, var_59_1)
	arg_59_0._showEpisodeId = var_59_0.id
end

function var_0_0._startIdleDialogue(arg_60_0)
	TaskDispatcher.cancelTask(arg_60_0._playIdleDialogue, arg_60_0)
	TaskDispatcher.runDelay(arg_60_0._playIdleDialogue, arg_60_0, arg_60_0._idleConfig.time)
end

function var_0_0._playIdleDialogue(arg_61_0)
	local var_61_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Idle)

	arg_61_0:_showDialogue(var_61_0)
end

function var_0_0._showEnterDialogue(arg_62_0)
	local var_62_0 = CommandStationConfig.instance:getRandomDialogTextId(CommandStationEnum.DialogueType.Enter)

	arg_62_0:_showDialogue(var_62_0)
end

function var_0_0._showDialogue(arg_63_0, arg_63_1)
	if not arg_63_1 then
		logError("_showDialogue textId is nil")

		return
	end

	local var_63_0 = lua_copost_npc_text.configDict[arg_63_1]

	if not var_63_0 then
		logError(string.format("CommandStationEnterView _showDialogue textId:%s config is nil", arg_63_1))

		return
	end

	TaskDispatcher.cancelTask(arg_63_0._playIdleDialogue, arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._hideDialogue, arg_63_0)
	TaskDispatcher.runDelay(arg_63_0._hideDialogue, arg_63_0, 5)
	arg_63_0._bottomAnimator:Play("in", 0, 0)
	gohelper.setActive(arg_63_0._gobottom, true)

	arg_63_0._txtanacn.text = var_63_0.text

	if LangSettings.instance:isCn() then
		arg_63_0._txtanaen.text = var_63_0.engtext
	else
		arg_63_0._txtanaen.text = ""
	end
end

function var_0_0._hideDialogue(arg_64_0)
	arg_64_0._bottomAnimator:Play("out", 0, 0)
	arg_64_0:_startIdleDialogue()
end

function var_0_0._showMap(arg_65_0)
	local var_65_0 = string.format("%s_%s", CommandStationEnum.PrefsKey.NewMapTip, CommandStationConfig.instance:getCurVersionId())

	if CommandStationController.hasOnceActionKey(var_65_0) then
		return
	end

	CommandStationController.setOnceActionKey(var_65_0)

	if CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.VersionName) then
		arg_65_0._txtmapname.text = luaLang("CommandStationEnterView_showMap_txtmapname")
	end

	gohelper.setActive(arg_65_0._gomap, true)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Story_Map_In)
	arg_65_0._mapAnimator:Play("go_mapname_in")
	TaskDispatcher.cancelTask(arg_65_0._mapOut, arg_65_0)
	TaskDispatcher.runDelay(arg_65_0._mapOut, arg_65_0, 3)
end

function var_0_0._mapOut(arg_66_0)
	arg_66_0._mapAnimator:Play("go_mapname_out")
end

function var_0_0.onClose(arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._hideDialogue, arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._playIdleDialogue, arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._mapOut, arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._openPostProcess, arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._delayPlayIdleAnim, arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._delayOpenMapView, arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._delayHideSelf, arg_67_0)
	TaskDispatcher.cancelTask(arg_67_0._boxCloseDone, arg_67_0)
	CommandStationController.StatCommandStationViewClose(arg_67_0.viewName, Time.realtimeSinceStartup - arg_67_0._viewOpenTime)
	UIBlockMgrExtend.setNeedCircleMv(true)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_playvideo", false)
	CommandStationMapModel.instance:setPreloadScene()
	CommandStationMapModel.instance:setPreloadView()
end

function var_0_0.onDestroyView(arg_68_0)
	if arg_68_0._preloadLoader then
		arg_68_0._preloadLoader:dispose()

		arg_68_0._preloadLoader = nil
	end
end

return var_0_0
