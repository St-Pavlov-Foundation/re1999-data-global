module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapView", package.seeall)

slot0 = class("Activity1_3ChessMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "LeftTop/#simage_Title")
	slot0._btnRewardBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_RewardBtn")
	slot0._goStage1 = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_Stage1")
	slot0._goStage2 = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_Stage2")
	slot0._goStage3 = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_Stage3")
	slot0._goStage4 = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_Stage4")
	slot0._goNextBtn = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_NextBtn")
	slot0._goNextBtnRoot = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_NextBtn/Root")
	slot0._txtStageName = gohelper.findChildText(slot0.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#txt_StageName")
	slot0._goImageLock = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#image_Lock")
	slot0._goLockBg = gohelper.findChild(slot0.viewGO, "Map/Path1/#go_NextBtn/Root/#image_StageNormalBG")
	slot0._txtStageNum = gohelper.findChildText(slot0.viewGO, "Map/Path1/#go_NextBtn/Root/Info/#txt_StageName/#txt_StageNum")
	slot0._btnGoNextClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "Map/Path1/#go_NextBtn/Root/#btn_Click")
	slot0._goPath2Stage1 = gohelper.findChild(slot0.viewGO, "Map/Path2/#go_Stage1")
	slot0._goPath2Stage2 = gohelper.findChild(slot0.viewGO, "Map/Path2/#go_Stage2")
	slot0._goPath2Stage3 = gohelper.findChild(slot0.viewGO, "Map/Path2/#go_Stage3")
	slot0._goPath2Stage4 = gohelper.findChild(slot0.viewGO, "Map/Path2/#go_Stage4")
	slot0._goPreviousBtn = gohelper.findChild(slot0.viewGO, "Map/Path2/#go_PreviousBtn")
	slot0._btnPath2Click = gohelper.findChildButtonWithAudio(slot0.viewGO, "Map/Path2/#go_PreviousBtn/Root/#btn_Click")
	slot0._goPath1 = gohelper.findChild(slot0.viewGO, "Map/Path1")
	slot0._goPath2 = gohelper.findChild(slot0.viewGO, "Map/Path2")
	slot0._goreceive = gohelper.findChild(slot0.viewGO, "RightTop/ani/gifts_receive")
	slot0._simageMask = gohelper.findChildSingleImage(slot0.viewGO, "image_Mask")
	slot0._simageMainPath1 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path1/image_MainPath1")
	slot0._simageMainPath2 = gohelper.findChildSingleImage(slot0.viewGO, "Map/Path2/image_MainPath2")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")

	gohelper.setActive(slot0._goexcessive, true)

	slot0._goRedDotRoot = gohelper.findChild(slot0.viewGO, "RightTop/#go_reddotreward")
	slot1 = typeof(UnityEngine.Animator)
	slot0._viewAnimator = slot0.viewGO:GetComponent(slot1)
	slot0._rewardAnimator = gohelper.findChildComponent(slot0.viewGO, "RightTop/ani", slot1)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnRewardBtn:AddClickListener(slot0._btnRewardBtnOnClick, slot0)
	slot0._btnGoNextClick:AddClickListener(slot0._btnClickOnClick, slot0)
	slot0._btnPath2Click:AddClickListener(slot0._btnPath2ClickOnClick, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickEpisode, slot0._onGotoTaskEpisode, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshRewardAnim, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRewardBtn:RemoveClickListener()
	slot0._btnGoNextClick:RemoveClickListener()
	slot0._btnPath2Click:RemoveClickListener()
end

function slot0._btnRewardBtnOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Activity1_3ChessTaskView)
end

function slot0._btnClickOnClick(slot0)
	if Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(Activity1_3ChessEnum.Chapter.Two) then
		AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
		slot0:_beginSwitchStage(Activity1_3ChessEnum.Chapter.Two)
	else
		GameFacade.showToast(ToastEnum.Va3Act120ChapterNotOpenTime)
	end
end

function slot0._btnPath2ClickOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
	slot0:_beginSwitchStage(Activity1_3ChessEnum.Chapter.One)
end

function slot0._editableInitView(slot0)
	slot0._path1NodeRoots = {
		slot0._goStage1,
		slot0._goStage2,
		slot0._goStage3,
		slot0._goStage4
	}
	slot0._path2NodeRoots = {
		slot0._goPath2Stage1,
		slot0._goPath2Stage2,
		slot0._goPath2Stage3,
		slot0._goPath2Stage4
	}
	slot0._stageRoots = {
		slot0._goPath1,
		slot0._goPath2
	}

	MainCameraMgr.instance:addView(slot0.viewName, slot0.initCamera, nil, slot0)
	slot0._simageMask:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	slot0._simageMainPath1:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_og_mapmainpath_1"))
	slot0._simageMainPath2:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_og_mapmainpath_2"))
	RedDotController.instance:addRedDot(slot0._goRedDotRoot, RedDotEnum.DotNode.Activity1_3RedDotAct122Reward)
end

function slot0.initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 8.75 * GameUtil.getAdapterScale(true)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshNextChapterView()
end

function slot0.onOpen(slot0)
	slot0:_initMapNodeItems()
	slot0:_refreshNodeItemViews()

	slot4 = Va3ChessConfig.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act304, Activity122Model.instance:getCurEpisodeId()) and slot3.chapterId or 1

	slot0:_switchToStage(slot4)
	slot0.viewContainer:showEnterSceneView(slot4)
	slot0:_refreshNextChapterView()
	slot0:_refreshRewardAnim()
	slot0:playViewAnimation(UIAnimationName.Open)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._acturalSwitchStage, slot0)
	TaskDispatcher.cancelTask(slot0._playNodeAppearEnd, slot0)
	TaskDispatcher.cancelTask(slot0._playNextBtnUnlockAni, slot0)
	TaskDispatcher.cancelTask(slot0._playNodeAppearAnimation, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._nodeItemDict then
		for slot4, slot5 in pairs(slot0._nodeItemDict) do
			slot5:onDestroyView()
		end
	end

	slot0._nodeItemDict = nil

	slot0._simageMask:UnLoadImage()
	slot0._simageMainPath2:UnLoadImage()
	slot0._simageMainPath1:UnLoadImage()
end

function slot0._initMapNodeItems(slot0)
	if slot0._nodeItemDict then
		return
	end

	slot0._nodeItemDict = {}
	slot0._episodeCfgList = Activity122Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act304)

	for slot5, slot6 in ipairs(slot0._episodeCfgList) do
		slot0:_createMapNodeItem(slot6)
	end
