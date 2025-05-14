module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapView", package.seeall)

local var_0_0 = class("Activity1_3ChessMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "LeftTop/#simage_Title")
	arg_1_0._btnRewardBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_RewardBtn")
	arg_1_0._goStage1 = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_Stage1")
	arg_1_0._goStage2 = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_Stage2")
	arg_1_0._goStage3 = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_Stage3")
	arg_1_0._goStage4 = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_Stage4")
	arg_1_0._goNextBtn = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_NextBtn")
	arg_1_0._goNextBtnRoot = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_NextBtn/Root")
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_0.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#txt_StageName")
	arg_1_0._goImageLock = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#image_Lock")
	arg_1_0._goLockBg = gohelper.findChild(arg_1_0.viewGO, "Map/Path1/#go_NextBtn/Root/#image_StageNormalBG")
	arg_1_0._txtStageNum = gohelper.findChildText(arg_1_0.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#txt_StageName/#txt_StageNum")
	arg_1_0._btnGoNextClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Map/Path1/#go_NextBtn/Root/#btn_Click")
	arg_1_0._goPath2Stage1 = gohelper.findChild(arg_1_0.viewGO, "Map/Path2/#go_Stage1")
	arg_1_0._goPath2Stage2 = gohelper.findChild(arg_1_0.viewGO, "Map/Path2/#go_Stage2")
	arg_1_0._goPath2Stage3 = gohelper.findChild(arg_1_0.viewGO, "Map/Path2/#go_Stage3")
	arg_1_0._goPath2Stage4 = gohelper.findChild(arg_1_0.viewGO, "Map/Path2/#go_Stage4")
	arg_1_0._goPreviousBtn = gohelper.findChild(arg_1_0.viewGO, "Map/Path2/#go_PreviousBtn")
	arg_1_0._btnPath2Click = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Map/Path2/#go_PreviousBtn/Root/#btn_Click")
	arg_1_0._goPath1 = gohelper.findChild(arg_1_0.viewGO, "Map/Path1")
	arg_1_0._goPath2 = gohelper.findChild(arg_1_0.viewGO, "Map/Path2")
	arg_1_0._goreceive = gohelper.findChild(arg_1_0.viewGO, "RightTop/ani/gifts_receive")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "image_Mask")
	arg_1_0._simageMainPath1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Map/Path1/image_MainPath1")
	arg_1_0._simageMainPath2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Map/Path2/image_MainPath2")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	gohelper.setActive(arg_1_0._goexcessive, true)

	arg_1_0._goRedDotRoot = gohelper.findChild(arg_1_0.viewGO, "RightTop/#go_reddotreward")

	local var_1_0 = typeof(UnityEngine.Animator)

	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(var_1_0)
	arg_1_0._rewardAnimator = gohelper.findChildComponent(arg_1_0.viewGO, "RightTop/ani", var_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRewardBtn:AddClickListener(arg_2_0._btnRewardBtnOnClick, arg_2_0)
	arg_2_0._btnGoNextClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0._btnPath2Click:AddClickListener(arg_2_0._btnPath2ClickOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickEpisode, arg_2_0._onGotoTaskEpisode, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0._refreshRewardAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRewardBtn:RemoveClickListener()
	arg_3_0._btnGoNextClick:RemoveClickListener()
	arg_3_0._btnPath2Click:RemoveClickListener()
end

function var_0_0._btnRewardBtnOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.Activity1_3ChessTaskView)
end

function var_0_0._btnClickOnClick(arg_5_0)
	if Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(Activity1_3ChessEnum.Chapter.Two) then
		AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
		arg_5_0:_beginSwitchStage(Activity1_3ChessEnum.Chapter.Two)
	else
		GameFacade.showToast(ToastEnum.Va3Act120ChapterNotOpenTime)
	end
end

function var_0_0._btnPath2ClickOnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
	arg_6_0:_beginSwitchStage(Activity1_3ChessEnum.Chapter.One)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._path1NodeRoots = {
		arg_7_0._goStage1,
		arg_7_0._goStage2,
		arg_7_0._goStage3,
		arg_7_0._goStage4
	}
	arg_7_0._path2NodeRoots = {
		arg_7_0._goPath2Stage1,
		arg_7_0._goPath2Stage2,
		arg_7_0._goPath2Stage3,
		arg_7_0._goPath2Stage4
	}
	arg_7_0._stageRoots = {
		arg_7_0._goPath1,
		arg_7_0._goPath2
	}

	MainCameraMgr.instance:addView(arg_7_0.viewName, arg_7_0.initCamera, nil, arg_7_0)
	arg_7_0._simageMask:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	arg_7_0._simageMainPath1:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_og_mapmainpath_1"))
	arg_7_0._simageMainPath2:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_og_mapmainpath_2"))
	RedDotController.instance:addRedDot(arg_7_0._goRedDotRoot, RedDotEnum.DotNode.Activity1_3RedDotAct122Reward)
end

function var_0_0.initCamera(arg_8_0)
	local var_8_0 = CameraMgr.instance:getMainCamera()

	var_8_0.orthographic = true
	var_8_0.orthographicSize = 8.75 * GameUtil.getAdapterScale(true)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_refreshNextChapterView()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_initMapNodeItems()
	arg_10_0:_refreshNodeItemViews()

	local var_10_0 = Activity122Model.instance:getCurEpisodeId()
	local var_10_1 = VersionActivity1_3Enum.ActivityId.Act304
	local var_10_2 = Va3ChessConfig.instance:getEpisodeCo(var_10_1, var_10_0)
	local var_10_3 = var_10_2 and var_10_2.chapterId or 1

	arg_10_0:_switchToStage(var_10_3)
	arg_10_0.viewContainer:showEnterSceneView(var_10_3)
	arg_10_0:_refreshNextChapterView()
	arg_10_0:_refreshRewardAnim()
	arg_10_0:playViewAnimation(UIAnimationName.Open)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._acturalSwitchStage, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playNodeAppearEnd, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playNextBtnUnlockAni, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playNodeAppearAnimation, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._nodeItemDict then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._nodeItemDict) do
			iter_12_1:onDestroyView()
		end
	end

	arg_12_0._nodeItemDict = nil

	arg_12_0._simageMask:UnLoadImage()
	arg_12_0._simageMainPath2:UnLoadImage()
	arg_12_0._simageMainPath1:UnLoadImage()
end

function var_0_0._initMapNodeItems(arg_13_0)
	if arg_13_0._nodeItemDict then
		return
	end

	arg_13_0._nodeItemDict = {}

	local var_13_0 = VersionActivity1_3Enum.ActivityId.Act304

	arg_13_0._episodeCfgList = Activity122Config.instance:getEpisodeList(var_13_0)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._episodeCfgList) do
		arg_13_0:_createMapNodeItem(iter_13_1)
	end
