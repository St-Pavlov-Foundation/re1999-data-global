module("modules.logic.main.view.MainThumbnailBgmView", package.seeall)

slot0 = class("MainThumbnailBgmView", BaseView)

function slot0.onInitView(slot0)
	slot0._goBgm = gohelper.findChild(slot0.viewGO, "#go_bgm")
	slot0._goNone = gohelper.findChild(slot0.viewGO, "#go_bgm/none")
	slot0._btnNoneBgm = gohelper.findChildButton(slot0.viewGO, "#go_bgm/none/#btn_nonebgm")
	slot0._goPlay0 = gohelper.findChild(slot0.viewGO, "#go_bgm/playing_0")
	slot0._btnPlay0Bgm = gohelper.findChildButton(slot0.viewGO, "#go_bgm/playing_0/#btn_play0bgm")
	slot0._btnPlay0Open = gohelper.findChildButton(slot0.viewGO, "#go_bgm/playing_0/#btn_play0open")
	slot0._goPlay1 = gohelper.findChild(slot0.viewGO, "#go_bgm/playing_1")
	slot0._play1Ani = slot0._goPlay1:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnPlay1Bgm = gohelper.findChildButton(slot0.viewGO, "#go_bgm/playing_1/#btn_play1bgm")
	slot0._txtPlay1BgmName = gohelper.findChildText(slot0.viewGO, "#go_bgm/playing_1/#txt_play1bgmname")
	slot0._btnPlay1Close = gohelper.findChildButton(slot0.viewGO, "#go_bgm/playing_1/#btn_play1close")
	slot0._goloop = gohelper.findChild(slot0.viewGO, "#go_bgm/playing_1/loop")
	slot0._goSingleLoop = gohelper.findChild(slot0.viewGO, "#go_bgm/playing_1/SingleLoop")
	slot0._btnPlay1Love = gohelper.findChildButton(slot0.viewGO, "#go_bgm/playing_1/#btn_play1love")
	slot0._goLoveSelect = gohelper.findChild(slot0.viewGO, "#go_bgm/playing_1/#btn_play1love/select")
	slot0._goLoveSelectEmpty = gohelper.findChild(slot0.viewGO, "#go_bgm/playing_1/#btn_play1love/empty")
	slot0._goReddot = gohelper.findChild(slot0.viewGO, "#go_bgm/bgm_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnNoneBgm:AddClickListener(slot0._btnNoneBgmOnClick, slot0)
	slot0._btnPlay0Bgm:AddClickListener(slot0._btnPlay0BgmOnClick, slot0)
	slot0._btnPlay0Open:AddClickListener(slot0._btnPlay0OpenOnClick, slot0)
	slot0._btnPlay1Bgm:AddClickListener(slot0._btnPlay1BgmOnClick, slot0)
	slot0._btnPlay1Close:AddClickListener(slot0._btnPlay1CloseOnClick, slot0)
	slot0._btnPlay1Love:AddClickListener(slot0._btnPlay1LoveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnNoneBgm:RemoveClickListener()
	slot0._btnPlay0Bgm:RemoveClickListener()
	slot0._btnPlay0Open:RemoveClickListener()
	slot0._btnPlay1Bgm:RemoveClickListener()
	slot0._btnPlay1Close:RemoveClickListener()
	slot0._btnPlay1Love:RemoveClickListener()
end

function slot0._btnNoneBgmOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1) then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		slot0:_clickToOpenBGMSwitchView()
	end
end

function slot0._btnPlay0BgmOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1) then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		slot0:_clickToOpenBGMSwitchView()
	end
end

function slot0._btnPlay0OpenOnClick(slot0)
	BGMSwitchModel.instance:setPlayingState(BGMSwitchEnum.PlayingState.UnfoldPlaying)
	slot0:_refreshView()
	BGMSwitchAudioTrigger.play_ui_replay_tinyopen()
end

function slot0._btnPlay1BgmOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1) then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		slot0:_clickToOpenBGMSwitchView()
	end
end

