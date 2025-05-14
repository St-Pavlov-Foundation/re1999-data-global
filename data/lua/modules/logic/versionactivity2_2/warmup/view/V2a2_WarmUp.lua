module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUp", package.seeall)

local var_0_0 = class("V2a2_WarmUp", BaseView)

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
end

function var_0_0.removeEvents(arg_3_0)
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

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = arg_5_0._scrollTaskDesc.gameObject
	local var_5_1 = gohelper.findChild(var_5_0, "Viewport")
	local var_5_2 = gohelper.findChild(arg_5_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	local var_5_3 = gohelper.findChild(var_5_2, "Viewport/Content")

	arg_5_0._btngetrewardGo = arg_5_0._btngetreward.gameObject
	arg_5_0._txtTaskContentTran = arg_5_0._txtTaskContent.transform
	arg_5_0._scroll_TaskDescGo = var_5_0
	arg_5_0._descScrollRect = var_5_0:GetComponent(gohelper.Type_ScrollRect)
	arg_5_0._scrollCanvasGroup = gohelper.onceAddComponent(var_5_0, typeof(UnityEngine.CanvasGroup))
	arg_5_0._taskDescViewportHeight = math.max(0, recthelper.getHeight(var_5_0.transform))
	arg_5_0._taskDescMask = var_5_1:GetComponent(gohelper.Type_RectMask2D)
	arg_5_0._goTaskContentTran = var_5_3.transform
	arg_5_0._taskScrollViewportWidth = recthelper.getWidth(var_5_2.transform)
	arg_5_0._animatorPlayer = var_0_4.Get(arg_5_0.viewGO)
	arg_5_0._animSelf = arg_5_0._animatorPlayer.animator
	arg_5_0._animEvent = gohelper.onceAddComponent(arg_5_0.viewGO, gohelper.Type_AnimationEventWrap)

	arg_5_0._animEvent:AddEventListener(var_0_5, arg_5_0._onSwitch, arg_5_0)
	arg_5_0:_resetTaskContentPos()
	arg_5_0:_setActive_goWrongChannel(false)

	arg_5_0._txtLimitTime.text = ""
	arg_5_0._descHeight = 0
	arg_5_0._rewardCount = 0
	arg_5_0._itemTabList = {}
	arg_5_0._rewardItemList = {}
end

function var_0_0.onDataUpdateFirst(arg_6_0)
	arg_6_0:_refreshOnce()
end

function var_0_0.onDataUpdate(arg_7_0)
	arg_7_0:_refresh()
end

function var_0_0.onSwitchEpisode(arg_8_0)
	arg_8_0._descScrollRect:StopMovement()
	arg_8_0:_resetTweenDescPos()
	arg_8_0:_refresh()
	arg_8_0.viewContainer:tryTweenDesc()
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_refreshOnce()
	arg_9_0:_refresh()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._lastSelectedIndex = nil

	local var_10_0 = arg_10_0.viewParam.parent

	gohelper.addChild(var_10_0, arg_10_0.viewGO)
end

function var_0_0.onClose(arg_11_0)
	GameUtil.onDestroyViewMember_TweenId(arg_11_0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_11_0, "_tweenId")
	arg_11_0._animEvent:RemoveEventListener(var_0_5)
	TaskDispatcher.cancelTask(arg_11_0._showLeftTime, arg_11_0)
	GameUtil.onDestroyViewMemberList(arg_11_0, "_itemTabList")
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

function var_0_0._refreshOnce(arg_13_0)
	arg_13_0:_showDeadline()
	arg_13_0:_refreshTabList()
	arg_13_0:_autoSelectTab()
end

function var_0_0._refresh(arg_14_0)
	arg_14_0:_refreshData()
	arg_14_0:_refreshTabList()
	arg_14_0:_refreshRewards()
	arg_14_0:_refreshRightView()
end

function var_0_0._refreshRightView(arg_15_0)
	local var_15_0, var_15_1, var_15_2, var_15_3 = arg_15_0.viewContainer:getRLOCCur()

	gohelper.setActive(arg_15_0._btngetrewardGo, var_15_3)

	if var_15_0 or var_15_1 then
		arg_15_0:_setActive_goWrongChannel(false)
	elseif not arg_15_0.viewContainer:checkIsDone() then
		arg_15_0:_setActive_goWrongChannel(true)
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._rewardItemList) do
		iter_15_1:refresh()
	end
end

function var_0_0._setActive_goWrongChannel(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._goWrongChannel, arg_16_1)
	gohelper.setActive(arg_16_0._scroll_TaskDescGo, not arg_16_1)

	if arg_16_1 then
		arg_16_0:_setMaskPaddingBottom(arg_16_0._taskDescViewportHeight)
	else
		arg_16_0:_setMaskPaddingBottom(0)
	end
