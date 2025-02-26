module("modules.logic.versionactivity2_3.warmup.view.V2a3_WarmUp", package.seeall)

slot0 = class("V2a3_WarmUp", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simageboxunopen = gohelper.findChildSingleImage(slot0.viewGO, "Middle/#simage_box_unopen")
	slot0._simageboxopen = gohelper.findChildSingleImage(slot0.viewGO, "Middle/#simage_box_open")
	slot0._simagelight = gohelper.findChildSingleImage(slot0.viewGO, "Middle/#simage_light")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "Middle/#image_icon")
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
end

function slot0.removeEvents(slot0)
	slot0._btngetreward:RemoveClickListener()
end

slot1 = _G.Vector4
slot2 = string.splitToNumber
slot3 = string.split
slot4 = SLFramework.AnimatorPlayer
slot5 = "switch"

function slot0._btngetrewardOnClick(slot0)
	slot1, slot2, slot3, slot4 = slot0.viewContainer:getRLOCCur()

	if not slot4 then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	slot0.viewContainer:sendFinishAct125EpisodeRequest()
end

function slot0._editableInitView(slot0)
	slot1 = slot0._scrollTaskDesc.gameObject
	slot3 = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	slot0._btngetrewardGo = slot0._btngetreward.gameObject
	slot0._txtTaskContentTran = slot0._txtTaskContent.transform
	slot0._scroll_TaskDescGo = slot1
	slot0._descScrollRect = slot1:GetComponent(gohelper.Type_ScrollRect)
	slot0._scrollCanvasGroup = gohelper.onceAddComponent(slot1, typeof(UnityEngine.CanvasGroup))
	slot0._taskDescViewportHeight = math.max(0, recthelper.getHeight(slot1.transform))
	slot0._taskDescMask = gohelper.findChild(slot1, "Viewport"):GetComponent(gohelper.Type_RectMask2D)
	slot0._goTaskContentTran = gohelper.findChild(slot3, "Viewport/Content").transform
	slot0._taskScrollViewportWidth = recthelper.getWidth(slot3.transform)
	slot0._animatorPlayer = uv0.Get(slot0.viewGO)
	slot0._animSelf = slot0._animatorPlayer.animator
	slot0._animEvent = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_AnimationEventWrap)

	slot0._animEvent:AddEventListener(uv1, slot0._onSwitch, slot0)
	slot0:_resetTaskContentPos()
	slot0:_setActive_goWrongChannel(false)

	slot0._txtLimitTime.text = ""
	slot0._descHeight = 0
	slot0._rewardCount = 0
	slot0._itemTabList = {}
	slot0._rewardItemList = {}
end

function slot0.onDataUpdateFirst(slot0)
	slot0:_refreshOnce()
end

function slot0.onDataUpdate(slot0)
	slot0:_refresh()
end

function slot0.onSwitchEpisode(slot0)
	slot0._descScrollRect:StopMovement()
	slot0:_resetTweenDescPos()
	slot0:_refresh()
	slot0.viewContainer:tryTweenDesc()
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshOnce()
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open_25001023)

	slot0._lastSelectedIndex = nil

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId")
	slot0._animEvent:RemoveEventListener(uv0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_itemTabList")
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshOnce(slot0)
	slot0:_showDeadline()
	slot0:_refreshTabList()
	slot0:_autoSelectTab()
end

function slot0._refresh(slot0)
	slot0:_refreshData()
	slot0:_refreshTabList()
	slot0:_refreshRewards()
	slot0:_refreshRightView()
end

function slot0._refreshRightView(slot0)
	slot1, slot2, slot3, slot4 = slot0.viewContainer:getRLOCCur()

	gohelper.setActive(slot0._btngetrewardGo, slot4)

	if slot1 or slot2 then
		slot0:_setActive_goWrongChannel(false)
	elseif not slot0.viewContainer:checkIsDone() then
		slot0:_setActive_goWrongChannel(true)
	end

	for slot8, slot9 in ipairs(slot0._rewardItemList) do
		slot9:refresh()
	end
end

function slot0._setActive_goWrongChannel(slot0, slot1)
	gohelper.setActive(slot0._goWrongChannel, slot1)
	gohelper.setActive(slot0._scroll_TaskDescGo, not slot1)

	if slot1 then
		slot0:_setMaskPaddingBottom(slot0._taskDescViewportHeight)
	else
		slot0:_setMaskPaddingBottom(0)
	end
end

function slot0._refreshData(slot0)
	slot1 = slot0.viewContainer:getEpisodeConfigCur()

	slot0.viewContainer:dispatchRedEvent()

	slot0._txtTaskTitle.text = slot1.name
	slot0._txtTaskContent.text = slot1.text
	slot0._descHeight = slot0._txtTaskContent.preferredHeight
end

function slot0._showDeadline(slot0)
	slot0:_showLeftTime()
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = slot0.viewContainer:getActivityRemainTimeStr()
end

function slot0._refreshTabList(slot0)
	for slot6 = 1, slot0.viewContainer:getEpisodeCount() do
		slot8 = slot6 == slot0.viewContainer:getCurSelectedEpisode()
		slot9 = nil

		if slot6 > #slot0._itemTabList then
			table.insert(slot0._itemTabList, slot0:_create_V2a3_WarmUp_radiotaskitem(slot6))
		else
			slot9 = slot0._itemTabList[slot6]
		end

		slot9:onUpdateMO(slot7)
		slot9:setActive(true)
		slot9:setSelected(slot8)
	end

	for slot6 = slot2 + 1, #slot0._itemTabList do
		slot0._itemTabList[slot6]:setActive(false)
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goTaskContentTran)
end

