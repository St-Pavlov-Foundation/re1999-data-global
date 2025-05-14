module("modules.logic.versionactivity1_4.act130.view.Activity130LevelViewStageItem", package.seeall)

local var_0_0 = class("Activity130LevelViewStageItem", LuaCompBase)

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
	arg_2_0._episodeId = arg_2_0._config and arg_2_0._config.episodeId or 0

	local var_2_0 = Activity130Model.instance:getCurEpisodeId()

	gohelper.setActive(arg_2_0._imagechess.gameObject, arg_2_0._episodeId == var_2_0)

	local var_2_1 = Activity130Model.instance:getNewFinishEpisode()
	local var_2_2 = Activity130Model.instance:getNewUnlockEpisode()
	local var_2_3 = false

	if arg_2_0._index == 1 then
		var_2_3 = true
	elseif arg_2_0._index == 2 then
		var_2_3 = not (Activity130Model.instance:getNewUnlockEpisode() == 1)
	else
		var_2_3 = Activity130Model.instance:isEpisodeUnlock(arg_2_0._episodeId)
	end

	gohelper.setActive(arg_2_0._gounlock, var_2_3)

	local var_2_4 = arg_2_0._index == 1 and var_2_1 ~= 0 or Activity130Model.instance:getEpisodeState(arg_2_0._episodeId) == Activity130Enum.EpisodeState.Finished

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

	if arg_2_0._index == 1 then
		arg_2_0._txtstagename.text = luaLang("v1a4_role37_level_prologue")
		arg_2_0._txtstagenum.text = ""

		gohelper.setActive(arg_2_0._btnreview.gameObject, false)
		gohelper.setActive(arg_2_0._stars[1].go, false)
		gohelper.setActive(arg_2_0._stars[2].go, false)
	else
		gohelper.setActive(arg_2_0._stars[1].go, true)
		gohelper.setActive(arg_2_0._stars[2].go, false)
		gohelper.setActive(arg_2_0._stars[1].has, var_2_4)
		gohelper.setActive(arg_2_0._stars[1].no, not var_2_4)

		arg_2_0._txtstagenum.text = arg_2_1.episodetag
		arg_2_0._txtstagename.text = arg_2_1.name
	end
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
	if Activity130Model.instance:getCurEpisodeId() == arg_5_0._episodeId then
		arg_5_0:_startEnterGame()

		return
	end

	arg_5_0:_startEnterEpisode(arg_5_0._episodeId)
end

function var_0_0._onJumpToEpisode(arg_6_0, arg_6_1)
	if arg_6_0._episodeId ~= arg_6_1 then
		return
	end

	if Activity130Model.instance:getCurEpisodeId() == arg_6_1 then
		arg_6_0:_startEnterGame()

		return
	end

	arg_6_0:_startEnterEpisode(arg_6_1)
end

function var_0_0._startEnterEpisode(arg_7_0, arg_7_1)
	local var_7_0 = Activity130Model.instance:getCurEpisodeId()

	Activity130Controller.instance:dispatchEvent(Activity130Event.EpisodeClick, arg_7_0._episodeId)
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

	if Activity130Model.instance:getCurEpisodeId() > arg_8_0._episodeId then
		arg_8_0._chessAnimator:Play("open_left", 0, 0)
	else
		arg_8_0._chessAnimator:Play("open_right", 0, 0)
	end

	TaskDispatcher.runDelay(arg_8_0._startEnterGame, arg_8_0, 0.87)
end

function var_0_0._startEnterGame(arg_9_0)
	UIBlockMgr.instance:endBlock("chessPlay")
	Activity130Model.instance:setCurEpisodeId(arg_9_0._episodeId)

	if arg_9_0._index == 1 then
		local var_9_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId

		if var_9_0 > 0 then
			arg_9_0:_enterActivity130Story(var_9_0)
		end

		return
	end

	if arg_9_0._config.mapId > 0 then
		local var_9_1 = Activity130Model.instance:getCurMapInfo().progress

		if var_9_1 == Activity130Enum.ProgressType.BeforeStory then
			if arg_9_0._config.beforeStoryId > 0 then
				StoryController.instance:playStory(arg_9_0._config.beforeStoryId, nil, arg_9_0._onStoryFinishAndEnterGameView, arg_9_0)
			else
				arg_9_0:_onStoryFinishAndEnterGameView()
			end
		elseif var_9_1 == Activity130Enum.ProgressType.AfterStory then
			if arg_9_0._config.afterStoryId > 0 then
				arg_9_0:_enterActivity130Story(arg_9_0._config.afterStoryId)
			else
				arg_9_0:_onStoryFinished()
			end
		else
			arg_9_0:_enterActivity130GameView()
		end
	elseif arg_9_0._config.beforeStoryId > 0 then
		arg_9_0:_enterActivity130Story(arg_9_0._config.beforeStoryId)
	end
end

function var_0_0._enterActivity130Story(arg_10_0, arg_10_1)
	UIBlockMgr.instance:startBlock("waitclose")
	Activity130Controller.instance:dispatchEvent(Activity130Event.PlayLeaveLevelView)

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

	local var_13_0 = ViewMgr.instance:getContainer(ViewName.Activity130LevelView).viewGO

	recthelper.setAnchorX(var_13_0.transform, 10000)
	UIBlockMgr.instance:endBlock("waitclose")
end