function slot0._btnPlay1CloseOnClick(slot0)
	BGMSwitchModel.instance:setPlayingState(BGMSwitchEnum.PlayingState.FoldPlaying)
	slot0._play1Ani:Play("close")
	TaskDispatcher.runDelay(slot0._refreshView, slot0, 0.34)
	BGMSwitchAudioTrigger.play_ui_replay_tinyclose()
end

function slot0._btnPlay1LoveOnClick(slot0)
	slot1, slot2 = slot0:getIdRandomAndNeedShowBgm()
	slot3 = slot2.id
	slot4 = not BGMSwitchModel.instance:isBgmFavorite(slot3)

	BgmRpc.instance:sendSetFavoriteBgmRequest(slot3, slot4)
	BGMSwitchAudioTrigger.play_ui_replay_heart(slot4)
end

function slot0._clickToOpenBGMSwitchView(slot0)
	slot0:_bgmMarkRead()
	BGMSwitchController.instance:openBGMSwitchView(true)
end

function slot0.getIdRandomAndNeedShowBgm(slot0)
	return BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId, BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(BGMSwitchController.instance:getMainBgmAudioId())
end

function slot0._refreshView(slot0)
	slot1 = BGMSwitchModel.instance:getPlayingState()

	gohelper.setActive(slot0._goNone, not BGMSwitchModel.instance:machineGearIsNeedPlayBgm() or slot1 == BGMSwitchEnum.PlayingState.None)
	gohelper.setActive(slot0._goPlay0, slot2 and slot1 == BGMSwitchEnum.PlayingState.FoldPlaying)
	gohelper.setActive(slot0._goPlay1, slot2 and slot1 == BGMSwitchEnum.PlayingState.UnfoldPlaying)

	if slot2 and slot1 == BGMSwitchEnum.PlayingState.UnfoldPlaying then
		slot3, slot4 = slot0:getIdRandomAndNeedShowBgm()

		gohelper.setActive(slot0._goloop, slot3)
		gohelper.setActive(slot0._goSingleLoop, not slot3)

		slot0._txtPlay1BgmName.text = slot4.audioName
		slot5 = BGMSwitchModel.instance:isBgmFavorite(slot4.id)

		gohelper.setActive(slot0._goLoveSelect, slot5)
		gohelper.setActive(slot0._goLoveSelectEmpty, not slot5)
	end
end

function slot0.onOpen(slot0)
	slot0.isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)

	if slot0.isUnlock then
		slot0:_addSelfEvents()
		slot0:_refreshView()
	end

	gohelper.setActive(slot0._goBgm, slot0.isUnlock)
end

function slot0._addSelfEvents(slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, slot0._refreshView, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, slot0._refreshView, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, slot0._refreshView, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, slot0._refreshView, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMSwitchClose, slot0._refreshView, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmMarkRead, slot0._bgmMarkRead, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.OnPlayMainBgm, slot0._onPlayMainBgm, slot0)
end

function slot0._removeSelfEvents(slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, slot0._refreshView, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, slot0._refreshView, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, slot0._refreshView, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, slot0._refreshView, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMSwitchClose, slot0._refreshView, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmMarkRead, slot0._bgmMarkRead, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.OnPlayMainBgm, slot0._onPlayMainBgm, slot0)
end

function slot0._editableInitView(slot0)
	slot0._redDotComp = RedDotController.instance:addNotEventRedDot(slot0._goReddot, slot0._isNotRead, slot0)
end

function slot0._onPlayMainBgm(slot0, slot1)
	slot0:_refreshView()
end

function slot0._bgmMarkRead(slot0)
	PlayerPrefsHelper.setNumber(BGMSwitchController.instance:getPlayerPrefKey(), BGMSwitchModel.instance:getUnReadCount())

	if slot0._redDotComp then
		slot0._redDotComp:refreshRedDot()
	end
end

function slot0._isNotRead(slot0)
	return BGMSwitchController.instance:hasBgmRedDot()
end

function slot0.onDestroyView(slot0)
	if slot0.isUnlock then
		TaskDispatcher.cancelTask(slot0._refreshView, slot0)
		slot0:_removeSelfEvents()
	end
end

return slot0
