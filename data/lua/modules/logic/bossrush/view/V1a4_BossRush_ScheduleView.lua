module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleView", package.seeall)

slot0 = class("V1a4_BossRush_ScheduleView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_Reward")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content")
	slot0._goGrayLine = gohelper.findChild(slot0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	slot0._goNormalLine = gohelper.findChild(slot0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_NormalLine")
	slot0._goTarget = gohelper.findChild(slot0.viewGO, "Root/#go_Target")
	slot0._simageTargetBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#go_Target/#simage_TargetBG")
	slot0._goTargetContent = gohelper.findChild(slot0.viewGO, "Root/#go_Target/#go_TargetContent")
	slot0._txtProgress = gohelper.findChildText(slot0.viewGO, "Root/ProgressTip/#txt_Progress")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

slot1 = string.format
slot2 = SLFramework.UGUI.UIDragListener
slot3 = SLFramework.UGUI.UIClickListener
slot4 = 425
slot5 = 1.5
slot6 = {
	Content = 2,
	ProgressBar = 1
}

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._scrollRewardGo = slot0._scrollReward.gameObject
	slot0._goGraylineTran = slot0._goGrayLine.transform
	slot0._goNormallineTran = slot0._goNormalLine.transform
	slot0._goContentTran = slot0._goContent.transform
	slot0._rectViewPortTran = gohelper.findChild(slot0._scrollRewardGo, "Viewport").transform
	slot0._hLayoutGroup = slot0._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	slot0._goGraylinePosX = recthelper.getAnchorX(slot0._goGraylineTran)

	slot0:_initTargetItem()
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulebg"))
	slot0._simageTargetBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulerightbg"))

	slot0._drag = uv0.Get(slot0._scrollRewardGo)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._scrollRewardGo, DungeonMapEpisodeAudio, slot0._scrollReward)
	slot0._touch = uv1.Get(slot0._scrollRewardGo)

	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)
	slot0._scrollReward:AddOnValueChanged(slot0._onScrollChange, slot0)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)
	recthelper.setAnchorX(slot0._goContentTran, 0)

	slot0._listStaticData = {}
end

function slot0._initTargetItem(slot0)
	slot1 = V1a4_BossRush_ScheduleItem
	slot0._targetItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_scheduleitem, slot0._goTargetContent, slot1.__cname), slot1)

	slot0:_setTargetActive(false)
end