function var_0_0._onStoryFinished(arg_14_0)
	module_views.StoryBackgroundView.viewType = ViewType.Full

	local var_14_0 = ViewMgr.instance:getContainer(ViewName.Activity130LevelView).viewGO

	recthelper.setAnchorX(var_14_0.transform, 0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)

	if not arg_14_0._config then
		return
	end

	if not Activity130Model.instance:isEpisodeFinished(arg_14_0._config.episodeId) then
		Activity130Rpc.instance:sendAct130StoryRequest(arg_14_0._config.activityId, arg_14_0._config.episodeId)
	end
end

function var_0_0._onStoryFinishAndEnterGameView(arg_15_0)
	Activity130Rpc.instance:sendAct130StoryRequest(arg_15_0._config.activityId, arg_15_0._config.episodeId, arg_15_0._enterActivity130GameView, arg_15_0)
end

function var_0_0._enterActivity130GameView(arg_16_0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.StartEnterGameView, arg_16_0._episodeId)
end

function var_0_0._btnReviewOnClick(arg_17_0)
	local var_17_0 = {}

	if arg_17_0._index == 1 then
		local var_17_1 = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId

		table.insert(var_17_0, var_17_1)
	else
		if Activity130Model.instance:getEpisodeState(arg_17_0._config.episodeId) ~= Activity130Enum.EpisodeState.Finished then
			arg_17_0:_btnclickOnClick()

			return
		end

		if arg_17_0._config.beforeStoryId > 0 then
			table.insert(var_17_0, arg_17_0._config.beforeStoryId)
		end

		if arg_17_0._config.afterStoryId > 0 then
			table.insert(var_17_0, arg_17_0._config.afterStoryId)
		end
	end

	StoryController.instance:playStories(var_17_0)
end

function var_0_0.onUpdateMO(arg_18_0, arg_18_1)
	return
end

function var_0_0._addEvents(arg_19_0)
	Activity130Controller.instance:registerCallback(Activity130Event.playNewUnlockEpisode, arg_19_0._startNewUnlockEpisodeAni, arg_19_0)
	Activity130Controller.instance:registerCallback(Activity130Event.playNewFinishEpisode, arg_19_0._startNewFinishEpisodeAni, arg_19_0)
	Activity130Controller.instance:registerCallback(Activity130Event.EpisodeClick, arg_19_0._playChooseEpisode, arg_19_0)
	Activity130Controller.instance:registerCallback(Activity130Event.EnterEpisode, arg_19_0._onJumpToEpisode, arg_19_0)
	Activity130Controller.instance:registerCallback(Activity130Event.PlayChessAutoToNewEpisode, arg_19_0._playChessAutoToEpisode, arg_19_0)
end

function var_0_0._removeEvents(arg_20_0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.playNewUnlockEpisode, arg_20_0._startNewUnlockEpisodeAni, arg_20_0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.playNewFinishEpisode, arg_20_0._startNewFinishEpisodeAni, arg_20_0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.EpisodeClick, arg_20_0._playChooseEpisode, arg_20_0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.EnterEpisode, arg_20_0._onJumpToEpisode, arg_20_0)
	Activity130Controller.instance:unregisterCallback(Activity130Event.PlayChessAutoToNewEpisode, arg_20_0._playChessAutoToEpisode, arg_20_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_20_0._onOpenViewFinish, arg_20_0)
end

function var_0_0._startNewUnlockEpisodeAni(arg_21_0, arg_21_1)
	if arg_21_0._episodeId and arg_21_0._episodeId == arg_21_1 then
		gohelper.setActive(arg_21_0._gounlock, true)
		arg_21_0._animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function var_0_0._startNewFinishEpisodeAni(arg_22_0, arg_22_1)
	if arg_22_0._episodeId and arg_22_0._episodeId == arg_22_1 then
		gohelper.setActive(arg_22_0._gounlock, true)
		arg_22_0._animator:Play("finish", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	end
end

function var_0_0._playChooseEpisode(arg_23_0, arg_23_1)
	local var_23_0 = Activity130Model.instance:getCurEpisodeId()

	if arg_23_0._episodeId == var_23_0 then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if arg_23_1 < arg_23_0._episodeId then
			arg_23_0._chessAnimator:Play("close_left", 0, 0)
		else
			arg_23_0._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function var_0_0._playChessAutoToEpisode(arg_24_0, arg_24_1)
	UIBlockMgr.instance:startBlock("chessPlay")

	local var_24_0 = Activity130Model.instance:getCurEpisodeId()

	if arg_24_0._episodeId == var_24_0 then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if arg_24_1 < arg_24_0._episodeId then
			arg_24_0._chessAnimator:Play("close_left", 0, 0)
		else
			arg_24_0._chessAnimator:Play("close_right", 0, 0)
		end
	end

	if arg_24_0._episodeId == arg_24_1 then
		TaskDispatcher.runDelay(arg_24_0._autoChessStartFinished, arg_24_0, 0.25)
	end
end

function var_0_0._autoChessStartFinished(arg_25_0)
	UIBlockMgr.instance:endBlock("chessPlay")
	gohelper.setActive(arg_25_0._imagechess.gameObject, true)

	if Activity130Model.instance:getCurEpisodeId() > arg_25_0._episodeId then
		arg_25_0._chessAnimator:Play("open_left", 0, 0)
	else
		arg_25_0._chessAnimator:Play("open_right", 0, 0)
	end

	Activity130Model.instance:setCurEpisodeId(arg_25_0._episodeId)
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0:_removeEvents()
	arg_26_0:removeEventListeners()
end

return var_0_0
