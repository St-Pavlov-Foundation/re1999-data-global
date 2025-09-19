module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiLevelItem", package.seeall)

local var_0_0 = class("WuErLiXiLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._anim = arg_1_0.go:GetComponent(gohelper.Type_Animator)
	arg_1_0._gostagenormal1 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal1")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal1/info/#txt_stageNum")
	arg_1_0._txtname1 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal1/info/#txt_stagename")
	arg_1_0._gostarno1 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal1/info/star1/no")
	arg_1_0._imagestarno1 = gohelper.findChildImage(arg_1_0.go, "unlock/#go_stagenormal1/info/star1/no")
	arg_1_0._gostar1 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal1/info/star1/#go_star")
	arg_1_0._goimagestar1 = gohelper.findChild(arg_1_0._gostar1, "#image_Star")
	arg_1_0._animStar1 = arg_1_0._goimagestar1:GetComponent(gohelper.Type_Animation)
	arg_1_0._gostagenormal2 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal2")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal2/info/#txt_stageNum")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.go, "unlock/#go_stagenormal2/info/#txt_stagename")
	arg_1_0._gostarno2 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal2/info/star1/no")
	arg_1_0._imagestarno2 = gohelper.findChildImage(arg_1_0.go, "unlock/#go_stagenormal2/info/star1/no")
	arg_1_0._gostar2 = gohelper.findChild(arg_1_0.go, "unlock/#go_stagenormal2/info/star1/#go_star")
	arg_1_0._goimagestar2 = gohelper.findChild(arg_1_0._gostar2, "#image_Star")
	arg_1_0._animStar2 = arg_1_0._goimagestar2:GetComponent(gohelper.Type_Animation)
	arg_1_0._gostageunlock = gohelper.findChild(arg_1_0.go, "unlock/#go_stageunlock")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "unlock/#btn_click")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
end

function var_0_0._btnOnClick(arg_3_0)
	if not arg_3_0._islvunlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	Activity180Rpc.instance:sendAct180EnterEpisodeRequest(arg_3_0._actId, arg_3_0.id, arg_3_0._startEpisodeFinished, arg_3_0)
end

