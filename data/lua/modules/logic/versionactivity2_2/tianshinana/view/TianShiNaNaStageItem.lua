module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaStageItem", package.seeall)

local var_0_0 = class("TianShiNaNaStageItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked")
	arg_1_0._gostory = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_StoryStage")
	arg_1_0._gogame1 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_GameStage1")
	arg_1_0._gogame2 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_GameStage2")
	arg_1_0._goStar1Has1 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Star/#go_Star1/Has1")
	arg_1_0._goStar1Has2 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Star/#go_Star1/Has2")
	arg_1_0._goStar1Eff = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Star/#go_Star1/eff_star")
	arg_1_0._goStar2 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Star/#go_Star2")
	arg_1_0._goStar2Has1 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Star/#go_Star2/Has1")
	arg_1_0._goStar2Has2 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Star/#go_Star2/Has2")
	arg_1_0._goStar2Eff = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/#go_Star/#go_Star2/eff_star")
	arg_1_0._txtstagename = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_UnLocked/#txt_StageName")
	arg_1_0._txtstagenameEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_UnLocked/#txt_StageName/#txt_StageName")
	arg_1_0._txtstagenum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_UnLocked/#txt_StageNum")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_UnLocked/#btn_click")
	arg_1_0._effect1 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/eff_flow1")
	arg_1_0._effect2 = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/eff_flow2")
	arg_1_0._goChess = gohelper.findChild(arg_1_0.viewGO, "image_chess")
	arg_1_0._chessAnimator = gohelper.findChild(arg_1_0._goChess, "ani"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._txtlockstagenum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_Locked/#txt_StageNum")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.initCo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._episodeCo = arg_2_1
	arg_2_0._index = arg_2_2
	arg_2_0._txtstagename.text = arg_2_0._episodeCo.name
	arg_2_0._txtstagenameEn.text = arg_2_0._episodeCo.nameEn
	arg_2_0._txtstagenum.text = string.format("%02d", arg_2_0._index)
	arg_2_0._txtlockstagenum.text = string.format("%02d", arg_2_0._index)

	gohelper.setActive(arg_2_0._gostory, arg_2_0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Story)
	gohelper.setActive(arg_2_0._gogame1, arg_2_0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Normal)
	gohelper.setActive(arg_2_0._gogame2, arg_2_0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(arg_2_0._effect1, arg_2_0._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(arg_2_0._effect2, arg_2_0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)

	local var_2_0 = not string.nilorempty(arg_2_0._episodeCo.exStarCondition)

	gohelper.setActive(arg_2_0._goStar2, var_2_0)
	gohelper.setActive(arg_2_0._goStar1Has1, arg_2_0._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(arg_2_0._goStar1Has2, arg_2_0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(arg_2_0._goStar2Has1, arg_2_0._episodeCo.episodeType ~= TianShiNaNaEnum.EpisodeType.Hard)
	gohelper.setActive(arg_2_0._goStar2Has2, arg_2_0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard)
	arg_2_0:_refreshView()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._clickBtn, arg_3_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeClick, arg_3_0._playChooseEpisode, arg_3_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeStarChange, arg_3_0._onStarChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeClick, arg_4_0._playChooseEpisode, arg_4_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeStarChange, arg_4_0._onStarChange, arg_4_0)
end

function var_0_0._onStarChange(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 + 1 == arg_5_0._index then
		arg_5_0:_refreshView()

		if arg_5_2 == 0 then
			if arg_5_0._episodeCo.episodeType == TianShiNaNaEnum.EpisodeType.Hard then
				arg_5_0._anim:Play("unlock_hard")
			else
				arg_5_0._anim:Play("unlock")
			end
		end

		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
	elseif arg_5_1 == arg_5_0._index then
		arg_5_0:_refreshView()

		if arg_5_2 < 1 and arg_5_3 >= 1 then
			gohelper.setActive(arg_5_0._goStar1Eff, true)
		end

		if arg_5_2 < 2 and arg_5_3 >= 2 then
			gohelper.setActive(arg_5_0._goStar2Eff, true)
		end
	end
end

function var_0_0._refreshView(arg_6_0)
	gohelper.setActive(arg_6_0._goStar1Eff, false)
	gohelper.setActive(arg_6_0._goStar2Eff, false)

	local var_6_0 = true
	local var_6_1 = lua_activity167_episode.configDict[arg_6_0._episodeCo.activityId][arg_6_0._episodeCo.preEpisode]

	if var_6_1 then
		if var_6_1.storyBefore > 0 and not StoryModel.instance:isStoryFinished(var_6_1.storyBefore) then
			var_6_0 = false
		end

		if var_6_1.mapId > 0 and TianShiNaNaModel.instance:getEpisodeStar(arg_6_0._index - 1) <= 0 then
			var_6_0 = false
		end
	end

	gohelper.setActive(arg_6_0._gounlock, var_6_0)
	gohelper.setActive(arg_6_0._golocked, not var_6_0)
	gohelper.setActive(arg_6_0._goChess, TianShiNaNaModel.instance.curSelectIndex == arg_6_0._index)

	if var_6_0 then
		local var_6_2 = TianShiNaNaModel.instance:getEpisodeStar(arg_6_0._index)

		ZProj.UGUIHelper.SetGrayFactor(arg_6_0._goStar1Has1, var_6_2 < 1 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(arg_6_0._goStar1Has2, var_6_2 < 1 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(arg_6_0._goStar2Has1, var_6_2 < 2 and 1 or 0)
		ZProj.UGUIHelper.SetGrayFactor(arg_6_0._goStar2Has2, var_6_2 < 2 and 1 or 0)
	end
end

function var_0_0._playChooseEpisode(arg_7_0, arg_7_1)
	if TianShiNaNaModel.instance.curSelectIndex == arg_7_0._index then
		if arg_7_1 < arg_7_0._index then
			arg_7_0._chessAnimator:Play("close_left", 0, 0)
		else
			arg_7_0._chessAnimator:Play("close_right", 0, 0)
		end

		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)
	end
end

function var_0_0._clickBtn(arg_8_0)
	if TianShiNaNaModel.instance.curSelectIndex == arg_8_0._index then
		arg_8_0:_beginStory()
	else
		UIBlockMgr.instance:startBlock("TianShiNaNaStageItem")
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeClick, arg_8_0._index)
		TaskDispatcher.runDelay(arg_8_0._delayPlayChessOpenAnim, arg_8_0, 0.4)
	end
end

function var_0_0._delayPlayChessOpenAnim(arg_9_0)
	gohelper.setActive(arg_9_0._goChess, true)
	arg_9_0._chessAnimator:Play("open_right", 0, 0)
	TaskDispatcher.runDelay(arg_9_0._beginStory, arg_9_0, 0.9)
end

function var_0_0._beginStory(arg_10_0)
	UIBlockMgr.instance:endBlock("TianShiNaNaStageItem")

	TianShiNaNaModel.instance.curSelectIndex = arg_10_0._index

	local var_10_0 = VersionActivity2_2Enum.ActivityId.TianShiNaNa

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. var_10_0, tostring(arg_10_0._index))

	if arg_10_0._episodeCo.mapId > 0 then
		if arg_10_0._episodeCo.storyBefore <= 0 then
			arg_10_0:_storyEnd()
		else
			StoryController.instance:playStory(arg_10_0._episodeCo.storyBefore, nil, arg_10_0._storyEnd, arg_10_0)
		end
	elseif arg_10_0._episodeCo.storyBefore > 0 then
		StoryController.instance:playStory(arg_10_0._episodeCo.storyBefore, nil, arg_10_0._storyEnd, arg_10_0)
	end
end

function var_0_0._onGetEpisodeInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 then
		TianShiNaNaModel.instance.currEpisodeId = arg_11_3.episodeId

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EnterLevelScene)
	end
end

function var_0_0._storyEnd(arg_12_0)
	if arg_12_0._episodeCo.mapId > 0 then
		Activity167Rpc.instance:sendAct167StartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, arg_12_0._episodeCo.id, arg_12_0._onGetEpisodeInfo, arg_12_0)
	else
		TaskDispatcher.runDelay(arg_12_0._delayMarkFinish, arg_12_0, 0.2)
	end
end

function var_0_0._delayMarkFinish(arg_13_0)
	if not arg_13_0._index then
		return
	end

	TianShiNaNaModel.instance:markEpisodeFinish(arg_13_0._index, 1)
end

function var_0_0.onDestroy(arg_14_0)
	UIBlockMgr.instance:endBlock("TianShiNaNaStageItem")
	TaskDispatcher.cancelTask(arg_14_0._delayPlayChessOpenAnim, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._beginStory, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayMarkFinish, arg_14_0)
end

return var_0_0
