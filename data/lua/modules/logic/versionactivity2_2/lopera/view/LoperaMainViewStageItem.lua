module("modules.logic.versionactivity2_2.lopera.view.LoperaMainViewStageItem", package.seeall)

local var_0_0 = class("LoperaMainViewStageItem", LuaCompBase)
local var_0_1 = VersionActivity2_2Enum.ActivityId.Lopera
local var_0_2 = LoperaEnum.MapCfgIdx

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_point")
	arg_1_0._goImagepointfinished = gohelper.findChild(arg_1_0.viewGO, "#image_pointfinished")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagefinish")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star")
	arg_1_0._gohasstar = gohelper.findChild(arg_1_0._gostar, "has/#image_Star")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "unlock")
	arg_1_0._imagestageline = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_stageline")
	arg_1_0._gogame = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stage/#go_Game")
	arg_1_0._gostory = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_stagenormal/#go_Story")
	arg_1_0._imageline = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_line")
	arg_1_0._imageangle = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_angle")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#txt_stageNum")
	arg_1_0._goArrowSign = gohelper.findChild(arg_1_0.viewGO, "#image_Sign")
	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#go_stage/info/#txt_stagename/#btn_review")
	arg_1_0._imagechess = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#image_chess")
	arg_1_0._chessAnimator = gohelper.findChild(arg_1_0._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")

	arg_1_0:_addEvents()
end

function var_0_0.refreshItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._actId = VersionActivity2_2Enum.ActivityId.Lopera
	arg_2_0._index = arg_2_2
	arg_2_0._config = arg_2_1
	arg_2_0._episodeId = arg_2_0._config.id
	arg_2_0._battleEpisodeId = arg_2_0._config.episodeId

	local var_2_0 = Activity168Model.instance:getCurEpisodeId()

	arg_2_0:refreshTitle()

	local var_2_1 = arg_2_0._config.mapId ~= 0
	local var_2_2 = Activity168Model.instance:isEpisodeFinished(arg_2_0._episodeId)
	local var_2_3 = Activity168Model.instance:isEpisodeUnlock(arg_2_0._episodeId)

	gohelper.setActive(arg_2_0._btnreview.gameObject, false)
	gohelper.setActive(arg_2_0._imagechess.gameObject, arg_2_0._episodeId == var_2_0)
	gohelper.setActive(arg_2_0._goArrowSign, arg_2_0._episodeId == var_2_0)
	gohelper.setActive(arg_2_0._gounlock, var_2_3)
	gohelper.setActive(arg_2_0._gostagefinish, var_2_1)
	gohelper.setActive(arg_2_0._gohasstar, var_2_2)
	gohelper.setActive(arg_2_0._gogame, var_2_1)
	gohelper.setActive(arg_2_0._goImagepointfinished, var_2_2)
end

function var_0_0.refreshTitle(arg_3_0)
	arg_3_0._txtstagename.text = arg_3_0._config.name
	arg_3_0._txtstagenum.text = string.format("STAGE %02d", arg_3_0._index)
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._btnclick:AddClickListener(arg_4_0._btnclickOnClick, arg_4_0)
	arg_4_0._btnreview:AddClickListener(arg_4_0._btnReviewOnClick, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	if arg_5_0._btnclick then
		arg_5_0._btnclick:RemoveClickListener()
		arg_5_0._btnreview:RemoveClickListener()
	end
end

function var_0_0._btnclickOnClick(arg_6_0)
	if Activity168Model.instance:getCurEpisodeId() == arg_6_0._episodeId then
		arg_6_0:_delayEnterLoperaLevel()
	else
		LoperaController.instance:dispatchEvent(LoperaEvent.ClickOtherEpisode, arg_6_0._episodeId)
		UIBlockHelper.instance:startBlock("LoperaMainViewStageItemEpisodeClick", 0.5, arg_6_0.viewName)
		TaskDispatcher.runDelay(arg_6_0._delayPlayChessOpenAnim, arg_6_0, 0.25)
	end
end

function var_0_0._delayPlayChessOpenAnim(arg_7_0)
	if not arg_7_0._imagechess then
		return
	end

	gohelper.setActive(arg_7_0._imagechess, true)

	if Activity168Model.instance:getCurEpisodeId() > arg_7_0._episodeId then
		arg_7_0._chessAnimator:Play("open_left", 0, 0)
	else
		arg_7_0._chessAnimator:Play("open_right", 0, 0)
	end

	gohelper.setActive(arg_7_0._goArrowSign, true)
	TaskDispatcher.runDelay(arg_7_0._delayEnterLoperaLevel, arg_7_0, 0.35)
end

function var_0_0._delayEnterLoperaLevel(arg_8_0)
	if not arg_8_0._config then
		return
	end

	LoperaController.instance:dispatchEvent(LoperaEvent.BeforeEnterEpisode)
	TaskDispatcher.runDelay(arg_8_0._enterLoperaLevel, arg_8_0, 0.5)
end

function var_0_0._enterLoperaLevel(arg_9_0)
	LoperaController.instance:enterEpisode(arg_9_0._episodeId)
end

function var_0_0._btnReviewOnClick(arg_10_0)
	if arg_10_0._config.mapId ~= 0 then
		LanShouPaController.instance:openStoryView(arg_10_0._episodeId)
	else
		StoryController.instance:playStory(arg_10_0._config.storyBefore, nil, arg_10_0._storyEnd, arg_10_0)
	end
end

function var_0_0._addEvents(arg_11_0)
	LoperaController.instance:registerCallback(LoperaEvent.ClickOtherEpisode, arg_11_0._playChooseEpisode, arg_11_0)
	LoperaController.instance:registerCallback(LoperaEvent.EnterEpisode, arg_11_0._onEnterEpisode, arg_11_0)
end

function var_0_0._removeEvents(arg_12_0)
	LoperaController.instance:unregisterCallback(LoperaEvent.ClickOtherEpisode, arg_12_0._playChooseEpisode, arg_12_0)
	LoperaController.instance:unregisterCallback(LoperaEvent.EnterEpisode, arg_12_0._onEnterEpisode, arg_12_0)
end

function var_0_0.playFinishAni(arg_13_0)
	arg_13_0:refreshItem(arg_13_0._config, arg_13_0._index)
	arg_13_0._animator:Play(UIAnimationName.Finish, 0, 0)
end

function var_0_0.playUnlockAni(arg_14_0)
	arg_14_0:refreshItem(arg_14_0._config, arg_14_0._index)
	arg_14_0._animator:Play(UIAnimationName.Unlock, 0, 0)
end

function var_0_0._playChooseEpisode(arg_15_0, arg_15_1)
	local var_15_0 = Activity168Model.instance:getCurEpisodeId()

	if arg_15_0._episodeId == var_15_0 then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if arg_15_1 < arg_15_0._episodeId then
			arg_15_0._chessAnimator:Play("close_left", 0, 0)
		else
			arg_15_0._chessAnimator:Play("close_right", 0, 0)
		end
	end

	gohelper.setActive(arg_15_0._goArrowSign, false)
end

function var_0_0._onEnterEpisode(arg_16_0, arg_16_1)
	if arg_16_0._episodeId ~= arg_16_1 then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaSelect .. var_0_1, tostring(arg_16_0._index))

	if arg_16_0._config.episodeType == LoperaEnum.EpisodeType.Explore then
		local var_16_0 = arg_16_0._config.storyBefore == 0
		local var_16_1 = Activity168Model.instance:getCurEpisodeId() == arg_16_1

		if var_16_0 or var_16_1 then
			arg_16_0:_storyEnd()
		else
			StoryController.instance:playStory(arg_16_0._config.storyBefore, nil, arg_16_0._storyEnd, arg_16_0)
		end
	elseif arg_16_0._config.episodeType == LoperaEnum.EpisodeType.Battle then
		if arg_16_0._battleEpisodeId <= 0 then
			logError("没有配置对应的关卡")

			return
		end

		local var_16_2 = Activity168Model.instance:getEpisodeData(arg_16_0._episodeId)
		local var_16_3 = DungeonConfig.instance:getEpisodeCO(arg_16_0._battleEpisodeId)
		local var_16_4 = var_16_3.beforeStory
		local var_16_5 = var_16_3.afterStory
		local var_16_6 = var_16_4 == 0 or var_16_2.status == LoperaEnum.EpisodeStatus.PlayStartStory
		local var_16_7 = var_16_5 == 0 and var_16_2.status == LoperaEnum.EpisodeStatus.PlayEndStory

		if var_16_6 then
			arg_16_0:_enterBattleHeroGroupView()
		elseif var_16_7 then
			StoryController.instance:playStory(var_16_5, nil, arg_16_0._storyEnd, arg_16_0)
		else
			StoryController.instance:playStory(var_16_4, nil, arg_16_0._storyEnd, arg_16_0)
		end
	elseif arg_16_0._config.episodeType == LoperaEnum.EpisodeType.Story then
		if arg_16_0._config.storyBefore == 0 or arg_16_0._config.mapId ~= 0 and Activity168Model.instance.currChessGameEpisodeId == arg_16_0._episodeId then
			arg_16_0:_storyEnd()
		else
			StoryController.instance:playStory(arg_16_0._config.storyBefore, nil, arg_16_0._storyEnd, arg_16_0)
		end
	elseif arg_16_0._config.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
		LoperaController.instance:openLoperaLevelView()
	end

	Activity168Model.instance:setCurEpisodeId(arg_16_1)
end

function var_0_0._storyEnd(arg_17_0)
	if arg_17_0._config.episodeType == LoperaEnum.EpisodeType.Explore then
		if Activity168Model.instance:getCurGameState().round == 1 then
			local var_17_0 = Activity168Config.instance:getMapStartCell()[var_0_2.storyId]

			if var_17_0 ~= 0 then
				StoryController.instance:playStory(var_17_0, nil, arg_17_0._gameFirstStoryEnd, arg_17_0)
			else
				arg_17_0:_gameFirstStoryEnd()
			end
		else
			LoperaController.instance:openLoperaLevelView()
		end
	elseif arg_17_0._config.episodeType == LoperaEnum.EpisodeType.Battle then
		local var_17_1 = Activity168Model.instance:getEpisodeData(arg_17_0._episodeId)

		if DungeonConfig.instance:getEpisodeCO(arg_17_0._battleEpisodeId).afterStory == 0 and var_17_1.status == LoperaEnum.EpisodeStatus.PlayEndStory then
			LoperaController.instance:finishStoryPlay()
		else
			LoperaController.instance:finishStoryPlay()
			arg_17_0:_enterBattleHeroGroupView()
		end
	elseif arg_17_0._config.episodeType == LoperaEnum.EpisodeType.Story then
		LoperaController.instance:finishStoryPlay()
	end
end

function var_0_0._gameFirstStoryEnd(arg_18_0)
	LoperaController.instance:openLoperaLevelView()
end

function var_0_0._enterBattleHeroGroupView(arg_19_0)
	local var_19_0 = arg_19_0._battleId
	local var_19_1 = LoperaController.instance
	local var_19_2 = arg_19_0._battleEpisodeId
	local var_19_3 = DungeonConfig.instance:getEpisodeCO(arg_19_0._battleEpisodeId)

	Activity168Model.instance:setCurBattleEpisodeId(arg_19_0._battleEpisodeId)
	DungeonFightController.instance:setBattleRequestAction(var_19_1.startBattle, var_19_1)
	DungeonFightController.instance:enterFight(var_19_3.chapterId, var_19_2)
end

function var_0_0.onDestroy(arg_20_0)
	arg_20_0:_removeEvents()
	arg_20_0:removeEventListeners()
end

return var_0_0
