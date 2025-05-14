module("modules.logic.versionactivity1_4.act131.view.Activity131LevelViewStageItem", package.seeall)

local var_0_0 = class("Activity131LevelViewStageItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_point")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "unlock")
	arg_1_0._imagestageline = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_stageline")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagefinish")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal")
	arg_1_0._imageline = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_line")
	arg_1_0._imageangle = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_angle")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename/#txt_stageNum")
	arg_1_0._stars = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 2 do
		local var_1_0 = {
			go = gohelper.findChild(arg_1_0.viewGO, "unlock/info/#txt_stagename/#go_star" .. iter_1_0)
		}

		var_1_0.has = gohelper.findChild(var_1_0.go, "has")
		var_1_0.no = gohelper.findChild(var_1_0.go, "no")

		table.insert(arg_1_0._stars, var_1_0)
	end

	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/info/#txt_stagename/#btn_review")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_chess")
	arg_1_0._chessAnimator = gohelper.findChild(arg_1_0._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")

	arg_1_0:_addEvents()
end

function var_0_0.refreshItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._index = arg_2_2
	arg_2_0._config = arg_2_1
	arg_2_0._episodeId = arg_2_0._config.episodeId

	local var_2_0 = Activity131Model.instance:getCurEpisodeId()

	gohelper.setActive(arg_2_0._imagechess.gameObject, arg_2_0._episodeId == var_2_0)

	local var_2_1 = Activity131Model.instance:getNewFinishEpisode()
	local var_2_2 = Activity131Model.instance:getNewUnlockEpisode()
	local var_2_3 = false

	if arg_2_0._index == 1 then
		var_2_3 = not (Activity131Model.instance:getNewUnlockEpisode() == 1)
	else
		var_2_3 = Activity131Model.instance:isEpisodeUnlock(arg_2_0._episodeId)
	end

	gohelper.setActive(arg_2_0._gounlock, var_2_3)

	local var_2_4 = Activity131Model.instance:getEpisodeState(arg_2_0._episodeId) == Activity131Enum.EpisodeState.Finished

	if var_2_4 then
		if var_2_1 == arg_2_0._episodeId then
			arg_2_0._animator:Play("finish", 0, 0)
		else
			arg_2_0._animator:Play("finish", 0, 1)
		end
	elseif var_2_2 == arg_2_0._episodeId then
		arg_2_0._animator:Play("unlock", 0, 0)
	else
		arg_2_0._animator:Play("unlock", 0, 1)
	end

	gohelper.setActive(arg_2_0._stars[1].go, true)
	gohelper.setActive(arg_2_0._stars[2].go, false)
	gohelper.setActive(arg_2_0._stars[1].has, var_2_4)
	gohelper.setActive(arg_2_0._stars[1].no, not var_2_4)

	arg_2_0._txtstagenum.text = arg_2_1.episodetag
	arg_2_0._txtstagename.text = arg_2_1.name
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
	arg_3_0._btnreview:AddClickListener(arg_3_0._btnReviewOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	if arg_4_0._btnclick then
		arg_4_0._btnclick:RemoveClickListener()
		arg_4_0._btnreview:RemoveClickListener()
	end
end

function var_0_0._btnclickOnClick(arg_5_0)
	if Activity131Model.instance:getCurEpisodeId() == arg_5_0._episodeId then
		arg_5_0:_startEnterGame()

		return
	end

	arg_5_0:_startEnterEpisode(arg_5_0._episodeId)
end

function var_0_0._onJumpToEpisode(arg_6_0, arg_6_1)
	if arg_6_0._episodeId ~= arg_6_1 then
		return
	end

	if Activity131Model.instance:getCurEpisodeId() == arg_6_1 then
		arg_6_0:_startEnterGame()

		return
	end

	arg_6_0:_startEnterEpisode(arg_6_1)
end

function var_0_0._startEnterEpisode(arg_7_0, arg_7_1)
	local var_7_0 = Activity131Model.instance:getCurEpisodeId()

	Activity131Controller.instance:dispatchEvent(Activity131Event.EpisodeClick, arg_7_0._episodeId)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("chessPlay")

	if arg_7_0._episodeId == var_7_0 then
		arg_7_0:_startEnterGame()
	else
		TaskDispatcher.runDelay(arg_7_0._chessStarFinished, arg_7_0, 0.25)
	end
end

function var_0_0._chessStarFinished(arg_8_0)
	gohelper.setActive(arg_8_0._imagechess.gameObject, true)

	if Activity131Model.instance:getCurEpisodeId() > arg_8_0._episodeId then
		arg_8_0._chessAnimator:Play("open_left")
	else
		arg_8_0._chessAnimator:Play("open_right", 0, 0)
	end

	TaskDispatcher.runDelay(arg_8_0._startEnterGame, arg_8_0, 0.87)
end

function var_0_0._startEnterGame(arg_9_0)
	UIBlockMgr.instance:endBlock("chessPlay")
	Activity131Model.instance:setCurEpisodeId(arg_9_0._episodeId)

	if arg_9_0._config.mapId > 0 then
		local var_9_0 = Activity131Model.instance:getCurMapInfo().progress

		if var_9_0 == Activity131Enum.ProgressType.BeforeStory then
			if arg_9_0._config.beforeStoryId > 0 then
				StoryController.instance:playStory(arg_9_0._config.beforeStoryId, nil, arg_9_0._onStoryFinishAndEnterGameView, arg_9_0)
			else
				arg_9_0:_onStoryFinishAndEnterGameView()
			end
		elseif var_9_0 == Activity131Enum.ProgressType.AfterStory then
			if arg_9_0._config.afterStoryId > 0 then
				arg_9_0:_enterActivity131Story(arg_9_0._config.afterStoryId)
			else
				arg_9_0:_onStoryFinished()
			end
		else
			arg_9_0:_enterActivity131GameView()
		end
	elseif arg_9_0._config.beforeStoryId > 0 then
		arg_9_0:_enterActivity131Story(arg_9_0._config.beforeStoryId)
	end
end

function var_0_0._enterActivity131Story(arg_10_0, arg_10_1)
	UIBlockMgr.instance:startBlock("waitclose")
	Activity131Controller.instance:dispatchEvent(Activity131Event.PlayLeaveLevelView)

	arg_10_0._enterStoryId = arg_10_1

	TaskDispatcher.runDelay(arg_10_0._waitLevelViewCloseFinished, arg_10_0, 0.34)
end

function var_0_0._waitLevelViewCloseFinished(arg_11_0)
	module_views.StoryBackgroundView.viewType = ViewType.Modal

	StoryController.instance:playStory(arg_11_0._enterStoryId, nil, arg_11_0._onStoryFinished, arg_11_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_11_0._onOpenViewFinish, arg_11_0)
end

function var_0_0._onOpenViewFinish(arg_12_0, arg_12_1)
	if arg_12_1 == ViewName.StoryFrontView then
		arg_12_0:_storyFrontViewShowed()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_12_0._onOpenViewFinish, arg_12_0)
	end
end

function var_0_0._storyFrontViewShowed(arg_13_0)
	arg_13_0._enterStoryId = 0

	local var_13_0 = ViewMgr.instance:getContainer(ViewName.Activity131LevelView).viewGO

	recthelper.setAnchorX(var_13_0.transform, 10000)
	UIBlockMgr.instance:endBlock("waitclose")
end

function var_0_0._onStoryFinished(arg_14_0)
	module_views.StoryBackgroundView.viewType = ViewType.Full

	local var_14_0 = ViewMgr.instance:getContainer(ViewName.Activity131LevelView).viewGO

	recthelper.setAnchorX(var_14_0.transform, 0)
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)

	if not Activity131Model.instance:isEpisodeFinished(arg_14_0._config.episodeId) then
		Activity131Rpc.instance:sendAct131StoryRequest(arg_14_0._config.activityId, arg_14_0._config.episodeId)
	end
