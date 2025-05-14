module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeItem", package.seeall)

local var_0_0 = class("FeiLinShiDuoEpisodeItem", LuaCompBase)

function var_0_0.onInit(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goGet = gohelper.findChild(arg_1_0._go, "unlock/Reward/#go_Get")
	arg_1_0._gostagenormal = gohelper.findChild(arg_1_0._go, "unlock/#go_stagenormal")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0._go, "unlock/#btn_click")
	arg_1_0._btnGameClick = gohelper.findChildButtonWithAudio(arg_1_0._go, "unlock/#go_gameEpisode/#btn_gameClick")
	arg_1_0._gostar = gohelper.findChild(arg_1_0._go, "unlock/star/#go_star")
	arg_1_0._gostarIdle = gohelper.findChild(arg_1_0._go, "unlock/star/star_idle")
	arg_1_0._imageStar = gohelper.findChildImage(arg_1_0._go, "unlock/star/#go_star/#image_Star")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0._go, "unlock/#txt_stagename")
	arg_1_0._txtstageNum = gohelper.findChildText(arg_1_0._go, "unlock/#txt_stageNum")
	arg_1_0._goGameEpisode = gohelper.findChild(arg_1_0._go, "unlock/#go_gameEpisode")
	arg_1_0._goGameFinished = gohelper.findChild(arg_1_0._go, "unlock/#go_gameEpisode/#go_gameFinished")
	arg_1_0._goStageLock = gohelper.findChild(arg_1_0._go, "unlock/#go_stageLock")
	arg_1_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0._go)
	arg_1_0._animGamePlayer = SLFramework.AnimatorPlayer.Get(arg_1_0._goGameEpisode)
end

function var_0_0.setInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index = arg_2_1
	arg_2_0.actId = arg_2_2.activityId
	arg_2_0.episodeId = arg_2_2.episodeId
	arg_2_0.config = arg_2_2
	arg_2_0.preEpisodeId = arg_2_2.preEpisodeId

	arg_2_0:refreshUI()
end

function var_0_0.refreshUI(arg_3_0)
	arg_3_0._txtstagename.text = arg_3_0.config.name
	arg_3_0._txtstageNum.text = string.format("0%s", arg_3_0.index)

	arg_3_0:isShowItem(true)

	local var_3_0 = FeiLinShiDuoModel.instance:getEpisodeFinishState(arg_3_0.episodeId)

	arg_3_0.isUnlock = FeiLinShiDuoModel.instance:isUnlock(arg_3_0.actId, arg_3_0.episodeId)

	gohelper.setActive(arg_3_0._goStageLock, not arg_3_0.isUnlock)
	gohelper.setActive(arg_3_0._gostar, var_3_0)
	gohelper.setActive(arg_3_0._gostarIdle, var_3_0)

	if var_3_0 then
		arg_3_0._animPlayer:Play("finish_idle", nil, arg_3_0)
	end

	arg_3_0.gameEpisodeConfig = FeiLinShiDuoConfig.instance:getGameEpisode(arg_3_0.episodeId)

	gohelper.setActive(arg_3_0._goGameEpisode, var_3_0 and arg_3_0.gameEpisodeConfig)

	local var_3_1 = arg_3_0.gameEpisodeConfig and FeiLinShiDuoModel.instance:getEpisodeFinishState(arg_3_0.gameEpisodeConfig.episodeId)

	gohelper.setActive(arg_3_0._goGameFinished, var_3_0 and var_3_1)
end

function var_0_0.isShowItem(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._go, arg_4_1)
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0._btnclick:AddClickListener(arg_5_0._btnclickOnClick, arg_5_0)
	arg_5_0._btnGameClick:AddClickListener(arg_5_0._btnGameClickOnClick, arg_5_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, arg_5_0.playEpisodeItemFinishAnim, arg_5_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, arg_5_0.playEpisodeItemUnlockAnim, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0._btnclick:RemoveClickListener()
	arg_6_0._btnGameClick:RemoveClickListener()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, arg_6_0.playEpisodeItemFinishAnim, arg_6_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, arg_6_0.playEpisodeItemUnlockAnim, arg_6_0)
