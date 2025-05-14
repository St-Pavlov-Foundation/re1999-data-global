module("modules.logic.versionactivity1_6.v1a6_warmup.view.VersionActivity1_6WarmUpView", package.seeall)

local var_0_0 = class("VersionActivity1_6WarmUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._scrollTaskTabList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	arg_1_0._goradiotaskitem = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	arg_1_0._txtTaskTitle = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/Title/#txt_TaskTitle")
	arg_1_0._txtTaskFMChannelNum = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	arg_1_0._scrollTaskDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	arg_1_0._goTaskDescViewPort = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport")
	arg_1_0._rectmask2D = arg_1_0._goTaskDescViewPort:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0._txtTaskContent = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward")
	arg_1_0._goWrongChannel = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Middle/titlebg/#txt_title")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_play")
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_replay")
	arg_1_0._btngetreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_getreward")
	arg_1_0._goMiddle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle")
	arg_1_0._txtmusictime = gohelper.findChildText(arg_1_0.viewGO, "Middle/#go_playing/#txt_time")
	arg_1_0._middleAnim = arg_1_0._goMiddle:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._isPlayingEpisodeDesc = false
	arg_1_0.isGetingReward = false
	arg_1_0._isReselectCloseFunc = false
	arg_1_0._bottom = 400

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity156Controller.instance:registerCallback(Activity156Event.DataUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onRewardRefresh, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._playSong, arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._playSong, arg_2_0)
	arg_2_0._btngetreward:AddClickListener(arg_2_0._btngetrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity156Controller.instance:unregisterCallback(Activity156Event.DataUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onRewardRefresh, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0._btnplay:RemoveClickListener()
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btngetreward:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._episodeItemTab = {}
	arg_4_0._rewardItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._goTaskContent = gohelper.findChild(arg_4_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	arg_4_0._scrollCanvasGroup = gohelper.onceAddComponent(arg_4_0._scrollTaskDesc.gameObject, typeof(UnityEngine.CanvasGroup))
	arg_4_0._goTaskScrollArrow = gohelper.findChild(arg_4_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/gameobject")
	arg_4_0._episodeCanGetInfoDict = {}
end

function var_0_0._btngetrewardOnClick(arg_5_0)
	Activity156Controller.instance:tryReceiveEpisodeRewards(arg_5_0._actId)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)

	arg_6_0._actId = ActivityEnum.Activity.Activity1_6WarmUp
	arg_6_0._config = Activity156Config.instance:getAct156Config(arg_6_0._actId)

	Activity156Controller.instance:getAct125InfoFromServer(arg_6_0._actId)
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:_refreshData()
	arg_7_0:_showDeadline()
	arg_7_0:_initEpisodeList()
	arg_7_0:_initRewards()
	arg_7_0:_initView()
end

function var_0_0._initView(arg_8_0)
	local var_8_0 = Activity156Model.instance:isEpisodeHasReceivedReward(arg_8_0._curSelectedLvId)
	local var_8_1 = Activity156Model.instance:checkLocalIsPlay(arg_8_0._curSelectedLvId)

	if var_8_1 then
		if var_8_0 then
			for iter_8_0, iter_8_1 in pairs(arg_8_0._rewardItemTab) do
				gohelper.setActive(iter_8_1.gocanget, false)
			end
		else
			for iter_8_2, iter_8_3 in pairs(arg_8_0._rewardItemTab) do
				gohelper.setActive(iter_8_3.gocanget, true)
			end

			gohelper.setActive(arg_8_0._btngetreward.gameObject, true)
		end
	else
		gohelper.setActive(arg_8_0._btngetreward.gameObject, false)
	end

	if var_8_0 or var_8_1 then
		arg_8_0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(arg_8_0._goWrongChannel, false)
		gohelper.setActive(arg_8_0._goTaskScrollArrow, true)
	else
		arg_8_0._rectmask2D.padding = Vector4(0, arg_8_0._bottom, 0, 0)

		gohelper.setActive(arg_8_0._goWrongChannel, true)
		gohelper.setActive(arg_8_0._goTaskScrollArrow, false)
	end

	gohelper.setActive(arg_8_0._btnreplay.gameObject, var_8_1)
	gohelper.setActive(arg_8_0._btnplay.gameObject, not var_8_1)
end

function var_0_0._refreshData(arg_9_0)
	arg_9_0._curSelectedLvId = Activity156Model.instance:getCurSelectedEpisode()

	if not arg_9_0._curSelectedLvId then
		arg_9_0._curSelectedLvId = Activity156Model.instance:getLastEpisode()

		Activity156Model.instance:setCurSelectedEpisode(arg_9_0._curSelectedLvId)
	end

	local var_9_0 = Activity156Config.instance:getEpisodeConfig(arg_9_0._curSelectedLvId)

	arg_9_0._descHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_9_0._txtTaskContent, var_9_0.text)
	arg_9_0._txtTaskContent.text = var_9_0.text

	local var_9_1 = Activity156Config.instance:getEpisodeConfig(arg_9_0._curSelectedLvId)

	arg_9_0._txtTitle.text = var_9_1.name

	recthelper.setAnchorY(arg_9_0._txtTaskContent.transform, 0)
	gohelper.setActive(arg_9_0._goWrongChannel, true)
	gohelper.setActive(arg_9_0._goTaskScrollArrow, false)
end

function var_0_0._showDeadline(arg_10_0)
	arg_10_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_10_0._onRefreshDeadline, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._onRefreshDeadline, arg_10_0, 60)
end

function var_0_0._onRefreshDeadline(arg_11_0)
	arg_11_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_11_0._actId)
