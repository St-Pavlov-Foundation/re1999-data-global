module("modules.logic.versionactivity1_6.v1a6_warmup.view.VersionActivity1_6WarmUpView", package.seeall)

slot0 = class("VersionActivity1_6WarmUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/LimitTime/#txt_LimitTime")
	slot0._scrollTaskTabList = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	slot0._goradiotaskitem = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	slot0._txtTaskTitle = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/Title/#txt_TaskTitle")
	slot0._txtTaskFMChannelNum = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	slot0._scrollTaskDesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	slot0._goTaskDescViewPort = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport")
	slot0._rectmask2D = slot0._goTaskDescViewPort:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._txtTaskContent = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "Right/RawardPanel/#scroll_Reward")
	slot0._goWrongChannel = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Middle/titlebg/#txt_title")
	slot0._btnplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#btn_play")
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#btn_replay")
	slot0._btngetreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/RawardPanel/#btn_getreward")
	slot0._goMiddle = gohelper.findChildSingleImage(slot0.viewGO, "Middle")
	slot0._txtmusictime = gohelper.findChildText(slot0.viewGO, "Middle/#go_playing/#txt_time")
	slot0._middleAnim = slot0._goMiddle:GetComponent(typeof(UnityEngine.Animator))
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._isPlayingEpisodeDesc = false
	slot0.isGetingReward = false
	slot0._isReselectCloseFunc = false
	slot0._bottom = 400

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity156Controller.instance:registerCallback(Activity156Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._btnplay:AddClickListener(slot0._playSong, slot0)
	slot0._btnreplay:AddClickListener(slot0._playSong, slot0)
	slot0._btngetreward:AddClickListener(slot0._btngetrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	Activity156Controller.instance:unregisterCallback(Activity156Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._btnplay:RemoveClickListener()
	slot0._btnreplay:RemoveClickListener()
	slot0._btngetreward:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._episodeItemTab = {}
	slot0._rewardItemTab = slot0:getUserDataTb_()
	slot0._goTaskContent = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	slot0._scrollCanvasGroup = gohelper.onceAddComponent(slot0._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	slot0._goTaskScrollArrow = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/gameobject")
	slot0._episodeCanGetInfoDict = {}
end

function slot0._btngetrewardOnClick(slot0)
	Activity156Controller.instance:tryReceiveEpisodeRewards(slot0._actId)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = ActivityEnum.Activity.Activity1_6WarmUp
	slot0._config = Activity156Config.instance:getAct156Config(slot0._actId)

	Activity156Controller.instance:getAct125InfoFromServer(slot0._actId)
end

function slot0.refreshUI(slot0)
	slot0:_refreshData()
	slot0:_showDeadline()
	slot0:_initEpisodeList()
	slot0:_initRewards()
	slot0:_initView()
end

function slot0._initView(slot0)
	if Activity156Model.instance:checkLocalIsPlay(slot0._curSelectedLvId) then
		if Activity156Model.instance:isEpisodeHasReceivedReward(slot0._curSelectedLvId) then
			for slot6, slot7 in pairs(slot0._rewardItemTab) do
				gohelper.setActive(slot7.gocanget, false)
			end
		else
			for slot6, slot7 in pairs(slot0._rewardItemTab) do
				gohelper.setActive(slot7.gocanget, true)
			end

			gohelper.setActive(slot0._btngetreward.gameObject, true)
		end
	else
		gohelper.setActive(slot0._btngetreward.gameObject, false)
	end

	if slot1 or slot2 then
		slot0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(slot0._goWrongChannel, false)
		gohelper.setActive(slot0._goTaskScrollArrow, true)
	else
		slot0._rectmask2D.padding = Vector4(0, slot0._bottom, 0, 0)

		gohelper.setActive(slot0._goWrongChannel, true)
		gohelper.setActive(slot0._goTaskScrollArrow, false)
	end

	gohelper.setActive(slot0._btnreplay.gameObject, slot2)
	gohelper.setActive(slot0._btnplay.gameObject, not slot2)
end

function slot0._refreshData(slot0)
	slot0._curSelectedLvId = Activity156Model.instance:getCurSelectedEpisode()

	if not slot0._curSelectedLvId then
		slot0._curSelectedLvId = Activity156Model.instance:getLastEpisode()

		Activity156Model.instance:setCurSelectedEpisode(slot0._curSelectedLvId)
	end

	slot1 = Activity156Config.instance:getEpisodeConfig(slot0._curSelectedLvId)
	slot0._descHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(slot0._txtTaskContent, slot1.text)
	slot0._txtTaskContent.text = slot1.text
	slot0._txtTitle.text = Activity156Config.instance:getEpisodeConfig(slot0._curSelectedLvId).name

	recthelper.setAnchorY(slot0._txtTaskContent.transform, 0)
	gohelper.setActive(slot0._goWrongChannel, true)
	gohelper.setActive(slot0._goTaskScrollArrow, false)
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 60)
end

function slot0._onRefreshDeadline(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0._actId)
end

slot0.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function slot0._initEpisodeList(slot0)
	for slot5 = 1, Activity156Config.instance:getEpisodeCount(slot0._actId) do
		if not slot0._episodeItemTab[slot5] then
			slot6 = slot0:getUserDataTb_()
			slot6.episodeItemGo = gohelper.cloneInPlace(slot0._goradiotaskitem, "taskItem" .. slot5)
			slot7 = slot6.episodeItemGo
			slot6.txtDateUnSelected = gohelper.findChildText(slot7, "txt_DateUnSelected")
			slot6.goDateSelected = gohelper.findChild(slot7, "image_Selected")
			slot6.txtDateSelected = gohelper.findChildText(slot7, "image_Selected/txt_DateSelected")
			slot6.finishEffectGo = gohelper.findChild(slot7, "image_Selected/Wave_effect2")
			slot6.imagewave = gohelper.findChildImage(slot7, "image_Selected/image_wave")
			slot6.goDateLocked = gohelper.findChild(slot7, "image_Locked")
			slot6.click = gohelper.findChildButton(slot7, "btn_click")

			slot6.click:AddClickListener(slot0._taskItemOnClick, slot0, slot5)

			slot0._episodeItemTab[slot5] = slot6
		end

		slot6.txtDateUnSelected.text = string.format("Day.%s", slot5)
		slot6.txtDateSelected.text = string.format("Day.%s", slot5)

		gohelper.setActive(slot6.episodeItemGo, true)

		slot7 = slot5 == slot0._curSelectedLvId

		gohelper.setActive(slot6.goDateSelected, slot7)
		gohelper.setActive(slot6.txtDateUnSelected.gameObject, not slot7)
		gohelper.setActive(slot6.goDateLocked, not Activity156Model.instance:reallyOpen(slot0._actId, slot5))
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goTaskContent.transform)

	slot0._scrollTaskTabList.horizontalNormalizedPosition = slot0:_getScrollTargetValue(1, slot1, slot0._curSelectedLvId)
end

function slot0._getScrollTargetValue(slot0, slot1, slot2, slot3)
	if slot3 == 1 then
		return 0
	end

	return 1 / (slot2 - slot1) * (slot3 - slot1)
end

function slot0._taskItemOnClick(slot0, slot1)
	slot2 = Activity156Model.instance:getCurSelectedEpisode()
	slot3 = Activity156Model.instance:isEpisodeUnLock(slot1)

	if not Activity156Model.instance:isOpen(slot0._actId, slot1) then
		return
	end

	function slot0._switchCallBack()
		TaskDispatcher.cancelTask(uv0._switchCallBack, uv0)

		uv0._txtTitle.text = Activity156Config.instance:getEpisodeConfig(uv0._curSelectedLvId).name

		uv0:refreshUI()
	end

	if slot2 ~= slot1 and slot3 then
		slot0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(slot0._switchCallBack, slot0, 0.3)
	end

	Activity156Controller.instance:setCurSelectedEpisode(slot1, true)

	if not Activity156Model.instance:checkIsPlayingMusicId(slot1) then
		slot0:_initMusic()
		slot0._middleAnim:Play("idle", 0, 0)
	end

	if slot0._isReselectCloseFunc then
		slot0:_revertViewCloseCheckFunc()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._initRewards(slot0)
	slot0._rewardCount = #string.split(slot0._config[slot0._curSelectedLvId].bonus, "|")

	for slot6 = 1, slot0._rewardCount do
		if not slot0._rewardItemTab[slot6] then
			slot7 = {
				go = gohelper.cloneInPlace(slot0._gorewarditem, "rewarditem" .. slot6)
			}
			slot7.icon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot7.go, "go_icon"))
			slot7.goreceive = gohelper.findChild(slot7.go, "go_receive")
			slot7.gocanget = gohelper.findChild(slot7.go, "go_canget")
			slot7.hasgetAnim = gohelper.findChild(slot7.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(slot0._rewardItemTab, slot7)
		end

		gohelper.setActive(slot0._rewardItemTab[slot6].go, true)

		if Activity156Model.instance:isEpisodeHasReceivedReward(slot0._curSelectedLvId) then
			gohelper.setActive(slot0._rewardItemTab[slot6].goreceive, true)
		else
			gohelper.setActive(slot0._rewardItemTab[slot6].goreceive, Activity156Model.instance:isEpisodeFinished(slot0._curSelectedLvId) and not slot0.isGetingReward)
		end

		slot8 = string.splitToNumber(slot2[slot6], "#")

		slot0._rewardItemTab[slot6].icon:setMOValue(slot8[1], slot8[2], slot8[3])
		slot0._rewardItemTab[slot6].icon:setCountFontSize(42)
		slot0._rewardItemTab[slot6].icon:setScale(0.5)
	end

	for slot6 = slot0._rewardCount + 1, #slot0._rewardItemTab do
		gohelper.setActive(slot0._rewardItemTab[slot6].go, false)
	end
end

function slot0._onRewardRefresh(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		for slot5, slot6 in pairs(slot0._rewardItemTab) do
			gohelper.setActive(slot6.gocanget, false)
		end

		slot0:_onGetRewardAnim(uv0.AnimSwitchMode.UnFinish2Finish)
	end
end

function slot0._onGetRewardAnim(slot0, slot1)
	for slot6 = 1, slot0._rewardCount do
		gohelper.setActive(slot0._rewardItemTab[slot6].goreceive, true)
		slot0._rewardItemTab[slot6].hasgetAnim:Play(slot1 == uv0.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle", 0, 0)
	end

	slot0.isGetingReward = false
end

function slot0._onDailyRefresh(slot0)
	if slot0._actId then
		Activity156Controller.instance:getAct125InfoFromServer(slot0._actId)
	end
end

function slot0._messageBoxYesFunc(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function slot0._checkIsPlayingDesc(slot0)
	if slot0._isPlayingEpisodeDesc and not Activity156Model.instance:checkLocalIsPlay(slot0._curSelectedLvId) then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5_WarmUpPlayingQuitCheck, MsgBoxEnum.BoxType.Yes_No, slot0._messageBoxYesFunc, nil, , slot0, slot0)
	end
end

function slot0._overrideViewCloseCheckFunc(slot0)
	if ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView) and slot1.navigationView then
		slot0._originCloseCheckFunc = slot2._closeCheckFunc
		slot0._originCloseCheckObj = slot2._closeCheckObj
		slot0._originHomeCheckFunc = slot2._homeCheckFunc
		slot0._originHomeCheckObj = slot2._homeCheckObj

		slot2:setCloseCheck(slot0._checkIsPlayingDesc, slot0)
		slot2:setHomeCheck(slot0._checkIsPlayingDesc, slot0)
	end

	slot0._isReselectCloseFunc = true
end

function slot0._revertViewCloseCheckFunc(slot0)
	if ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView) and slot1.navigationView then
		slot2:setCloseCheck(slot0._originCloseCheckFunc, slot0._originCloseCheckObj)
		slot2:setHomeCheck(slot0._originHomeCheckFunc, slot0._originHomeCheckObj)
	end

	slot0._originCloseCheckFunc = nil
	slot0._originCloseCheckObj = nil
	slot0._originHomeCheckFunc = nil
	slot0._originHomeCheckObj = nil
	slot0._isReselectCloseFunc = false
end

function slot0._playSong(slot0)
	if Activity156Model.instance:checkIsPlayingMusicId(slot0._curSelectedLvId) then
		return
	end

	slot1 = Activity156Config.instance:getEpisodeConfig(slot0._curSelectedLvId)
	slot2 = Activity156Enum.DayToMusic[slot0._curSelectedLvId]

	slot0:_initMusic()

	if not Activity156Model.instance:checkLocalIsPlay(slot0._curSelectedLvId) then
		slot0:_overrideViewCloseCheckFunc()
	end

	slot0.playaudioId = AudioMgr.instance:trigger(slot2)

	Activity156Model.instance:setIsPlayingMusicId(slot0._curSelectedLvId)

	slot0.desctime = slot1.time
	slot0.musictime = slot1.musictime or 10
	slot0._txtmusictime.text = formatLuaLang("VersionActivity1_6WarmUpView_musictime", slot0.musictime)

	slot0:_playEpisodeDesc(slot0.desctime, slot0._onPlayEpisodeDescFinished, slot0)

	slot0._scrollCanvasGroup.blocksRaycasts = false

	TaskDispatcher.runDelay(slot0._playsongcallback, slot0, slot0.musictime)
	slot0._middleAnim:Update(0)
	slot0._middleAnim:Play("play", 0, 0)
	TaskDispatcher.runRepeat(slot0._remainMusicTime, slot0, 1, slot0.musictime)
end

function slot0._remainMusicTime(slot0)
	slot0.musictime = slot0.musictime - 1
	slot0._txtmusictime.text = formatLuaLang("VersionActivity1_6WarmUpView_musictime", slot0.musictime)

	if slot0.musictime == 0 then
		TaskDispatcher.cancelTask(slot0._remainMusicTime, slot0)

		return
	end
end

function slot0._playsongcallback(slot0)
	slot0._middleAnim:Play("close", 0, 0)
	slot0:_initMusic()
end

function slot0._onPlayEpisodeDescFinished(slot0)
	slot0._scrollCanvasGroup.blocksRaycasts = true
	slot0._isPlayingEpisodeDesc = false

	slot0:_revertViewCloseCheckFunc()
	slot0:_checkIsPlayingButNoCompeleteDesc()

	if Activity156Model.instance:isEpisodeHasReceivedReward(slot0._curSelectedLvId) then
		return
	end

	slot0.isGetingReward = true
	slot4 = slot0._curSelectedLvId

	Activity156Model.instance:setLocalIsPlay(slot4)

	for slot4, slot5 in pairs(slot0._rewardItemTab) do
		gohelper.setActive(slot5.gocanget, true)
	end

	Activity156Controller.instance:setCurSelectedEpisode(slot0._curSelectedLvId)
	gohelper.setActive(slot0._btngetreward.gameObject, true)
	gohelper.setActive(slot0._btnreplay.gameObject, true)
end

function slot0._playEpisodeDesc(slot0, slot1, slot2, slot3)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, slot1, slot0.everyFrame, slot2, slot3, nil)

	gohelper.setActive(slot0._goWrongChannel, false)

	slot0._isPlayingEpisodeDesc = true