end

function slot0._createMapNodeItem(slot0, slot1)
	if not slot0._nodeItemDict[slot1.id] then
		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity1_3ChessMapNodeItem.prefabPath, slot2 <= #slot0._path1NodeRoots and slot0._path1NodeRoots[slot2] or slot0._path2NodeRoots[slot2 - #slot0._path1NodeRoots]), Activity1_3ChessMapNodeItem, slot0)

		slot7:setCfg(slot1)
		slot7:setClickCallback(slot0._clickNodeCallback, slot0)

		slot0._nodeItemDict[slot2] = slot7
	end
end

function slot0._refreshNodeItemViews(slot0)
	if not slot0._nodeItemDict then
		return
	end

	for slot4, slot5 in pairs(slot0._nodeItemDict) do
		slot5:refreshUI()
	end
end

function slot0._refreshNextChapterView(slot0)
	gohelper.setActive(slot0._goNextBtn, true)

	if Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(Activity1_3ChessEnum.Chapter.Two) and Activity122Model.instance:getPlayerCacheData().isNextChapterLock then
		slot1.isNextChapterLock = false

		Activity122Model.instance:saveCacheData()
		TaskDispatcher.runDelay(slot0._playNextBtnUnlockAni, slot0, 0.4)
	end

	gohelper.setActive(slot0._goImageLock, not slot2)
	ZProj.UGUIHelper.SetGrayFactor(slot0._goLockBg, slot2 and 0 or 1)
end

function slot0._clickNodeCallback(slot0, slot1)
	if Activity122Model.instance:getCurEpisodeId() == slot1 then
		slot0._targetNodeId = slot1

		slot0:_playNodeAppearEnd()
	else
		slot3 = VersionActivity1_3Enum.ActivityId.Act304
		slot10 = slot0._nodeItemDict[slot1]

		if Va3ChessConfig.instance:getEpisodeCo(slot3, slot2).chapterId == Va3ChessConfig.instance:getEpisodeCo(slot3, slot2).chapterId then
			UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
			slot0._nodeItemDict[slot2]:playDisAppearAni(slot1)

			slot0._targetNodeId = slot1

			TaskDispatcher.runDelay(slot0._playNodeAppearAnimation, slot0, 0.4)
			AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.PlayerChessMove)
		else
			slot10:playAppearAni(slot2)
			AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.PlayerChessMove)
		end
	end