end

var_0_0.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function var_0_0._initEpisodeList(arg_12_0)
	local var_12_0 = Activity156Config.instance:getEpisodeCount(arg_12_0._actId)

	for iter_12_0 = 1, var_12_0 do
		local var_12_1 = arg_12_0._episodeItemTab[iter_12_0]

		if not var_12_1 then
			var_12_1 = arg_12_0:getUserDataTb_()
			var_12_1.episodeItemGo = gohelper.cloneInPlace(arg_12_0._goradiotaskitem, "taskItem" .. iter_12_0)

			local var_12_2 = var_12_1.episodeItemGo

			var_12_1.txtDateUnSelected = gohelper.findChildText(var_12_2, "txt_DateUnSelected")
			var_12_1.goDateSelected = gohelper.findChild(var_12_2, "image_Selected")
			var_12_1.txtDateSelected = gohelper.findChildText(var_12_2, "image_Selected/txt_DateSelected")
			var_12_1.finishEffectGo = gohelper.findChild(var_12_2, "image_Selected/Wave_effect2")
			var_12_1.imagewave = gohelper.findChildImage(var_12_2, "image_Selected/image_wave")
			var_12_1.goDateLocked = gohelper.findChild(var_12_2, "image_Locked")
			var_12_1.click = gohelper.findChildButton(var_12_2, "btn_click")

			var_12_1.click:AddClickListener(arg_12_0._taskItemOnClick, arg_12_0, iter_12_0)

			arg_12_0._episodeItemTab[iter_12_0] = var_12_1
		end

		var_12_1.txtDateUnSelected.text = string.format("Day.%s", iter_12_0)
		var_12_1.txtDateSelected.text = string.format("Day.%s", iter_12_0)

		gohelper.setActive(var_12_1.episodeItemGo, true)

		local var_12_3 = iter_12_0 == arg_12_0._curSelectedLvId

		gohelper.setActive(var_12_1.goDateSelected, var_12_3)
		gohelper.setActive(var_12_1.txtDateUnSelected.gameObject, not var_12_3)

		local var_12_4 = not Activity156Model.instance:reallyOpen(arg_12_0._actId, iter_12_0)

		gohelper.setActive(var_12_1.goDateLocked, var_12_4)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_12_0._goTaskContent.transform)

	arg_12_0._scrollTaskTabList.horizontalNormalizedPosition = arg_12_0:_getScrollTargetValue(1, var_12_0, arg_12_0._curSelectedLvId)
end