end

function slot0.everyFrame(slot0, slot1)
	slot0._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, slot0._bottom, slot1), 0, 0)
end

function slot0._checkIsPlayingButNoCompeleteDesc(slot0)
	if slot0.playaudioId and slot0._descHeight - slot0._bottom > 0 then
		slot3 = slot1 * slot0.desctime / slot0._bottom

		if slot0._movetweenId then
			ZProj.TweenHelper.KillById(slot0._movetweenId)

			slot0._movetweenId = nil
		end

		slot0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._txtTaskContent.transform, slot1, slot3)

		gohelper.setActive(slot0._goTaskScrollArrow, true)
	end
end

function slot0._initMusic(slot0)
	if slot0.playaudioId then
		slot0:_stopAudio()

		slot0.playaudioId = nil

		if slot0._playsongcallback then
			TaskDispatcher.cancelTask(slot0._playsongcallback, slot0)

			slot0._playsongcallback = nil
		end

		if slot0._tweenId then
			ZProj.TweenHelper.KillById(slot0._tweenId)

			slot0._tweenId = nil
		end

		if slot0._movetweenId then
			ZProj.TweenHelper.KillById(slot0._movetweenId)

			slot0._movetweenId = nil
		end

		Activity156Model.instance:cleanIsPlayingMusicId()

		slot0._scrollCanvasGroup.blocksRaycasts = true

		TaskDispatcher.cancelTask(slot0._remainMusicTime, slot0)
	end
end

function slot0.onClose(slot0)
	Activity156Model.instance:cleanCurSelectedEpisode()
	Activity156Model.instance:cleanIsPlayingMusicId()
	slot0:_initMusic()
	slot0:_revertViewCloseCheckFunc()
end

function slot0._stopAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_andamtte1_6_music.stop_ui_andamtte1_6_music)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._switchCallBack, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._playsongcallback, slot0)
	TaskDispatcher.cancelTask(slot0._remainMusicTime, slot0)

	if slot0._episodeItemTab then
		for slot4, slot5 in pairs(slot0._episodeItemTab) do
			slot5.click:RemoveClickListener()

			slot5 = nil
		end
	end

	slot0._config = nil
end

return slot0