end

function var_0_0._onStoryFinishAndEnterGameView(arg_15_0)
	Activity131Rpc.instance:sendAct131StoryRequest(arg_15_0._config.activityId, arg_15_0._config.episodeId, arg_15_0._enterActivity131GameView, arg_15_0)
end

function var_0_0._enterActivity131GameView(arg_16_0)
	Activity131Controller.instance:dispatchEvent(Activity131Event.StartEnterGameView, arg_16_0._episodeId)
end

function var_0_0._btnReviewOnClick(arg_17_0)
	local var_17_0 = {}

	if Activity131Model.instance:getEpisodeState(arg_17_0._config.episodeId) ~= Activity131Enum.EpisodeState.Finished then
		arg_17_0:_btnclickOnClick()

		return
	end

	if arg_17_0._config.beforeStoryId > 0 then
		table.insert(var_17_0, arg_17_0._config.beforeStoryId)
	end

	if arg_17_0._config.afterStoryId > 0 then
		table.insert(var_17_0, arg_17_0._config.afterStoryId)
	end

	StoryController.instance:playStories(var_17_0)
end

function var_0_0._addEvents(arg_18_0)
	Activity131Controller.instance:registerCallback(Activity131Event.playNewUnlockEpisode, arg_18_0._startNewUnlockEpisodeAni, arg_18_0)
	Activity131Controller.instance:registerCallback(Activity131Event.playNewFinishEpisode, arg_18_0._startNewFinishEpisodeAni, arg_18_0)
	Activity131Controller.instance:registerCallback(Activity131Event.EpisodeClick, arg_18_0._playChooseEpisode, arg_18_0)
	Activity131Controller.instance:registerCallback(Activity131Event.EnterEpisode, arg_18_0._onJumpToEpisode, arg_18_0)
	Activity131Controller.instance:registerCallback(Activity131Event.PlayChessAutoToNewEpisode, arg_18_0._playChessAutoToEpisode, arg_18_0)