function var_0_0._getScrollTargetValue(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 == 1 then
		return 0
	end

	return 1 / (arg_13_2 - arg_13_1) * (arg_13_3 - arg_13_1)
end

function var_0_0._taskItemOnClick(arg_14_0, arg_14_1)
	local var_14_0 = Activity156Model.instance:getCurSelectedEpisode()
	local var_14_1 = Activity156Model.instance:isEpisodeUnLock(arg_14_1)

	if not Activity156Model.instance:isOpen(arg_14_0._actId, arg_14_1) then
		return
	end

	function arg_14_0._switchCallBack()
		TaskDispatcher.cancelTask(arg_14_0._switchCallBack, arg_14_0)

		local var_15_0 = Activity156Config.instance:getEpisodeConfig(arg_14_0._curSelectedLvId)

		arg_14_0._txtTitle.text = var_15_0.name

		arg_14_0:refreshUI()
	end

	if var_14_0 ~= arg_14_1 and var_14_1 then
		arg_14_0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_14_0._switchCallBack, arg_14_0, 0.3)
	end

	Activity156Controller.instance:setCurSelectedEpisode(arg_14_1, true)

	if not Activity156Model.instance:checkIsPlayingMusicId(arg_14_1) then
		arg_14_0:_initMusic()
		arg_14_0._middleAnim:Play("idle", 0, 0)
	end

	if arg_14_0._isReselectCloseFunc then
		arg_14_0:_revertViewCloseCheckFunc()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._initRewards(arg_16_0)
	local var_16_0 = arg_16_0._config[arg_16_0._curSelectedLvId].bonus
	local var_16_1 = string.split(var_16_0, "|")

	arg_16_0._rewardCount = #var_16_1

	for iter_16_0 = 1, arg_16_0._rewardCount do
		if not arg_16_0._rewardItemTab[iter_16_0] then
			local var_16_2 = {
				go = gohelper.cloneInPlace(arg_16_0._gorewarditem, "rewarditem" .. iter_16_0)
			}
			local var_16_3 = gohelper.findChild(var_16_2.go, "go_icon")

			var_16_2.icon = IconMgr.instance:getCommonPropItemIcon(var_16_3)
			var_16_2.goreceive = gohelper.findChild(var_16_2.go, "go_receive")
			var_16_2.gocanget = gohelper.findChild(var_16_2.go, "go_canget")
			var_16_2.hasgetAnim = gohelper.findChild(var_16_2.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(arg_16_0._rewardItemTab, var_16_2)
		end

		gohelper.setActive(arg_16_0._rewardItemTab[iter_16_0].go, true)

		if Activity156Model.instance:isEpisodeHasReceivedReward(arg_16_0._curSelectedLvId) then
			gohelper.setActive(arg_16_0._rewardItemTab[iter_16_0].goreceive, true)
		else
			local var_16_4 = Activity156Model.instance:isEpisodeFinished(arg_16_0._curSelectedLvId)

			gohelper.setActive(arg_16_0._rewardItemTab[iter_16_0].goreceive, var_16_4 and not arg_16_0.isGetingReward)
		end

		local var_16_5 = string.splitToNumber(var_16_1[iter_16_0], "#")

		arg_16_0._rewardItemTab[iter_16_0].icon:setMOValue(var_16_5[1], var_16_5[2], var_16_5[3])
		arg_16_0._rewardItemTab[iter_16_0].icon:setCountFontSize(42)
		arg_16_0._rewardItemTab[iter_16_0].icon:setScale(0.5)
	end

	for iter_16_1 = arg_16_0._rewardCount + 1, #arg_16_0._rewardItemTab do
		gohelper.setActive(arg_16_0._rewardItemTab[iter_16_1].go, false)
	end
end

function var_0_0._onRewardRefresh(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.CommonPropView then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._rewardItemTab) do
			gohelper.setActive(iter_17_1.gocanget, false)
		end

		arg_17_0:_onGetRewardAnim(var_0_0.AnimSwitchMode.UnFinish2Finish)
	end
end

function var_0_0._onGetRewardAnim(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 == var_0_0.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for iter_18_0 = 1, arg_18_0._rewardCount do
		gohelper.setActive(arg_18_0._rewardItemTab[iter_18_0].goreceive, true)
		arg_18_0._rewardItemTab[iter_18_0].hasgetAnim:Play(var_18_0, 0, 0)
	end

	arg_18_0.isGetingReward = false
end

function var_0_0._onDailyRefresh(arg_19_0)
	if arg_19_0._actId then
		Activity156Controller.instance:getAct125InfoFromServer(arg_19_0._actId)
	end
end

function var_0_0._messageBoxYesFunc(arg_20_0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function var_0_0._checkIsPlayingDesc(arg_21_0)
	local var_21_0 = Activity156Model.instance:checkLocalIsPlay(arg_21_0._curSelectedLvId)

	if arg_21_0._isPlayingEpisodeDesc and not var_21_0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5_WarmUpPlayingQuitCheck, MsgBoxEnum.BoxType.Yes_No, arg_21_0._messageBoxYesFunc, nil, nil, arg_21_0, arg_21_0)
	end
end

function var_0_0._overrideViewCloseCheckFunc(arg_22_0)
	local var_22_0 = ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView)

	if var_22_0 then
		local var_22_1 = var_22_0.navigationView

		if var_22_1 then
			arg_22_0._originCloseCheckFunc = var_22_1._closeCheckFunc
			arg_22_0._originCloseCheckObj = var_22_1._closeCheckObj
			arg_22_0._originHomeCheckFunc = var_22_1._homeCheckFunc
			arg_22_0._originHomeCheckObj = var_22_1._homeCheckObj

			var_22_1:setCloseCheck(arg_22_0._checkIsPlayingDesc, arg_22_0)
			var_22_1:setHomeCheck(arg_22_0._checkIsPlayingDesc, arg_22_0)
		end
	end

	arg_22_0._isReselectCloseFunc = true
end

function var_0_0._revertViewCloseCheckFunc(arg_23_0)
	local var_23_0 = ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView)

	if var_23_0 then
		local var_23_1 = var_23_0.navigationView

		if var_23_1 then
			var_23_1:setCloseCheck(arg_23_0._originCloseCheckFunc, arg_23_0._originCloseCheckObj)
			var_23_1:setHomeCheck(arg_23_0._originHomeCheckFunc, arg_23_0._originHomeCheckObj)
		end
	end

	arg_23_0._originCloseCheckFunc = nil
	arg_23_0._originCloseCheckObj = nil
	arg_23_0._originHomeCheckFunc = nil
	arg_23_0._originHomeCheckObj = nil
	arg_23_0._isReselectCloseFunc = false