function slot0._onDragBeginHandler(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEndHandler(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDownHandler(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0._onScrollChange(slot0, slot1)
	if slot0._isGetAllDisplay then
		return
	end

	slot0:_showTarget()
end

function slot0.onUpdateParam(slot0)
end

function slot0._getStage(slot0)
	return slot0.viewParam.stage
end

function slot0.onOpen(slot0)
	slot0:_setListStaticData(0, 0, 0)
	V1a4_BossRush_ScheduleViewListModel.instance:setStaticData(slot0._listStaticData)

	slot1 = slot0:_getStage()
	slot2 = BossRushModel.instance:getLastPointInfo(slot1)
	slot3, slot0._lastRewardIndex = BossRushModel.instance:calcRewardClaim(slot1, slot2.last)
	slot0._isAutoClaim, slot0._claimRewardIndex = BossRushModel.instance:calcRewardClaim(slot1, slot2.cur)
	slot0._lastPointInfo = slot2
	slot0._displayAllIndexes = BossRushConfig.instance:getStageRewardDisplayIndexesList(slot1)

	if slot0._isAutoClaim then
		slot0:_setListStaticData(0, slot4 + 1, slot0._claimRewardIndex)
	end

	slot0:_refresh()
	slot0:_showTarget()
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveAct128GetTotalRewardsReply, slot0._refresh, slot0)
end

function slot0._setListStaticData(slot0, slot1, slot2, slot3)
	slot0._listStaticData.curIndex = slot1 or 0
	slot0._listStaticData.fromIndex = slot2 or 0
	slot0._listStaticData.toIndex = slot3 or 0
end

function slot0.onOpenFinish(slot0)
	slot0:_openTweenStart()
end

function slot0.onClose(slot0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveAct128GetTotalRewardsReply, slot0._refresh, slot0)

	if slot0._isAutoClaim then
		slot0:_openTweenFinishInner()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagePanelBG:UnLoadImage()
	slot0._simageTargetBG:UnLoadImage()
	slot0._scrollReward:RemoveOnValueChanged()
	slot0:_deleteProgressTween()
	slot0:_deleteContentTween()
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()
	end

	slot0._drag = nil

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()
	end

	slot0._touch = nil

	if slot0._audioScroll then
		slot0._audioScroll:onDestroy()
	end

	slot0._audioScroll = nil
end

function slot0._deleteProgressTween(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_progressBarTweenId")
end

function slot0._deleteContentTween(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_contentTweenId")
end

function slot0._refresh(slot0)
	slot2 = slot0._lastPointInfo
	slot3 = slot2.last
	slot4 = slot2.max
	slot5 = BossRushModel.instance:getScheduleViewRewardList(slot0:_getStage())
	slot6 = {}

	if #slot0._displayAllIndexes > 0 and slot0._claimRewardIndex < slot0._displayAllIndexes[slot7] then
		for slot11, slot12 in ipairs(slot0._displayAllIndexes) do
			if not slot5[slot12].isGot then
				slot6[#slot6 + 1] = slot12
			end
		end
	end

	slot0._dataList = slot5
	slot0._notGotDisplayIndexes = slot6
	slot0._isGetAllDisplay = #slot6 == 0

	slot0:_refreshProgress(slot3, slot4)

	if slot0._isGetAllDisplay then
		slot0:_setTargetActive(false)

		slot0._rectViewPortTran.offsetMax = Vector2(uv0, 0)
	else
		slot0:_setTargetActive(true)

		slot0._rectViewPortTran.offsetMax = Vector2(0, 0)
	end

	recthelper.setWidth(slot0._goContentTran, slot0:_calcHLayoutContentMaxWidth(#slot5))
	slot0:_initItemList(slot5)
	slot0:_refreshContentOffset(slot0._lastRewardIndex)
end

function slot0._create_V1a4_BossRush_ScheduleItem(slot0)
	slot1 = slot0.viewContainer:getListScrollParam()
	slot2 = slot1.cellClass

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(slot1.prefabUrl, slot0._goContent, slot2.__cname), slot2)
end

function slot0._initItemList(slot0, slot1)
	if slot0._itemList then
		return
	end

	slot0._itemList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0:_create_V1a4_BossRush_ScheduleItem()
		slot7._index = slot5

		slot7:setData(slot6)
		table.insert(slot0._itemList, slot7)
	end
end

function slot0._tweenProgress(slot0)
	slot0:_deleteProgressTween()

	slot1 = slot0._lastPointInfo

	if math.abs(slot1.last - slot1.cur) < 0.1 then
		slot0:_openTweenFinish(uv0.ProgressBar)

		return
	end

	slot0._progressBarTweenId = ZProj.TweenHelper.DOTweenFloat(slot2, slot3, uv1, slot0._progressBarTweenUpdateCb, slot0._progressBarTweenFinishedCb, slot0, nil, EaseType.Linear)
end

function slot0._progressBarTweenUpdateCb(slot0, slot1)
	slot0:_refreshProgress(math.floor(slot1), slot0._lastPointInfo.max)
end

function slot0._progressBarTweenFinishedCb(slot0)
	slot0:_openTweenFinish(uv0.ProgressBar)
end

function slot0._tweenContent(slot0)
	slot0:_deleteContentTween()

	if not slot0._isAutoClaim then
		slot0:_openTweenFinish(uv0.Content)

		return
	end

	if math.abs(-recthelper.getAnchorX(slot0._goContentTran) - slot0:_calcHorizontalLayoutPixel(slot0._claimRewardIndex)) < 0.1 then
		slot0:_openTweenFinish(uv0.Content)

		return
	end

	slot0._contentTweenId = ZProj.TweenHelper.DOTweenFloat(slot2, slot3, uv1, slot0._contentTweenUpdateCb, slot0._contentTweenFinishedCb, slot0, nil, EaseType.Linear)
end

function slot0._contentTweenUpdateCb(slot0, slot1)
	recthelper.setAnchorX(slot0._goContentTran, -slot1)
end

function slot0._contentTweenFinishedCb(slot0)
	slot0:_openTweenFinish(uv0.Content)
end

function slot0._openTweenStart(slot0)
	slot0._openedTweens = {
		[uv0.ProgressBar] = true,
		[uv0.Content] = true
	}

	slot0:_tweenContent()
	slot0:_tweenProgress()
end

function slot0._openTweenFinish(slot0, slot1)
	slot0._openedTweens[slot1] = nil

	if next(slot0._openedTweens) then
		return
	end

	slot0:_openTweenFinishInner()
end

function slot0._openTweenFinishInner(slot0)
	slot2 = slot0._lastPointInfo.cur
	slot0._lastRewardIndex = slot0._claimRewardIndex
	slot0._lastPointInfo.last = slot2

	BossRushModel.instance:setStageLastTotalPoint(slot0:_getStage(), slot2)

	if not slot0._isAutoClaim then
		return
	end

	slot0._isAutoClaim = false

	BossRushRpc.instance:sendAct128GetTotalRewardsRequest(slot1)
end

function slot0._refreshProgress(slot0, slot1, slot2)
	slot5 = slot0.viewContainer:getListScrollParam().cellWidth
	slot6 = slot0:_getCellSpaceH()
	slot7 = slot0._goGraylinePosX
	slot12, slot13 = BossRushConfig.instance:calcStageRewardProgWidth(slot0:_getStage(), slot1, slot6, slot5, slot0._hLayoutGroup.padding.left + slot5 / 2, slot6 + slot5, slot7, -slot7)

	recthelper.setWidth(slot0._goGraylineTran, slot13)
	recthelper.setWidth(slot0._goNormallineTran, slot12)

	slot0._txtProgress.text = uv0("<color=#b34a16>%s</color>/%s", slot1, slot2)
end

function slot0._refreshContentOffset(slot0, slot1)
	recthelper.setAnchorX(slot0._goContentTran, -slot0:_calcHorizontalLayoutPixel(slot1))
end

slot7 = 200
slot8 = 1250

function slot0._calcHorizontalLayoutPixel(slot0, slot1)
	slot2 = slot0:_getCellSpaceH()
	slot4 = slot0._hLayoutGroup.padding.left

	if slot0._isGetAllDisplay then
		slot5 = uv0 + uv1
	end

	slot7 = math.max(0, recthelper.getWidth(slot0._goContentTran) - slot5)

	if slot1 <= 1 then
		return 0
	end

	return math.min(slot7, (slot1 - 1) * (slot2 + uv2) + slot4)
end

function slot0._getCellSpaceH(slot0)
	return slot0._hLayoutGroup.spacing
end

function slot0._calcHLayoutContentMaxWidth(slot0, slot1)
	slot2 = slot0.viewContainer:getListScrollParam()
	slot3 = slot2.cellWidth

	return (slot3 + slot0:_getCellSpaceH()) * math.max(0, slot1 or #slot0._dataList) - slot0._hLayoutGroup.padding.left - slot3 / 2 + slot2.endSpace
end

slot9 = 2

function slot0._showTarget(slot0)
	if not slot0._notGotDisplayIndexes or #slot1 == 0 then
		slot0:_setTargetActive(false)

		return
	end

	slot0:_setTargetActive(true)

	slot3 = slot0.viewContainer:getListScrollParam()
	slot4 = slot3.cellWidth
	slot9, slot10 = nil
	slot9 = math.abs(recthelper.getAnchorX(slot0._goContentTran)) <= slot4 / 2 and 2 + uv0 or 2 + math.floor((slot8 - slot7) / (slot4 + slot3.cellSpaceH)) + uv0

	for slot14, slot15 in ipairs(slot1) do
		if slot9 <= slot15 then
			slot10 = slot15

			break
		end
	end

	slot10 = slot10 or math.min(slot9, slot1[#slot1])
	slot11 = slot0._dataList[slot10]
	slot11._index = slot10

	slot0._targetItem:refreshByDisplayTarget(slot11)
end

function slot0._showFirstTarget(slot0)
	if not slot0._notGotDisplayIndexes or #slot1 == 0 then
		slot0:_setTargetActive(false)

		return
	end

	slot0:_setTargetActive(true)

	slot2 = slot1[1]
	slot3 = slot0._dataList[slot2]
	slot3._index = slot2

	slot0._targetItem:refreshByDisplayTarget(slot3)
end

function slot0._setTargetActive(slot0, slot1)
	gohelper.setActive(slot0._goTarget, slot1)
end

return slot0
