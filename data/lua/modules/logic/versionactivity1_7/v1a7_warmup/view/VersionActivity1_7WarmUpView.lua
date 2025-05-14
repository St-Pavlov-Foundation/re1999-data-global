module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpView", package.seeall)

local var_0_0 = class("VersionActivity1_7WarmUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._goradiotaskitem = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	arg_1_0._txtTaskTitle = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	arg_1_0._txtTaskFMChannelNum = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	arg_1_0._scrollTaskDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	arg_1_0._goTaskDescViewPort = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport")
	arg_1_0._rectmask2D = arg_1_0._goTaskDescViewPort:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0._txtTaskContent = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward")
	arg_1_0._goWrongChannel = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._btngetreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_getreward")
	arg_1_0._isPlayingEpisodeDesc = false
	arg_1_0._bottom = 324

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onRewardRefresh, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0._btngetreward:AddClickListener(arg_2_0._btngetrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onRewardRefresh, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0._btngetreward:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._episodeItemTab = {}
	arg_4_0._rewardItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._goTaskScroll = gohelper.findChild(arg_4_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	arg_4_0._goTaskContent = gohelper.findChild(arg_4_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	arg_4_0._scrollCanvasGroup = gohelper.onceAddComponent(arg_4_0._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	arg_4_0._episodeCanGetInfoDict = {}
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

	arg_6_0._actId = ActivityEnum.Activity.Activity1_7WarmUp

	Activity125Controller.instance:getAct125InfoFromServer(arg_6_0._actId)
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:_refreshData()
	arg_7_0:_showDeadline()
	arg_7_0:_initEpisodeList()
	arg_7_0:_initRewards()
	arg_7_0:_initView()
	arg_7_0:_checkPlayDesc()
end

function var_0_0._initView(arg_8_0)
	local var_8_0 = Activity125Model.instance:isEpisodeFinished(arg_8_0._actId, arg_8_0:getCurSelectedEpisode())
	local var_8_1 = Activity125Model.instance:checkLocalIsPlay(arg_8_0._actId, arg_8_0:getCurSelectedEpisode())
	local var_8_2 = Activity125Model.instance:checkIsOldEpisode(arg_8_0._actId, arg_8_0:getCurSelectedEpisode())
	local var_8_3 = not var_8_0 and var_8_1

	for iter_8_0, iter_8_1 in pairs(arg_8_0._rewardItemTab) do
		gohelper.setActive(iter_8_1.gocanget, var_8_3)
		gohelper.setActive(iter_8_1.goreceive, var_8_0 and not arg_8_0.viewContainer:isPlayingDesc())
	end

	gohelper.setActive(arg_8_0._btngetreward.gameObject, var_8_3)

	if var_8_0 or var_8_1 or var_8_2 then
		arg_8_0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(arg_8_0._goWrongChannel, false)
	else
		arg_8_0._rectmask2D.padding = Vector4(0, arg_8_0._bottom, 0, 0)

		gohelper.setActive(arg_8_0._goWrongChannel, true)
	end
end

function var_0_0.getCurSelectedEpisode(arg_9_0)
	return Activity125Model.instance:getSelectEpisodeId(arg_9_0._actId)
end

function var_0_0._refreshData(arg_10_0)
	local var_10_0 = arg_10_0:getCurSelectedEpisode()
	local var_10_1 = Activity125Config.instance:getEpisodeConfig(arg_10_0._actId, var_10_0)

	arg_10_0._txtTaskContent.text = var_10_1.text
	arg_10_0._descHeight = arg_10_0._txtTaskContent.preferredHeight
	arg_10_0._txtTaskTitle.text = var_10_1.name

	recthelper.setAnchorY(arg_10_0._txtTaskContent.transform, 0)
	gohelper.setActive(arg_10_0._goWrongChannel, true)
end

function var_0_0._showDeadline(arg_11_0)
	arg_11_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_11_0._onRefreshDeadline, arg_11_0)
	TaskDispatcher.runRepeat(arg_11_0._onRefreshDeadline, arg_11_0, 60)
end

function var_0_0._onRefreshDeadline(arg_12_0)
	arg_12_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_12_0._actId)
end

var_0_0.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function var_0_0._initEpisodeList(arg_13_0)
	local var_13_0 = Activity125Config.instance:getEpisodeCount(arg_13_0._actId)
	local var_13_1 = arg_13_0:getCurSelectedEpisode()

	for iter_13_0 = 1, var_13_0 do
		local var_13_2 = arg_13_0._episodeItemTab[iter_13_0]

		if not var_13_2 then
			var_13_2 = arg_13_0:getUserDataTb_()
			var_13_2.episodeItemGo = gohelper.cloneInPlace(arg_13_0._goradiotaskitem, "taskItem" .. iter_13_0)

			local var_13_3 = var_13_2.episodeItemGo

			var_13_2.txtDateUnSelected = gohelper.findChildText(var_13_3, "txt_DateUnSelected")
			var_13_2.goDateSelected = gohelper.findChild(var_13_3, "image_Selected")
			var_13_2.txtDateSelected = gohelper.findChildText(var_13_3, "image_Selected/txt_DateSelected")
			var_13_2.finishEffectGo = gohelper.findChild(var_13_3, "image_Selected/Wave_effect2")
			var_13_2.imagewave = gohelper.findChildImage(var_13_3, "image_Selected/image_wave")
			var_13_2.goDateLocked = gohelper.findChild(var_13_3, "image_Locked")
			var_13_2.goRed = gohelper.findChild(var_13_3, "#go_reddot")
			var_13_2.click = gohelper.findChildButton(var_13_3, "btn_click")

			var_13_2.click:AddClickListener(arg_13_0._taskItemOnClick, arg_13_0, iter_13_0)

			arg_13_0._episodeItemTab[iter_13_0] = var_13_2
		end

		var_13_2.txtDateUnSelected.text = string.format("Day.%s", iter_13_0)
		var_13_2.txtDateSelected.text = string.format("Day.%s", iter_13_0)

		gohelper.setActive(var_13_2.episodeItemGo, true)

		local var_13_4 = iter_13_0 == var_13_1

		gohelper.setActive(var_13_2.goDateSelected, var_13_4)
		gohelper.setActive(var_13_2.txtDateUnSelected.gameObject, not var_13_4)

		local var_13_5 = not Activity125Model.instance:isEpisodeReallyOpen(arg_13_0._actId, iter_13_0)

		gohelper.setActive(var_13_2.goDateLocked, var_13_5)
		gohelper.setActive(var_13_2.goRed, Activity125Model.instance:isEpisodeReallyOpen(arg_13_0._actId, iter_13_0) and Activity125Model.instance:isHasEpisodeCanReceiveReward(arg_13_0._actId, iter_13_0))
	end

	ZProj.UGUIHelper.RebuildLayout(arg_13_0._goTaskContent.transform)

	if var_13_1 == arg_13_0._selectId then
		return
	end

	arg_13_0._selectId = var_13_1

	local var_13_6 = math.max(recthelper.getWidth(arg_13_0._goTaskContent.transform) - recthelper.getWidth(arg_13_0._goTaskScroll.transform), 0)
	local var_13_7 = (var_13_1 - 1) * 166

	recthelper.setAnchorX(arg_13_0._goTaskContent.transform, -math.min(var_13_7, var_13_6))
end

function var_0_0._taskItemOnClick(arg_14_0, arg_14_1)
	if arg_14_0.viewContainer:isPlayingDesc() then
		return
	end

	local var_14_0 = arg_14_0:getCurSelectedEpisode()
	local var_14_1, var_14_2 = Activity125Model.instance:isEpisodeDayOpen(arg_14_0._actId, arg_14_1)

	if not var_14_1 then
		GameFacade.showToast(ToastEnum.V1A7WarmupDayLock, var_14_2)

		return
	end

	if not Activity125Model.instance:isEpisodeUnLock(arg_14_0._actId, arg_14_1) then
		GameFacade.showToast(ToastEnum.V1A7WarmupPreEpisodeLock)

		return
	end

	if var_14_0 ~= arg_14_1 then
		Activity125Model.instance:setSelectEpisodeId(arg_14_0._actId, arg_14_1)
		Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._initRewards(arg_15_0)
	local var_15_0 = Activity125Config.instance:getEpisodeConfig(arg_15_0._actId, arg_15_0:getCurSelectedEpisode()).bonus
	local var_15_1 = string.split(var_15_0, "|")

	arg_15_0._rewardCount = #var_15_1

	for iter_15_0 = 1, arg_15_0._rewardCount do
		if not arg_15_0._rewardItemTab[iter_15_0] then
			local var_15_2 = {
				go = gohelper.cloneInPlace(arg_15_0._gorewarditem, "rewarditem" .. iter_15_0)
			}
			local var_15_3 = gohelper.findChild(var_15_2.go, "go_icon")

			var_15_2.icon = IconMgr.instance:getCommonPropItemIcon(var_15_3)
			var_15_2.goreceive = gohelper.findChild(var_15_2.go, "go_receive")
			var_15_2.gocanget = gohelper.findChild(var_15_2.go, "go_canget")
			var_15_2.hasgetAnim = gohelper.findChild(var_15_2.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(arg_15_0._rewardItemTab, var_15_2)
		end

		gohelper.setActive(arg_15_0._rewardItemTab[iter_15_0].go, true)

		local var_15_4 = string.splitToNumber(var_15_1[iter_15_0], "#")

		arg_15_0._rewardItemTab[iter_15_0].icon:setMOValue(var_15_4[1], var_15_4[2], var_15_4[3])
		arg_15_0._rewardItemTab[iter_15_0].icon:setCountFontSize(42)
		arg_15_0._rewardItemTab[iter_15_0].icon:setScale(0.5)
	end

	for iter_15_1 = arg_15_0._rewardCount + 1, #arg_15_0._rewardItemTab do
		gohelper.setActive(arg_15_0._rewardItemTab[iter_15_1].go, false)
	end
end

function var_0_0._onRewardRefresh(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.CommonPropView then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._rewardItemTab) do
			gohelper.setActive(iter_16_1.gocanget, false)
		end

		arg_16_0:_onGetRewardAnim(var_0_0.AnimSwitchMode.UnFinish2Finish)
	end
end

function var_0_0._onGetRewardAnim(arg_17_0, arg_17_1)
	arg_17_0.viewContainer:setIsPlayingDesc(false)

	local var_17_0 = arg_17_1 == var_0_0.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for iter_17_0 = 1, arg_17_0._rewardCount do
		gohelper.setActive(arg_17_0._rewardItemTab[iter_17_0].goreceive, true)
		arg_17_0._rewardItemTab[iter_17_0].hasgetAnim:Play(var_17_0, 0, 0)
	end
end

function var_0_0._onDailyRefresh(arg_18_0)
	if arg_18_0._actId then
		Activity125Controller.instance:getAct125InfoFromServer(arg_18_0._actId)
	end
end

function var_0_0._checkPlayDesc(arg_19_0)
	local var_19_0 = Activity125Model.instance:isEpisodeFinished(arg_19_0._actId, arg_19_0:getCurSelectedEpisode())
	local var_19_1 = Activity125Model.instance:checkLocalIsPlay(arg_19_0._actId, arg_19_0:getCurSelectedEpisode())

	if Activity125Model.instance:checkIsOldEpisode(arg_19_0._actId, arg_19_0:getCurSelectedEpisode()) and not var_19_0 and not var_19_1 then
		arg_19_0:playDesc()
	end
end

function var_0_0.playDesc(arg_20_0)
	if arg_20_0.viewContainer:isPlayingDesc() then
		return
	end

	local var_20_0 = Activity125Config.instance:getEpisodeConfig(arg_20_0._actId, arg_20_0:getCurSelectedEpisode())

	arg_20_0.viewContainer:setIsPlayingDesc(true)

	arg_20_0.desctime = var_20_0.time or 5

	arg_20_0:_playEpisodeDesc(arg_20_0.desctime, arg_20_0._onPlayEpisodeDescFinished, arg_20_0)

	arg_20_0._scrollCanvasGroup.blocksRaycasts = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)
end

function var_0_0._playEpisodeDesc(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0._tweenId then
		ZProj.TweenHelper.KillById(arg_21_0._tweenId)

		arg_21_0._tweenId = nil
	end

	arg_21_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, arg_21_1, arg_21_0.everyFrame, arg_21_2, arg_21_3, nil)

	gohelper.setActive(arg_21_0._goWrongChannel, false)
end

function var_0_0.everyFrame(arg_22_0, arg_22_1)
	arg_22_0._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, arg_22_0._bottom, arg_22_1), 0, 0)
