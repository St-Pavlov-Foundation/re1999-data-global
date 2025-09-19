module("modules.logic.versionactivity2_6.warmup.view.V2a6_WarmUp", package.seeall)

local var_0_0 = class("V2a6_WarmUp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_goto")
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
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btngetreward:AddClickListener(arg_2_0._btngetrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btngetreward:RemoveClickListener()
end

local var_0_1 = _G.Vector4
local var_0_2 = string.splitToNumber
local var_0_3 = string.split
local var_0_4 = SLFramework.AnimatorPlayer
local var_0_5 = "switch"

function var_0_0._btngetrewardOnClick(arg_4_0)
	local var_4_0, var_4_1, var_4_2, var_4_3 = arg_4_0.viewContainer:getRLOCCur()

	if not var_4_3 then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_4_0.viewContainer:sendFinishAct125EpisodeRequest()
end

function var_0_0._btngotoOnClick(arg_5_0)
	SDKDataTrackMgr.instance:trackClickActivityJumpButton()
	arg_5_0.viewContainer:openWebView(arg_5_0._onWebViewCb, arg_5_0)
end

function var_0_0._onWebViewCb(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == WebViewEnum.WebViewCBType.Cb and string.split(arg_6_2, "#")[1] == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = arg_7_0._scrollTaskDesc.gameObject
	local var_7_1 = gohelper.findChild(var_7_0, "Viewport")
	local var_7_2 = gohelper.findChild(arg_7_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	local var_7_3 = gohelper.findChild(var_7_2, "Viewport/Content")

	arg_7_0._btngetrewardGo = arg_7_0._btngetreward.gameObject
	arg_7_0._txtTaskContentTran = arg_7_0._txtTaskContent.transform
	arg_7_0._scroll_TaskDescGo = var_7_0
	arg_7_0._descScrollRect = var_7_0:GetComponent(gohelper.Type_ScrollRect)
	arg_7_0._scrollCanvasGroup = gohelper.onceAddComponent(var_7_0, typeof(UnityEngine.CanvasGroup))
	arg_7_0._taskDescViewportHeight = math.max(0, recthelper.getHeight(var_7_0.transform))
	arg_7_0._taskDescMask = var_7_1:GetComponent(gohelper.Type_RectMask2D)
	arg_7_0._goTaskContentTran = var_7_3.transform
	arg_7_0._taskScrollViewportWidth = recthelper.getWidth(var_7_2.transform)
	arg_7_0._animatorPlayer = var_0_4.Get(arg_7_0.viewGO)
	arg_7_0._animSelf = arg_7_0._animatorPlayer.animator
	arg_7_0._animEvent = gohelper.onceAddComponent(arg_7_0.viewGO, gohelper.Type_AnimationEventWrap)

	arg_7_0._animEvent:AddEventListener(var_0_5, arg_7_0._onSwitch, arg_7_0)

	arg_7_0._btngotoGo = arg_7_0._btngoto.gameObject

	arg_7_0:_refreshActive_btngoto()
	arg_7_0:_resetTaskContentPos()
	arg_7_0:_setActive_goWrongChannel(false)

	arg_7_0._txtLimitTime.text = ""
	arg_7_0._descHeight = 0
	arg_7_0._rewardCount = 0
	arg_7_0._itemTabList = {}
	arg_7_0._rewardItemList = {}
end

function var_0_0.onDataUpdateFirst(arg_8_0)
	arg_8_0:_refreshOnce()
end

function var_0_0.onDataUpdate(arg_9_0)
	arg_9_0:_refresh()
end

function var_0_0.onSwitchEpisode(arg_10_0)
	arg_10_0._descScrollRect:StopMovement()
	arg_10_0:_resetTweenDescPos()
	arg_10_0:_refresh()
	arg_10_0.viewContainer:tryTweenDesc()
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:_refreshOnce()
	arg_11_0:_refresh()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._lastSelectedIndex = nil

	local var_12_0 = arg_12_0.viewParam.parent

	gohelper.addChild(var_12_0, arg_12_0.viewGO)
	AudioMgr.instance:trigger(AudioEnum2_6.WarmUp.play_ui_wenming_cut_20260903)
end

function var_0_0.onClose(arg_13_0)
	GameUtil.onDestroyViewMember_TweenId(arg_13_0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_13_0, "_tweenId")
	arg_13_0._animEvent:RemoveEventListener(var_0_5)
	TaskDispatcher.cancelTask(arg_13_0._showLeftTime, arg_13_0)
	GameUtil.onDestroyViewMemberList(arg_13_0, "_itemTabList")
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

function var_0_0._refreshOnce(arg_15_0)
	arg_15_0:_showDeadline()
	arg_15_0:_refreshTabList()
	arg_15_0:_autoSelectTab()
end

function var_0_0._refresh(arg_16_0)
	arg_16_0:_refreshData()
	arg_16_0:_refreshTabList()
	arg_16_0:_refreshRewards()
	arg_16_0:_refreshRightView()
end

function var_0_0._refreshRightView(arg_17_0)
	local var_17_0, var_17_1, var_17_2, var_17_3 = arg_17_0.viewContainer:getRLOCCur()

	gohelper.setActive(arg_17_0._btngetrewardGo, var_17_3)

	if var_17_0 or var_17_1 then
		arg_17_0:_setActive_goWrongChannel(false)
	elseif not arg_17_0.viewContainer:checkIsDone() then
		arg_17_0:_setActive_goWrongChannel(true)
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._rewardItemList) do
		iter_17_1:refresh()
	end
end

function var_0_0._setActive_goWrongChannel(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._goWrongChannel, arg_18_1)
	arg_18_0:_setActive_scroll_TaskDescGo(not arg_18_1)

	if arg_18_1 then
		arg_18_0:_setMaskPaddingBottom(arg_18_0._taskDescViewportHeight)
	else
		arg_18_0:_setMaskPaddingBottom(0)
	end
end

function var_0_0._refreshData(arg_19_0)
	local var_19_0 = arg_19_0.viewContainer:getEpisodeConfigCur()

	arg_19_0.viewContainer:dispatchRedEvent()

	arg_19_0._txtTaskTitle.text = var_19_0.name
	arg_19_0._txtTaskContent.text = var_19_0.text
end

function var_0_0._showDeadline(arg_20_0)
	arg_20_0:_showLeftTime()
	TaskDispatcher.cancelTask(arg_20_0._showLeftTime, arg_20_0)
	TaskDispatcher.runRepeat(arg_20_0._showLeftTime, arg_20_0, 60)
end

function var_0_0._showLeftTime(arg_21_0)
	arg_21_0._txtLimitTime.text = arg_21_0.viewContainer:getActivityRemainTimeStr()
end

function var_0_0._refreshTabList(arg_22_0)
	local var_22_0 = arg_22_0.viewContainer:getCurSelectedEpisode()
	local var_22_1 = arg_22_0.viewContainer:getEpisodeCount()

	for iter_22_0 = 1, var_22_1 do
		local var_22_2 = iter_22_0
		local var_22_3 = var_22_2 == var_22_0
		local var_22_4

		if iter_22_0 > #arg_22_0._itemTabList then
			var_22_4 = arg_22_0:_create_V2a6_WarmUp_radiotaskitem(iter_22_0)

			table.insert(arg_22_0._itemTabList, var_22_4)
		else
			var_22_4 = arg_22_0._itemTabList[iter_22_0]
		end

		var_22_4:onUpdateMO(var_22_2)
		var_22_4:setActive(true)
		var_22_4:setSelected(var_22_3)
	end

	for iter_22_1 = var_22_1 + 1, #arg_22_0._itemTabList do
		arg_22_0._itemTabList[iter_22_1]:setActive(false)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_22_0._goTaskContentTran)
end

function var_0_0._setSelectIndex(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == arg_23_0._lastSelectedIndex then
		return
	end

	if arg_23_2 then
		arg_23_0:_taskScrollToIndex(arg_23_1)
	else
		arg_23_0:onClickTab(arg_23_0:index2EpisodeId(arg_23_0.viewContainer:getCurSelectedEpisode()) or 1)
	end
end

local var_0_6 = 166

function var_0_0._taskScrollToIndex(arg_24_0, arg_24_1)
	local var_24_0 = math.max(recthelper.getWidth(arg_24_0._goTaskContentTran) - arg_24_0._taskScrollViewportWidth, 0)
	local var_24_1 = math.min((arg_24_1 - 1) * var_0_6, var_24_0)

	recthelper.setAnchorX(arg_24_0._goTaskContentTran, -var_24_1)

	arg_24_0._lastSelectedIndex = arg_24_1
end

function var_0_0.onClickTab(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1
	local var_25_1 = arg_25_0.viewContainer:getCurSelectedEpisode()

	if var_25_1 == var_25_0 then
		return
	end

	arg_25_0._lastSelectedIndex = arg_25_0:episode2Index(var_25_0)

	arg_25_0.viewContainer:switchTabWithAnim(var_25_1, var_25_0)
end

function var_0_0._refreshRewards(arg_26_0)
	local var_26_0 = arg_26_0.viewContainer:getEpisodeConfigCur().bonus
	local var_26_1 = var_0_3(var_26_0, "|")
	local var_26_2 = #var_26_1

	arg_26_0._rewardCount = var_26_2

	for iter_26_0 = 1, var_26_2 do
		local var_26_3
		local var_26_4 = var_0_2(var_26_1[iter_26_0], "#")

		if iter_26_0 > #arg_26_0._rewardItemList then
			var_26_3 = arg_26_0:_create_V2a6_WarmUp_rewarditem(iter_26_0)

			table.insert(arg_26_0._rewardItemList, var_26_3)
		else
			var_26_3 = arg_26_0._rewardItemList[iter_26_0]
		end

		var_26_3:onUpdateMO(var_26_4)
		var_26_3:setActive(true)
	end

	for iter_26_1 = var_26_2 + 1, #arg_26_0._rewardItemList do
		arg_26_0._rewardItemList[iter_26_1]:setActive(false)
	end
end

function var_0_0.openDesc(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = arg_27_0.viewContainer:getRLOCCur()

	if var_27_0 or var_27_1 then
		if arg_27_1 then
			arg_27_1(arg_27_2)
		end

		return
	end

	arg_27_0:_resetTweenDescPos()

	local var_27_2 = arg_27_0.viewContainer:getEpisodeConfigCur()
	local var_27_3 = math.max(var_27_2.time or 0, 1)

	gohelper.setActive(arg_27_0._goWrongChannel, false)
	arg_27_0:_setActive_scroll_TaskDescGo(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)

	local function var_27_4()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)

		if arg_27_1 then
			arg_27_1(arg_27_2)
		end
	end

	GameUtil.onDestroyViewMember_TweenId(arg_27_0, "_tweenId")

	arg_27_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, var_27_3, arg_27_0._tweenDescUpdateCb, function()
		arg_27_0:_tweenDescEndCb(var_27_3, var_27_4)
	end, arg_27_0)
end

local var_0_7 = Mathf.Lerp

function var_0_0._tweenDescUpdateCb(arg_30_0, arg_30_1)
	local var_30_0 = var_0_7(0, arg_30_0._taskDescViewportHeight, arg_30_1)

	arg_30_0:_setMaskPaddingBottom(var_30_0)
end

function var_0_0._tweenDescEndCb(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0._descHeight - arg_31_0._taskDescViewportHeight

	if var_31_0 <= 0 then
		if arg_31_2 then
			arg_31_2(arg_31_3)
		end

		return
	end

	local var_31_1 = var_31_0 * (arg_31_1 / arg_31_0._taskDescViewportHeight)

	GameUtil.onDestroyViewMember_TweenId(arg_31_0, "_movetweenId")

	arg_31_0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(arg_31_0._txtTaskContentTran, var_31_0, var_31_1, arg_31_2, arg_31_3)
end

function var_0_0._resetTaskContentPos(arg_32_0)
	recthelper.setAnchorY(arg_32_0._txtTaskContentTran, 0)
end

function var_0_0.episode2Index(arg_33_0, arg_33_1)
	return arg_33_1
end

function var_0_0.index2EpisodeId(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._itemTabList[arg_34_1]

	if not var_34_0 then
		return
	end

	return var_34_0._mo
end

function var_0_0._setMaskPaddingBottom(arg_35_0, arg_35_1)
	arg_35_0._taskDescMask.padding = var_0_1(0, arg_35_1, 0, 0)
end

function var_0_0._autoSelectTab(arg_36_0)
	local var_36_0 = arg_36_0.viewContainer:getCurSelectedEpisode() or arg_36_0.viewContainer:getFirstRewardEpisode()

	arg_36_0.viewContainer:setCurSelectEpisodeIdSlient(var_36_0)
	arg_36_0:_setSelectIndex(arg_36_0:episode2Index(var_36_0), true)
end

function var_0_0._create_V2a6_WarmUp_radiotaskitem(arg_37_0, arg_37_1)
	local var_37_0 = gohelper.cloneInPlace(arg_37_0._goradiotaskitem)
	local var_37_1 = V2a6_WarmUp_radiotaskitem.New({
		parent = arg_37_0,
		baseViewContainer = arg_37_0.viewContainer
	})

	var_37_1:setIndex(arg_37_1)
	var_37_1:init(var_37_0)

	return var_37_1
end

function var_0_0._create_V2a6_WarmUp_rewarditem(arg_38_0, arg_38_1)
	local var_38_0 = gohelper.cloneInPlace(arg_38_0._gorewarditem)
	local var_38_1 = V2a6_WarmUp_rewarditem.New({
		parent = arg_38_0,
		baseViewContainer = arg_38_0.viewContainer
	})

	var_38_1:setIndex(arg_38_1)
	var_38_1:init(var_38_0)

	return var_38_1
end

function var_0_0._resetTweenDescPos(arg_39_0)
	GameUtil.onDestroyViewMember_TweenId(arg_39_0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_39_0, "_tweenId")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	arg_39_0:_resetTaskContentPos()
end

function var_0_0._playAnim(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_0._animatorPlayer:Play(arg_40_1, arg_40_2, arg_40_3)
end

function var_0_0.tweenSwitch(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:_playAnim(UIAnimationName.Switch, arg_41_1, arg_41_2)
end

function var_0_0._onSwitch(arg_42_0)
	local var_42_0 = arg_42_0.viewContainer:getCurSelectedEpisode()
	local var_42_1

	if arg_42_0._lastSelectedIndex then
		var_42_1 = arg_42_0._itemTabList[arg_42_0._lastSelectedIndex]._mo
	end

	arg_42_0.viewContainer:switchTabNoAnim(var_42_0, var_42_1)
end

function var_0_0.playRewardItemsHasGetAnim(arg_43_0)
	for iter_43_0 = 1, arg_43_0._rewardCount do
		arg_43_0._rewardItemList[iter_43_0]:playAnim_hasget()
	end
end

function var_0_0.setBlock_scroll(arg_44_0, arg_44_1)
	arg_44_0._scrollCanvasGroup.blocksRaycasts = not arg_44_1
end

function var_0_0._refreshActive_btngoto(arg_45_0)
	local var_45_0 = CommonConfig.instance:getConstStr(ConstEnum.V2a4_WarmUp_btnplay_openTs)

	if string.nilorempty(var_45_0) then
		gohelper.setActive(arg_45_0._btnplayGo, true)

		return
	end

	local var_45_1 = ServerTime.now() >= TimeUtil.stringToTimestamp(var_45_0) and not string.nilorempty(arg_45_0.viewContainer:getH5BaseUrl())

	gohelper.setActive(arg_45_0._btngotoGo, var_45_1)
end

function var_0_0._refreshTxtTaskContentHeight(arg_46_0)
	ZProj.UGUIHelper.RebuildLayout(arg_46_0._txtTaskContentTran)

	arg_46_0._descHeight = arg_46_0._txtTaskContent.preferredHeight
end

function var_0_0._setActive_scroll_TaskDescGo(arg_47_0, arg_47_1)
	gohelper.setActive(arg_47_0._scroll_TaskDescGo, arg_47_1)

	if arg_47_1 then
		ZProj.UGUIHelper.RebuildLayout(arg_47_0._txtTaskContentTran)

		arg_47_0._descHeight = arg_47_0._txtTaskContent.preferredHeight
	end
end

return var_0_0
