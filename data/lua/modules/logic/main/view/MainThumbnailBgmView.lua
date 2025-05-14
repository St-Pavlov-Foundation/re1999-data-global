module("modules.logic.main.view.MainThumbnailBgmView", package.seeall)

local var_0_0 = class("MainThumbnailBgmView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBgm = gohelper.findChild(arg_1_0.viewGO, "#go_bgm")
	arg_1_0._goNone = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/none")
	arg_1_0._btnNoneBgm = gohelper.findChildButton(arg_1_0.viewGO, "#go_bgm/none/#btn_nonebgm")
	arg_1_0._goPlay0 = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/playing_0")
	arg_1_0._btnPlay0Bgm = gohelper.findChildButton(arg_1_0.viewGO, "#go_bgm/playing_0/#btn_play0bgm")
	arg_1_0._btnPlay0Open = gohelper.findChildButton(arg_1_0.viewGO, "#go_bgm/playing_0/#btn_play0open")
	arg_1_0._goPlay1 = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/playing_1")
	arg_1_0._play1Ani = arg_1_0._goPlay1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnPlay1Bgm = gohelper.findChildButton(arg_1_0.viewGO, "#go_bgm/playing_1/#btn_play1bgm")
	arg_1_0._txtPlay1BgmName = gohelper.findChildText(arg_1_0.viewGO, "#go_bgm/playing_1/#txt_play1bgmname")
	arg_1_0._btnPlay1Close = gohelper.findChildButton(arg_1_0.viewGO, "#go_bgm/playing_1/#btn_play1close")
	arg_1_0._goloop = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/playing_1/loop")
	arg_1_0._goSingleLoop = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/playing_1/SingleLoop")
	arg_1_0._btnPlay1Love = gohelper.findChildButton(arg_1_0.viewGO, "#go_bgm/playing_1/#btn_play1love")
	arg_1_0._goLoveSelect = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/playing_1/#btn_play1love/select")
	arg_1_0._goLoveSelectEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/playing_1/#btn_play1love/empty")
	arg_1_0._goReddot = gohelper.findChild(arg_1_0.viewGO, "#go_bgm/bgm_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnNoneBgm:AddClickListener(arg_2_0._btnNoneBgmOnClick, arg_2_0)
	arg_2_0._btnPlay0Bgm:AddClickListener(arg_2_0._btnPlay0BgmOnClick, arg_2_0)
	arg_2_0._btnPlay0Open:AddClickListener(arg_2_0._btnPlay0OpenOnClick, arg_2_0)
	arg_2_0._btnPlay1Bgm:AddClickListener(arg_2_0._btnPlay1BgmOnClick, arg_2_0)
	arg_2_0._btnPlay1Close:AddClickListener(arg_2_0._btnPlay1CloseOnClick, arg_2_0)
	arg_2_0._btnPlay1Love:AddClickListener(arg_2_0._btnPlay1LoveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnNoneBgm:RemoveClickListener()
	arg_3_0._btnPlay0Bgm:RemoveClickListener()
	arg_3_0._btnPlay0Open:RemoveClickListener()
	arg_3_0._btnPlay1Bgm:RemoveClickListener()
	arg_3_0._btnPlay1Close:RemoveClickListener()
	arg_3_0._btnPlay1Love:RemoveClickListener()
end

function var_0_0._btnNoneBgmOnClick(arg_4_0)
	local var_4_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local var_4_1 = GuideController.instance:isForbidGuides()
	local var_4_2 = GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1)

	if var_4_0 and not var_4_1 and not var_4_2 then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		arg_4_0:_clickToOpenBGMSwitchView()
	end
end

function var_0_0._btnPlay0BgmOnClick(arg_5_0)
	local var_5_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local var_5_1 = GuideController.instance:isForbidGuides()
	local var_5_2 = GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1)

	if var_5_0 and not var_5_1 and not var_5_2 then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		arg_5_0:_clickToOpenBGMSwitchView()
	end
end

function var_0_0._btnPlay0OpenOnClick(arg_6_0)
	BGMSwitchModel.instance:setPlayingState(BGMSwitchEnum.PlayingState.UnfoldPlaying)
	arg_6_0:_refreshView()
	BGMSwitchAudioTrigger.play_ui_replay_tinyopen()
end

function var_0_0._btnPlay1BgmOnClick(arg_7_0)
	local var_7_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local var_7_1 = GuideController.instance:isForbidGuides()
	local var_7_2 = GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1)

	if var_7_0 and not var_7_1 and not var_7_2 then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		arg_7_0:_clickToOpenBGMSwitchView()
	end
end

function var_0_0._btnPlay1CloseOnClick(arg_8_0)
	BGMSwitchModel.instance:setPlayingState(BGMSwitchEnum.PlayingState.FoldPlaying)
	arg_8_0._play1Ani:Play("close")
	TaskDispatcher.runDelay(arg_8_0._refreshView, arg_8_0, 0.34)
	BGMSwitchAudioTrigger.play_ui_replay_tinyclose()
