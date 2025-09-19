module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaLevelItem", package.seeall)

local var_0_0 = class("NuoDiKaLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._itemAnim = arg_1_0.go:GetComponent(gohelper.Type_Animator)
	arg_1_0._gostagenormal1 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal1")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal1/info/#txt_stageNum")
	arg_1_0._txtname1 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal1/info/#txt_stagename")
	arg_1_0._gostar1 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal1/info/star1")
	arg_1_0._gostagenormal2 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal2")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal2/info/#txt_stageNum")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal2/info/#txt_stagename")
	arg_1_0._gostar2 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal2/info/star1")
	arg_1_0._gostageunlock = gohelper.findChild(arg_1_0.go, "unlock/#go_stageunlock")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "unlock/#btn_click")
	arg_1_0._itemAnim = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
	NuoDiKaController.instance:registerCallback(NuoDiKaEvent.JumpToEpisode, arg_2_0._onJumpToEpisode, arg_2_0)
end

function var_0_0._btnOnClick(arg_3_0)
	if not arg_3_0._islvunlock then
		return
	end

	Activity180Rpc.instance:sendAct180EnterEpisodeRequest(arg_3_0._actId, arg_3_0.id, arg_3_0._startEpisodeFinished, arg_3_0)
end

function var_0_0._onJumpToEpisode(arg_4_0, arg_4_1)
	if arg_4_0.id ~= arg_4_1 then
		return
	end

	Activity180Rpc.instance:sendAct180EnterEpisodeRequest(arg_4_0._actId, arg_4_0.id, arg_4_0._startEpisodeFinished, arg_4_0)
end