end

function var_0_0._createMapNodeItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.id

	if not arg_14_0._nodeItemDict[var_14_0] then
		local var_14_1 = Activity1_3ChessMapNodeItem.prefabPath
		local var_14_2 = var_14_0 <= #arg_14_0._path1NodeRoots and arg_14_0._path1NodeRoots[var_14_0] or arg_14_0._path2NodeRoots[var_14_0 - #arg_14_0._path1NodeRoots]
		local var_14_3 = arg_14_0:getResInst(var_14_1, var_14_2)
		local var_14_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_3, Activity1_3ChessMapNodeItem, arg_14_0)

		var_14_4:setCfg(arg_14_1)
		var_14_4:setClickCallback(arg_14_0._clickNodeCallback, arg_14_0)

		arg_14_0._nodeItemDict[var_14_0] = var_14_4
	end
end

function var_0_0._refreshNodeItemViews(arg_15_0)
	if not arg_15_0._nodeItemDict then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0._nodeItemDict) do
		iter_15_1:refreshUI()
	end
end

function var_0_0._refreshNextChapterView(arg_16_0)
	gohelper.setActive(arg_16_0._goNextBtn, true)

	local var_16_0 = Activity122Model.instance:getPlayerCacheData()
	local var_16_1 = Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(Activity1_3ChessEnum.Chapter.Two)

	if var_16_1 and var_16_0.isNextChapterLock then
		var_16_0.isNextChapterLock = false

		Activity122Model.instance:saveCacheData()
		TaskDispatcher.runDelay(arg_16_0._playNextBtnUnlockAni, arg_16_0, 0.4)
	end

	gohelper.setActive(arg_16_0._goImageLock, not var_16_1)
	ZProj.UGUIHelper.SetGrayFactor(arg_16_0._goLockBg, var_16_1 and 0 or 1)
end

function var_0_0._clickNodeCallback(arg_17_0, arg_17_1)
	local var_17_0 = Activity122Model.instance:getCurEpisodeId()

	if var_17_0 == arg_17_1 then
		arg_17_0._targetNodeId = arg_17_1

		arg_17_0:_playNodeAppearEnd()
	else
		local var_17_1 = VersionActivity1_3Enum.ActivityId.Act304
		local var_17_2 = Va3ChessConfig.instance:getEpisodeCo(var_17_1, var_17_0)
		local var_17_3 = Va3ChessConfig.instance:getEpisodeCo(var_17_1, var_17_0)
		local var_17_4 = var_17_2.chapterId
		local var_17_5 = var_17_3.chapterId == var_17_4
		local var_17_6 = arg_17_0._nodeItemDict[var_17_0]
		local var_17_7 = arg_17_0._nodeItemDict[arg_17_1]

		if var_17_5 then
			UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
			var_17_6:playDisAppearAni(arg_17_1)

			arg_17_0._targetNodeId = arg_17_1

			TaskDispatcher.runDelay(arg_17_0._playNodeAppearAnimation, arg_17_0, 0.4)
			AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.PlayerChessMove)
		else
			var_17_7:playAppearAni(var_17_0)
			AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.PlayerChessMove)
		end
	end
end

