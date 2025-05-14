module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewStageItem", package.seeall)

local var_0_0 = class("LanShouPaMapViewStageItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_point")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "unlock")
	arg_1_0._imagestageline = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_stageline")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagefinish")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal")
	arg_1_0._gogame = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal/#go_Game")
	arg_1_0._gostory = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal/#go_Story")
	arg_1_0._imageline = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_line")
	arg_1_0._imageangle = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_angle")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename/#txt_stageNum")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "unlock/info/#txt_stagename/#go_star")
	arg_1_0._gohasstar = gohelper.findChild(arg_1_0._gostar, "has/#image_Star")
	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/info/#txt_stagename/#btn_review")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_chess")
	arg_1_0._chessAnimator = gohelper.findChild(arg_1_0._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")

	arg_1_0:_addEvents()
end

function var_0_0.refreshItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	arg_2_0._index = arg_2_2
	arg_2_0._config = arg_2_1
	arg_2_0._episodeId = arg_2_0._config.id

	local var_2_0 = Activity164Model.instance:getCurEpisodeId() or LanShouPaEnum.episodeId

	arg_2_0._txtstagename.text = arg_2_0._config.name
	arg_2_0._txtstagenum.text = string.format("STAGE %02d", arg_2_2)

	local var_2_1 = arg_2_0._config.mapIds ~= 0
	local var_2_2 = arg_2_2 <= Activity164Model.instance:getUnlockCount()
	local var_2_3 = Activity164Config.instance:getStoryList(arg_2_0._actId, arg_2_0._episodeId)

	gohelper.setActive(arg_2_0._btnreview.gameObject, var_2_1 and var_2_2 and var_2_3 and #var_2_3 > 0)
	gohelper.setActive(arg_2_0._imagechess.gameObject, arg_2_0._episodeId == var_2_0)
	gohelper.setActive(arg_2_0._gounlock, Activity164Model.instance:getUnlockCount() >= arg_2_2 - 1)
	gohelper.setActive(arg_2_0._gostagefinish, var_2_1)
	gohelper.setActive(arg_2_0._gostagenormal, true)
	gohelper.setActive(arg_2_0._gohasstar, var_2_2)
	gohelper.setActive(arg_2_0._gogame, var_2_1)
	gohelper.setActive(arg_2_0._gostory, not var_2_1)
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
	if Activity164Model.instance:getCurEpisodeId() == arg_5_0._episodeId then
		arg_5_0:_realPlayStory()
	else
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.EpisodeClick, arg_5_0._episodeId)
		UIBlockHelper.instance:startBlock("LanShouPaMapViewStageItemEpisodeClick", 0.5, arg_5_0.viewName)
		TaskDispatcher.runDelay(arg_5_0._delayPlayChessOpenAnim, arg_5_0, 0.25)
	end
end

function var_0_0._delayPlayChessOpenAnim(arg_6_0)
	if not arg_6_0._imagechess then
		return
	end

	gohelper.setActive(arg_6_0._imagechess, true)

	if Activity164Model.instance:getCurEpisodeId() > arg_6_0._episodeId then
		arg_6_0._chessAnimator:Play("open_left", 0, 0)
	else
		arg_6_0._chessAnimator:Play("open_right", 0, 0)
	end

	Activity164Model.instance:setCurEpisodeId(arg_6_0._episodeId)
	TaskDispatcher.runDelay(arg_6_0._realPlayStory, arg_6_0, 0.25)
end

function var_0_0._realPlayStory(arg_7_0)
	if not arg_7_0._config then
		return
	end

	local var_7_0 = VersionActivity2_1Enum.ActivityId.LanShouPa
	local var_7_1 = Activity164Config.instance:getEpisodeCoList(var_7_0)

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_1LanShouPaSelect .. var_7_0, tostring(tabletool.indexOf(var_7_1, arg_7_0._config)))

	if arg_7_0._config.storyBefore == 0 or arg_7_0._config.mapIds ~= 0 and Activity164Model.instance.currChessGameEpisodeId == arg_7_0._episodeId then
		arg_7_0:_storyEnd()
	else
		StoryController.instance:playStory(arg_7_0._config.storyBefore, nil, arg_7_0._storyEnd, arg_7_0)
	end
end

function var_0_0._btnReviewOnClick(arg_8_0)
	if arg_8_0._config.mapIds ~= 0 then
		LanShouPaController.instance:openStoryView(arg_8_0._episodeId)
	else
		StoryController.instance:playStory(arg_8_0._config.storyBefore, nil, arg_8_0._storyEnd, arg_8_0)
	end
end

function var_0_0._storyEnd(arg_9_0)
	if arg_9_0._config.mapIds ~= 0 then
		Activity164Model.instance.currChessGameEpisodeId = arg_9_0._episodeId

		LanShouPaController.instance:enterChessGame(arg_9_0._actId, arg_9_0._episodeId)
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.StartEnterGameView)
	else
		Activity164Model.instance:markEpisodeFinish(arg_9_0._episodeId)
	end
end

function var_0_0._addEvents(arg_10_0)
	LanShouPaController.instance:registerCallback(LanShouPaEvent.EpisodeClick, arg_10_0._playChooseEpisode, arg_10_0)
end

function var_0_0._removeEvents(arg_11_0)
	LanShouPaController.instance:unregisterCallback(LanShouPaEvent.EpisodeClick, arg_11_0._playChooseEpisode, arg_11_0)
end

function var_0_0.onPlayFinish(arg_12_0)
	arg_12_0:refreshItem(arg_12_0._config, arg_12_0._index)
	arg_12_0._animator:Play("finish", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function var_0_0.onPlayUnlock(arg_13_0)
	arg_13_0:refreshItem(arg_13_0._config, arg_13_0._index)
	arg_13_0._animator:Play("unlock", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function var_0_0._playChooseEpisode(arg_14_0, arg_14_1)
	local var_14_0 = Activity164Model.instance:getCurEpisodeId()

	if arg_14_0._episodeId == var_14_0 then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if arg_14_1 < arg_14_0._episodeId then
			arg_14_0._chessAnimator:Play("close_left", 0, 0)
		else
			arg_14_0._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0:_removeEvents()
	arg_15_0:removeEventListeners()
end

return var_0_0