end

function slot0._playNodeAppearAnimation(slot0, slot1)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
	slot0._nodeItemDict[slot0._targetNodeId]:playAppearAni(Activity122Model.instance:getCurEpisodeId())
	TaskDispatcher.runDelay(slot0._playNodeAppearEnd, slot0, 0.8)
end

function slot0._playNodeAppearEnd(slot0)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
	slot0:playViewAnimation(UIAnimationName.Close)
	Activity1_3ChessController.instance:requestEnterChessGame(slot0._targetNodeId, 0.3)

	slot0._targetNodeId = nil
end

function slot0._beginSwitchStage(slot0, slot1)
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)
	slot0:playSwitchSceneAni(slot1 == Activity1_3ChessEnum.Chapter.Two)

	slot0._delayToStage = slot1

	TaskDispatcher.cancelTask(slot0._acturalSwitchStage, slot0)
	TaskDispatcher.runDelay(slot0._acturalSwitchStage, slot0, 0.5)
end

function slot0._acturalSwitchStage(slot0, slot1)
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)
	slot0:_switchToStage(slot0._delayToStage)
end

function slot0._switchToStage(slot0, slot1)
	if slot0:_checkChessMapStageOpen(slot1) then
		slot0._curStage = slot1

		for slot6 = 1, #slot0._stageRoots do
			gohelper.setActive(slot0._stageRoots[slot6], slot6 == slot1)
		end
	end

	if slot0.viewContainer.switchStage then
		slot0.viewContainer:switchStage(slot1)
	end
end

function slot0._checkChessMapStageOpen(slot0, slot1)
	return Activity1_3ChessController.instance:checkEpisodeIsOpenByChapterId(slot1)
end

function slot0.onSetVisible(slot0, slot1, slot2)
	if slot1 then
		slot0:_refreshNodeItemViews()

		if not slot2 then
			slot0:_switchToStage(Va3ChessConfig.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act304, Activity122Model.instance:getCurEpisodeId()) and slot5.chapterId or 1)
		end

		slot0:_refreshNextChapterView()
	end
end

function slot0._onGotoTaskEpisode(slot0, slot1)
	if slot0:_getEpisodeChapterId(slot1) and slot2 ~= slot0._curStage then
		slot0:_switchToStage(slot2)
	end

	slot0:_clickNodeCallback(slot1)
end

function slot0._getEpisodeChapterId(slot0, slot1)
	if not slot0._episodeCfgList or #slot0._episodeCfgList < 1 then
		return
	end

	if slot1 and Activity122Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act304, slot1) and Activity1_3ChessController.isOpenDay(slot1) then
		return slot2.chapterId
	end

	slot3 = slot0._episodeCfgList[1]

	for slot7, slot8 in ipairs(slot0._episodeCfgList) do
		if Activity122Model.instance:isEpisodeClear(slot8.id) then
			slot3 = slot8
		else
			if Activity1_3ChessController.isOpenDay(slot8.id) then
				slot3 = slot8
			end

			break
		end
	end

	if slot3 then
		return slot3.chapterId
	end
end

function slot0.playViewAnimation(slot0, slot1)
	slot0._viewAnimator:Play(slot1, 0, 0)
end

function slot0._playNextBtnUnlockAni(slot0)
	gohelper.onceAddComponent(slot0._goNextBtnRoot, typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock)
end

function slot0.playCloseAnimation(slot0, slot1, slot2)
	gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator)):Play(UIAnimationName.Close, slot1, slot2)
end

function slot0.playSwitchSceneAni(slot0, slot1)
	gohelper.setActive(slot0._goexcessive, true)
	gohelper.findChildComponent(slot0.viewGO, "#go_excessive", typeof(UnityEngine.Animator)):Play(slot1 and "story" or "hard")
end

function slot0._refreshRewardAnim(slot0)
	if slot0._lastIsHasReward ~= Activity1_3ChessController.instance:checkHasReward() then
		slot0._lastIsHasReward = slot1

		slot0._rewardAnimator:Play(slot1 and "loop" or "idle")
	end
end

return slot0
