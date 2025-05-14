module("modules.logic.versionactivity1_9.warmup.view.VersionActivity1_9WarmUpView", package.seeall)

local var_0_0 = class("VersionActivity1_9WarmUpView", BaseView)

var_0_0.UI_CLICK_BLOCK_KEY = "VersionActivity1_9WarmUpView_UI_CLICK_BLOCK_KEY"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_start")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#go_start/#simage_bg")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_start/#go_drag")
	arg_1_0._goscepter = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_start/#go_scepter")
	arg_1_0._goguide = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_start/#go_guide")
	arg_1_0._simageday = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#simage_day")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._scrollTaskTabList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	arg_1_0._goradiotaskitem = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem/#go_reddot")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_Title")
	arg_1_0._txtTaskTitle = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	arg_1_0._scrollTaskDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	arg_1_0._txtTaskContent = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	arg_1_0._goWrongChannel = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._btngetreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_getreward")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngetreward:AddClickListener(arg_2_0._btngetrewardOnClick, arg_2_0)
	arg_2_0:_addEvents()
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngetreward:RemoveClickListener()
	arg_3_0:_removeEvents()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._episodeItemTab = {}
	arg_4_0._rewardItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._goTaskScroll = gohelper.findChild(arg_4_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	arg_4_0._goTaskContent = gohelper.findChild(arg_4_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	arg_4_0._scrollCanvasGroup = gohelper.onceAddComponent(arg_4_0._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	arg_4_0._episodeCanGetInfoDict = {}
	arg_4_0._rectmask2D = gohelper.findChild(arg_4_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._godrag.gameObject)
	arg_4_0._bottom = 324

	local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "Middle")

	arg_4_0._animView = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animEventWrap = arg_4_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_4_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._animScepter = var_4_0:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animScepterPlayer = SLFramework.AnimatorPlayer.Get(var_4_0)
	arg_4_0._animDayIcon = arg_4_0._simageday.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._btngetrewardOnClick(arg_5_0)
	local var_5_0 = arg_5_0:getCurSelectedEpisode()
	local var_5_1 = Activity125Model.instance:isEpisodeFinished(arg_5_0._actId, var_5_0)
	local var_5_2 = Activity125Model.instance:checkLocalIsPlay(arg_5_0._actId, var_5_0)

	if not (not var_5_1 and var_5_2) then
		return
	end

	arg_5_0.viewContainer:setIsPlayingDesc(true)

	local var_5_3 = Activity125Config.instance:getEpisodeConfig(arg_5_0._actId, var_5_0)

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(arg_5_0._actId, var_5_0, var_5_3.targetFrequency)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)

	arg_6_0._actId = arg_6_0.viewParam.actId

	Activity125Controller.instance:getAct125InfoFromServer(arg_6_0._actId)
	arg_6_0._animView:Play("in", 0, 0)

	arg_6_0._isPlayScepterAnim = false

	arg_6_0:_checkGuide()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:_refreshData()
	arg_7_0:_showDeadline()
	arg_7_0:_initEpisodeList()
	arg_7_0:_initRewards()
	arg_7_0:_initView()
	arg_7_0:_checkPlayDesc()
end

function var_0_0._addEvents(arg_8_0)
	arg_8_0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0._onRewardRefresh, arg_8_0)
	arg_8_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_8_0._onDailyRefresh, arg_8_0)
	arg_8_0._drag:AddDragEndListener(arg_8_0._onDragEnd, arg_8_0)
	arg_8_0._drag:AddDragBeginListener(arg_8_0._onDragBegin, arg_8_0)
	arg_8_0._animEventWrap:AddEventListener("switch", arg_8_0._playSwitchAnimRefreshView, arg_8_0)
end

function var_0_0._removeEvents(arg_9_0)
	arg_9_0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_9_0.refreshUI, arg_9_0)
	arg_9_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_9_0._onRewardRefresh, arg_9_0)
	arg_9_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_9_0._onDailyRefresh, arg_9_0)
	arg_9_0._drag:RemoveDragListener()
	arg_9_0._drag:RemoveDragEndListener()
	arg_9_0._drag:RemoveDragBeginListener()
	arg_9_0._animEventWrap:RemoveAllEventListener()
end

