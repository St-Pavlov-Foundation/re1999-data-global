module("modules.logic.versionactivity1_9.warmup.view.VersionActivity1_9WarmUpView", package.seeall)

slot0 = class("VersionActivity1_9WarmUpView", BaseView)
slot0.UI_CLICK_BLOCK_KEY = "VersionActivity1_9WarmUpView_UI_CLICK_BLOCK_KEY"

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "Middle/#go_start")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "Middle/#go_start/#simage_bg")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "Middle/#go_start/#go_drag")
	slot0._goscepter = gohelper.findChild(slot0.viewGO, "Middle/#go_start/#go_scepter")
	slot0._goguide = gohelper.findChild(slot0.viewGO, "Middle/#go_start/#go_guide")
	slot0._simageday = gohelper.findChildSingleImage(slot0.viewGO, "Middle/#simage_day")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/LimitTime/#txt_LimitTime")
	slot0._scrollTaskTabList = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	slot0._goradiotaskitem = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem/#go_reddot")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#go_Title")
	slot0._txtTaskTitle = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	slot0._scrollTaskDesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	slot0._txtTaskContent = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	slot0._goWrongChannel = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "Right/RawardPanel/#scroll_Reward")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	slot0._btngetreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/RawardPanel/#btn_getreward")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngetreward:AddClickListener(slot0._btngetrewardOnClick, slot0)
	slot0:_addEvents()
end

function slot0.removeEvents(slot0)
	slot0._btngetreward:RemoveClickListener()
	slot0:_removeEvents()
end

function slot0._editableInitView(slot0)
	slot0._episodeItemTab = {}
	slot0._rewardItemTab = slot0:getUserDataTb_()
	slot0._goTaskScroll = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	slot0._goTaskContent = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	slot0._scrollCanvasGroup = gohelper.onceAddComponent(slot0._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	slot0._episodeCanGetInfoDict = {}
	slot0._rectmask2D = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag.gameObject)
	slot0._bottom = 324
	slot2 = gohelper.findChild(slot0.viewGO, "Middle")
	slot0._animView = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._animPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._animScepter = slot2:GetComponent(typeof(UnityEngine.Animator))
	slot0._animScepterPlayer = SLFramework.AnimatorPlayer.Get(slot2)
	slot0._animDayIcon = slot0._simageday.gameObject:GetComponent(typeof(UnityEngine.Animator))
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

	slot0._actId = slot0.viewParam.actId

	Activity125Controller.instance:getAct125InfoFromServer(slot0._actId)
	slot0._animView:Play("in", 0, 0)

	slot0._isPlayScepterAnim = false

	slot0:_checkGuide()
end

function slot0.refreshUI(slot0)
	slot0:_refreshData()
	slot0:_showDeadline()
	slot0:_initEpisodeList()
	slot0:_initRewards()
	slot0:_initView()
	slot0:_checkPlayDesc()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._animEventWrap:AddEventListener("switch", slot0._playSwitchAnimRefreshView, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._animEventWrap:RemoveAllEventListener()
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
	else
		slot0._rectmask2D.padding = Vector4(0, slot0._bottom, 0, 0)

		gohelper.setActive(slot0._goWrongChannel, true)
	end

	slot0:_activeScepter(slot5)
end

function slot0.getCurSelectedEpisode(slot0)
	return Activity125Model.instance:getSelectEpisodeId(slot0._actId)
end

function slot0._refreshData(slot0)
	slot2 = Activity125Config.instance:getEpisodeConfig(slot0._actId, slot0:getCurSelectedEpisode())
	slot0._txtTaskContent.text = slot2.text
	slot0._descHeight = slot0._txtTaskContent.preferredHeight
	slot0._txtTaskTitle.text = slot2.name

	recthelper.setAnchorY(slot0._txtTaskContent.transform, 0)
	gohelper.setActive(slot0._goWrongChannel, true)
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
		gohelper.setActive(slot7.goDateLocked, not Activity125Model.instance:isEpisodeReallyOpen(slot0._actId, slot6))
		gohelper.setActive(slot7.goRed, Activity125Model.instance:isEpisodeReallyOpen(slot0._actId, slot6) and Activity125Model.instance:isHasEpisodeCanReceiveReward(slot0._actId, slot6))
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goTaskContent.transform)

	if slot2 == slot0._selectId then
		return
	end

	slot0._selectId = slot2

	recthelper.setAnchorX(slot0._goTaskContent.transform, -math.min((slot2 - 1) * 166, math.max(recthelper.getWidth(slot0._goTaskContent.transform) - recthelper.getWidth(slot0._goTaskScroll.transform), 0)))
end

