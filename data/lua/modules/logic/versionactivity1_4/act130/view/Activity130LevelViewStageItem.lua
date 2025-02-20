module("modules.logic.versionactivity1_4.act130.view.Activity130LevelViewStageItem", package.seeall)

slot0 = class("Activity130LevelViewStageItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#image_point")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "unlock")
	slot0._imagestageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_stageline")
	slot0._gostagefinish = gohelper.findChild(slot0.viewGO, "unlock/#go_stagefinish")
	slot0._gostagenormal = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal")
	slot0._imageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_line")
	slot0._imageangle = gohelper.findChildImage(slot0.viewGO, "unlock/#image_angle")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "unlock/info/#txt_stagename")
	slot5 = "unlock/info/#txt_stagename/#txt_stageNum"
	slot0._txtstagenum = gohelper.findChildText(slot0.viewGO, slot5)
	slot0._stars = slot0:getUserDataTb_()

	for slot5 = 1, 2 do
		slot6 = {
			go = gohelper.findChild(slot0.viewGO, "unlock/info/#txt_stagename/#go_star" .. slot5)
		}
		slot6.has = gohelper.findChild(slot6.go, "has")
		slot6.no = gohelper.findChild(slot6.go, "no")

		table.insert(slot0._stars, slot6)
	end

	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/info/#txt_stagename/#btn_review")
	slot0._imagechess = gohelper.findChildImage(slot0.viewGO, "unlock/#image_chess")
	slot0._chessAnimator = gohelper.findChild(slot0._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#btn_click")

	slot0:_addEvents()
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot0._index = slot2
	slot0._config = slot1
	slot0._episodeId = slot0._config and slot0._config.episodeId or 0

	gohelper.setActive(slot0._imagechess.gameObject, slot0._episodeId == Activity130Model.instance:getCurEpisodeId())

	slot5 = Activity130Model.instance:getNewUnlockEpisode()
	slot6 = false

	gohelper.setActive(slot0._gounlock, slot0._index == 1 and true or (slot0._index ~= 2 or not (Activity130Model.instance:getNewUnlockEpisode() == 1)) and Activity130Model.instance:isEpisodeUnlock(slot0._episodeId))

	if slot0._index == 1 and Activity130Model.instance:getNewFinishEpisode() ~= 0 or Activity130Model.instance:getEpisodeState(slot0._episodeId) == Activity130Enum.EpisodeState.Finished then
		if slot4 == slot0._episodeId then
			slot0._animator:Play("finish", 0, 0)
		else
			slot0._animator:Play("finish", 0, 1)
		end
	elseif slot5 == slot0._episodeId then
		slot0._animator:Play("unlock", 0, 0)
	else
		slot0._animator:Play("unlock", 0, 1)
	end

	if slot0._index == 1 then
		slot0._txtstagename.text = luaLang("v1a4_role37_level_prologue")
		slot0._txtstagenum.text = ""

		gohelper.setActive(slot0._btnreview.gameObject, false)
		gohelper.setActive(slot0._stars[1].go, false)
		gohelper.setActive(slot0._stars[2].go, false)
	else
		gohelper.setActive(slot0._stars[1].go, true)
		gohelper.setActive(slot0._stars[2].go, false)
		gohelper.setActive(slot0._stars[1].has, slot7)
		gohelper.setActive(slot0._stars[1].no, not slot7)

		slot0._txtstagenum.text = slot1.episodetag
		slot0._txtstagename.text = slot1.name
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnreview:AddClickListener(slot0._btnReviewOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()
		slot0._btnreview:RemoveClickListener()
	end
end

function slot0._btnclickOnClick(slot0)
	if Activity130Model.instance:getCurEpisodeId() == slot0._episodeId then
		slot0:_startEnterGame()

		return
	end

	slot0:_startEnterEpisode(slot0._episodeId)
end

function slot0._onJumpToEpisode(slot0, slot1)
	if slot0._episodeId ~= slot1 then
		return
	end

	if Activity130Model.instance:getCurEpisodeId() == slot1 then
		slot0:_startEnterGame()

		return
	end

	slot0:_startEnterEpisode(slot1)
end

function slot0._startEnterEpisode(slot0, slot1)
	Activity130Controller.instance:dispatchEvent(Activity130Event.EpisodeClick, slot0._episodeId)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("chessPlay")

	if slot0._episodeId == Activity130Model.instance:getCurEpisodeId() then
		slot0:_startEnterGame()
	else
		TaskDispatcher.runDelay(slot0._chessStarFinished, slot0, 0.25)
	end
end

function slot0._chessStarFinished(slot0)
	gohelper.setActive(slot0._imagechess.gameObject, true)

	if slot0._episodeId < Activity130Model.instance:getCurEpisodeId() then
		slot0._chessAnimator:Play("open_left", 0, 0)
	else
		slot0._chessAnimator:Play("open_right", 0, 0)
	end

	TaskDispatcher.runDelay(slot0._startEnterGame, slot0, 0.87)
end

function slot0._startEnterGame(slot0)
	UIBlockMgr.instance:endBlock("chessPlay")
	Activity130Model.instance:setCurEpisodeId(slot0._episodeId)

	if slot0._index == 1 then
		if ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId > 0 then
			slot0:_enterActivity130Story(slot1)
		end

		return
	end

	if slot0._config.mapId > 0 then
		if Activity130Model.instance:getCurMapInfo().progress == Activity130Enum.ProgressType.BeforeStory then
			if slot0._config.beforeStoryId > 0 then
				StoryController.instance:playStory(slot0._config.beforeStoryId, nil, slot0._onStoryFinishAndEnterGameView, slot0)
			else
				slot0:_onStoryFinishAndEnterGameView()
			end
		elseif slot1 == Activity130Enum.ProgressType.AfterStory then
			if slot0._config.afterStoryId > 0 then
				slot0:_enterActivity130Story(slot0._config.afterStoryId)
			else
				slot0:_onStoryFinished()
			end
		else
			slot0:_enterActivity130GameView()
		end
	elseif slot0._config.beforeStoryId > 0 then
		slot0:_enterActivity130Story(slot0._config.beforeStoryId)
	end
end

function slot0._enterActivity130Story(slot0, slot1)
	UIBlockMgr.instance:startBlock("waitclose")
	Activity130Controller.instance:dispatchEvent(Activity130Event.PlayLeaveLevelView)

	slot0._enterStoryId = slot1

	TaskDispatcher.runDelay(slot0._waitLevelViewCloseFinished, slot0, 0.34)
end

function slot0._waitLevelViewCloseFinished(slot0)
	module_views.StoryBackgroundView.viewType = ViewType.Modal

	StoryController.instance:playStory(slot0._enterStoryId, nil, slot0._onStoryFinished, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.StoryFrontView then
		slot0:_storyFrontViewShowed()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	end
end

function slot0._storyFrontViewShowed(slot0)
	slot0._enterStoryId = 0

	recthelper.setAnchorX(ViewMgr.instance:getContainer(ViewName.Activity130LevelView).viewGO.transform, 10000)
	UIBlockMgr.instance:endBlock("waitclose")
end

function slot0._onStoryFinished(slot0)
	module_views.StoryBackgroundView.viewType = ViewType.Full

	recthelper.setAnchorX(ViewMgr.instance:getContainer(ViewName.Activity130LevelView).viewGO.transform, 0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)

	if not slot0._config then
		return
	end

	if not Activity130Model.instance:isEpisodeFinished(slot0._config.episodeId) then
		Activity130Rpc.instance:sendAct130StoryRequest(slot0._config.activityId, slot0._config.episodeId)
	end
end

function slot0._onStoryFinishAndEnterGameView(slot0)
	Activity130Rpc.instance:sendAct130StoryRequest(slot0._config.activityId, slot0._config.episodeId, slot0._enterActivity130GameView, slot0)
end

function slot0._enterActivity130GameView(slot0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.StartEnterGameView, slot0._episodeId)
end

function slot0._btnReviewOnClick(slot0)
	if slot0._index == 1 then
		table.insert({}, ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId)
	else
		if Activity130Model.instance:getEpisodeState(slot0._config.episodeId) ~= Activity130Enum.EpisodeState.Finished then
			slot0:_btnclickOnClick()

			return
		end

		if slot0._config.beforeStoryId > 0 then
			table.insert(slot1, slot0._config.beforeStoryId)
		end

		if slot0._config.afterStoryId > 0 then
			table.insert(slot1, slot0._config.afterStoryId)
		end
	end

	StoryController.instance:playStories(slot1)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0._addEvents(slot0)
	Activity130Controller.instance:registerCallback(Activity130Event.playNewUnlockEpisode, slot0._startNewUnlockEpisodeAni, slot0)
	Activity130Controller.instance:registerCallback(Activity130Event.playNewFinishEpisode, slot0._startNewFinishEpisodeAni, slot0)
	Activity130Controller.instance:registerCallback(Activity130Event.EpisodeClick, slot0._playChooseEpisode, slot0)
	Activity130Controller.instance:registerCallback(Activity130Event.EnterEpisode, slot0._onJumpToEpisode, slot0)
	Activity130Controller.instance:registerCallback(Activity130Event.PlayChessAutoToNewEpisode, slot0._playChessAutoToEpisode, slot0)
end

function slot0._removeEvents(slot0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.playNewUnlockEpisode, slot0._startNewUnlockEpisodeAni, slot0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.playNewFinishEpisode, slot0._startNewFinishEpisodeAni, slot0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.EpisodeClick, slot0._playChooseEpisode, slot0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.EnterEpisode, slot0._onJumpToEpisode, slot0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.PlayChessAutoToNewEpisode, slot0._playChessAutoToEpisode, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0._startNewUnlockEpisodeAni(slot0, slot1)
	if slot0._episodeId and slot0._episodeId == slot1 then
		gohelper.setActive(slot0._gounlock, true)
		slot0._animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function slot0._startNewFinishEpisodeAni(slot0, slot1)
	if slot0._episodeId and slot0._episodeId == slot1 then
		gohelper.setActive(slot0._gounlock, true)
		slot0._animator:Play("finish", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function slot0._playChooseEpisode(slot0, slot1)
	if slot0._episodeId == Activity130Model.instance:getCurEpisodeId() then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if slot1 < slot0._episodeId then
			slot0._chessAnimator:Play("close_left", 0, 0)
		else
			slot0._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function slot0._playChessAutoToEpisode(slot0, slot1)
	UIBlockMgr.instance:startBlock("chessPlay")

	if slot0._episodeId == Activity130Model.instance:getCurEpisodeId() then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if slot1 < slot0._episodeId then
			slot0._chessAnimator:Play("close_left", 0, 0)
		else
			slot0._chessAnimator:Play("close_right", 0, 0)
		end
	end

	if slot0._episodeId == slot1 then
		TaskDispatcher.runDelay(slot0._autoChessStartFinished, slot0, 0.25)
	end
end

function slot0._autoChessStartFinished(slot0)
	UIBlockMgr.instance:endBlock("chessPlay")
	gohelper.setActive(slot0._imagechess.gameObject, true)

	if slot0._episodeId < Activity130Model.instance:getCurEpisodeId() then
		slot0._chessAnimator:Play("open_left", 0, 0)
	else
		slot0._chessAnimator:Play("open_right", 0, 0)
	end

	Activity130Model.instance:setCurEpisodeId(slot0._episodeId)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	slot0:removeEventListeners()
end

return slot0