function var_0_0._initView(arg_10_0)
	local var_10_0 = Activity125Model.instance:isEpisodeFinished(arg_10_0._actId, arg_10_0:getCurSelectedEpisode())
	local var_10_1 = Activity125Model.instance:checkLocalIsPlay(arg_10_0._actId, arg_10_0:getCurSelectedEpisode())
	local var_10_2 = Activity125Model.instance:checkIsOldEpisode(arg_10_0._actId, arg_10_0:getCurSelectedEpisode())
	local var_10_3 = not var_10_0 and var_10_1

	for iter_10_0, iter_10_1 in pairs(arg_10_0._rewardItemTab) do
		gohelper.setActive(iter_10_1.gocanget, var_10_3)
		gohelper.setActive(iter_10_1.goreceive, var_10_0 and not arg_10_0.viewContainer:isPlayingDesc())
	end

	gohelper.setActive(arg_10_0._btngetreward.gameObject, var_10_3)

	local var_10_4 = var_10_0 or var_10_1 or var_10_2

	if var_10_4 then
		arg_10_0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(arg_10_0._goWrongChannel, false)
	else
		arg_10_0._rectmask2D.padding = Vector4(0, arg_10_0._bottom, 0, 0)

		gohelper.setActive(arg_10_0._goWrongChannel, true)
	end

	arg_10_0:_activeScepter(var_10_4)
end

function var_0_0.getCurSelectedEpisode(arg_11_0)
	return Activity125Model.instance:getSelectEpisodeId(arg_11_0._actId)
end

function var_0_0._refreshData(arg_12_0)
	local var_12_0 = arg_12_0:getCurSelectedEpisode()
	local var_12_1 = Activity125Config.instance:getEpisodeConfig(arg_12_0._actId, var_12_0)

	arg_12_0._txtTaskContent.text = var_12_1.text
	arg_12_0._descHeight = arg_12_0._txtTaskContent.preferredHeight
	arg_12_0._txtTaskTitle.text = var_12_1.name

	recthelper.setAnchorY(arg_12_0._txtTaskContent.transform, 0)
	gohelper.setActive(arg_12_0._goWrongChannel, true)
end

function var_0_0._showDeadline(arg_13_0)
	arg_13_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_13_0._onRefreshDeadline, arg_13_0)
	TaskDispatcher.runRepeat(arg_13_0._onRefreshDeadline, arg_13_0, 60)
end

function var_0_0._onRefreshDeadline(arg_14_0)
	arg_14_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_14_0._actId)
end

var_0_0.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function var_0_0._initEpisodeList(arg_15_0)
	local var_15_0 = Activity125Config.instance:getEpisodeCount(arg_15_0._actId)
	local var_15_1 = arg_15_0:getCurSelectedEpisode()

	for iter_15_0 = 1, var_15_0 do
		local var_15_2 = arg_15_0._episodeItemTab[iter_15_0]

		if not var_15_2 then
			var_15_2 = arg_15_0:getUserDataTb_()
			var_15_2.episodeItemGo = gohelper.cloneInPlace(arg_15_0._goradiotaskitem, "taskItem" .. iter_15_0)

			local var_15_3 = var_15_2.episodeItemGo

			var_15_2.txtDateUnSelected = gohelper.findChildText(var_15_3, "txt_DateUnSelected")
			var_15_2.goDateSelected = gohelper.findChild(var_15_3, "image_Selected")
			var_15_2.txtDateSelected = gohelper.findChildText(var_15_3, "image_Selected/txt_DateSelected")
			var_15_2.finishEffectGo = gohelper.findChild(var_15_3, "image_Selected/Wave_effect2")
			var_15_2.imagewave = gohelper.findChildImage(var_15_3, "image_Selected/image_wave")
			var_15_2.goDateLocked = gohelper.findChild(var_15_3, "image_Locked")
			var_15_2.goRed = gohelper.findChild(var_15_3, "#go_reddot")
			var_15_2.click = gohelper.findChildButton(var_15_3, "btn_click")

			var_15_2.click:AddClickListener(arg_15_0._taskItemOnClick, arg_15_0, iter_15_0)

			arg_15_0._episodeItemTab[iter_15_0] = var_15_2
		end

		var_15_2.txtDateUnSelected.text = string.format("Day.%s", iter_15_0)
		var_15_2.txtDateSelected.text = string.format("Day.%s", iter_15_0)

		gohelper.setActive(var_15_2.episodeItemGo, true)

		local var_15_4 = iter_15_0 == var_15_1

		gohelper.setActive(var_15_2.goDateSelected, var_15_4)
		gohelper.setActive(var_15_2.txtDateUnSelected.gameObject, not var_15_4)

		local var_15_5 = not Activity125Model.instance:isEpisodeReallyOpen(arg_15_0._actId, iter_15_0)

		gohelper.setActive(var_15_2.goDateLocked, var_15_5)
		gohelper.setActive(var_15_2.goRed, Activity125Model.instance:isEpisodeReallyOpen(arg_15_0._actId, iter_15_0) and Activity125Model.instance:isHasEpisodeCanReceiveReward(arg_15_0._actId, iter_15_0))
	end

	ZProj.UGUIHelper.RebuildLayout(arg_15_0._goTaskContent.transform)

	if var_15_1 == arg_15_0._selectId then
		return
	end

	arg_15_0._selectId = var_15_1

	local var_15_6 = math.max(recthelper.getWidth(arg_15_0._goTaskContent.transform) - recthelper.getWidth(arg_15_0._goTaskScroll.transform), 0)
	local var_15_7 = (var_15_1 - 1) * 166

	recthelper.setAnchorX(arg_15_0._goTaskContent.transform, -math.min(var_15_7, var_15_6))