end

function var_0_0._playSong(arg_24_0)
	if Activity156Model.instance:checkIsPlayingMusicId(arg_24_0._curSelectedLvId) then
		return
	end

	local var_24_0 = Activity156Config.instance:getEpisodeConfig(arg_24_0._curSelectedLvId)
	local var_24_1 = Activity156Enum.DayToMusic[arg_24_0._curSelectedLvId]

	arg_24_0:_initMusic()

	if not Activity156Model.instance:checkLocalIsPlay(arg_24_0._curSelectedLvId) then
		arg_24_0:_overrideViewCloseCheckFunc()
	end

	arg_24_0.playaudioId = AudioMgr.instance:trigger(var_24_1)

	Activity156Model.instance:setIsPlayingMusicId(arg_24_0._curSelectedLvId)

	arg_24_0.desctime = var_24_0.time
	arg_24_0.musictime = var_24_0.musictime or 10
	arg_24_0._txtmusictime.text = formatLuaLang("VersionActivity1_6WarmUpView_musictime", arg_24_0.musictime)

	arg_24_0:_playEpisodeDesc(arg_24_0.desctime, arg_24_0._onPlayEpisodeDescFinished, arg_24_0)

	arg_24_0._scrollCanvasGroup.blocksRaycasts = false

	TaskDispatcher.runDelay(arg_24_0._playsongcallback, arg_24_0, arg_24_0.musictime)
	arg_24_0._middleAnim:Update(0)
	arg_24_0._middleAnim:Play("play", 0, 0)
	TaskDispatcher.runRepeat(arg_24_0._remainMusicTime, arg_24_0, 1, arg_24_0.musictime)
end

function var_0_0._remainMusicTime(arg_25_0)
	arg_25_0.musictime = arg_25_0.musictime - 1
	arg_25_0._txtmusictime.text = formatLuaLang("VersionActivity1_6WarmUpView_musictime", arg_25_0.musictime)

	if arg_25_0.musictime == 0 then
		TaskDispatcher.cancelTask(arg_25_0._remainMusicTime, arg_25_0)

		return
	end
end

function var_0_0._playsongcallback(arg_26_0)
	arg_26_0._middleAnim:Play("close", 0, 0)
	arg_26_0:_initMusic()
end

