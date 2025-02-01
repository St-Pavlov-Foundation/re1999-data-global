module("modules.logic.versionactivity1_8.warmup.view.VersionActivity1_8WarmUpView", package.seeall)

slot0 = class("VersionActivity1_8WarmUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/LimitTime/#txt_LimitTime")
	slot0._goradiotaskitem = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	slot0._txtTaskTitle = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	slot0._txtTaskFMChannelNum = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	slot0._scrollTaskDesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	slot0._goTaskDescViewPort = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport")
	slot0._rectmask2D = slot0._goTaskDescViewPort:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._txtTaskContent = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	slot0._goTaskDescArrow = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/#go_arrow/arrow")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "Right/RawardPanel/#scroll_Reward")
	slot0._goWrongChannel = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	slot0._txtWrongChannel = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#go_WrongChannel/txt_WrongChannel")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	slot0._btngetreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/RawardPanel/#btn_getreward")
	slot0._isPlayingEpisodeDesc = false
	slot0._bottom = 324

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.OnClickFile, slot0._refreshWrongChannel, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._btngetreward:AddClickListener(slot0._btngetrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.OnClickFile, slot0._refreshWrongChannel, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._btngetreward:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._episodeItemTab = {}
	slot0._rewardItemTab = slot0:getUserDataTb_()
	slot0._goTaskScroll = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	slot0._goTaskContent = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	slot0._scrollCanvasGroup = gohelper.onceAddComponent(slot0._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	slot0._episodeCanGetInfoDict = {}
end

function slot0._btngetrewardOnClick(slot0)
	slot1 = slot0:getCurSelectedEpisode()

	if not (not Activity125Model.instance:isEpisodeFinished(slot0._actId, slot1) and Activity125Model.instance:checkLocalIsPlay(slot0._actId, slot1)) then
		return
	end

	slot0.viewContainer:setIsPlayingDesc(true)
	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(slot0._actId, slot1, Activity125Config.instance:getEpisodeConfig(slot0._actId, slot1).targetFrequency)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = ActivityEnum.Activity.Activity1_8WarmUp

	Activity125Controller.instance:getAct125InfoFromServer(slot0._actId)
end

function slot0.refreshUI(slot0)
	slot0:_refreshData()
	slot0:_showDeadline()
	slot0:_initEpisodeList()
	slot0:_initRewards()
	slot0:_initView()
	slot0:_checkPlayDesc()
end

function slot0._initView(slot0)
	slot3 = Activity125Model.instance:checkIsOldEpisode(slot0._actId, slot0:getCurSelectedEpisode())
	slot4 = not Activity125Model.instance:isEpisodeFinished(slot0._actId, slot0:getCurSelectedEpisode()) and Activity125Model.instance:checkLocalIsPlay(slot0._actId, slot0:getCurSelectedEpisode())

	for slot8, slot9 in pairs(slot0._rewardItemTab) do
		gohelper.setActive(slot9.gocanget, slot4)
		gohelper.setActive(slot9.goreceive, slot1 and not slot0.viewContainer:isPlayingDesc())
	end

	gohelper.setActive(slot0._btngetreward.gameObject, slot4)

	if slot1 or slot2 or slot3 then
		slot0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(slot0._goWrongChannel, false)
		gohelper.setActive(slot0._goTaskDescArrow, true)
	else
		slot0._rectmask2D.padding = Vector4(0, slot0._bottom, 0, 0)

		gohelper.setActive(slot0._goWrongChannel, true)
		gohelper.setActive(slot0._goTaskDescArrow, false)
	end
end

function slot0.getCurSelectedEpisode(slot0)
	return Activity125Model.instance:getSelectEpisodeId(slot0._actId)
end

function slot0._refreshData(slot0)
	slot1 = slot0:getCurSelectedEpisode()

	Activity125Model.instance:setHasCheckEpisode(slot0._actId, slot1)
	RedDotController.instance:dispatchEvent(RedDotEvent.RedDotEvent.UpdateActTag)

	slot2 = Activity125Config.instance:getEpisodeConfig(slot0._actId, slot1)
	slot0._txtTaskContent.text = slot2.text
	slot0._descHeight = slot0._txtTaskContent.preferredHeight
	slot0._txtTaskTitle.text = slot2.name

	recthelper.setAnchorY(slot0._txtTaskContent.transform, 0)
	gohelper.setActive(slot0._goWrongChannel, true)
	gohelper.setActive(slot0._goTaskDescArrow, false)
	slot0:_refreshWrongChannel()
end

function slot0._showDeadline(slot0)
	slot0:_showLeftTime()
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
end

function slot0._showLeftTime(slot0)
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
	slot2 = slot0:getCurSelectedEpisode()

	for slot6 = 1, Activity125Config.instance:getEpisodeCount(slot0._actId) do
		if not slot0._episodeItemTab[slot6] then
			slot7 = slot0:getUserDataTb_()
			slot7.episodeItemGo = gohelper.cloneInPlace(slot0._goradiotaskitem, "taskItem" .. slot6)
			slot8 = slot7.episodeItemGo
			slot7.txtDateUnSelected = gohelper.findChildText(slot8, "txt_DateUnSelected")
			slot7.goDateSelected = gohelper.findChild(slot8, "image_Selected")
			slot7.txtDateSelected = gohelper.findChildText(slot8, "image_Selected/txt_DateSelected")
			slot7.finishEffectGo = gohelper.findChild(slot8, "image_Selected/Wave_effect2")
			slot7.imagewave = gohelper.findChildImage(slot8, "image_Selected/image_wave")
			slot7.goDateLocked = gohelper.findChild(slot8, "image_Locked")
			slot7.goRed = gohelper.findChild(slot8, "#go_reddot")
			slot7.click = gohelper.findChildButton(slot8, "btn_click")

			slot7.click:AddClickListener(slot0._taskItemOnClick, slot0, slot6)

			slot0._episodeItemTab[slot6] = slot7
		end

		slot7.txtDateUnSelected.text = string.format("Day.%s", slot6)
		slot7.txtDateSelected.text = string.format("Day.%s", slot6)

		gohelper.setActive(slot7.episodeItemGo, true)

		slot8 = slot6 == slot2

		gohelper.setActive(slot7.goDateSelected, slot8)
		gohelper.setActive(slot7.txtDateUnSelected.gameObject, not slot8)

		slot9 = not Activity125Model.instance:isEpisodeReallyOpen(slot0._actId, slot6)

		gohelper.setActive(slot7.goDateLocked, slot9)
		gohelper.setActive(slot7.goRed, not slot9 and Activity125Model.instance:isFirstCheckEpisode(slot0._actId, slot6) or not Activity125Model.instance:isEpisodeFinished(slot0._actId, slot6) and Activity125Model.instance:checkLocalIsPlay(slot0._actId, slot6))
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goTaskContent.transform)

	if slot2 == slot0._selectId then
		return
	end

	slot0._selectId = slot2

	recthelper.setAnchorX(slot0._goTaskContent.transform, -math.min((slot2 - 1) * 166, math.max(recthelper.getWidth(slot0._goTaskContent.transform) - recthelper.getWidth(slot0._goTaskScroll.transform), 0)))
end

function slot0._taskItemOnClick(slot0, slot1)
	if slot0.viewContainer:isPlayingDesc() then
		return
	end

	slot2 = slot0:getCurSelectedEpisode()
	slot3, slot4 = Activity125Model.instance:isEpisodeDayOpen(slot0._actId, slot1)

	if not slot3 then
		GameFacade.showToast(ToastEnum.V1A8WarmupEpisodeNotOpen, slot4)

		return
	end

	if not Activity125Model.instance:isEpisodeUnLock(slot0._actId, slot1) then
		GameFacade.showToast(ToastEnum.V1A8WarmupEpisodeLock)

		return
	end

	if slot2 ~= slot1 then
		Activity125Model.instance:setSelectEpisodeId(slot0._actId, slot1)
		Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
		slot0:refreshUI()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._initRewards(slot0)
	slot0._rewardCount = #string.split(Activity125Config.instance:getEpisodeConfig(slot0._actId, slot0:getCurSelectedEpisode()).bonus, "|")

	for slot7 = 1, slot0._rewardCount do
		if not slot0._rewardItemTab[slot7] then
			slot8 = {
				go = gohelper.cloneInPlace(slot0._gorewarditem, "rewarditem" .. slot7)
			}
			slot8.icon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot8.go, "go_icon"))
			slot8.goreceive = gohelper.findChild(slot8.go, "go_receive")
			slot8.gocanget = gohelper.findChild(slot8.go, "go_canget")
			slot8.hasgetAnim = gohelper.findChild(slot8.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(slot0._rewardItemTab, slot8)
		end

		gohelper.setActive(slot0._rewardItemTab[slot7].go, true)

		slot9 = string.splitToNumber(slot3[slot7], "#")

		slot0._rewardItemTab[slot7].icon:setMOValue(slot9[1], slot9[2], slot9[3])
		slot0._rewardItemTab[slot7].icon:setCountFontSize(42)
		slot0._rewardItemTab[slot7].icon:setScale(0.5)
	end

	for slot7 = slot0._rewardCount + 1, #slot0._rewardItemTab do
		gohelper.setActive(slot0._rewardItemTab[slot7].go, false)
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
	slot0.viewContainer:setIsPlayingDesc(false)

	for slot6 = 1, slot0._rewardCount do
		gohelper.setActive(slot0._rewardItemTab[slot6].goreceive, true)
		slot0._rewardItemTab[slot6].hasgetAnim:Play(slot1 == uv0.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle", 0, 0)
	end
end

function slot0._onDailyRefresh(slot0)
	if slot0._actId then
		Activity125Controller.instance:getAct125InfoFromServer(slot0._actId)
	end
end

function slot0._checkPlayDesc(slot0)
	if Activity125Model.instance:checkIsOldEpisode(slot0._actId, slot0:getCurSelectedEpisode()) and not Activity125Model.instance:isEpisodeFinished(slot0._actId, slot0:getCurSelectedEpisode()) and not Activity125Model.instance:checkLocalIsPlay(slot0._actId, slot0:getCurSelectedEpisode()) then
		slot0:playDesc()
	end
end

function slot0.playDesc(slot0)
	if slot0.viewContainer:isPlayingDesc() then
		return
	end

	slot0.viewContainer:setIsPlayingDesc(true)

	slot0.desctime = Activity125Config.instance:getEpisodeConfig(slot0._actId, slot0:getCurSelectedEpisode()).time or 5

	slot0:_playEpisodeDesc(slot0.desctime, slot0._onPlayEpisodeDescFinished, slot0)

	slot0._scrollCanvasGroup.blocksRaycasts = false
end

function slot0._playEpisodeDesc(slot0, slot1, slot2, slot3)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, slot1, slot0.everyFrame, slot2, slot3, nil)
	slot4 = AudioParam.New()
	slot4.loopNum = 999

	AudioEffectMgr.instance:playAudio(AudioEnum.Warmup1_8.play_caption, slot4)
	gohelper.setActive(slot0._goWrongChannel, false)
	gohelper.setActive(slot0._goTaskDescArrow, true)
end

function slot0.everyFrame(slot0, slot1)
	slot0._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, slot0._bottom, slot1), 0, 0)