end

function var_0_0._taskItemOnClick(arg_16_0, arg_16_1)
	if arg_16_0.viewContainer:isPlayingDesc() or arg_16_0._isPlayScepterAnim then
		return
	end

	local var_16_0 = arg_16_0:getCurSelectedEpisode()
	local var_16_1, var_16_2 = Activity125Model.instance:isEpisodeDayOpen(arg_16_0._actId, arg_16_1)

	if not var_16_1 then
		GameFacade.showToast(ToastEnum.V1A7WarmupDayLock, var_16_2)

		return
	end

	if not Activity125Model.instance:isEpisodeUnLock(arg_16_0._actId, arg_16_1) then
		GameFacade.showToast(ToastEnum.V1A9WarmupPreEpisodeLock)

		return
	end

	if var_16_0 ~= arg_16_1 then
		UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
		arg_16_0:_playDescFinish()
		Activity125Model.instance:setSelectEpisodeId(arg_16_0._actId, arg_16_1)
		arg_16_0._animPlayer:Play("switch", arg_16_0._playSwitchAnimFinish, arg_16_0)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_16_0:_checkGuide()
end

function var_0_0._playSwitchAnimFinish(arg_17_0)
	arg_17_0._animView:Play("idle", 0, 0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._playSwitchAnimRefreshView(arg_18_0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function var_0_0._initRewards(arg_19_0)
	local var_19_0 = Activity125Config.instance:getEpisodeConfig(arg_19_0._actId, arg_19_0:getCurSelectedEpisode()).bonus
	local var_19_1 = string.split(var_19_0, "|")

	arg_19_0._rewardCount = #var_19_1

	for iter_19_0 = 1, arg_19_0._rewardCount do
		if not arg_19_0._rewardItemTab[iter_19_0] then
			local var_19_2 = {
				go = gohelper.cloneInPlace(arg_19_0._gorewarditem, "rewarditem" .. iter_19_0)
			}
			local var_19_3 = gohelper.findChild(var_19_2.go, "go_icon")

			var_19_2.icon = IconMgr.instance:getCommonPropItemIcon(var_19_3)
			var_19_2.goreceive = gohelper.findChild(var_19_2.go, "go_receive")
			var_19_2.gocanget = gohelper.findChild(var_19_2.go, "go_canget")
			var_19_2.hasgetAnim = gohelper.findChild(var_19_2.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(arg_19_0._rewardItemTab, var_19_2)
		end

		gohelper.setActive(arg_19_0._rewardItemTab[iter_19_0].go, true)

		local var_19_4 = string.splitToNumber(var_19_1[iter_19_0], "#")

		arg_19_0._rewardItemTab[iter_19_0].icon:setMOValue(var_19_4[1], var_19_4[2], var_19_4[3])
		arg_19_0._rewardItemTab[iter_19_0].icon:setCountFontSize(42)
		arg_19_0._rewardItemTab[iter_19_0].icon:setScale(0.5)
	end

	for iter_19_1 = arg_19_0._rewardCount + 1, #arg_19_0._rewardItemTab do
		gohelper.setActive(arg_19_0._rewardItemTab[iter_19_1].go, false)
	end
end

function var_0_0._onRewardRefresh(arg_20_0, arg_20_1)
	if arg_20_1 == ViewName.CommonPropView then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._rewardItemTab) do
			gohelper.setActive(iter_20_1.gocanget, false)
		end

		arg_20_0:_onGetRewardAnim(var_0_0.AnimSwitchMode.UnFinish2Finish)
	end
end

function var_0_0._onGetRewardAnim(arg_21_0, arg_21_1)
	arg_21_0.viewContainer:setIsPlayingDesc(false)

	local var_21_0 = arg_21_1 == var_0_0.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for iter_21_0 = 1, arg_21_0._rewardCount do
		gohelper.setActive(arg_21_0._rewardItemTab[iter_21_0].goreceive, true)
		arg_21_0._rewardItemTab[iter_21_0].hasgetAnim:Play(var_21_0, 0, 0)
	end
end

function var_0_0._onDailyRefresh(arg_22_0)
	if arg_22_0._actId then
		Activity125Controller.instance:getAct125InfoFromServer(arg_22_0._actId)
	end
end

function var_0_0._checkPlayDesc(arg_23_0)
	local var_23_0 = Activity125Model.instance:isEpisodeFinished(arg_23_0._actId, arg_23_0:getCurSelectedEpisode())
	local var_23_1 = Activity125Model.instance:checkLocalIsPlay(arg_23_0._actId, arg_23_0:getCurSelectedEpisode())

	if Activity125Model.instance:checkIsOldEpisode(arg_23_0._actId, arg_23_0:getCurSelectedEpisode()) and not var_23_0 and not var_23_1 then
		arg_23_0:playDesc()
	end
end

function var_0_0.playDesc(arg_24_0)
	if arg_24_0.viewContainer:isPlayingDesc() then
		return
	end

	local var_24_0 = Activity125Config.instance:getEpisodeConfig(arg_24_0._actId, arg_24_0:getCurSelectedEpisode())

	arg_24_0.viewContainer:setIsPlayingDesc(true)

	arg_24_0.desctime = var_24_0.time or 5

	arg_24_0:_playEpisodeDesc(arg_24_0.desctime, arg_24_0._onPlayEpisodeDescFinished, arg_24_0)

	arg_24_0._scrollCanvasGroup.blocksRaycasts = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)
end

function var_0_0._playEpisodeDesc(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0:_onKillTween()

	arg_25_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, arg_25_1, arg_25_0.everyFrame, arg_25_2, arg_25_3, nil)

	gohelper.setActive(arg_25_0._goWrongChannel, false)
end

function var_0_0.everyFrame(arg_26_0, arg_26_1)
	arg_26_0._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, arg_26_0._bottom, arg_26_1), 0, 0)