function var_0_0._startEpisodeFinished(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end

	if arg_5_3.activityId ~= arg_5_0._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(arg_5_3.episode)
	NuoDiKaModel.instance:setCurEpisode(arg_5_0._index, arg_5_0.id)
	arg_5_0:_playBeforeStory()
end

function var_0_0._playBeforeStory(arg_6_0)
	arg_6_0._startTime = ServerTime.now()

	if NuoDiKaModel.instance:isEpisodePass(arg_6_0.id) then
		if arg_6_0._config.beforeStory > 0 then
			local var_6_0 = {}

			var_6_0.mark = true

			StoryController.instance:playStory(arg_6_0._config.beforeStory, var_6_0, arg_6_0._enterGame, arg_6_0)
		else
			arg_6_0:_enterGame()
		end

		return
	end

	if NuoDiKaModel.instance:getEpisodeStatus(arg_6_0.id) == NuoDiKaEnum.EpisodeStatus.BeforeStory then
		if arg_6_0._config.beforeStory > 0 then
			local var_6_1 = {}

			var_6_1.mark = true

			StoryController.instance:playStory(arg_6_0._config.beforeStory, var_6_1, arg_6_0._onBeforeStoryFinished, arg_6_0)
		else
			arg_6_0:_enterGame()
		end
	else
		arg_6_0:_enterGame()
	end
end

function var_0_0._onBeforeStoryFinished(arg_7_0)
	Activity180Rpc.instance:sendAct180StoryRequest(arg_7_0._actId, arg_7_0.id, arg_7_0._onStartUnlockBeforeStory, arg_7_0)
end

function var_0_0._onStartUnlockBeforeStory(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	if arg_8_3.activityId ~= arg_8_0._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(arg_8_3.episode)

	if arg_8_0._isStoryEpisode and arg_8_0._config.afterStory == 0 then
		NuoDiKaModel.instance:setNewFinishEpisode(arg_8_0.id)
	end

	arg_8_0:_enterGame()
end

function var_0_0._enterGame(arg_9_0)
	if NuoDiKaModel.instance:isEpisodePass(arg_9_0.id) then
		if not arg_9_0._isStoryEpisode then
			local var_9_0 = {
				episodeId = arg_9_0.id,
				callback = arg_9_0._enterAfterStory,
				callbackObj = arg_9_0
			}

			NuoDiKaController.instance:enterGameView(var_9_0)
		else
			arg_9_0:_enterAfterStory()
		end

		return
	end

	if NuoDiKaModel.instance:getEpisodeStatus(arg_9_0.id) == NuoDiKaEnum.EpisodeStatus.MapGame then
		local var_9_1 = {
			episodeId = arg_9_0.id,
			callback = arg_9_0._onGameFinished,
			callbackObj = arg_9_0
		}

		NuoDiKaController.instance:enterGameView(var_9_1)
	else
		arg_9_0:_enterAfterStory()
	end
end

function var_0_0._onGameFinished(arg_10_0)
	Activity180Rpc.instance:sendAct180GameFinishRequest(arg_10_0._actId, arg_10_0.id, arg_10_0._onStartUnlockGame, arg_10_0)
end

function var_0_0._onStartUnlockGame(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 ~= 0 then
		return
	end

	if arg_11_3.activityId ~= arg_11_0._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(arg_11_3.episode)

	if arg_11_0._config.afterStory == 0 then
		NuoDiKaModel.instance:setNewFinishEpisode(arg_11_0.id)
	end

	arg_11_0:_enterAfterStory()
end

function var_0_0._enterAfterStory(arg_12_0)
	if NuoDiKaModel.instance:isEpisodePass(arg_12_0.id) then
		if arg_12_0._config.afterStory > 0 then
			StoryController.instance:playStory(arg_12_0._config.afterStory, nil, arg_12_0._levelFinished, arg_12_0)
		else
			arg_12_0:_levelFinished()
		end

		return
	end

	if NuoDiKaModel.instance:getEpisodeStatus(arg_12_0.id) == NuoDiKaEnum.EpisodeStatus.AfterStory then
		if arg_12_0._config.afterStory > 0 then
			local var_12_0 = {}

			var_12_0.mark = true

			StoryController.instance:playStory(arg_12_0._config.afterStory, var_12_0, arg_12_0._onAfterStoryFinished, arg_12_0)
		else
			arg_12_0:_levelFinished()
		end
	else
		arg_12_0:_levelFinished()
	end
end

function var_0_0._onAfterStoryFinished(arg_13_0)
	Activity180Rpc.instance:sendAct180StoryRequest(arg_13_0._actId, arg_13_0.id, arg_13_0._onStartUnlockAfterStory, arg_13_0)
end

function var_0_0._onStartUnlockAfterStory(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 ~= 0 then
		return
	end

	if arg_14_3.activityId ~= arg_14_0._actId then
		return
	end

	NuoDiKaModel.instance:updateEpisodeInfo(arg_14_3.episode)
	NuoDiKaModel.instance:setNewFinishEpisode(arg_14_0.id)
	arg_14_0:_levelFinished()
end

function var_0_0._levelFinished(arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._backToLevel, arg_15_0, 0.5)
end

function var_0_0._backToLevel(arg_16_0)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnBackToLevel)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.EpisodeFinished)
end

function var_0_0.setParam(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._config = arg_17_1
	arg_17_0.id = arg_17_1.episodeId
	arg_17_0._actId = arg_17_3
	arg_17_0._index = arg_17_2
	arg_17_0._isStoryEpisode = arg_17_0._config.mapId == 0

	arg_17_0:refreshUI()
end

function var_0_0.refreshUI(arg_18_0)
	arg_18_0._islvunlock = NuoDiKaModel.instance:isEpisodeUnlock(arg_18_0.id)
	arg_18_0._islvpass = NuoDiKaModel.instance:isEpisodePass(arg_18_0.id)

	gohelper.setActive(arg_18_0._gostar2, arg_18_0._islvpass)
	gohelper.setActive(arg_18_0._gostar1, arg_18_0._islvpass)

	arg_18_0._txtname1.text = arg_18_0._config.name
	arg_18_0._txtname2.text = arg_18_0._config.name
	arg_18_0._txtnum1.text = "STAGE 0" .. arg_18_0._index
	arg_18_0._txtnum2.text = "STAGE 0" .. arg_18_0._index

	if not arg_18_0._islvunlock then
		arg_18_0._itemAnim.enabled = true

		arg_18_0._itemAnim:Play("lockidle", 0, 0)
	elseif not arg_18_0._islvpass then
		arg_18_0._itemAnim.enabled = true

		arg_18_0._itemAnim:Play("normalidle", 0, 0)
	else
		arg_18_0._itemAnim:Play("finishidle", 0, 0)
	end

	local var_18_0 = arg_18_0.id == NuoDiKaModel.instance:getMaxUnlockEpisodeId()

	gohelper.setActive(arg_18_0._gostagenormal1, arg_18_0._islvunlock and not var_18_0)
	gohelper.setActive(arg_18_0._gostagenormal2, arg_18_0._islvunlock and var_18_0)
end

function var_0_0.isUnlock(arg_19_0)
	return arg_19_0._islvunlock
end

function var_0_0.playFinish(arg_20_0)
	arg_20_0._itemAnim.enabled = true

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_finished)
	arg_20_0._itemAnim:Play("finish", 0, 0)
	gohelper.setActive(arg_20_0._gostagenormal1, true)

	arg_20_0._islvpass = NuoDiKaModel.instance:isEpisodePass(arg_20_0.id)

	gohelper.setActive(arg_20_0._gostar2, arg_20_0._islvpass)
	gohelper.setActive(arg_20_0._gostar1, arg_20_0._islvpass)
	gohelper.setActive(arg_20_0._gostagenormal2, false)
end

function var_0_0.playUnlock(arg_21_0)
	gohelper.setActive(arg_21_0._gostagenormal1, false)
	gohelper.setActive(arg_21_0._gostagenormal2, true)

	arg_21_0._itemAnim.enabled = true

	AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_unlock)
	arg_21_0._itemAnim:Play("unlock", 0, 0)
end

function var_0_0.playStarAnim(arg_22_0)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function var_0_0.removeEventListeners(arg_23_0)
	NuoDiKaController.instance:unregisterCallback(NuoDiKaEvent.JumpToEpisode, arg_23_0._onJumpToEpisode, arg_23_0)
	arg_23_0._btnclick:RemoveClickListener()
end

function var_0_0.onDestroy(arg_24_0)
	return
end

return var_0_0
