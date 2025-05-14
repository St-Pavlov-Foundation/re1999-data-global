module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressView", package.seeall)

local var_0_0 = class("V1a6_CachotProgressView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._txtdetail = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_detail")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_score")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#txt_score/#simage_icon")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "Left/#go_progress")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#go_progress/#scroll_view")
	arg_1_0._gofillbg = gohelper.findChild(arg_1_0.viewGO, "Left/#go_progress/#scroll_view/Viewport/Content/#go_fillbg")
	arg_1_0._gofill = gohelper.findChild(arg_1_0.viewGO, "Left/#go_progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gonextstagetips = gohelper.findChild(arg_1_0.viewGO, "Left/#go_nextstagetips")
	arg_1_0._txtnextstageopentime = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_nextstagetips/nextstage/#txt_nextstageopentime")
	arg_1_0._txtreamindoulescore = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_score/#txt_remaindoublescore")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_back")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, arg_2_0.onRogueSateInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onWeekRefresh, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, arg_3_0.onRogueSateInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onWeekRefresh, arg_3_0)
	arg_3_0._btnback:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	V1a6_CachotProgressListModel.instance:initDatas()
	arg_6_0:refreshScoreUI()
end

function var_0_0.refreshScoreUI(arg_7_0)
	arg_7_0:refreshScoreInfo()
	arg_7_0:refreshStageInfo()
	arg_7_0:setProgressBarWidth()
	arg_7_0:setProgressHorizontalPos()
	arg_7_0:refreshRedDot()
end

function var_0_0.refreshStageInfo(arg_8_0)
	arg_8_0:updateUnLockNextStageRemainTime()
end

function var_0_0.refreshUnLockNextStageTimeUI(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 > 0 then
		arg_9_0._txtnextstageopentime.text = formatLuaLang("cachotprogressview_remainDay", arg_9_1)
	else
		arg_9_0._txtnextstageopentime.text = formatLuaLang("cachotprogressview_remainHour", arg_9_2)
	end
end

function var_0_0.refreshScoreInfo(arg_10_0)
	local var_10_0 = V1a6_CachotProgressListModel.instance:getCurGetTotalScore()
	local var_10_1 = lua_rogue_const.configDict[V1a6_CachotEnum.Const.DoubleScoreLimit]
	local var_10_2 = tonumber(var_10_1 and var_10_1.value or 0)
	local var_10_3 = V1a6_CachotProgressListModel.instance:getWeekScore()
	local var_10_4 = var_10_2 <= var_10_3

	arg_10_0._txtscore.text = var_10_0 or ""

	gohelper.setActive(arg_10_0._txtreamindoulescore.gameObject, not var_10_4)

	if not var_10_4 then
		local var_10_5 = {
			var_10_3,
			var_10_2
		}

		arg_10_0._txtreamindoulescore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("cachot_progressview_remaindoublescore"), var_10_5)
	end
end

var_0_0.SingleRewardtWidth = 240

function var_0_0.setProgressBarWidth(arg_11_0)
	local var_11_0 = V1a6_CachotProgressListModel.instance:getUnLockedRewardCount()

	arg_11_0:setScrollFillBgWidth(var_11_0)
	arg_11_0:setScrollFillWidth()
end

function var_0_0.setScrollFillBgWidth(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = arg_12_1 - 1
	local var_12_2 = Mathf.Clamp(var_12_1, 0, var_12_1) * var_0_0.SingleRewardtWidth

	recthelper.setWidth(arg_12_0._gofillbg.transform, var_12_2)
end

function var_0_0.setScrollFillWidth(arg_13_0)
	if V1a6_CachotProgressListModel.instance:getCurrentStage() <= 0 then
		recthelper.setWidth(arg_13_0._gofill.transform, 0)

		return
	end

	local var_13_0 = V1a6_CachotProgressListModel.instance:getCurFinishRewardCount()
	local var_13_1 = V1a6_CachotProgressListModel.instance:getCurGetTotalScore()
	local var_13_2, var_13_3 = V1a6_CachotScoreConfig.instance:getStagePartRange(var_13_1)
	local var_13_4 = V1a6_CachotScoreConfig.instance:getStagePartScore(var_13_2)
	local var_13_5 = V1a6_CachotScoreConfig.instance:getStagePartScore(var_13_3) - var_13_4
	local var_13_6 = var_13_5 > 0 and (var_13_1 - var_13_4) / var_13_5 or 0

	if var_13_6 >= 1 then
		var_13_6 = 0
	end

	local var_13_7 = var_13_0 + var_13_6
	local var_13_8 = Mathf.Clamp(var_13_7 - 1, 0, var_13_7) * var_0_0.SingleRewardtWidth

	recthelper.setWidth(arg_13_0._gofill.transform, var_13_8)
end

function var_0_0.setProgressHorizontalPos(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer._scrollView:getCsScroll()
	local var_14_1 = V1a6_CachotProgressListModel.instance:getHasFinishedMoList()
	local var_14_2 = 0

	if var_14_1 and #var_14_1 > 0 then
		var_14_2 = var_14_2 + (arg_14_0.viewContainer._scrollParam.startSpace or 0)

		for iter_14_0 = 1, #var_14_1 - 1 do
			var_14_2 = var_14_2 + (var_14_1[iter_14_0]:getLineWidth() or 0)
		end
	end

	arg_14_0.viewContainer._scrollView:refreshScroll()

	var_14_0.HorizontalScrollPixel = math.max(0, var_14_2)
end

function var_0_0.updateUnLockNextStageRemainTime(arg_15_0)
	local var_15_0 = V1a6_CachotProgressListModel.instance:isAllRewardUnLocked()

	gohelper.setActive(arg_15_0._gonextstagetips, not var_15_0)

	if not var_15_0 then
		TaskDispatcher.cancelTask(arg_15_0.onOneMinutesPassCallBack, arg_15_0)
		TaskDispatcher.runRepeat(arg_15_0.onOneMinutesPassCallBack, arg_15_0, TimeUtil.OneMinuteSecond)
		arg_15_0:checkIsArriveUnLockNextStageTime()
	end
end

function var_0_0.onOneMinutesPassCallBack(arg_16_0)
	V1a6_CachotProgressListModel.instance:updateUnLockNextStageRemainTime(TimeUtil.OneMinuteSecond)
	arg_16_0:checkIsArriveUnLockNextStageTime()
end

function var_0_0.checkIsArriveUnLockNextStageTime(arg_17_0)
	local var_17_0 = V1a6_CachotProgressListModel.instance:getUnLockNextStageRemainTime()

	if var_17_0 and var_17_0 > 0 then
		local var_17_1, var_17_2 = TimeUtil.secondsToDDHHMMSS(var_17_0)

		arg_17_0:refreshUnLockNextStageTimeUI(var_17_1, var_17_2)
	else
		TaskDispatcher.cancelTask(arg_17_0.onOneMinutesPassCallBack, arg_17_0)
		RogueRpc.instance:sendGetRogueStateRequest()
	end
end

function var_0_0.onRogueSateInfoUpdate(arg_18_0)
	V1a6_CachotProgressListModel.instance:initDatas()
	arg_18_0:refreshScoreUI()
end

function var_0_0._onWeekRefresh(arg_19_0)
	RogueRpc.instance:sendGetRogueStateRequest()
end

function var_0_0.refreshRedDot(arg_20_0)
	local var_20_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueDoubleScore
	local var_20_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueRewardStage
	local var_20_2 = ServerTime.now()
	local var_20_3 = V1a6_CachotProgressListModel.instance:getCurrentStage()

	if V1a6_CachotProgressListModel.instance:checkRewardStageChange() then
		PlayerPrefsHelper.setNumber(var_20_1, var_20_3)
		V1a6_CachotProgressListModel.instance:checkRewardStageChangeRed()
	end

	if V1a6_CachotProgressListModel.instance:checkDoubleStoreRefresh() then
		PlayerPrefsHelper.setString(var_20_0, var_20_2)
		V1a6_CachotProgressListModel.instance:checkDoubleStoreRefreshRed()
	end
end

function var_0_0._btnbackOnClick(arg_21_0)
	arg_21_0:closeThis()
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.onOneMinutesPassCallBack, arg_23_0)
end

return var_0_0