function slot0._setSelectIndex(slot0, slot1, slot2)
	if slot1 == slot0._lastSelectedIndex then
		return
	end

	if slot2 then
		slot0:_taskScrollToIndex(slot1)
	else
		slot0:onClickTab(slot0:index2EpisodeId(slot0.viewContainer:getCurSelectedEpisode()) or 1)
	end
end

slot6 = 166

function slot0._taskScrollToIndex(slot0, slot1)
	recthelper.setAnchorX(slot0._goTaskContentTran, -math.min((slot1 - 1) * uv0, math.max(recthelper.getWidth(slot0._goTaskContentTran) - slot0._taskScrollViewportWidth, 0)))

	slot0._lastSelectedIndex = slot1
end

function slot0.onClickTab(slot0, slot1)
	if slot0.viewContainer:getCurSelectedEpisode() == slot1 then
		return
	end

	slot0._lastSelectedIndex = slot0:episode2Index(slot2)

	slot0.viewContainer:switchTabWithAnim(slot3, slot2)
end

function slot0._refreshRewards(slot0)
	slot4 = #uv0(slot0.viewContainer:getEpisodeConfigCur().bonus, "|")
	slot0._rewardCount = slot4

	for slot8 = 1, slot4 do
		slot9 = nil
		slot10 = uv1(slot3[slot8], "#")

		if slot8 > #slot0._rewardItemList then
			table.insert(slot0._rewardItemList, slot0:_create_V2a3_WarmUp_rewarditem(slot8))
		else
			slot9 = slot0._rewardItemList[slot8]
		end

		slot9:onUpdateMO(slot10)
		slot9:setActive(true)
	end

	for slot8 = slot4 + 1, #slot0._rewardItemList do
		slot0._rewardItemList[slot8]:setActive(false)
	end
end

function slot0.openDesc(slot0, slot1, slot2)
	slot3, slot4 = slot0.viewContainer:getRLOCCur()

	if slot3 or slot4 then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	slot0:_resetTweenDescPos()

	slot7 = slot0.viewContainer:getEpisodeConfigCur().time or 0

	gohelper.setActive(slot0._goWrongChannel, false)
	gohelper.setActive(slot0._scroll_TaskDescGo, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)

	function slot7()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)

		if uv0 then
			uv0(uv1)
		end
	end

	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId")

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, math.max(slot7, 1), slot0._tweenDescUpdateCb, function ()
		uv0:_tweenDescEndCb(uv1, uv2)
	end, slot0)
end

slot7 = Mathf.Lerp

function slot0._tweenDescUpdateCb(slot0, slot1)
	slot0:_setMaskPaddingBottom(uv0(0, slot0._taskDescViewportHeight, slot1))
end

function slot0._tweenDescEndCb(slot0, slot1, slot2, slot3)
	if slot0._descHeight - slot0._taskDescViewportHeight <= 0 then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	GameUtil.onDestroyViewMember_TweenId(slot0, "_movetweenId")

	slot0._movetweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._txtTaskContentTran, slot4, slot4 * slot1 / slot0._taskDescViewportHeight, slot2, slot3)
end

function slot0._resetTaskContentPos(slot0)
	recthelper.setAnchorY(slot0._txtTaskContentTran, 0)
end

function slot0.episode2Index(slot0, slot1)
	return slot1
end

function slot0.index2EpisodeId(slot0, slot1)
	if not slot0._itemTabList[slot1] then
		return
	end

	return slot2._mo
end

function slot0._setMaskPaddingBottom(slot0, slot1)
	slot0._taskDescMask.padding = uv0(0, slot1, 0, 0)
end

function slot0._autoSelectTab(slot0)
	slot1 = slot0.viewContainer:getCurSelectedEpisode() or slot0.viewContainer:getFirstRewardEpisode()

	slot0.viewContainer:setCurSelectEpisodeIdSlient(slot1)
	slot0:_setSelectIndex(slot0:episode2Index(slot1), true)
end

function slot0._create_V2a3_WarmUp_radiotaskitem(slot0, slot1)
	slot3 = V2a3_WarmUp_radiotaskitem.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._goradiotaskitem))

	return slot3
end

function slot0._create_V2a3_WarmUp_rewarditem(slot0, slot1)
	slot3 = V2a3_WarmUp_rewarditem.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._gorewarditem))

	return slot3
end

function slot0._resetTweenDescPos(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId")
	slot0:_resetTaskContentPos()
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2, slot3)
end

function slot0.tweenSwitch(slot0, slot1, slot2)
	slot0:_playAnim(UIAnimationName.Switch, slot1, slot2)
end

function slot0._onSwitch(slot0)
	slot1 = slot0.viewContainer:getCurSelectedEpisode()
	slot2 = nil

	if slot0._lastSelectedIndex then
		slot2 = slot0._itemTabList[slot0._lastSelectedIndex]._mo
	end

	slot0.viewContainer:switchTabNoAnim(slot1, slot2)
end

function slot0.playRewardItemsHasGetAnim(slot0)
	for slot4 = 1, slot0._rewardCount do
		slot0._rewardItemList[slot4]:playAnim_hasget()
	end
end

function slot0.setBlock_scroll(slot0, slot1)
	slot0._scrollCanvasGroup.blocksRaycasts = not slot1
end

return slot0