end

function var_0_0._onPlayEpisodeDescFinished(arg_27_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	arg_27_0:_checkIsPlayingButNoCompeleteDesc()
	arg_27_0.viewContainer:setIsPlayingDesc(false)

	if Activity125Model.instance:isEpisodeFinished(arg_27_0._actId, arg_27_0:getCurSelectedEpisode()) then
		return
	end

	Activity125Model.instance:setLocalIsPlay(arg_27_0._actId, arg_27_0:getCurSelectedEpisode())
	arg_27_0:refreshUI()
	Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeUnlock)
end

function var_0_0._checkIsPlayingButNoCompeleteDesc(arg_28_0)
	local var_28_0 = arg_28_0._descHeight - arg_28_0._bottom

	if var_28_0 > 0 then
		local var_28_1 = var_28_0 * (arg_28_0.desctime / arg_28_0._bottom)

		if arg_28_0._movetweenId then
			ZProj.TweenHelper.KillById(arg_28_0._movetweenId)

			arg_28_0._movetweenId = nil
		end

		arg_28_0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(arg_28_0._txtTaskContent.transform, var_28_0, var_28_1, arg_28_0._playDescFinish, arg_28_0)
	end
end

function var_0_0._playDescFinish(arg_29_0)
	arg_29_0._scrollCanvasGroup.blocksRaycasts = true

	if arg_29_0._movetweenId then
		ZProj.TweenHelper.KillById(arg_29_0._movetweenId)

		arg_29_0._movetweenId = nil
	end