function var_0_0._startEpisodeFinished(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_2 ~= 0 then
		return
	end

	if arg_4_3.activityId ~= arg_4_0._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(arg_4_3.episode)
	WuErLiXiModel.instance:setCurEpisodeIndex(arg_4_0._index)
	arg_4_0:_playBeforeStory()
end

function var_0_0._playBeforeStory(arg_5_0)
	arg_5_0._startTime = ServerTime.now()

	if WuErLiXiModel.instance:isEpisodePass(arg_5_0.id) then
		if arg_5_0._config.beforeStory > 0 then
			local var_5_0 = {}

			var_5_0.mark = true

			StoryController.instance:playStory(arg_5_0._config.beforeStory, var_5_0, arg_5_0._enterGame, arg_5_0)
		else
			arg_5_0:_enterGame()
		end

		return
	end

	if WuErLiXiModel.instance:getEpisodeStatus(arg_5_0.id) == WuErLiXiEnum.EpisodeStatus.BeforeStory then
		if arg_5_0._config.beforeStory > 0 then
			local var_5_1 = {}

			var_5_1.mark = true

			StoryController.instance:playStory(arg_5_0._config.beforeStory, var_5_1, arg_5_0._onBeforeStoryFinished, arg_5_0)
		else
			arg_5_0:_enterGame()
		end
	else
		arg_5_0:_enterGame()
	end
end

function var_0_0._onBeforeStoryFinished(arg_6_0)
	Activity180Rpc.instance:sendAct180StoryRequest(arg_6_0._actId, arg_6_0.id, arg_6_0._onStartUnlockBeforeStory, arg_6_0)
end

function var_0_0._onStartUnlockBeforeStory(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		return
	end

	if arg_7_3.activityId ~= arg_7_0._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(arg_7_3.episode)

	if arg_7_0._isStoryEpisode and arg_7_0._config.afterStory == 0 then
		WuErLiXiModel.instance:setNewFinishEpisode(arg_7_0.id)
	end

	arg_7_0:_enterGame()
end

function var_0_0._enterGame(arg_8_0)
	if WuErLiXiModel.instance:isEpisodePass(arg_8_0.id) then
		if not arg_8_0._isStoryEpisode then
			local var_8_0 = {
				episodeId = arg_8_0.id,
				callback = arg_8_0._enterAfterStory,
				callbackObj = arg_8_0
			}

			WuErLiXiController.instance:enterGameView(var_8_0)
		else
			arg_8_0:_enterAfterStory()
		end

		return
	end

	if WuErLiXiModel.instance:getEpisodeStatus(arg_8_0.id) == WuErLiXiEnum.EpisodeStatus.MapGame then
		local var_8_1 = {
			episodeId = arg_8_0.id,
			callback = arg_8_0._onGameFinished,
			callbackObj = arg_8_0
		}

		WuErLiXiController.instance:enterGameView(var_8_1)
	else
		arg_8_0:_enterAfterStory()
	end
end

function var_0_0._onGameFinished(arg_9_0)
	Activity180Rpc.instance:sendAct180GameFinishRequest(arg_9_0._actId, arg_9_0.id, arg_9_0._onStartUnlockGame, arg_9_0)
end

function var_0_0._onStartUnlockGame(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	if arg_10_3.activityId ~= arg_10_0._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(arg_10_3.episode)

	if arg_10_0._config.afterStory == 0 then
		WuErLiXiModel.instance:setNewFinishEpisode(arg_10_0.id)
	end

	arg_10_0:_enterAfterStory()
end

function var_0_0._enterAfterStory(arg_11_0)
	if WuErLiXiModel.instance:isEpisodePass(arg_11_0.id) then
		if arg_11_0._config.afterStory > 0 then
			StoryController.instance:playStory(arg_11_0._config.afterStory, nil, arg_11_0._levelFinished, arg_11_0)
		else
			arg_11_0:_levelFinished()
		end

		return
	end

	if WuErLiXiModel.instance:getEpisodeStatus(arg_11_0.id) == WuErLiXiEnum.EpisodeStatus.AfterStory then
		if arg_11_0._config.afterStory > 0 then
			local var_11_0 = {}

			var_11_0.mark = true

			StoryController.instance:playStory(arg_11_0._config.afterStory, var_11_0, arg_11_0._onAfterStoryFinished, arg_11_0)
		else
			arg_11_0:_levelFinished()
		end
	else
		arg_11_0:_levelFinished()
	end
end

function var_0_0._onAfterStoryFinished(arg_12_0)
	Activity180Rpc.instance:sendAct180StoryRequest(arg_12_0._actId, arg_12_0.id, arg_12_0._onStartUnlockAfterStory, arg_12_0)
end

function var_0_0._onStartUnlockAfterStory(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 ~= 0 then
		return
	end

	if arg_13_3.activityId ~= arg_13_0._actId then
		return
	end

	WuErLiXiModel.instance:updateEpisodeInfo(arg_13_3.episode)
	WuErLiXiModel.instance:setNewFinishEpisode(arg_13_0.id)
	arg_13_0:_levelFinished()
end

function var_0_0._levelFinished(arg_14_0)
	StatController.instance:track(StatEnum.EventName.WuErLiXiDungeonFinish, {
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_14_0.id),
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - arg_14_0._startTime
	})
	TaskDispatcher.runDelay(arg_14_0._backToLevel, arg_14_0, 0.5)
end

function var_0_0._backToLevel(arg_15_0)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnBackToLevel)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.EpisodeFinished)
end

function var_0_0.setParam(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._config = arg_16_1
	arg_16_0.id = arg_16_1.episodeId
	arg_16_0._actId = arg_16_3
	arg_16_0._index = arg_16_2
	arg_16_0._isStoryEpisode = arg_16_0._config.mapId == 0

	arg_16_0:refreshUI()
end

function var_0_0.refreshUI(arg_17_0)
	arg_17_0._islvunlock = WuErLiXiModel.instance:isEpisodeUnlock(arg_17_0.id)
	arg_17_0._islvpass = WuErLiXiModel.instance:isEpisodePass(arg_17_0.id)
	arg_17_0._txtname1.text = arg_17_0._config.name
	arg_17_0._txtname2.text = arg_17_0._config.name
	arg_17_0._txtnum1.text = "0" .. arg_17_0._index
	arg_17_0._txtnum2.text = "0" .. arg_17_0._index

	if not arg_17_0._islvunlock then
		arg_17_0._anim.enabled = true

		arg_17_0._anim:Play("lockidle", 0, 0)
	elseif not arg_17_0._islvpass then
		arg_17_0._anim.enabled = true

		arg_17_0._anim:Play("normalidle", 0, 0)
	else
		arg_17_0._anim:Play("finishidle", 0, 0)
	end

	gohelper.setActive(arg_17_0._gostagenormal1, arg_17_0._islvunlock and arg_17_0._isStoryEpisode)
	gohelper.setActive(arg_17_0._gostagenormal2, arg_17_0._islvunlock and not arg_17_0._isStoryEpisode)
end

function var_0_0.isUnlock(arg_18_0)
	return arg_18_0._islvunlock
end

function var_0_0.playFinish(arg_19_0)
	arg_19_0._anim.enabled = true

	arg_19_0._anim:Play("finish", 0, 0)
end

function var_0_0.playUnlock(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	gohelper.setActive(arg_20_0._gostagenormal1, arg_20_0._isStoryEpisode)
	gohelper.setActive(arg_20_0._gostagenormal2, not arg_20_0._isStoryEpisode)

	arg_20_0._anim.enabled = true

	arg_20_0._anim:Play("unlock", 0, 0)
end

function var_0_0.playStarAnim(arg_21_0)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function var_0_0.removeEventListeners(arg_22_0)
	arg_22_0._btnclick:RemoveClickListener()
end

function var_0_0.onDestroy(arg_23_0)
	return
end

return var_0_0