end

function var_0_0._removeEvents(arg_19_0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.playNewUnlockEpisode, arg_19_0._startNewUnlockEpisodeAni, arg_19_0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.playNewFinishEpisode, arg_19_0._startNewFinishEpisodeAni, arg_19_0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.EpisodeClick, arg_19_0._playChooseEpisode, arg_19_0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.EnterEpisode, arg_19_0._onJumpToEpisode, arg_19_0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.PlayChessAutoToNewEpisode, arg_19_0._playChessAutoToEpisode, arg_19_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_19_0._onOpenViewFinish, arg_19_0)
end

function var_0_0._startNewUnlockEpisodeAni(arg_20_0, arg_20_1)
	if arg_20_0._episodeId and arg_20_0._episodeId == arg_20_1 then
		gohelper.setActive(arg_20_0._gounlock, true)
		arg_20_0._animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function var_0_0._startNewFinishEpisodeAni(arg_21_0, arg_21_1)
	if arg_21_0._episodeId and arg_21_0._episodeId == arg_21_1 then
		gohelper.setActive(arg_21_0._gounlock, true)
		arg_21_0._animator:Play("finish", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function var_0_0._playChooseEpisode(arg_22_0, arg_22_1)
	local var_22_0 = Activity131Model.instance:getCurEpisodeId()

	if arg_22_0._episodeId == var_22_0 then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if arg_22_1 < arg_22_0._episodeId then
			arg_22_0._chessAnimator:Play("close_left", 0, 0)
		else
			arg_22_0._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function var_0_0._playChessAutoToEpisode(arg_23_0, arg_23_1)
	UIBlockMgr.instance:startBlock("chessPlay")

	local var_23_0 = Activity131Model.instance:getCurEpisodeId()

	if arg_23_0._episodeId == var_23_0 then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if arg_23_1 < arg_23_0._episodeId then
			arg_23_0._chessAnimator:Play("close_left", 0, 0)
		else
			arg_23_0._chessAnimator:Play("close_right", 0, 0)
		end
	end

	if arg_23_0._episodeId == arg_23_1 then
		TaskDispatcher.runDelay(arg_23_0._autoChessStartFinished, arg_23_0, 0.25)
	end
end

function var_0_0._autoChessStartFinished(arg_24_0)
	UIBlockMgr.instance:endBlock("chessPlay")
	gohelper.setActive(arg_24_0._imagechess.gameObject, true)

	if Activity131Model.instance:getCurEpisodeId() > arg_24_0._episodeId then
		arg_24_0._chessAnimator:Play("open_left", 0, 0)
	else
		arg_24_0._chessAnimator:Play("open_right", 0, 0)
	end

	Activity131Model.instance:setCurEpisodeId(arg_24_0._episodeId)
end

function var_0_0.onDestroyView(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._chessStarFinished, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._startEnterGame, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._waitLevelViewCloseFinished, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._autoChessStartFinished, arg_25_0)
	arg_25_0:_removeEvents()
	arg_25_0:removeEventListeners()
end

return var_0_0