function var_0_0._playNodeAppearAnimation(arg_18_0, arg_18_1)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	local var_18_0 = Activity122Model.instance:getCurEpisodeId()

	arg_18_0._nodeItemDict[arg_18_0._targetNodeId]:playAppearAni(var_18_0)
	TaskDispatcher.runDelay(arg_18_0._playNodeAppearEnd, arg_18_0, 0.8)
end

function var_0_0._playNodeAppearEnd(arg_19_0)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
	arg_19_0:playViewAnimation(UIAnimationName.Close)
	Activity1_3ChessController.instance:requestEnterChessGame(arg_19_0._targetNodeId, 0.3)

	arg_19_0._targetNodeId = nil
end

function var_0_0._beginSwitchStage(arg_20_0, arg_20_1)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
	arg_20_0:playSwitchSceneAni(arg_20_1 == Activity1_3ChessEnum.Chapter.Two)

	arg_20_0._delayToStage = arg_20_1

	TaskDispatcher.cancelTask(arg_20_0._acturalSwitchStage, arg_20_0)
	TaskDispatcher.runDelay(arg_20_0._acturalSwitchStage, arg_20_0, 0.5)
end

function var_0_0._acturalSwitchStage(arg_21_0, arg_21_1)
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)
	arg_21_0:_switchToStage(arg_21_0._delayToStage)
end

function var_0_0._switchToStage(arg_22_0, arg_22_1)
	if arg_22_0:_checkChessMapStageOpen(arg_22_1) then
		arg_22_0._curStage = arg_22_1

		for iter_22_0 = 1, #arg_22_0._stageRoots do
			gohelper.setActive(arg_22_0._stageRoots[iter_22_0], iter_22_0 == arg_22_1)
		end
	end

	if arg_22_0.viewContainer.switchStage then
		arg_22_0.viewContainer:switchStage(arg_22_1)
	end
end

function var_0_0._checkChessMapStageOpen(arg_23_0, arg_23_1)
	return (Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(arg_23_1))
end

function var_0_0.onSetVisible(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		arg_24_0:_refreshNodeItemViews()

		local var_24_0 = Activity122Model.instance:getCurEpisodeId()
		local var_24_1 = VersionActivity1_3Enum.ActivityId.Act304
		local var_24_2 = Va3ChessConfig.instance:getEpisodeCo(var_24_1, var_24_0)
		local var_24_3 = var_24_2 and var_24_2.chapterId or 1

		if not arg_24_2 then
			arg_24_0:_switchToStage(var_24_3)
		end

		arg_24_0:_refreshNextChapterView()
	end
end

function var_0_0._onGotoTaskEpisode(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:_getEpisodeChapterId(arg_25_1)

	if var_25_0 and var_25_0 ~= arg_25_0._curStage then
		arg_25_0:_switchToStage(var_25_0)
	end

	arg_25_0:_clickNodeCallback(arg_25_1)
end

function var_0_0._getEpisodeChapterId(arg_26_0, arg_26_1)
	if not arg_26_0._episodeCfgList or #arg_26_0._episodeCfgList < 1 then
		return
	end

	local var_26_0 = arg_26_1 and Activity122Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act304, arg_26_1)

	if var_26_0 and Activity1_3ChessController.isOpenDay(arg_26_1) then
		return var_26_0.chapterId
	end

	local var_26_1 = arg_26_0._episodeCfgList[1]

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._episodeCfgList) do
		if Activity122Model.instance:isEpisodeClear(iter_26_1.id) then
			var_26_1 = iter_26_1
		else
			if Activity1_3ChessController.isOpenDay(iter_26_1.id) then
				var_26_1 = iter_26_1
			end

			break
		end
	end

	if var_26_1 then
		return var_26_1.chapterId
	end
end

function var_0_0.playViewAnimation(arg_27_0, arg_27_1)
	arg_27_0._viewAnimator:Play(arg_27_1, 0, 0)
end

function var_0_0._playNextBtnUnlockAni(arg_28_0)
	gohelper.onceAddComponent(arg_28_0._goNextBtnRoot, typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock)
end

function var_0_0.playCloseAnimation(arg_29_0, arg_29_1, arg_29_2)
	gohelper.onceAddComponent(arg_29_0.viewGO, typeof(UnityEngine.Animator)):Play(UIAnimationName.Close, arg_29_1, arg_29_2)
end

function var_0_0.playSwitchSceneAni(arg_30_0, arg_30_1)
	gohelper.setActive(arg_30_0._goexcessive, true)

	local var_30_0 = typeof(UnityEngine.Animator)

	gohelper.findChildComponent(arg_30_0.viewGO, "#go_excessive", var_30_0):Play(arg_30_1 and "story" or "hard")
end

function var_0_0._refreshRewardAnim(arg_31_0)
	local var_31_0 = Activity1_3ChessController.instance:checkHasReward()

	if arg_31_0._lastIsHasReward ~= var_31_0 then
		arg_31_0._lastIsHasReward = var_31_0

		arg_31_0._rewardAnimator:Play(var_31_0 and "loop" or "idle")
	end
end

return var_0_0