end

function slot0._onPlayEpisodeDescFinished(slot0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Warmup1_8.play_caption, 0.5)

	slot0._scrollCanvasGroup.blocksRaycasts = true

	slot0.viewContainer:setIsPlayingDesc(false)
	slot0:_checkIsPlayingButNoCompeleteDesc()

	if Activity125Model.instance:isEpisodeFinished(slot0._actId, slot0:getCurSelectedEpisode()) then
		return
	end

	Activity125Model.instance:setLocalIsPlay(slot0._actId, slot0:getCurSelectedEpisode())
	slot0:refreshUI()
end

function slot0._checkIsPlayingButNoCompeleteDesc(slot0)
	if slot0._descHeight - slot0._bottom > 0 then
		slot3 = slot1 * slot0.desctime / slot0._bottom

		if slot0._movetweenId then
			ZProj.TweenHelper.KillById(slot0._movetweenId)

			slot0._movetweenId = nil
		end

		slot0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._txtTaskContent.transform, slot1, slot3)
	end
end

function slot0.onClose(slot0)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Warmup1_8.play_caption)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._episodeItemTab then
		for slot4, slot5 in pairs(slot0._episodeItemTab) do
			slot5.click:RemoveClickListener()
		end
	end
end

function slot0._refreshWrongChannel(slot0)
	if slot0:getCurSelectedEpisode() == 1 and PlayerPrefsHelper.getNumber(PlayerPrefsKey.Act1_8WarmUpClickFile .. PlayerModel.instance:getMyUserId(), 0) == 0 then
		slot0._txtWrongChannel.text = luaLang("justreport_firsttips")
	else
		slot0._txtWrongChannel.text = luaLang("justreport_secondtips")
	end
end

return slot0
