module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaStageItem", package.seeall)

slot0 = class("TianShiNaNaStageItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_UnLocked")
	slot0._gostory = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_StoryStage")
	slot0._gogame1 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_GameStage1")
	slot0._gogame2 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_GameStage2")
	slot0._goStar1Has1 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Star/#go_Star1/Has1")
	slot0._goStar1Has2 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Star/#go_Star1/Has2")
	slot0._goStar1Eff = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Star/#go_Star1/eff_star")
	slot0._goStar2 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Star/#go_Star2")
	slot0._goStar2Has1 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Star/#go_Star2/Has1")
	slot0._goStar2Has2 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Star/#go_Star2/Has2")
	slot0._goStar2Eff = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Star/#go_Star2/eff_star")
	slot0._txtstagename = gohelper.findChildTextMesh(slot0.viewGO, "#go_UnLocked/#txt_StageName")
	slot0._txtstagenameEn = gohelper.findChildTextMesh(slot0.viewGO, "#go_UnLocked/#txt_StageName/#txt_StageName")
	slot0._txtstagenum = gohelper.findChildTextMesh(slot0.viewGO, "#go_UnLocked/#txt_StageNum")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_UnLocked/#btn_click")
	slot0._effect1 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/eff_flow1")
	slot0._effect2 = gohelper.findChild(slot0.viewGO, "#go_UnLocked/eff_flow2")
	slot0._goChess = gohelper.findChild(slot0.viewGO, "image_chess")
	slot0._chessAnimator = gohelper.findChild(slot0._goChess, "ani"):GetComponent(typeof(UnityEngine.Animator))
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._txtlockstagenum = gohelper.findChildTextMesh(slot0.viewGO, "#go_Locked/#txt_StageNum")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.initCo(slot0, slot1, slot2)
	slot0._episodeCo = slot1
	slot0._index = slot2
	slot0._txtstagename.text = slot0._episodeCo.name
	slot0._txtstagenameEn.text = slot0._episodeCo.nameEn
	slot0._txtstagenum.text = string.format("%02d", slot0._index)
	slot0._txtlockstagenum.text = string.format("%02d", slot0._index)

	gohelper.setActive(slot0._gostory, slot0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Story)
	gohelper.setActive(slot0._gogame1, slot0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Normal)
	gohelper.setActive(slot0._gogame2, slot0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(slot0._effect1, slot0._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(slot0._effect2, slot0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(slot0._goStar2, not string.nilorempty(slot0._episodeCo.exStarCondition))
	gohelper.setActive(slot0._goStar1Has1, slot0._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(slot0._goStar1Has2, slot0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(slot0._goStar2Has1, slot0._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(slot0._goStar2Has2, slot0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	slot0:_refreshView()
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._clickBtn, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeClick, slot0._playChooseEpisode, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeStarChange, slot0._onStarChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeClick, slot0._playChooseEpisode, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeStarChange, slot0._onStarChange, slot0)
end

function slot0._onStarChange(slot0, slot1, slot2, slot3)
	if slot1 + 1 == slot0._index then
		slot0:_refreshView()

		if slot2 == 0 then
			if slot0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard then
				slot0._anim:Play("unlock_hard")
			else
				slot0._anim:Play("unlock")
			end
		end

		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	elseif slot1 == slot0._index then
		slot0:_refreshView()

		if slot2 < 1 and slot3 >= 1 then
			gohelper.setActive(slot0._goStar1Eff, true)
		end

		if slot2 < 2 and slot3 >= 2 then
			gohelper.setActive(slot0._goStar2Eff, true)
		end
	end
end

function slot0._refreshView(slot0)
	gohelper.setActive(slot0._goStar1Eff, false)
	gohelper.setActive(slot0._goStar2Eff, false)

	slot1 = true

	if lua_activity167_episode.configDict[slot0._episodeCo.activityId][slot0._episodeCo.preEpisode] then
		if slot2.storyBefore > 0 and not StoryModel.instance:isStoryFinished(slot2.storyBefore) then
			slot1 = false
		end

		if slot2.mapId > 0 and TianShiNaNaModel.instance:getEpisodeStar(slot0._index - 1) <= 0 then
			slot1 = false
		end
	end

	gohelper.setActive(slot0._gounlock, slot1)
	gohelper.setActive(slot0._golocked, not slot1)
	gohelper.setActive(slot0._goChess, TianShiNaNaModel.instance.curSelectIndex == slot0._index)

	if slot1 then
		ZProj.UGUIHelper.SetGrayFactor(slot0._goStar1Has1, TianShiNaNaModel.instance:getEpisodeStar(slot0._index) < 1 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(slot0._goStar1Has2, slot3 < 1 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(slot0._goStar2Has1, slot3 < 2 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(slot0._goStar2Has2, slot3 < 2 and 1 or 0)
	end
end

function slot0._playChooseEpisode(slot0, slot1)
	if TianShiNaNaModel.instance.curSelectIndex == slot0._index then
		if slot1 < slot0._index then
			slot0._chessAnimator:Play("close_left", 0, 0)
		else
			slot0._chessAnimator:Play("close_right", 0, 0)
		end

		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)
	end
end

function slot0._clickBtn(slot0)
	if TianShiNaNaModel.instance.curSelectIndex == slot0._index then
		slot0:_beginStory()
	else
		UIBlockMgr.instance:startBlock("TianShiNaNaStageItem")
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeClick, slot0._index)
		TaskDispatcher.runDelay(slot0._delayPlayChessOpenAnim, slot0, 0.4)
	end
end

function slot0._delayPlayChessOpenAnim(slot0)
	gohelper.setActive(slot0._goChess, true)
	slot0._chessAnimator:Play("open_right", 0, 0)
	TaskDispatcher.runDelay(slot0._beginStory, slot0, 0.9)
end

function slot0._beginStory(slot0)
	UIBlockMgr.instance:endBlock("TianShiNaNaStageItem")

	TianShiNaNaModel.instance.curSelectIndex = slot0._index

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. VersionActivity2_2Enum.ActivityId.TianShiNaNa, tostring(slot0._index))

	if slot0._episodeCo.mapId > 0 then
		if slot0._episodeCo.storyBefore <= 0 then
			slot0:_storyEnd()
		else
			StoryController.instance:playStory(slot0._episodeCo.storyBefore, nil, slot0._storyEnd, slot0)
		end
	elseif slot0._episodeCo.storyBefore > 0 then
		StoryController.instance:playStory(slot0._episodeCo.storyBefore, nil, slot0._storyEnd, slot0)
	end
end

function slot0._onGetEpisodeInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		TianShiNaNaModel.instance.currEpisodeId = slot3.episodeId

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EnterLevelScene)
	end
end

function slot0._storyEnd(slot0)
	if slot0._episodeCo.mapId > 0 then
		Activity167Rpc.instance:sendAct167StartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, slot0._episodeCo.id, slot0._onGetEpisodeInfo, slot0)
	else
		TaskDispatcher.runDelay(slot0._delayMarkFinish, slot0, 0.2)
	end
end

function slot0._delayMarkFinish(slot0)
	if not slot0._index then
		return
	end

	TianShiNaNaModel.instance:markEpisodeFinish(slot0._index, 1)
end

function slot0.onDestroy(slot0)
	UIBlockMgr.instance:endBlock("TianShiNaNaStageItem")
	TaskDispatcher.cancelTask(slot0._delayPlayChessOpenAnim, slot0)
	TaskDispatcher.cancelTask(slot0._beginStory, slot0)
	TaskDispatcher.cancelTask(slot0._delayMarkFinish, slot0)
end

return slot0