end

function var_0_0._btnclickOnClick(arg_7_0)
	if not arg_7_0:checkIsOpen() then
		return
	end

	FeiLinShiDuoModel.instance:setCurEpisodeId(arg_7_0.episodeId)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SelectEpisode, arg_7_0.index, arg_7_0.episodeId, false)
	FeiLinShiDuoStatHelper.instance:initEpisodeStartTime(arg_7_0.episodeId)
end

function var_0_0._btnGameClickOnClick(arg_8_0)
	if not arg_8_0:checkIsOpen() then
		return
	end

	FeiLinShiDuoModel.instance:setCurEpisodeId(arg_8_0.episodeId)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SelectEpisode, arg_8_0.index, arg_8_0.episodeId, true)
end

function var_0_0.checkIsOpen(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActMO(arg_9_0.actId)
	local var_9_1 = true

	if var_9_0 == nil then
		logError("not such activity id: " .. arg_9_0.actId)

		var_9_1 = false
	end

	if not var_9_0:isOpen() or var_9_0:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		var_9_1 = false
	end

	arg_9_0.isUnlock = FeiLinShiDuoModel.instance:isUnlock(arg_9_0.actId, arg_9_0.episodeId)

	if not arg_9_0.isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		var_9_1 = false
	end

	return var_9_1
end

function var_0_0.playEpisodeItemFinishAnim(arg_10_0, arg_10_1)
	arg_10_0.curFinishEpisodeId = arg_10_1
	arg_10_0.finishGameConfig = FeiLinShiDuoConfig.instance:getGameEpisode(arg_10_1)

	if arg_10_1 == arg_10_0.episodeId then
		gohelper.setActive(arg_10_0._gostar, true)
		arg_10_0._animPlayer:Play("finish", nil, arg_10_0)
		UIBlockMgr.instance:startBlock("FeiLinShiDuoEpisodeItemAnim")
		UIBlockMgrExtend.setNeedCircleMv(false)
		arg_10_0:playNextEpisodeShowAnim()

		if arg_10_1 == FeiLinShiDuoModel.instance:getLastEpisodeId() then
			FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SwitchBG, true)
		end

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_jinye_story_star)
	elseif arg_10_0.gameEpisodeConfig and arg_10_0.gameEpisodeConfig.episodeId == arg_10_1 then
		gohelper.setActive(arg_10_0._goGameEpisode, true)
		arg_10_0._animGamePlayer:Play("finish_idle", nil, arg_10_0)
		gohelper.setActive(arg_10_0._goGameFinished, true)
		arg_10_0:playNextEpisodeUnlockAnim()
	end
end

function var_0_0.playNextEpisodeShowAnim(arg_11_0)
	gohelper.setActive(arg_11_0._gostarIdle, true)

	if arg_11_0.finishGameConfig then
		gohelper.setActive(arg_11_0._goGameEpisode, true)
		arg_11_0._animGamePlayer:Play("open", arg_11_0.playGameShowAnimFinish, arg_11_0)
	else
		arg_11_0:playNextEpisodeUnlockAnim()
	end
end

function var_0_0.playNextEpisodeUnlockAnim(arg_12_0)
	arg_12_0._animPlayer:Play("finish_idle", nil, arg_12_0)

	local var_12_0 = FeiLinShiDuoConfig.instance:getNextEpisode(arg_12_0.curFinishEpisodeId)

	if var_12_0 then
		FeiLinShiDuoModel.instance:setCurEpisodeId(var_12_0.episodeId)
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, var_12_0.episodeId)
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_leimi_level_difficulty)
	else
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SwitchBG, false)
		UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.playGameShowAnimFinish(arg_13_0)
	UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.playEpisodeItemUnlockAnim(arg_14_0, arg_14_1)
	if arg_14_1 == arg_14_0.episodeId then
		arg_14_0._animPlayer:Play("unlock", arg_14_0.playUnlockAnimFinish, arg_14_0)
		gohelper.setActive(arg_14_0._goStageLock, false)
	end
end

function var_0_0.playUnlockAnimFinish(arg_15_0)
	UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroy(arg_16_0)
	return
end

return var_0_0