end

function var_0_0._btnPlay1LoveOnClick(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:getIdRandomAndNeedShowBgm()
	local var_9_2 = var_9_1.id
	local var_9_3 = not BGMSwitchModel.instance:isBgmFavorite(var_9_2)

	BgmRpc.instance:sendSetFavoriteBgmRequest(var_9_2, var_9_3)
	BGMSwitchAudioTrigger.play_ui_replay_heart(var_9_3)
end

function var_0_0._clickToOpenBGMSwitchView(arg_10_0)
	arg_10_0:_bgmMarkRead()
	BGMSwitchController.instance:openBGMSwitchView(true)
end

function var_0_0.getIdRandomAndNeedShowBgm(arg_11_0)
	local var_11_0 = BGMSwitchController.instance:getMainBgmAudioId()
	local var_11_1 = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(var_11_0)

	return BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId, var_11_1
end

function var_0_0._refreshView(arg_12_0)
	local var_12_0 = BGMSwitchModel.instance:getPlayingState()
	local var_12_1 = BGMSwitchModel.instance:machineGearIsNeedPlayBgm()

	gohelper.setActive(arg_12_0._goNone, not var_12_1 or var_12_0 == BGMSwitchEnum.PlayingState.None)
	gohelper.setActive(arg_12_0._goPlay0, var_12_1 and var_12_0 == BGMSwitchEnum.PlayingState.FoldPlaying)
	gohelper.setActive(arg_12_0._goPlay1, var_12_1 and var_12_0 == BGMSwitchEnum.PlayingState.UnfoldPlaying)

	if var_12_1 and var_12_0 == BGMSwitchEnum.PlayingState.UnfoldPlaying then
		local var_12_2, var_12_3 = arg_12_0:getIdRandomAndNeedShowBgm()

		gohelper.setActive(arg_12_0._goloop, var_12_2)
		gohelper.setActive(arg_12_0._goSingleLoop, not var_12_2)

		arg_12_0._txtPlay1BgmName.text = var_12_3.audioName

		local var_12_4 = BGMSwitchModel.instance:isBgmFavorite(var_12_3.id)

		gohelper.setActive(arg_12_0._goLoveSelect, var_12_4)
		gohelper.setActive(arg_12_0._goLoveSelectEmpty, not var_12_4)
	end
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)

	if arg_13_0.isUnlock then
		arg_13_0:_addSelfEvents()
		arg_13_0:_refreshView()
	end

	gohelper.setActive(arg_13_0._goBgm, arg_13_0.isUnlock)
end

function var_0_0._addSelfEvents(arg_14_0)
	arg_14_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, arg_14_0._refreshView, arg_14_0)
	arg_14_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, arg_14_0._refreshView, arg_14_0)
	arg_14_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, arg_14_0._refreshView, arg_14_0)
	arg_14_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, arg_14_0._refreshView, arg_14_0)
	arg_14_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMSwitchClose, arg_14_0._refreshView, arg_14_0)
	arg_14_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmMarkRead, arg_14_0._bgmMarkRead, arg_14_0)
	arg_14_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.OnPlayMainBgm, arg_14_0._onPlayMainBgm, arg_14_0)
end

function var_0_0._removeSelfEvents(arg_15_0)
	arg_15_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, arg_15_0._refreshView, arg_15_0)
	arg_15_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, arg_15_0._refreshView, arg_15_0)
	arg_15_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, arg_15_0._refreshView, arg_15_0)
	arg_15_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, arg_15_0._refreshView, arg_15_0)
	arg_15_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMSwitchClose, arg_15_0._refreshView, arg_15_0)
	arg_15_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmMarkRead, arg_15_0._bgmMarkRead, arg_15_0)
	arg_15_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.OnPlayMainBgm, arg_15_0._onPlayMainBgm, arg_15_0)
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0._redDotComp = RedDotController.instance:addNotEventRedDot(arg_16_0._goReddot, arg_16_0._isNotRead, arg_16_0)
end

function var_0_0._onPlayMainBgm(arg_17_0, arg_17_1)
	arg_17_0:_refreshView()
end

function var_0_0._bgmMarkRead(arg_18_0)
	local var_18_0 = BGMSwitchModel.instance:getUnReadCount()

	PlayerPrefsHelper.setNumber(BGMSwitchController.instance:getPlayerPrefKey(), var_18_0)

	if arg_18_0._redDotComp then
		arg_18_0._redDotComp:refreshRedDot()
	end
end

function var_0_0._isNotRead(arg_19_0)
	return BGMSwitchController.instance:hasBgmRedDot()
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0.isUnlock then
		TaskDispatcher.cancelTask(arg_20_0._refreshView, arg_20_0)
		arg_20_0:_removeSelfEvents()
	end
end

return var_0_0
