module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelItem", package.seeall)

local var_0_0 = class("ActDuDuGuLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gogameicon = gohelper.findChild(arg_1_0.go, "unlock/#go_gameicon")
	arg_1_0._imagegameicon = gohelper.findChildImage(arg_1_0.go, "unlock/#go_gameicon")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal")
	arg_1_0._gostageunlock = gohelper.findChild(arg_1_0.go, "unlock/#go_stageunlock")
	arg_1_0._gostagefinish = gohelper.findChild(arg_1_0.go, "unlock/#go_stagefinish")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "unlock/#btn_click")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.go, "unlock/info/#txt_stagename")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.go, "unlock/info/#txt_stageNum")
	arg_1_0._txtstage = gohelper.findChildText(arg_1_0.go, "unlock/info/txt_stage")
	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0.go, "unlock/info/#btn_review")
	arg_1_0._gostarno = gohelper.findChild(arg_1_0.go, "unlock/info/star1/no")
	arg_1_0._imagestarno = gohelper.findChildImage(arg_1_0.go, "unlock/info/star1/no")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.go, "unlock/info/star1/#go_star")
	arg_1_0._anim = arg_1_0.go:GetComponent(gohelper.Type_Animator)
	arg_1_0._goimagestar = gohelper.findChild(arg_1_0._gostar, "#image_Star")
	arg_1_0._animStar = arg_1_0._goimagestar:GetComponent(gohelper.Type_Animation)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
	arg_2_0._btnreview:AddClickListener(arg_2_0._btnOnReview, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnreview:RemoveClickListener()
end

function var_0_0.onDestroy(arg_4_0)
	return
end

function var_0_0._btnOnClick(arg_5_0)
	if not arg_5_0._islvunlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActDuDuGuModel.instance:setCurLvIndex(arg_5_0._index)
	arg_5_0:_playBeforeStory()
end

function var_0_0._playBeforeStory(arg_6_0)
	if arg_6_0._config.beforeStory > 0 then
		local var_6_0 = {}

		var_6_0.mark = true
		var_6_0.episodeId = arg_6_0._config.id

		if arg_6_0._config.battleId <= 0 then
			DungeonRpc.instance:sendStartDungeonRequest(arg_6_0._config.chapterId, arg_6_0._config.id)
		end

		StoryController.instance:playStory(arg_6_0._config.beforeStory, var_6_0, arg_6_0._enterFight, arg_6_0)
	else
		arg_6_0:_enterFight()
	end
end

function var_0_0._enterFight(arg_7_0)
	if arg_7_0._config.battleId and arg_7_0._config.battleId > 0 then
		DungeonRpc.instance:sendStartDungeonRequest(arg_7_0._config.chapterId, arg_7_0._config.id)
		DungeonFightController.instance:enterFightByBattleId(arg_7_0._config.chapterId, arg_7_0._config.id, arg_7_0._config.battleId)
	else
		arg_7_0:_enterAfterStory()
	end
end

function var_0_0._enterAfterStory(arg_8_0)
	if arg_8_0._config.afterStory > 0 then
		local var_8_0 = {}

		var_8_0.mark = true
		var_8_0.episodeId = arg_8_0._config.id

		StoryController.instance:playStory(arg_8_0._config.afterStory, var_8_0, arg_8_0._onLevelFinished, arg_8_0)
	else
		arg_8_0:_onLevelFinished()
	end
end

function var_0_0._onLevelFinished(arg_9_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_9_0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function var_0_0._btnOnReview(arg_10_0)
	return
end

function var_0_0.setParam(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._config = arg_11_1
	arg_11_0.id = arg_11_1.id
	arg_11_0._episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_11_0.id)
	arg_11_0._actId = arg_11_3
	arg_11_0._index = arg_11_2

	arg_11_0:_refreshUI()
end

function var_0_0._refreshUI(arg_12_0)
	arg_12_0._txtname.text = arg_12_0._config.name
	arg_12_0._txtnum.text = "0" .. arg_12_0._index

	gohelper.setActive(arg_12_0._gogameicon, arg_12_0._config.battleId > 0)
	arg_12_0:refreshStatus()
end

function var_0_0.refreshStatus(arg_13_0)
	arg_13_0._islvunlock = ActDuDuGuModel.instance:isLevelUnlock(arg_13_0._actId, arg_13_0.id)
	arg_13_0._islvpass = ActDuDuGuModel.instance:isLevelPass(arg_13_0._actId, arg_13_0.id)

	if arg_13_0._islvunlock then
		local var_13_0 = arg_13_0._islvpass and "finishidle" or "normalidle"

		arg_13_0._anim:Play(var_13_0)
	else
		arg_13_0._anim:Play("lockidle")
	end
end

function var_0_0.lockStatus(arg_14_0)
	arg_14_0._anim:Play("finishidle")
end

function var_0_0.isUnlock(arg_15_0)
	return arg_15_0._islvunlock
end

function var_0_0.playFinish(arg_16_0)
	arg_16_0._anim:Play("finish", 0, 0)
end

function var_0_0.playUnlock(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	arg_17_0._anim:Play("unlock", 0, 0)
end

function var_0_0.playStarAnim(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
	arg_18_0._animStar:Play()
end

return var_0_0