function slot0._taskItemOnClick(slot0, slot1)
	if slot0.viewContainer:isPlayingDesc() or slot0._isPlayScepterAnim then
		return
	end

	slot2 = slot0:getCurSelectedEpisode()
	slot3, slot4 = Activity125Model.instance:isEpisodeDayOpen(slot0._actId, slot1)

	if not slot3 then
		GameFacade.showToast(ToastEnum.V1A7WarmupDayLock, slot4)

		return
	end

	if not Activity125Model.instance:isEpisodeUnLock(slot0._actId, slot1) then
		GameFacade.showToast(ToastEnum.V1A9WarmupPreEpisodeLock)

		return
	end

	if slot2 ~= slot1 then
		UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)
		slot0:_playDescFinish()
		Activity125Model.instance:setSelectEpisodeId(slot0._actId, slot1)
		slot0._animPlayer:Play("switch", slot0._playSwitchAnimFinish, slot0)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:_checkGuide()
end

function slot0._playSwitchAnimFinish(slot0)
	slot0._animView:Play("idle", 0, 0)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0._playSwitchAnimRefreshView(slot0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
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

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)
end

function slot0._playEpisodeDesc(slot0, slot1, slot2, slot3)
	slot0:_onKillTween()

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, slot1, slot0.everyFrame, slot2, slot3, nil)

	gohelper.setActive(slot0._goWrongChannel, false)
end

function slot0.everyFrame(slot0, slot1)
	slot0._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, slot0._bottom, slot1), 0, 0)
end

function slot0._onPlayEpisodeDescFinished(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	slot0:_checkIsPlayingButNoCompeleteDesc()
	slot0.viewContainer:setIsPlayingDesc(false)

	if Activity125Model.instance:isEpisodeFinished(slot0._actId, slot0:getCurSelectedEpisode()) then
		return
	end

	Activity125Model.instance:setLocalIsPlay(slot0._actId, slot0:getCurSelectedEpisode())
	slot0:refreshUI()
	Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeUnlock)
end

function slot0._checkIsPlayingButNoCompeleteDesc(slot0)
	if slot0._descHeight - slot0._bottom > 0 then
		slot3 = slot1 * slot0.desctime / slot0._bottom

		if slot0._movetweenId then
			ZProj.TweenHelper.KillById(slot0._movetweenId)

			slot0._movetweenId = nil
		end

		slot0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._txtTaskContent.transform, slot1, slot3, slot0._playDescFinish, slot0)
	end
end

function slot0._playDescFinish(slot0)
	slot0._scrollCanvasGroup.blocksRaycasts = true

	if slot0._movetweenId then
		ZProj.TweenHelper.KillById(slot0._movetweenId)

		slot0._movetweenId = nil
	end
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_gudu_preheat)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	slot0:_onKillTween()

	if slot0._episodeItemTab then
		for slot4, slot5 in pairs(slot0._episodeItemTab) do
			slot5.click:RemoveClickListener()
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	slot0._simageday:UnLoadImage()
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot2.position.x - slot0.startDragPosX < 0 then
		slot0:checkFinishEpisode(slot0._actId, slot0:getCurSelectedEpisode())
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0.startDragPosX = slot2.position.x
end

function slot0._onKillTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.checkFinishEpisode(slot0, slot1, slot2)
	if not Activity125Model.instance:isEpisodeReallyOpen(slot1, slot2) then
		return
	end

	if (Activity125Model.instance:checkIsOldEpisode(slot1, slot2) or Activity125Model.instance:checkLocalIsPlay(slot1, slot2) or Activity125Model.instance:isEpisodeFinished(slot1, slot2)) and Activity125Model.instance:getSelectEpisodeId(slot1) == slot2 then
		return
	end

	Activity125Model.instance:setSelectEpisodeId(slot1, slot2)

	if not slot5 then
		Activity125Model.instance:setOldEpisode(slot1, slot2)
	end

	slot0:_playScepterAnim()
end

function slot0._playScepterAnim(slot0)
	slot0._isPlayScepterAnim = true

	gohelper.setActive(slot0._goguide, false)
	slot0._animScepterPlayer:Play("day_0" .. slot0:getCurSelectedEpisode(), slot0._playScepterAnimFinish, slot0)
	gohelper.setActive(slot0._goguide, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_preheat)
end

function slot0._playScepterAnimFinish(slot0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
	slot0:_activeScepter(true)

	slot0._isPlayScepterAnim = false
end

function slot0._activeScepter(slot0, slot1)
	if slot1 then
		slot0._simageday:LoadImage(ResUrl.getV1a9WarmUpSingleBg(slot0:getCurSelectedEpisode()))
	end

	gohelper.setActive(slot0._goTitle, slot1)
	gohelper.setActive(slot0._gostart, not slot1)
	gohelper.setActive(slot0._simageday.gameObject, slot1)

	if slot1 then
		if not slot0._simageday.gameObject.activeSelf then
			slot0._animDayIcon:Play("open", 0, 0)
			slot0._animDayIcon:Update(0)
		end
	else
		slot0._animScepter:Play("idle", 0, 1)
		slot0._animScepter:Update(0)
	end
end

function slot0._checkGuide(slot0)
	gohelper.setActive(slot0._goguide, not Activity125Model.instance:checkLocalIsPlay(slot0._actId, slot0:getCurSelectedEpisode()))
end

return slot0
