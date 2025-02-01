module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressView", package.seeall)

slot0 = class("V1a6_CachotProgressView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._txtdetail = gohelper.findChildText(slot0.viewGO, "Left/#txt_detail")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "Left/#txt_score")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "Left/#txt_score/#simage_icon")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "Left/#go_progress")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "Left/#go_progress/#scroll_view")
	slot0._gofillbg = gohelper.findChild(slot0.viewGO, "Left/#go_progress/#scroll_view/Viewport/Content/#go_fillbg")
	slot0._gofill = gohelper.findChild(slot0.viewGO, "Left/#go_progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gonextstagetips = gohelper.findChild(slot0.viewGO, "Left/#go_nextstagetips")
	slot0._txtnextstageopentime = gohelper.findChildText(slot0.viewGO, "Left/#go_nextstagetips/nextstage/#txt_nextstageopentime")
	slot0._txtreamindoulescore = gohelper.findChildText(slot0.viewGO, "Left/#txt_score/#txt_remaindoublescore")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_back")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, slot0.onRogueSateInfoUpdate, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onWeekRefresh, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, slot0.onRogueSateInfoUpdate, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onWeekRefresh, slot0)
	slot0._btnback:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	V1a6_CachotProgressListModel.instance:initDatas()
	slot0:refreshScoreUI()
end

function slot0.refreshScoreUI(slot0)
	slot0:refreshScoreInfo()
	slot0:refreshStageInfo()
	slot0:setProgressBarWidth()
	slot0:setProgressHorizontalPos()
	slot0:refreshRedDot()
end

function slot0.refreshStageInfo(slot0)
	slot0:updateUnLockNextStageRemainTime()
end

function slot0.refreshUnLockNextStageTimeUI(slot0, slot1, slot2)
	if slot1 > 0 then
		slot0._txtnextstageopentime.text = formatLuaLang("cachotprogressview_remainDay", slot1)
	else
		slot0._txtnextstageopentime.text = formatLuaLang("cachotprogressview_remainHour", slot2)
	end
end

function slot0.refreshScoreInfo(slot0)
	slot5 = tonumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.DoubleScoreLimit] and slot2.value or 0) <= V1a6_CachotProgressListModel.instance:getWeekScore()
	slot0._txtscore.text = V1a6_CachotProgressListModel.instance:getCurGetTotalScore() or ""

	gohelper.setActive(slot0._txtreamindoulescore.gameObject, not slot5)

	if not slot5 then
		slot0._txtreamindoulescore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("cachot_progressview_remaindoublescore"), {
			slot4,
			slot3
		})
	end
end

slot0.SingleRewardtWidth = 240

function slot0.setProgressBarWidth(slot0)
	slot0:setScrollFillBgWidth(V1a6_CachotProgressListModel.instance:getUnLockedRewardCount())
	slot0:setScrollFillWidth()
end

function slot0.setScrollFillBgWidth(slot0, slot1)
	slot2 = 0
	slot3 = slot1 - 1

	recthelper.setWidth(slot0._gofillbg.transform, Mathf.Clamp(slot3, 0, slot3) * uv0.SingleRewardtWidth)
end

function slot0.setScrollFillWidth(slot0)
	if V1a6_CachotProgressListModel.instance:getCurrentStage() <= 0 then
		recthelper.setWidth(slot0._gofill.transform, 0)

		return
	end

	slot2 = V1a6_CachotProgressListModel.instance:getCurFinishRewardCount()
	slot4, slot5 = V1a6_CachotScoreConfig.instance:getStagePartRange(V1a6_CachotProgressListModel.instance:getCurGetTotalScore())

	if (V1a6_CachotScoreConfig.instance:getStagePartScore(slot5) - V1a6_CachotScoreConfig.instance:getStagePartScore(slot4) > 0 and (slot3 - slot6) / slot8 or 0) >= 1 then
		slot9 = 0
	end

	slot10 = slot2 + slot9

	recthelper.setWidth(slot0._gofill.transform, Mathf.Clamp(slot10 - 1, 0, slot10) * uv0.SingleRewardtWidth)
end

function slot0.setProgressHorizontalPos(slot0)
	slot1 = slot0.viewContainer._scrollView:getCsScroll()

	if V1a6_CachotProgressListModel.instance:getHasFinishedMoList() and #slot2 > 0 then
		for slot7 = 1, #slot2 - 1 do
			slot3 = 0 + (slot0.viewContainer._scrollParam.startSpace or 0) + (slot2[slot7]:getLineWidth() or 0)
		end
	end

	slot0.viewContainer._scrollView:refreshScroll()

	slot1.HorizontalScrollPixel = math.max(0, slot3)
end

function slot0.updateUnLockNextStageRemainTime(slot0)
	slot1 = V1a6_CachotProgressListModel.instance:isAllRewardUnLocked()

	gohelper.setActive(slot0._gonextstagetips, not slot1)

	if not slot1 then
		TaskDispatcher.cancelTask(slot0.onOneMinutesPassCallBack, slot0)
		TaskDispatcher.runRepeat(slot0.onOneMinutesPassCallBack, slot0, TimeUtil.OneMinuteSecond)
		slot0:checkIsArriveUnLockNextStageTime()
	end
end

function slot0.onOneMinutesPassCallBack(slot0)
	V1a6_CachotProgressListModel.instance:updateUnLockNextStageRemainTime(TimeUtil.OneMinuteSecond)
	slot0:checkIsArriveUnLockNextStageTime()
end

function slot0.checkIsArriveUnLockNextStageTime(slot0)
	if V1a6_CachotProgressListModel.instance:getUnLockNextStageRemainTime() and slot1 > 0 then
		slot2, slot3 = TimeUtil.secondsToDDHHMMSS(slot1)

		slot0:refreshUnLockNextStageTimeUI(slot2, slot3)
	else
		TaskDispatcher.cancelTask(slot0.onOneMinutesPassCallBack, slot0)
		RogueRpc.instance:sendGetRogueStateRequest()
	end
end

function slot0.onRogueSateInfoUpdate(slot0)
	V1a6_CachotProgressListModel.instance:initDatas()
	slot0:refreshScoreUI()
end

function slot0._onWeekRefresh(slot0)
	RogueRpc.instance:sendGetRogueStateRequest()
end

function slot0.refreshRedDot(slot0)
	slot1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueDoubleScore
	slot3 = ServerTime.now()

	if V1a6_CachotProgressListModel.instance:checkRewardStageChange() then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueRewardStage, V1a6_CachotProgressListModel.instance:getCurrentStage())
		V1a6_CachotProgressListModel.instance:checkRewardStageChangeRed()
	end

	if V1a6_CachotProgressListModel.instance:checkDoubleStoreRefresh() then
		PlayerPrefsHelper.setString(slot1, slot3)
		V1a6_CachotProgressListModel.instance:checkDoubleStoreRefreshRed()
	end
end

function slot0._btnbackOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.onOneMinutesPassCallBack, slot0)
end

return slot0
