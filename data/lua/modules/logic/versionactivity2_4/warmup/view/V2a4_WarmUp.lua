module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp", package.seeall)

local var_0_0 = class("V2a4_WarmUp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simageboxunopen = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#simage_box_unopen")
	arg_1_0._simageboxopen = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#simage_box_open")
	arg_1_0._simagelight = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#simage_light")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#image_icon")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._scrollTaskTabList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	arg_1_0._goradiotaskitem = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem/#go_reddot")
	arg_1_0._scrollTaskDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	arg_1_0._txtTaskContent = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	arg_1_0._goWrongChannel = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._btngetreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/RawardPanel/#btn_getreward")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_task")
	arg_1_0._gotask_reddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_task/#go_task_reddot")
	arg_1_0._btnanswercall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_answercall")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_play")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngetreward:AddClickListener(arg_2_0._btngetrewardOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnanswercall:AddClickListener(arg_2_0._btnanswercallOnClick, arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplaylOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngetreward:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnanswercall:RemoveClickListener()
	arg_3_0._btnplay:RemoveClickListener()
end

local var_0_1 = string.format
local var_0_2 = table.insert
local var_0_3 = table.concat
local var_0_4 = _G.Vector4
local var_0_5 = string.splitToNumber
local var_0_6 = string.split
local var_0_7 = SLFramework.AnimatorPlayer
local var_0_8 = "switch"

function var_0_0._btngetrewardOnClick(arg_4_0)
	local var_4_0, var_4_1, var_4_2, var_4_3 = arg_4_0.viewContainer:getRLOCCur()

	if not var_4_3 then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_4_0.viewContainer:sendFinishAct125EpisodeRequest()
end

function var_0_0._btntaskOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	ViewMgr.instance:openView(ViewName.V2a4_WarmUp_TaskView)
end

function var_0_0._btnanswercallOnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_diqiu_yure_click_20249044)
	Activity125Controller.instance:sendGetTaskInfoRequest(arg_6_0._openV2a4_WarmUp_DialogueView, arg_6_0)
end

local var_0_9 = "https://re.bluepoch.com/event/ShowdowninChinatown/"

function var_0_0._btnplaylOnClick(arg_7_0)
	if SettingsModel.instance:isTwRegion() or SettingsModel.instance:isKrRegion() then
		WebViewController.instance:openWebView(arg_7_0.viewContainer:getH5BaseUrl(), false, arg_7_0._onWebViewCb, arg_7_0)
	else
		WebViewController.instance:simpleOpenWebView(arg_7_0.viewContainer:getH5BaseUrl(), false, arg_7_0._onWebViewCb, arg_7_0)
	end
end

function var_0_0._onWebViewCb(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == WebViewEnum.WebViewCBType.Cb and string.split(arg_8_2, "#")[1] == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end
end

function var_0_0._openV2a4_WarmUp_DialogueView(arg_9_0)
	local var_9_0 = arg_9_0.viewContainer:getCurSelectedEpisode()
	local var_9_1 = {
		level = var_9_0
	}

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	ViewMgr.instance:openView(ViewName.V2a4_WarmUp_DialogueView, var_9_1)
end

function var_0_0._editableInitView(arg_10_0)
	local var_10_0 = arg_10_0._scrollTaskDesc.gameObject
	local var_10_1 = gohelper.findChild(var_10_0, "Viewport")
	local var_10_2 = gohelper.findChild(arg_10_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	local var_10_3 = gohelper.findChild(var_10_2, "Viewport/Content")

	arg_10_0._btngetrewardGo = arg_10_0._btngetreward.gameObject
	arg_10_0._txtTaskContentTran = arg_10_0._txtTaskContent.transform
	arg_10_0._scroll_TaskDescGo = var_10_0
	arg_10_0._descScrollRect = var_10_0:GetComponent(gohelper.Type_ScrollRect)
	arg_10_0._scrollCanvasGroup = gohelper.onceAddComponent(var_10_0, typeof(UnityEngine.CanvasGroup))
	arg_10_0._taskDescViewportHeight = math.max(0, recthelper.getHeight(var_10_0.transform))
	arg_10_0._taskDescMask = var_10_1:GetComponent(gohelper.Type_RectMask2D)
	arg_10_0._goTaskContentTran = var_10_3.transform
	arg_10_0._taskScrollViewportWidth = recthelper.getWidth(var_10_2.transform)
	arg_10_0._animatorPlayer = var_0_7.Get(arg_10_0.viewGO)
	arg_10_0._animSelf = arg_10_0._animatorPlayer.animator
	arg_10_0._animEvent = gohelper.onceAddComponent(arg_10_0.viewGO, gohelper.Type_AnimationEventWrap)

	arg_10_0._animEvent:AddEventListener(var_0_8, arg_10_0._onSwitch, arg_10_0)
	arg_10_0:_resetTaskContentPos()
	arg_10_0:_setActive_goWrongChannel(false)

	arg_10_0._phoneAnimation = arg_10_0._btnanswercall.gameObject:GetComponent(gohelper.Type_Animation)
	arg_10_0._btnplayGo = arg_10_0._btnplay.gameObject
	arg_10_0._txtLimitTime.text = ""
	arg_10_0._descHeight = 0
	arg_10_0._rewardCount = 0
	arg_10_0._itemTabList = {}
	arg_10_0._rewardItemList = {}

	RedDotController.instance:addRedDot(arg_10_0._gotask_reddot, RedDotEnum.DotNode.Activity125Task, 0)
end

function var_0_0.onDataUpdateFirst(arg_11_0)
	arg_11_0:_refreshOnce()
	arg_11_0:_refreshPhoneAnim()
	arg_11_0:_refreshActive_btnplay()
end

function var_0_0.onDataUpdate(arg_12_0)
	arg_12_0:_refresh()
	arg_12_0:_refreshPhoneAnim()
end

function var_0_0.onSwitchEpisode(arg_13_0)
	arg_13_0._descScrollRect:StopMovement()
	arg_13_0:_resetTweenDescPos()
	arg_13_0:_refresh()
	arg_13_0.viewContainer:tryTweenDesc()
	arg_13_0:_refreshPhoneAnim()
	arg_13_0:_refreshActive_btnplay()
end

function var_0_0._refreshPhoneAnim(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer:getCurSelectedEpisode()
	local var_14_1 = arg_14_0.viewContainer:isEpisodeFinished(var_14_0)
	local var_14_2 = arg_14_0._phoneAnimation.clip.name

	if var_14_1 then
		arg_14_0._phoneAnimation:Stop(var_14_2)
		arg_14_0._phoneAnimation:Play(var_14_2)
		arg_14_0._phoneAnimation:Sample()
		arg_14_0._phoneAnimation:Stop(var_14_2)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	else
		arg_14_0._phoneAnimation:Play(var_14_2)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_diqiu_yure_ring_20249041)
	end
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:_refreshOnce()
	arg_15_0:_refresh()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._lastSelectedIndex = nil

	local var_16_0 = arg_16_0.viewParam.parent

	gohelper.addChild(var_16_0, arg_16_0.viewGO)
end

function var_0_0.onClose(arg_17_0)
	GameUtil.onDestroyViewMember_TweenId(arg_17_0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_17_0, "_tweenId")
	arg_17_0._animEvent:RemoveEventListener(var_0_8)
	TaskDispatcher.cancelTask(arg_17_0._showLeftTime, arg_17_0)
	GameUtil.onDestroyViewMemberList(arg_17_0, "_itemTabList")
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

function var_0_0._refreshOnce(arg_19_0)
	arg_19_0:_showDeadline()
	arg_19_0:_refreshTabList()
	arg_19_0:_autoSelectTab()
end

function var_0_0._refresh(arg_20_0)
	arg_20_0:_refreshData()
	arg_20_0:_refreshTabList()
	arg_20_0:_refreshRewards()
	arg_20_0:_refreshRightView()
end

function var_0_0._refreshRightView(arg_21_0)
	local var_21_0, var_21_1, var_21_2, var_21_3 = arg_21_0.viewContainer:getRLOCCur()

	gohelper.setActive(arg_21_0._btngetrewardGo, var_21_3)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._rewardItemList) do
		iter_21_1:refresh()
	end
end

function var_0_0._setActive_goWrongChannel(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._goWrongChannel, arg_22_1)
	gohelper.setActive(arg_22_0._scroll_TaskDescGo, not arg_22_1)

	if arg_22_1 then
		arg_22_0:_setMaskPaddingBottom(arg_22_0._taskDescViewportHeight)
	else
		arg_22_0:_setMaskPaddingBottom(0)
	end
end

function var_0_0._refreshData(arg_23_0)
	local var_23_0 = arg_23_0.viewContainer:getEpisodeConfigCur()

	arg_23_0.viewContainer:dispatchRedEvent()

	arg_23_0._txtTaskContent.text = var_23_0.text
	arg_23_0._descHeight = arg_23_0._txtTaskContent.preferredHeight
end

function var_0_0._showDeadline(arg_24_0)
	arg_24_0:_showLeftTime()
	TaskDispatcher.cancelTask(arg_24_0._showLeftTime, arg_24_0)
	TaskDispatcher.runRepeat(arg_24_0._showLeftTime, arg_24_0, 60)
end

function var_0_0._showLeftTime(arg_25_0)
	arg_25_0._txtLimitTime.text = arg_25_0.viewContainer:getActivityRemainTimeStr()
end

function var_0_0._refreshTabList(arg_26_0)
	local var_26_0 = arg_26_0.viewContainer:getCurSelectedEpisode()
	local var_26_1 = arg_26_0.viewContainer:getEpisodeCount()

	for iter_26_0 = 1, var_26_1 do
		local var_26_2 = iter_26_0
		local var_26_3 = var_26_2 == var_26_0
		local var_26_4

		if iter_26_0 > #arg_26_0._itemTabList then
			var_26_4 = arg_26_0:_create_V2a4_WarmUp_radiotaskitem(iter_26_0)

			table.insert(arg_26_0._itemTabList, var_26_4)
		else
			var_26_4 = arg_26_0._itemTabList[iter_26_0]
		end

		var_26_4:onUpdateMO(var_26_2)
		var_26_4:setActive(true)
		var_26_4:setSelected(var_26_3)
	end

	for iter_26_1 = var_26_1 + 1, #arg_26_0._itemTabList do
		arg_26_0._itemTabList[iter_26_1]:setActive(false)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_26_0._goTaskContentTran)
end

function var_0_0._setSelectIndex(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == arg_27_0._lastSelectedIndex then
		return
	end

	if arg_27_2 then
		arg_27_0:_taskScrollToIndex(arg_27_1)
	else
		arg_27_0:onClickTab(arg_27_0:index2EpisodeId(arg_27_0.viewContainer:getCurSelectedEpisode()) or 1)
	end
end

local var_0_10 = 166

function var_0_0._taskScrollToIndex(arg_28_0, arg_28_1)
	local var_28_0 = math.max(recthelper.getWidth(arg_28_0._goTaskContentTran) - arg_28_0._taskScrollViewportWidth, 0)
	local var_28_1 = math.min((arg_28_1 - 1) * var_0_10, var_28_0)

	recthelper.setAnchorX(arg_28_0._goTaskContentTran, -var_28_1)

	arg_28_0._lastSelectedIndex = arg_28_1
end

function var_0_0.onClickTab(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_0.viewContainer:getCurSelectedEpisode()

	if var_29_1 == var_29_0 then
		return
	end

	arg_29_0._lastSelectedIndex = arg_29_0:episode2Index(var_29_0)

	arg_29_0.viewContainer:switchTabWithAnim(var_29_1, var_29_0)
end

function var_0_0._refreshRewards(arg_30_0)
	local var_30_0 = arg_30_0.viewContainer:getEpisodeConfigCur().clientbonus or ""
	local var_30_1 = var_0_6(var_30_0, "|")
	local var_30_2 = #var_30_1

	arg_30_0._rewardCount = var_30_2

	for iter_30_0 = 1, var_30_2 do
		local var_30_3
		local var_30_4 = var_0_5(var_30_1[iter_30_0], "#")

		if iter_30_0 > #arg_30_0._rewardItemList then
			var_30_3 = arg_30_0:_create_V2a4_WarmUp_rewarditem(iter_30_0)

			table.insert(arg_30_0._rewardItemList, var_30_3)
		else
			var_30_3 = arg_30_0._rewardItemList[iter_30_0]
		end

		var_30_3:onUpdateMO(var_30_4)
		var_30_3:setActive(true)
	end

	for iter_30_1 = var_30_2 + 1, #arg_30_0._rewardItemList do
		arg_30_0._rewardItemList[iter_30_1]:setActive(false)
	end
end

function var_0_0.openDesc(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0, var_31_1 = arg_31_0.viewContainer:getRLOCCur()

	if var_31_0 or var_31_1 then
		if arg_31_1 then
			arg_31_1(arg_31_2)
		end

		return
	end

	arg_31_0:_resetTweenDescPos()

	local var_31_2 = arg_31_0.viewContainer:getEpisodeConfigCur()
	local var_31_3 = math.max(var_31_2.time or 0, 1)

	gohelper.setActive(arg_31_0._goWrongChannel, false)
	gohelper.setActive(arg_31_0._scroll_TaskDescGo, true)

	local function var_31_4()
		if arg_31_1 then
			arg_31_1(arg_31_2)
		end
	end

	GameUtil.onDestroyViewMember_TweenId(arg_31_0, "_tweenId")

	arg_31_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, var_31_3, arg_31_0._tweenDescUpdateCb, function()
		arg_31_0:_tweenDescEndCb(var_31_3, var_31_4)
	end, arg_31_0)
end

local var_0_11 = Mathf.Lerp

function var_0_0._tweenDescUpdateCb(arg_34_0, arg_34_1)
	local var_34_0 = var_0_11(0, arg_34_0._taskDescViewportHeight, arg_34_1)

	arg_34_0:_setMaskPaddingBottom(var_34_0)
end

function var_0_0._tweenDescEndCb(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_0._descHeight - arg_35_0._taskDescViewportHeight

	if var_35_0 <= 0 then
		if arg_35_2 then
			arg_35_2(arg_35_3)
		end

		return
	end

	local var_35_1 = var_35_0 * (arg_35_1 / arg_35_0._taskDescViewportHeight)

	GameUtil.onDestroyViewMember_TweenId(arg_35_0, "_movetweenId")

	arg_35_0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(arg_35_0._txtTaskContentTran, var_35_0, var_35_1, arg_35_2, arg_35_3)
end

function var_0_0._resetTaskContentPos(arg_36_0)
	recthelper.setAnchorY(arg_36_0._txtTaskContentTran, 0)
end

function var_0_0.episode2Index(arg_37_0, arg_37_1)
	return arg_37_1
end

function var_0_0.index2EpisodeId(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0._itemTabList[arg_38_1]

	if not var_38_0 then
		return
	end

	return var_38_0._mo
end

function var_0_0._setMaskPaddingBottom(arg_39_0, arg_39_1)
	arg_39_0._taskDescMask.padding = var_0_4(0, arg_39_1, 0, 0)
end

function var_0_0._autoSelectTab(arg_40_0)
	local var_40_0 = arg_40_0.viewContainer:getCurSelectedEpisode() or arg_40_0.viewContainer:getFirstRewardEpisode()

	arg_40_0.viewContainer:setCurSelectEpisodeIdSlient(var_40_0)
	arg_40_0:_setSelectIndex(arg_40_0:episode2Index(var_40_0), true)
end

function var_0_0._create_V2a4_WarmUp_radiotaskitem(arg_41_0, arg_41_1)
	local var_41_0 = gohelper.cloneInPlace(arg_41_0._goradiotaskitem)
	local var_41_1 = V2a4_WarmUp_radiotaskitem.New({
		parent = arg_41_0,
		baseViewContainer = arg_41_0.viewContainer
	})

	var_41_1:setIndex(arg_41_1)
	var_41_1:init(var_41_0)

	return var_41_1
end

function var_0_0._create_V2a4_WarmUp_rewarditem(arg_42_0, arg_42_1)
	local var_42_0 = gohelper.cloneInPlace(arg_42_0._gorewarditem)
	local var_42_1 = V2a4_WarmUp_rewarditem.New({
		parent = arg_42_0,
		baseViewContainer = arg_42_0.viewContainer
	})

	var_42_1:setIndex(arg_42_1)
	var_42_1:init(var_42_0)

	return var_42_1
end

function var_0_0._resetTweenDescPos(arg_43_0)
	GameUtil.onDestroyViewMember_TweenId(arg_43_0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_43_0, "_tweenId")
	arg_43_0:_resetTaskContentPos()
end

function var_0_0._playAnim(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_0._animatorPlayer:Play(arg_44_1, arg_44_2, arg_44_3)
end

function var_0_0.tweenSwitch(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0:_playAnim(UIAnimationName.Switch, arg_45_1, arg_45_2)
end

function var_0_0._onSwitch(arg_46_0)
	local var_46_0 = arg_46_0.viewContainer:getCurSelectedEpisode()
	local var_46_1

	if arg_46_0._lastSelectedIndex then
		var_46_1 = arg_46_0._itemTabList[arg_46_0._lastSelectedIndex]._mo
	end

	arg_46_0.viewContainer:switchTabNoAnim(var_46_0, var_46_1)
end

function var_0_0.playRewardItemsHasGetAnim(arg_47_0)
	for iter_47_0 = 1, arg_47_0._rewardCount do
		arg_47_0._rewardItemList[iter_47_0]:playAnim_hasget()
	end
end

function var_0_0.setBlock_scroll(arg_48_0, arg_48_1)
	arg_48_0._scrollCanvasGroup.blocksRaycasts = not arg_48_1
end

function var_0_0._refreshActive_btnplay(arg_49_0)
	local var_49_0 = arg_49_0.viewContainer:isTimeToActiveH5Btn()

	gohelper.setActive(arg_49_0._btnplayGo, var_49_0)
end

return var_0_0