end

function var_0_0._onPlayEpisodeDescFinished(arg_23_0)
	arg_23_0._scrollCanvasGroup.blocksRaycasts = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	arg_23_0.viewContainer:setIsPlayingDesc(false)
	arg_23_0:_checkIsPlayingButNoCompeleteDesc()

	if Activity125Model.instance:isEpisodeFinished(arg_23_0._actId, arg_23_0:getCurSelectedEpisode()) then
		return
	end

	Activity125Model.instance:setLocalIsPlay(arg_23_0._actId, arg_23_0:getCurSelectedEpisode())
	arg_23_0:refreshUI()
	Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeUnlock)
end

function var_0_0._checkIsPlayingButNoCompeleteDesc(arg_24_0)
	local var_24_0 = arg_24_0._descHeight - arg_24_0._bottom

	if var_24_0 > 0 then
		local var_24_1 = var_24_0 * (arg_24_0.desctime / arg_24_0._bottom)

		if arg_24_0._movetweenId then
			ZProj.TweenHelper.KillById(arg_24_0._movetweenId)

			arg_24_0._movetweenId = nil
		end

		arg_24_0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(arg_24_0._txtTaskContent.transform, var_24_0, var_24_1)
	end
end

function var_0_0.onClose(arg_25_0)
	return
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._onRefreshDeadline, arg_26_0)

	if arg_26_0._tweenId then
		ZProj.TweenHelper.KillById(arg_26_0._tweenId)

		arg_26_0._tweenId = nil
	end

	if arg_26_0._episodeItemTab then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._episodeItemTab) do
			iter_26_1.click:RemoveClickListener()
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

return var_0_0