end

function var_0_0.onClose(arg_30_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_gudu_preheat)
end

function var_0_0.onDestroyView(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._onRefreshDeadline, arg_31_0)
	arg_31_0:_onKillTween()

	if arg_31_0._episodeItemTab then
		for iter_31_0, iter_31_1 in pairs(arg_31_0._episodeItemTab) do
			iter_31_1.click:RemoveClickListener()
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	arg_31_0._simageday:UnLoadImage()
end

function var_0_0._onDragEnd(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_2.position.x - arg_32_0.startDragPosX < 0 then
		arg_32_0:checkFinishEpisode(arg_32_0._actId, arg_32_0:getCurSelectedEpisode())
	end
end

function var_0_0._onDragBegin(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.startDragPosX = arg_33_2.position.x
end

function var_0_0._onKillTween(arg_34_0)
	if arg_34_0._tweenId then
		ZProj.TweenHelper.KillById(arg_34_0._tweenId)

		arg_34_0._tweenId = nil
	end
end

function var_0_0.checkFinishEpisode(arg_35_0, arg_35_1, arg_35_2)
	if not Activity125Model.instance:isEpisodeReallyOpen(arg_35_1, arg_35_2) then
		return
	end

	local var_35_0 = Activity125Model.instance:getSelectEpisodeId(arg_35_1)
	local var_35_1 = Activity125Model.instance:checkIsOldEpisode(arg_35_1, arg_35_2)
	local var_35_2 = Activity125Model.instance:checkLocalIsPlay(arg_35_1, arg_35_2)
	local var_35_3 = Activity125Model.instance:isEpisodeFinished(arg_35_1, arg_35_2)

	if (var_35_1 or var_35_2 or var_35_3) and var_35_0 == arg_35_2 then
		return
	end

	Activity125Model.instance:setSelectEpisodeId(arg_35_1, arg_35_2)

	if not var_35_1 then
		Activity125Model.instance:setOldEpisode(arg_35_1, arg_35_2)
	end

	arg_35_0:_playScepterAnim()
end

function var_0_0._playScepterAnim(arg_36_0)
	arg_36_0._isPlayScepterAnim = true

	gohelper.setActive(arg_36_0._goguide, false)

	local var_36_0 = arg_36_0:getCurSelectedEpisode()
	local var_36_1 = "day_0" .. var_36_0

	arg_36_0._animScepterPlayer:Play(var_36_1, arg_36_0._playScepterAnimFinish, arg_36_0)
	gohelper.setActive(arg_36_0._goguide, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_preheat)
end

function var_0_0._playScepterAnimFinish(arg_37_0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
	arg_37_0:_activeScepter(true)

	arg_37_0._isPlayScepterAnim = false
end

function var_0_0._activeScepter(arg_38_0, arg_38_1)
	if arg_38_1 then
		local var_38_0 = arg_38_0:getCurSelectedEpisode()

		arg_38_0._simageday:LoadImage(ResUrl.getV1a9WarmUpSingleBg(var_38_0))
	end

	gohelper.setActive(arg_38_0._goTitle, arg_38_1)
	gohelper.setActive(arg_38_0._gostart, not arg_38_1)

	local var_38_1 = arg_38_0._simageday.gameObject.activeSelf

	gohelper.setActive(arg_38_0._simageday.gameObject, arg_38_1)

	if arg_38_1 then
		if not var_38_1 then
			arg_38_0._animDayIcon:Play("open", 0, 0)
			arg_38_0._animDayIcon:Update(0)
		end
	else
		arg_38_0._animScepter:Play("idle", 0, 1)
		arg_38_0._animScepter:Update(0)
	end
end

function var_0_0._checkGuide(arg_39_0)
	local var_39_0 = Activity125Model.instance:checkLocalIsPlay(arg_39_0._actId, arg_39_0:getCurSelectedEpisode())

	gohelper.setActive(arg_39_0._goguide, not var_39_0)
end

return var_0_0