end

function var_0_0._refreshData(arg_17_0)
	local var_17_0 = arg_17_0.viewContainer:getEpisodeConfigCur()

	arg_17_0.viewContainer:dispatchRedEvent()

	arg_17_0._txtTaskTitle.text = var_17_0.name
	arg_17_0._txtTaskContent.text = var_17_0.text
	arg_17_0._descHeight = arg_17_0._txtTaskContent.preferredHeight
end

function var_0_0._showDeadline(arg_18_0)
	arg_18_0:_showLeftTime()
	TaskDispatcher.cancelTask(arg_18_0._showLeftTime, arg_18_0)
	TaskDispatcher.runRepeat(arg_18_0._showLeftTime, arg_18_0, 60)
end

function var_0_0._showLeftTime(arg_19_0)
	arg_19_0._txtLimitTime.text = arg_19_0.viewContainer:getActivityRemainTimeStr()
end

function var_0_0._refreshTabList(arg_20_0)
	local var_20_0 = arg_20_0.viewContainer:getCurSelectedEpisode()
	local var_20_1 = arg_20_0.viewContainer:getEpisodeCount()

	for iter_20_0 = 1, var_20_1 do
		local var_20_2 = iter_20_0
		local var_20_3 = var_20_2 == var_20_0
		local var_20_4

		if iter_20_0 > #arg_20_0._itemTabList then
			var_20_4 = arg_20_0:_create_V2a2_WarmUp_radiotaskitem(iter_20_0)

			table.insert(arg_20_0._itemTabList, var_20_4)
		else
			var_20_4 = arg_20_0._itemTabList[iter_20_0]
		end

		var_20_4:onUpdateMO(var_20_2)
		var_20_4:setActive(true)
		var_20_4:setSelected(var_20_3)
	end

	for iter_20_1 = var_20_1 + 1, #arg_20_0._itemTabList do
		arg_20_0._itemTabList[iter_20_1]:setActive(false)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_20_0._goTaskContentTran)
end

