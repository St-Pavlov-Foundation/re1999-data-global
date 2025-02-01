module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossScheduleView", package.seeall)

slot0 = class("VersionActivity1_6_BossScheduleView", BaseView)

function slot0._getViewportW(slot0)
	return recthelper.getWidth(slot0._scrollReward.transform)
end

function slot0._calcContentWidth(slot0)
	return recthelper.getWidth(slot0._goContentTran)
end

function slot0._getMaxScrollX(slot0)
	return math.max(0, slot0:_calcContentWidth() - slot0:_getViewportW())
end

slot1 = 1.5
slot2 = {
	Content = 2,
	ProgressBar = 1
}

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_Reward")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content")
	slot0._goGrayLine = gohelper.findChild(slot0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	slot0._goNormalLine = gohelper.findChild(slot0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_NormalLine")
	slot0._txtProgress = gohelper.findChildText(slot0.viewGO, "Root/ProgressTip/#txt_Progress")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")
	slot0._txtbestProgress = gohelper.findChildText(slot0.viewGO, "Root/#txt_Progress")
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

	slot0._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulebg"))

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollRewardGo)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._scrollRewardGo, DungeonMapEpisodeAudio, slot0._scrollReward)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._scrollRewardGo)

	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)
	slot0._scrollReward:AddOnValueChanged(slot0._onScrollChange, slot0)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)
	recthelper.setAnchorX(slot0._goContentTran, 0)

	slot0._listStaticData = {}
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
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_setListStaticData(0, 0, 0)
	VersionActivity1_6ScheduleViewListModel.instance:setStaticData(slot0._listStaticData)

	slot0._isAutoClaim, slot0._lastRewardIndex, slot0._claimRewardIndex = VersionActivity1_6DungeonBossModel.instance:checkAbleGetReward(VersionActivity1_6DungeonBossModel.instance:getTotalScore())

	if slot0._isAutoClaim then
		slot0:_setListStaticData(0, slot0._lastRewardIndex + 1, slot0._claimRewardIndex)
	end

	slot0:_refresh()
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
	if slot0._isAutoClaim then
		slot0:_openTweenFinishInner()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagePanelBG:UnLoadImage()
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
	slot1 = VersionActivity1_6DungeonBossModel.instance:getScheduleViewRewardList()
	slot2 = {}
	slot4 = VersionActivity1_6DungeonBossModel.instance:getAleadyGotBonusIds()

	for slot8, slot9 in ipairs(Activity149Config.instance:getBossRewardCfgList()) do
		if not slot1[slot8].isGot then
			slot2[#slot2 + 1] = slot8
		end
	end

	slot0._dataList = slot1

	recthelper.setWidth(slot0._goContentTran, slot0:_calcHLayoutContentMaxWidth(#slot1))
	slot0:_initItemList(slot1)
	slot0:_refreshContentOffset(slot0._lastRewardIndex)
	slot0:_refreshBestProgress()
end

function slot0._createScheduleItem(slot0)
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
		slot7 = slot0:_createScheduleItem()
		slot7._index = slot5

		slot7:setData(slot6)
		table.insert(slot0._itemList, slot7)
	end
end

function slot0._openTweenStart(slot0)
	slot0._openedTweens = {
		[uv0.ProgressBar] = true,
		[uv0.Content] = true
	}

	slot0:_tweenContent()
	slot0:_tweenProgress()
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

function slot0._openTweenFinish(slot0, slot1)
	slot0._openedTweens[slot1] = nil

	if next(slot0._openedTweens) then
		return
	end

	slot0:_openTweenFinishInner()
end

function slot0._contentTweenUpdateCb(slot0, slot1)
	recthelper.setAnchorX(slot0._goContentTran, -slot1)
end

function slot0._contentTweenFinishedCb(slot0)
	slot0:_openTweenFinish(uv0.Content)
end

function slot0._tweenProgress(slot0)
	slot0:_deleteProgressTween()

	slot1 = VersionActivity1_6DungeonBossModel.instance
	slot2 = slot1:getScorePrefValue()

	if slot1:getTotalScore() == 0 then
		slot0:_progressBarTweenUpdateCb(0)
	end

	if math.abs(slot2 - slot3) < 0.1 then
		slot0:_refreshProgress(slot3, Activity149Config.instance:getBossRewardMaxScore())
		slot0:_openTweenFinish(uv0.ProgressBar)

		return
	end

	slot1:setScorePrefValue(slot3)

	slot0._progressBarTweenId = ZProj.TweenHelper.DOTweenFloat(slot2, slot3, uv1, slot0._progressBarTweenUpdateCb, slot0._progressBarTweenFinishedCb, slot0, nil, EaseType.Linear)
end

function slot0._progressBarTweenUpdateCb(slot0, slot1)
	slot0:_refreshProgress(math.floor(slot1), Activity149Config.instance:getBossRewardMaxScore())
end

function slot0._progressBarTweenFinishedCb(slot0)
	slot0:_openTweenFinish(uv0.ProgressBar)
end

function slot0._openTweenFinishInner(slot0)
	if not slot0._isAutoClaim then
		return
	end

	slot0._isAutoClaim = false

	VersionActivity1_6DungeonRpc.instance:sendAct149GetScoreRewardsRequest()
end

function slot0._refreshProgress(slot0, slot1, slot2)
	slot4 = slot0.viewContainer:getListScrollParam().cellWidth
	slot5 = slot0:_getCellSpaceH()
	slot6 = slot0._goGraylinePosX
	slot11, slot12 = Activity149Config.instance:calRewardProgressWidth(slot1, slot5, slot4, slot0._hLayoutGroup.padding.left + slot4 / 2, slot5 + slot4, slot6, -slot6)

	recthelper.setWidth(slot0._goGraylineTran, slot12)
	recthelper.setWidth(slot0._goNormallineTran, slot11)

	if LangSettings.instance:isEn() then
		slot0._txtProgress.text = string.format(" <color=#b34a16>%s</color>/%s", slot1, slot2)
	else
		slot0._txtProgress.text = string.format("<color=#b34a16>%s</color>/%s", slot1, slot2)
	end
end

function slot0._refreshBestProgress(slot0)
	if LangSettings.instance:isEn() then
		slot0._txtbestProgress.text = " " .. VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()
	else
		slot0._txtbestProgress.text = slot1
	end
end

function slot0._refreshContentOffset(slot0, slot1)
	recthelper.setAnchorX(slot0._goContentTran, -slot0:_calcHorizontalLayoutPixel(slot1))
end

slot3 = 200

function slot0._calcHorizontalLayoutPixel(slot0, slot1)
	slot2 = slot0:_getCellSpaceH()
	slot4 = slot0._hLayoutGroup.padding.left
	slot5 = recthelper.getWidth(slot0._goContentTran)
	slot6 = slot0:_getMaxScrollX()

	if slot1 <= 1 then
		return 0
	end

	return math.min(slot6, (slot1 - 1) * (slot2 + uv0) + slot4)
end

function slot0._getCellSpaceH(slot0)
	return slot0._hLayoutGroup.spacing
end

function slot0._calcHLayoutContentMaxWidth(slot0, slot1)
	slot2 = slot0.viewContainer:getListScrollParam()
	slot3 = slot2.cellWidth

	return (slot3 + slot0:_getCellSpaceH()) * math.max(0, slot1 or #slot0._dataList) - slot0._hLayoutGroup.padding.left - slot3 / 2 + slot2.endSpace
end

return slot0