function var_0_0._onPlayEpisodeDescFinished(arg_27_0)
	arg_27_0._scrollCanvasGroup.blocksRaycasts = true
	arg_27_0._isPlayingEpisodeDesc = false

	arg_27_0:_revertViewCloseCheckFunc()
	arg_27_0:_checkIsPlayingButNoCompeleteDesc()

	if Activity156Model.instance:isEpisodeHasReceivedReward(arg_27_0._curSelectedLvId) then
		return
	end

	arg_27_0.isGetingReward = true

	Activity156Model.instance:setLocalIsPlay(arg_27_0._curSelectedLvId)

	for iter_27_0, iter_27_1 in pairs(arg_27_0._rewardItemTab) do
		gohelper.setActive(iter_27_1.gocanget, true)
	end

	Activity156Controller.instance:setCurSelectedEpisode(arg_27_0._curSelectedLvId)
	gohelper.setActive(arg_27_0._btngetreward.gameObject, true)
	gohelper.setActive(arg_27_0._btnreplay.gameObject, true)
end

function var_0_0._playEpisodeDesc(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_0._tweenId then
		ZProj.TweenHelper.KillById(arg_28_0._tweenId)

		arg_28_0._tweenId = nil
	end

	arg_28_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, arg_28_1, arg_28_0.everyFrame, arg_28_2, arg_28_3, nil)

	gohelper.setActive(arg_28_0._goWrongChannel, false)

	arg_28_0._isPlayingEpisodeDesc = true
end

function var_0_0.everyFrame(arg_29_0, arg_29_1)
	arg_29_0._rectmask2D.padding = Vector4(0, Mathf.Lerp(0, arg_29_0._bottom, arg_29_1), 0, 0)
end

function var_0_0._checkIsPlayingButNoCompeleteDesc(arg_30_0)
	if arg_30_0.playaudioId then
		local var_30_0 = arg_30_0._descHeight - arg_30_0._bottom

		if var_30_0 > 0 then
			local var_30_1 = var_30_0 * (arg_30_0.desctime / arg_30_0._bottom)

			if arg_30_0._movetweenId then
				ZProj.TweenHelper.KillById(arg_30_0._movetweenId)

				arg_30_0._movetweenId = nil
			end

			arg_30_0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(arg_30_0._txtTaskContent.transform, var_30_0, var_30_1)

			gohelper.setActive(arg_30_0._goTaskScrollArrow, true)
		end
	end
end

function var_0_0._initMusic(arg_31_0)
	if arg_31_0.playaudioId then
		arg_31_0:_stopAudio()

		arg_31_0.playaudioId = nil

		if arg_31_0._playsongcallback then
			TaskDispatcher.cancelTask(arg_31_0._playsongcallback, arg_31_0)

			arg_31_0._playsongcallback = nil
		end

		if arg_31_0._tweenId then
			ZProj.TweenHelper.KillById(arg_31_0._tweenId)

			arg_31_0._tweenId = nil
		end

		if arg_31_0._movetweenId then
			ZProj.TweenHelper.KillById(arg_31_0._movetweenId)

			arg_31_0._movetweenId = nil
		end

		Activity156Model.instance:cleanIsPlayingMusicId()

		arg_31_0._scrollCanvasGroup.blocksRaycasts = true

		TaskDispatcher.cancelTask(arg_31_0._remainMusicTime, arg_31_0)
	end
end

function var_0_0.onClose(arg_32_0)
	Activity156Model.instance:cleanCurSelectedEpisode()
	Activity156Model.instance:cleanIsPlayingMusicId()
	arg_32_0:_initMusic()
	arg_32_0:_revertViewCloseCheckFunc()
end

function var_0_0._stopAudio(arg_33_0)
	AudioMgr.instance:trigger(AudioEnum.ui_andamtte1_6_music.stop_ui_andamtte1_6_music)
end

function var_0_0.onDestroyView(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._switchCallBack, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._onRefreshDeadline, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._playsongcallback, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._remainMusicTime, arg_34_0)

	if arg_34_0._episodeItemTab then
		for iter_34_0, iter_34_1 in pairs(arg_34_0._episodeItemTab) do
			iter_34_1.click:RemoveClickListener()

			iter_34_1 = nil
		end
	end

	arg_34_0._config = nil
end

return var_0_0
