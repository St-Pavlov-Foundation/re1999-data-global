module("modules.logic.versionactivity2_2.lopera.view.LoperaMainViewStageItem", package.seeall)

slot0 = class("LoperaMainViewStageItem", LuaCompBase)
slot1 = VersionActivity2_2Enum.ActivityId.Lopera
slot2 = LoperaEnum.MapCfgIdx

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#image_point")
	slot0._goImagepointfinished = gohelper.findChild(slot0.viewGO, "#image_pointfinished")
	slot0._gostagefinish = gohelper.findChild(slot0.viewGO, "unlock/#go_stagefinish")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star")
	slot0._gohasstar = gohelper.findChild(slot0._gostar, "has/#image_Star")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "unlock")
	slot0._imagestageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_stageline")
	slot0._gogame = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/#go_Game")
	slot0._gostory = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal/#go_Story")
	slot0._imageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_line")
	slot0._imageangle = gohelper.findChildImage(slot0.viewGO, "unlock/#image_angle")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename")
	slot0._txtstagenum = gohelper.findChildText(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#txt_stageNum")
	slot0._goArrowSign = gohelper.findChild(slot0.viewGO, "#image_Sign")
	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#btn_review")
	slot0._imagechess = gohelper.findChildImage(slot0.viewGO, "unlock/#image_chess")
	slot0._chessAnimator = gohelper.findChild(slot0._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#btn_click")

	slot0:_addEvents()
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot0._actId = VersionActivity2_2Enum.ActivityId.Lopera
	slot0._index = slot2
	slot0._config = slot1
	slot0._episodeId = slot0._config.id
	slot0._battleEpisodeId = slot0._config.episodeId
	slot3 = Activity168Model.instance:getCurEpisodeId()

	slot0:refreshTitle()

	slot4 = slot0._config.mapId ~= 0
	slot5 = Activity168Model.instance:isEpisodeFinished(slot0._episodeId)

	gohelper.setActive(slot0._btnreview.gameObject, false)
	gohelper.setActive(slot0._imagechess.gameObject, slot0._episodeId == slot3)
	gohelper.setActive(slot0._goArrowSign, slot0._episodeId == slot3)
	gohelper.setActive(slot0._gounlock, Activity168Model.instance:isEpisodeUnlock(slot0._episodeId))
	gohelper.setActive(slot0._gostagefinish, slot4)
	gohelper.setActive(slot0._gohasstar, slot5)
	gohelper.setActive(slot0._gogame, slot4)
	gohelper.setActive(slot0._goImagepointfinished, slot5)
end

function slot0.refreshTitle(slot0)
	slot0._txtstagename.text = slot0._config.name
	slot0._txtstagenum.text = string.format("STAGE %02d", slot0._index)
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
	if Activity168Model.instance:getCurEpisodeId() == slot0._episodeId then
		slot0:_delayEnterLoperaLevel()
	else
		LoperaController.instance:dispatchEvent(LoperaEvent.ClickOtherEpisode, slot0._episodeId)
		UIBlockHelper.instance:startBlock("LoperaMainViewStageItemEpisodeClick", 0.5, slot0.viewName)
		TaskDispatcher.runDelay(slot0._delayPlayChessOpenAnim, slot0, 0.25)
	end
end

function slot0._delayPlayChessOpenAnim(slot0)
	if not slot0._imagechess then
		return
	end

	gohelper.setActive(slot0._imagechess, true)

	if slot0._episodeId < Activity168Model.instance:getCurEpisodeId() then
		slot0._chessAnimator:Play("open_left", 0, 0)
	else
		slot0._chessAnimator:Play("open_right", 0, 0)
	end

	gohelper.setActive(slot0._goArrowSign, true)
	TaskDispatcher.runDelay(slot0._delayEnterLoperaLevel, slot0, 0.35)
end

function slot0._delayEnterLoperaLevel(slot0)
	if not slot0._config then
		return
	end

	LoperaController.instance:dispatchEvent(LoperaEvent.BeforeEnterEpisode)
	TaskDispatcher.runDelay(slot0._enterLoperaLevel, slot0, 0.5)
end

function slot0._enterLoperaLevel(slot0)
	LoperaController.instance:enterEpisode(slot0._episodeId)
end

function slot0._btnReviewOnClick(slot0)
	if slot0._config.mapId ~= 0 then
		LanShouPaController.instance:openStoryView(slot0._episodeId)
	else
		StoryController.instance:playStory(slot0._config.storyBefore, nil, slot0._storyEnd, slot0)
	end
end

function slot0._addEvents(slot0)
	LoperaController.instance:registerCallback(LoperaEvent.ClickOtherEpisode, slot0._playChooseEpisode, slot0)
	LoperaController.instance:registerCallback(LoperaEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
end

function slot0._removeEvents(slot0)
	LoperaController.instance:unregisterCallback(LoperaEvent.ClickOtherEpisode, slot0._playChooseEpisode, slot0)
	LoperaController.instance:unregisterCallback(LoperaEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
end

function slot0.playFinishAni(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
	slot0._animator:Play(UIAnimationName.Finish, 0, 0)
end

function slot0.playUnlockAni(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
	slot0._animator:Play(UIAnimationName.Unlock, 0, 0)
end

function slot0._playChooseEpisode(slot0, slot1)
	if slot0._episodeId == Activity168Model.instance:getCurEpisodeId() then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if slot1 < slot0._episodeId then
			slot0._chessAnimator:Play("close_left", 0, 0)
		else
			slot0._chessAnimator:Play("close_right", 0, 0)
		end
	end

	gohelper.setActive(slot0._goArrowSign, false)
end

function slot0._onEnterEpisode(slot0, slot1)
	if slot0._episodeId ~= slot1 then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaSelect .. uv0, tostring(slot0._index))

	if slot0._config.episodeType == LoperaEnum.EpisodeType.Explore then
		if slot0._config.storyBefore == 0 or Activity168Model.instance:getCurEpisodeId() == slot1 then
			slot0:_storyEnd()
		else
			StoryController.instance:playStory(slot0._config.storyBefore, nil, slot0._storyEnd, slot0)
		end
	elseif slot0._config.episodeType == LoperaEnum.EpisodeType.Battle then
		if slot0._battleEpisodeId <= 0 then
			logError("没有配置对应的关卡")

			return
		end

		slot2 = Activity168Model.instance:getEpisodeData(slot0._episodeId)
		slot3 = DungeonConfig.instance:getEpisodeCO(slot0._battleEpisodeId)
		slot7 = slot3.afterStory == 0 and slot2.status == LoperaEnum.EpisodeStatus.PlayEndStory

		if slot3.beforeStory == 0 or slot2.status == LoperaEnum.EpisodeStatus.PlayStartStory then
			slot0:_enterBattleHeroGroupView()
		elseif slot7 then
			StoryController.instance:playStory(slot5, nil, slot0._storyEnd, slot0)
		else
			StoryController.instance:playStory(slot4, nil, slot0._storyEnd, slot0)
		end
	elseif slot0._config.episodeType == LoperaEnum.EpisodeType.Story then
		if slot0._config.storyBefore == 0 or slot0._config.mapId ~= 0 and Activity168Model.instance.currChessGameEpisodeId == slot0._episodeId then
			slot0:_storyEnd()
		else
			StoryController.instance:playStory(slot0._config.storyBefore, nil, slot0._storyEnd, slot0)
		end
	elseif slot0._config.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
		LoperaController.instance:openLoperaLevelView()
	end

	Activity168Model.instance:setCurEpisodeId(slot1)
end

function slot0._storyEnd(slot0)
	if slot0._config.episodeType == LoperaEnum.EpisodeType.Explore then
		if Activity168Model.instance:getCurGameState().round == 1 then
			if Activity168Config.instance:getMapStartCell()[uv0.storyId] ~= 0 then
				StoryController.instance:playStory(slot4, nil, slot0._gameFirstStoryEnd, slot0)
			else
				slot0:_gameFirstStoryEnd()
			end
		else
			LoperaController.instance:openLoperaLevelView()
		end
	elseif slot0._config.episodeType == LoperaEnum.EpisodeType.Battle then
		if DungeonConfig.instance:getEpisodeCO(slot0._battleEpisodeId).afterStory == 0 and Activity168Model.instance:getEpisodeData(slot0._episodeId).status == LoperaEnum.EpisodeStatus.PlayEndStory then
			LoperaController.instance:finishStoryPlay()
		else
			LoperaController.instance:finishStoryPlay()
			slot0:_enterBattleHeroGroupView()
		end
	elseif slot0._config.episodeType == LoperaEnum.EpisodeType.Story then
		LoperaController.instance:finishStoryPlay()
	end
end

function slot0._gameFirstStoryEnd(slot0)
	LoperaController.instance:openLoperaLevelView()
end

function slot0._enterBattleHeroGroupView(slot0)
	slot1 = slot0._battleId
	slot2 = LoperaController.instance

	Activity168Model.instance:setCurBattleEpisodeId(slot0._battleEpisodeId)
	DungeonFightController.instance:setBattleRequestAction(slot2.startBattle, slot2)
	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot0._battleEpisodeId).chapterId, slot0._battleEpisodeId)
end

function slot0.onDestroy(slot0)
	slot0:_removeEvents()
	slot0:removeEventListeners()
end

return slot0
