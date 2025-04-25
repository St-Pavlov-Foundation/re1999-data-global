module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeItem", package.seeall)

slot0 = class("FeiLinShiDuoEpisodeItem", LuaCompBase)

function slot0.onInit(slot0, slot1)
	slot0._go = slot1
	slot0._goGet = gohelper.findChild(slot0._go, "unlock/Reward/#go_Get")
	slot0._gostagenormal = gohelper.findChild(slot0._go, "unlock/#go_stagenormal")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0._go, "unlock/#btn_click")
	slot0._btnGameClick = gohelper.findChildButtonWithAudio(slot0._go, "unlock/#go_gameEpisode/#btn_gameClick")
	slot0._gostar = gohelper.findChild(slot0._go, "unlock/star/#go_star")
	slot0._gostarIdle = gohelper.findChild(slot0._go, "unlock/star/star_idle")
	slot0._imageStar = gohelper.findChildImage(slot0._go, "unlock/star/#go_star/#image_Star")
	slot0._txtstagename = gohelper.findChildText(slot0._go, "unlock/#txt_stagename")
	slot0._txtstageNum = gohelper.findChildText(slot0._go, "unlock/#txt_stageNum")
	slot0._goGameEpisode = gohelper.findChild(slot0._go, "unlock/#go_gameEpisode")
	slot0._goGameFinished = gohelper.findChild(slot0._go, "unlock/#go_gameEpisode/#go_gameFinished")
	slot0._goStageLock = gohelper.findChild(slot0._go, "unlock/#go_stageLock")
	slot0._animPlayer = SLFramework.AnimatorPlayer.Get(slot0._go)
	slot0._animGamePlayer = SLFramework.AnimatorPlayer.Get(slot0._goGameEpisode)
end

function slot0.setInfo(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.actId = slot2.activityId
	slot0.episodeId = slot2.episodeId
	slot0.config = slot2
	slot0.preEpisodeId = slot2.preEpisodeId

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txtstagename.text = slot0.config.name
	slot0._txtstageNum.text = string.format("0%s", slot0.index)

	slot0:isShowItem(true)

	slot1 = FeiLinShiDuoModel.instance:getEpisodeFinishState(slot0.episodeId)
	slot0.isUnlock = FeiLinShiDuoModel.instance:isUnlock(slot0.actId, slot0.episodeId)

	gohelper.setActive(slot0._goStageLock, not slot0.isUnlock)
	gohelper.setActive(slot0._gostar, slot1)
	gohelper.setActive(slot0._gostarIdle, slot1)

	if slot1 then
		slot0._animPlayer:Play("finish_idle", nil, slot0)
	end

	slot0.gameEpisodeConfig = FeiLinShiDuoConfig.instance:getGameEpisode(slot0.episodeId)

	gohelper.setActive(slot0._goGameEpisode, slot1 and slot0.gameEpisodeConfig)
	gohelper.setActive(slot0._goGameFinished, slot1 and (slot0.gameEpisodeConfig and FeiLinShiDuoModel.instance:getEpisodeFinishState(slot0.gameEpisodeConfig.episodeId)))
end

function slot0.isShowItem(slot0, slot1)
	gohelper.setActive(slot0._go, slot1)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnGameClick:AddClickListener(slot0._btnGameClickOnClick, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, slot0.playEpisodeItemFinishAnim, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, slot0.playEpisodeItemUnlockAnim, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnGameClick:RemoveClickListener()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, slot0.playEpisodeItemFinishAnim, slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, slot0.playEpisodeItemUnlockAnim, slot0)
end

function slot0._btnclickOnClick(slot0)
	if not slot0:checkIsOpen() then
		return
	end

	FeiLinShiDuoModel.instance:setCurEpisodeId(slot0.episodeId)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SelectEpisode, slot0.index, slot0.episodeId, false)
	FeiLinShiDuoStatHelper.instance:initEpisodeStartTime(slot0.episodeId)
end

function slot0._btnGameClickOnClick(slot0)
	if not slot0:checkIsOpen() then
		return
	end

	FeiLinShiDuoModel.instance:setCurEpisodeId(slot0.episodeId)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SelectEpisode, slot0.index, slot0.episodeId, true)
end

function slot0.checkIsOpen(slot0)
	slot2 = true

	if ActivityModel.instance:getActMO(slot0.actId) == nil then
		logError("not such activity id: " .. slot0.actId)

		slot2 = false
	end

	if not slot1:isOpen() or slot1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		slot2 = false
	end

	slot0.isUnlock = FeiLinShiDuoModel.instance:isUnlock(slot0.actId, slot0.episodeId)

	if not slot0.isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		slot2 = false
	end

	return slot2
end

function slot0.playEpisodeItemFinishAnim(slot0, slot1)
	slot0.curFinishEpisodeId = slot1
	slot0.finishGameConfig = FeiLinShiDuoConfig.instance:getGameEpisode(slot1)

	if slot1 == slot0.episodeId then
		gohelper.setActive(slot0._gostar, true)
		slot0._animPlayer:Play("finish", nil, slot0)
		UIBlockMgr.instance:startBlock("FeiLinShiDuoEpisodeItemAnim")
		UIBlockMgrExtend.setNeedCircleMv(false)
		slot0:playNextEpisodeShowAnim()

		if slot1 == FeiLinShiDuoModel.instance:getLastEpisodeId() then
			FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SwitchBG, true)
		end

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_jinye_story_star)
	elseif slot0.gameEpisodeConfig and slot0.gameEpisodeConfig.episodeId == slot1 then
		gohelper.setActive(slot0._goGameEpisode, true)
		slot0._animGamePlayer:Play("finish_idle", nil, slot0)
		gohelper.setActive(slot0._goGameFinished, true)
		slot0:playNextEpisodeUnlockAnim()
	end
end

function slot0.playNextEpisodeShowAnim(slot0)
	gohelper.setActive(slot0._gostarIdle, true)

	if slot0.finishGameConfig then
		gohelper.setActive(slot0._goGameEpisode, true)
		slot0._animGamePlayer:Play("open", slot0.playGameShowAnimFinish, slot0)
	else
		slot0:playNextEpisodeUnlockAnim()
	end
end

function slot0.playNextEpisodeUnlockAnim(slot0)
	slot0._animPlayer:Play("finish_idle", nil, slot0)

	if FeiLinShiDuoConfig.instance:getNextEpisode(slot0.curFinishEpisodeId) then
		FeiLinShiDuoModel.instance:setCurEpisodeId(slot1.episodeId)
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, slot1.episodeId)
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_leimi_level_difficulty)
	else
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SwitchBG, false)
		UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function slot0.playGameShowAnimFinish(slot0)
	UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.playEpisodeItemUnlockAnim(slot0, slot1)
	if slot1 == slot0.episodeId then
		slot0._animPlayer:Play("unlock", slot0.playUnlockAnimFinish, slot0)
		gohelper.setActive(slot0._goStageLock, false)
	end
end

function slot0.playUnlockAnimFinish(slot0)
	UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onDestroy(slot0)
end

return slot0