function var_0_0._setSelectIndex(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == arg_21_0._lastSelectedIndex then
		return
	end

	if arg_21_2 then
		arg_21_0:_taskScrollToIndex(arg_21_1)
	else
		arg_21_0:onClickTab(arg_21_0:index2EpisodeId(arg_21_0.viewContainer:getCurSelectedEpisode()) or 1)
	end
end

local var_0_6 = 166

function var_0_0._taskScrollToIndex(arg_22_0, arg_22_1)
	local var_22_0 = math.max(recthelper.getWidth(arg_22_0._goTaskContentTran) - arg_22_0._taskScrollViewportWidth, 0)
	local var_22_1 = math.min((arg_22_1 - 1) * var_0_6, var_22_0)

	recthelper.setAnchorX(arg_22_0._goTaskContentTran, -var_22_1)

	arg_22_0._lastSelectedIndex = arg_22_1
end

function var_0_0.onClickTab(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1
	local var_23_1 = arg_23_0.viewContainer:getCurSelectedEpisode()

	if var_23_1 == var_23_0 then
		return
	end

	arg_23_0._lastSelectedIndex = arg_23_0:episode2Index(var_23_0)

	arg_23_0.viewContainer:switchTabWithAnim(var_23_1, var_23_0)
end

function var_0_0._refreshRewards(arg_24_0)
	local var_24_0 = arg_24_0.viewContainer:getEpisodeConfigCur().bonus
	local var_24_1 = var_0_3(var_24_0, "|")
	local var_24_2 = #var_24_1

	arg_24_0._rewardCount = var_24_2

	for iter_24_0 = 1, var_24_2 do
		local var_24_3
		local var_24_4 = var_0_2(var_24_1[iter_24_0], "#")

		if iter_24_0 > #arg_24_0._rewardItemList then
			var_24_3 = arg_24_0:_create_V2a2_WarmUp_rewarditem(iter_24_0)

			table.insert(arg_24_0._rewardItemList, var_24_3)
		else
			var_24_3 = arg_24_0._rewardItemList[iter_24_0]
		end

		var_24_3:onUpdateMO(var_24_4)
		var_24_3:setActive(true)
	end

	for iter_24_1 = var_24_2 + 1, #arg_24_0._rewardItemList do
		arg_24_0._rewardItemList[iter_24_1]:setActive(false)
	end
end

function var_0_0.openDesc(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = arg_25_0.viewContainer:getRLOCCur()

	if var_25_0 or var_25_1 then
		if arg_25_1 then
			arg_25_1(arg_25_2)
		end

		return
	end

	arg_25_0:_resetTweenDescPos()

	local var_25_2 = arg_25_0.viewContainer:getEpisodeConfigCur()
	local var_25_3 = math.max(var_25_2.time or 0, 1)

	gohelper.setActive(arg_25_0._goWrongChannel, false)
	gohelper.setActive(arg_25_0._scroll_TaskDescGo, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)

	local function var_25_4()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)

		if arg_25_1 then
			arg_25_1(arg_25_2)
		end
	end

	GameUtil.onDestroyViewMember_TweenId(arg_25_0, "_tweenId")

	arg_25_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, var_25_3, arg_25_0._tweenDescUpdateCb, function()
		arg_25_0:_tweenDescEndCb(var_25_3, var_25_4)
	end, arg_25_0)
end

local var_0_7 = Mathf.Lerp

function var_0_0._tweenDescUpdateCb(arg_28_0, arg_28_1)
	local var_28_0 = var_0_7(0, arg_28_0._taskDescViewportHeight, arg_28_1)

	arg_28_0:_setMaskPaddingBottom(var_28_0)
end

function var_0_0._tweenDescEndCb(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0._descHeight - arg_29_0._taskDescViewportHeight

	if var_29_0 <= 0 then
		if arg_29_2 then
			arg_29_2(arg_29_3)
		end

		return
	end

	local var_29_1 = var_29_0 * (arg_29_1 / arg_29_0._taskDescViewportHeight)

	GameUtil.onDestroyViewMember_TweenId(arg_29_0, "_movetweenId")

	arg_29_0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(arg_29_0._txtTaskContentTran, var_29_0, var_29_1, arg_29_2, arg_29_3)
end

function var_0_0._resetTaskContentPos(arg_30_0)
	recthelper.setAnchorY(arg_30_0._txtTaskContentTran, 0)
end

function var_0_0.episode2Index(arg_31_0, arg_31_1)
	return arg_31_1
end

function var_0_0.index2EpisodeId(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._itemTabList[arg_32_1]

	if not var_32_0 then
		return
	end

	return var_32_0._mo
end

function var_0_0._setMaskPaddingBottom(arg_33_0, arg_33_1)
	arg_33_0._taskDescMask.padding = var_0_1(0, arg_33_1, 0, 0)
end

function var_0_0._autoSelectTab(arg_34_0)
	local var_34_0 = arg_34_0.viewContainer:getCurSelectedEpisode() or arg_34_0.viewContainer:getFirstRewardEpisode()

	arg_34_0.viewContainer:setCurSelectEpisodeIdSlient(var_34_0)
	arg_34_0:_setSelectIndex(arg_34_0:episode2Index(var_34_0), true)
end

function var_0_0._create_V2a2_WarmUp_radiotaskitem(arg_35_0, arg_35_1)
	local var_35_0 = gohelper.cloneInPlace(arg_35_0._goradiotaskitem)
	local var_35_1 = V2a2_WarmUp_radiotaskitem.New({
		parent = arg_35_0,
		baseViewContainer = arg_35_0.viewContainer
	})

	var_35_1:setIndex(arg_35_1)
	var_35_1:init(var_35_0)

	return var_35_1
end

function var_0_0._create_V2a2_WarmUp_rewarditem(arg_36_0, arg_36_1)
	local var_36_0 = gohelper.cloneInPlace(arg_36_0._gorewarditem)
	local var_36_1 = V2a2_WarmUp_rewarditem.New({
		parent = arg_36_0,
		baseViewContainer = arg_36_0.viewContainer
	})

	var_36_1:setIndex(arg_36_1)
	var_36_1:init(var_36_0)

	return var_36_1
end

function var_0_0._resetTweenDescPos(arg_37_0)
	GameUtil.onDestroyViewMember_TweenId(arg_37_0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_37_0, "_tweenId")
	arg_37_0:_resetTaskContentPos()
end

function var_0_0._playAnim(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0._animatorPlayer:Play(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0.tweenSwitch(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0:_playAnim(UIAnimationName.Switch, arg_39_1, arg_39_2)
end

function var_0_0._onSwitch(arg_40_0)
	local var_40_0 = arg_40_0.viewContainer:getCurSelectedEpisode()
	local var_40_1

	if arg_40_0._lastSelectedIndex then
		var_40_1 = arg_40_0._itemTabList[arg_40_0._lastSelectedIndex]._mo
	end

	arg_40_0.viewContainer:switchTabNoAnim(var_40_0, var_40_1)
end

function var_0_0.playRewardItemsHasGetAnim(arg_41_0)
	for iter_41_0 = 1, arg_41_0._rewardCount do
		arg_41_0._rewardItemList[iter_41_0]:playAnim_hasget()
	end
end

function var_0_0.setBlock_scroll(arg_42_0, arg_42_1)
	arg_42_0._scrollCanvasGroup.blocksRaycasts = not arg_42_1
end

return var_0_0
