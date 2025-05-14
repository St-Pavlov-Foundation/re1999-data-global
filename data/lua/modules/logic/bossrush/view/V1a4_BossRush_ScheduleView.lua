module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleView", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScheduleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_Reward")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content")
	arg_1_0._goGrayLine = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	arg_1_0._goNormalLine = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_NormalLine")
	arg_1_0._goTarget = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Target")
	arg_1_0._simageTargetBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#go_Target/#simage_TargetBG")
	arg_1_0._goTargetContent = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Target/#go_TargetContent")
	arg_1_0._txtProgress = gohelper.findChildText(arg_1_0.viewGO, "Root/ProgressTip/#txt_Progress")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

local var_0_1 = string.format
local var_0_2 = SLFramework.UGUI.UIDragListener
local var_0_3 = SLFramework.UGUI.UIClickListener
local var_0_4 = 425
local var_0_5 = 1.5
local var_0_6 = {
	Content = 2,
	ProgressBar = 1
}

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._scrollRewardGo = arg_6_0._scrollReward.gameObject
	arg_6_0._goGraylineTran = arg_6_0._goGrayLine.transform
	arg_6_0._goNormallineTran = arg_6_0._goNormalLine.transform
	arg_6_0._goContentTran = arg_6_0._goContent.transform
	arg_6_0._rectViewPortTran = gohelper.findChild(arg_6_0._scrollRewardGo, "Viewport").transform
	arg_6_0._hLayoutGroup = arg_6_0._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_6_0._goGraylinePosX = recthelper.getAnchorX(arg_6_0._goGraylineTran)

	arg_6_0:_initTargetItem()
	arg_6_0._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulebg"))
	arg_6_0._simageTargetBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulerightbg"))

	arg_6_0._drag = var_0_2.Get(arg_6_0._scrollRewardGo)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBeginHandler, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEndHandler, arg_6_0)

	arg_6_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_6_0._scrollRewardGo, DungeonMapEpisodeAudio, arg_6_0._scrollReward)
	arg_6_0._touch = var_0_3.Get(arg_6_0._scrollRewardGo)

	arg_6_0._touch:AddClickDownListener(arg_6_0._onClickDownHandler, arg_6_0)
	arg_6_0._scrollReward:AddOnValueChanged(arg_6_0._onScrollChange, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)
	recthelper.setAnchorX(arg_6_0._goContentTran, 0)

	arg_6_0._listStaticData = {}
end

function var_0_0._initTargetItem(arg_7_0)
	local var_7_0 = V1a4_BossRush_ScheduleItem
	local var_7_1 = arg_7_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_scheduleitem, arg_7_0._goTargetContent, var_7_0.__cname)

	arg_7_0._targetItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, var_7_0)

	arg_7_0:_setTargetActive(false)
end

function var_0_0._onDragBeginHandler(arg_8_0)
	arg_8_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_9_0)
	arg_9_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_10_0)
	arg_10_0._audioScroll:onClickDown()
end

function var_0_0._onScrollChange(arg_11_0, arg_11_1)
	if arg_11_0._isGetAllDisplay then
		return
	end

	arg_11_0:_showTarget()
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0._getStage(arg_13_0)
	return arg_13_0.viewParam.stage
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_setListStaticData(0, 0, 0)
	V1a4_BossRush_ScheduleViewListModel.instance:setStaticData(arg_14_0._listStaticData)

	local var_14_0 = arg_14_0:_getStage()
	local var_14_1 = BossRushModel.instance:getLastPointInfo(var_14_0)
	local var_14_2, var_14_3 = BossRushModel.instance:calcRewardClaim(var_14_0, var_14_1.last)

	arg_14_0._isAutoClaim, arg_14_0._claimRewardIndex = BossRushModel.instance:calcRewardClaim(var_14_0, var_14_1.cur)
	arg_14_0._lastPointInfo = var_14_1
	arg_14_0._lastRewardIndex = var_14_3
	arg_14_0._displayAllIndexes = BossRushConfig.instance:getStageRewardDisplayIndexesList(var_14_0)

	if arg_14_0._isAutoClaim then
		arg_14_0:_setListStaticData(0, var_14_3 + 1, arg_14_0._claimRewardIndex)
	end

	arg_14_0:_refresh()
	arg_14_0:_showTarget()
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveAct128GetTotalRewardsReply, arg_14_0._refresh, arg_14_0)
end

function var_0_0._setListStaticData(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._listStaticData.curIndex = arg_15_1 or 0
	arg_15_0._listStaticData.fromIndex = arg_15_2 or 0
	arg_15_0._listStaticData.toIndex = arg_15_3 or 0
end

function var_0_0.onOpenFinish(arg_16_0)
	arg_16_0:_openTweenStart()
end

function var_0_0.onClose(arg_17_0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveAct128GetTotalRewardsReply, arg_17_0._refresh, arg_17_0)

	if arg_17_0._isAutoClaim then
		arg_17_0:_openTweenFinishInner()
	end
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagePanelBG:UnLoadImage()
	arg_18_0._simageTargetBG:UnLoadImage()
	arg_18_0._scrollReward:RemoveOnValueChanged()
	arg_18_0:_deleteProgressTween()
	arg_18_0:_deleteContentTween()
	GameUtil.onDestroyViewMemberList(arg_18_0, "_itemList")

	if arg_18_0._drag then
		arg_18_0._drag:RemoveDragBeginListener()
		arg_18_0._drag:RemoveDragEndListener()
	end

	arg_18_0._drag = nil

	if arg_18_0._touch then
		arg_18_0._touch:RemoveClickDownListener()
	end

	arg_18_0._touch = nil

	if arg_18_0._audioScroll then
		arg_18_0._audioScroll:onDestroy()
	end

	arg_18_0._audioScroll = nil
end

function var_0_0._deleteProgressTween(arg_19_0)
	GameUtil.onDestroyViewMember_TweenId(arg_19_0, "_progressBarTweenId")
end

function var_0_0._deleteContentTween(arg_20_0)
	GameUtil.onDestroyViewMember_TweenId(arg_20_0, "_contentTweenId")
end

function var_0_0._refresh(arg_21_0)
	local var_21_0 = arg_21_0:_getStage()
	local var_21_1 = arg_21_0._lastPointInfo
	local var_21_2 = var_21_1.last
	local var_21_3 = var_21_1.max
	local var_21_4 = BossRushModel.instance:getScheduleViewRewardList(var_21_0)
	local var_21_5 = {}
	local var_21_6 = #arg_21_0._displayAllIndexes

	if var_21_6 > 0 and arg_21_0._claimRewardIndex < arg_21_0._displayAllIndexes[var_21_6] then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._displayAllIndexes) do
			if not var_21_4[iter_21_1].isGot then
				var_21_5[#var_21_5 + 1] = iter_21_1
			end
		end
	end

	arg_21_0._dataList = var_21_4
	arg_21_0._notGotDisplayIndexes = var_21_5
	arg_21_0._isGetAllDisplay = #var_21_5 == 0

	arg_21_0:_refreshProgress(var_21_2, var_21_3)

	if arg_21_0._isGetAllDisplay then
		arg_21_0:_setTargetActive(false)

		arg_21_0._rectViewPortTran.offsetMax = Vector2(var_0_4, 0)
	else
		arg_21_0:_setTargetActive(true)

		arg_21_0._rectViewPortTran.offsetMax = Vector2(0, 0)
	end

	recthelper.setWidth(arg_21_0._goContentTran, arg_21_0:_calcHLayoutContentMaxWidth(#var_21_4))
	arg_21_0:_initItemList(var_21_4)
	arg_21_0:_refreshContentOffset(arg_21_0._lastRewardIndex)
end

function var_0_0._create_V1a4_BossRush_ScheduleItem(arg_22_0)
	local var_22_0 = arg_22_0.viewContainer:getListScrollParam()
	local var_22_1 = var_22_0.cellClass
	local var_22_2 = arg_22_0.viewContainer:getResInst(var_22_0.prefabUrl, arg_22_0._goContent, var_22_1.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_22_2, var_22_1)
end

function var_0_0._initItemList(arg_23_0, arg_23_1)
	if arg_23_0._itemList then
		return
	end

	arg_23_0._itemList = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		local var_23_0 = arg_23_0:_create_V1a4_BossRush_ScheduleItem()

		var_23_0._index = iter_23_0

		var_23_0:setData(iter_23_1)
		table.insert(arg_23_0._itemList, var_23_0)
	end
end

function var_0_0._tweenProgress(arg_24_0)
	arg_24_0:_deleteProgressTween()

	local var_24_0 = arg_24_0._lastPointInfo
	local var_24_1 = var_24_0.last
	local var_24_2 = var_24_0.cur

	if math.abs(var_24_1 - var_24_2) < 0.1 then
		arg_24_0:_openTweenFinish(var_0_6.ProgressBar)

		return
	end

	arg_24_0._progressBarTweenId = ZProj.TweenHelper.DOTweenFloat(var_24_1, var_24_2, var_0_5, arg_24_0._progressBarTweenUpdateCb, arg_24_0._progressBarTweenFinishedCb, arg_24_0, nil, EaseType.Linear)
end

function var_0_0._progressBarTweenUpdateCb(arg_25_0, arg_25_1)
	arg_25_1 = math.floor(arg_25_1)

	arg_25_0:_refreshProgress(arg_25_1, arg_25_0._lastPointInfo.max)
end

function var_0_0._progressBarTweenFinishedCb(arg_26_0)
	arg_26_0:_openTweenFinish(var_0_6.ProgressBar)
end

function var_0_0._tweenContent(arg_27_0)
	arg_27_0:_deleteContentTween()

	if not arg_27_0._isAutoClaim then
		arg_27_0:_openTweenFinish(var_0_6.Content)

		return
	end

	local var_27_0 = arg_27_0._claimRewardIndex
	local var_27_1 = -recthelper.getAnchorX(arg_27_0._goContentTran)
	local var_27_2 = arg_27_0:_calcHorizontalLayoutPixel(var_27_0)

	if math.abs(var_27_1 - var_27_2) < 0.1 then
		arg_27_0:_openTweenFinish(var_0_6.Content)

		return
	end

	arg_27_0._contentTweenId = ZProj.TweenHelper.DOTweenFloat(var_27_1, var_27_2, var_0_5, arg_27_0._contentTweenUpdateCb, arg_27_0._contentTweenFinishedCb, arg_27_0, nil, EaseType.Linear)
end

function var_0_0._contentTweenUpdateCb(arg_28_0, arg_28_1)
	recthelper.setAnchorX(arg_28_0._goContentTran, -arg_28_1)
end

function var_0_0._contentTweenFinishedCb(arg_29_0)
	arg_29_0:_openTweenFinish(var_0_6.Content)
end

function var_0_0._openTweenStart(arg_30_0)
	arg_30_0._openedTweens = {
		[var_0_6.ProgressBar] = true,
		[var_0_6.Content] = true
	}

	arg_30_0:_tweenContent()
	arg_30_0:_tweenProgress()
end

function var_0_0._openTweenFinish(arg_31_0, arg_31_1)
	arg_31_0._openedTweens[arg_31_1] = nil

	if next(arg_31_0._openedTweens) then
		return
	end

	arg_31_0:_openTweenFinishInner()
end

function var_0_0._openTweenFinishInner(arg_32_0)
	local var_32_0 = arg_32_0:_getStage()
	local var_32_1 = arg_32_0._lastPointInfo.cur

	arg_32_0._lastRewardIndex = arg_32_0._claimRewardIndex
	arg_32_0._lastPointInfo.last = var_32_1

	BossRushModel.instance:setStageLastTotalPoint(var_32_0, var_32_1)

	if not arg_32_0._isAutoClaim then
		return
	end

	arg_32_0._isAutoClaim = false

	BossRushRpc.instance:sendAct128GetTotalRewardsRequest(var_32_0)
end

function var_0_0._refreshProgress(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:_getStage()
	local var_33_1 = arg_33_0.viewContainer:getListScrollParam().cellWidth
	local var_33_2 = arg_33_0:_getCellSpaceH()
	local var_33_3 = arg_33_0._goGraylinePosX
	local var_33_4 = arg_33_0._hLayoutGroup.padding.left + var_33_1 / 2
	local var_33_5 = var_33_2 + var_33_1
	local var_33_6, var_33_7 = BossRushConfig.instance:calcStageRewardProgWidth(var_33_0, arg_33_1, var_33_2, var_33_1, var_33_4, var_33_5, var_33_3, -var_33_3)

	recthelper.setWidth(arg_33_0._goGraylineTran, var_33_7)
	recthelper.setWidth(arg_33_0._goNormallineTran, var_33_6)

	arg_33_0._txtProgress.text = var_0_1("<color=#b34a16>%s</color>/%s", arg_33_1, arg_33_2)
end

function var_0_0._refreshContentOffset(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:_calcHorizontalLayoutPixel(arg_34_1)

	recthelper.setAnchorX(arg_34_0._goContentTran, -var_34_0)
end

local var_0_7 = 200
local var_0_8 = 1250

function var_0_0._calcHorizontalLayoutPixel(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:_getCellSpaceH()
	local var_35_1 = arg_35_0._hLayoutGroup.padding.left
	local var_35_2 = var_0_8

	if arg_35_0._isGetAllDisplay then
		var_35_2 = var_35_2 + var_0_4
	end

	local var_35_3 = recthelper.getWidth(arg_35_0._goContentTran)
	local var_35_4 = math.max(0, var_35_3 - var_35_2)

	if arg_35_1 <= 1 then
		return 0
	end

	return math.min(var_35_4, (arg_35_1 - 1) * (var_35_0 + var_0_7) + var_35_1)
end

function var_0_0._getCellSpaceH(arg_36_0)
	return arg_36_0._hLayoutGroup.spacing
end

function var_0_0._calcHLayoutContentMaxWidth(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or #arg_37_0._dataList

	local var_37_0 = arg_37_0.viewContainer:getListScrollParam()
	local var_37_1 = var_37_0.cellWidth
	local var_37_2 = var_37_0.endSpace
	local var_37_3 = arg_37_0:_getCellSpaceH()
	local var_37_4 = arg_37_0._hLayoutGroup.padding.left

	return (var_37_1 + var_37_3) * math.max(0, arg_37_1) - var_37_4 - var_37_1 / 2 + var_37_2
end

local var_0_9 = 2

function var_0_0._showTarget(arg_38_0)
	local var_38_0 = arg_38_0._notGotDisplayIndexes

	if not var_38_0 or #var_38_0 == 0 then
		arg_38_0:_setTargetActive(false)

		return
	end

	arg_38_0:_setTargetActive(true)

	local var_38_1 = recthelper.getAnchorX(arg_38_0._goContentTran)
	local var_38_2 = arg_38_0.viewContainer:getListScrollParam()
	local var_38_3 = var_38_2.cellWidth
	local var_38_4 = var_38_3 + var_38_2.cellSpaceH
	local var_38_5 = var_38_3 / 2
	local var_38_6 = math.abs(var_38_1)
	local var_38_7
	local var_38_8

	if var_38_6 <= var_38_5 then
		var_38_7 = 2 + var_0_9
	else
		var_38_7 = 2 + math.floor((var_38_6 - var_38_5) / var_38_4) + var_0_9
	end

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		if var_38_7 <= iter_38_1 then
			var_38_8 = iter_38_1

			break
		end
	end

	if not var_38_8 then
		local var_38_9 = var_38_0[#var_38_0]

		var_38_8 = math.min(var_38_7, var_38_9)
	end

	local var_38_10 = arg_38_0._dataList[var_38_8]

	var_38_10._index = var_38_8

	arg_38_0._targetItem:refreshByDisplayTarget(var_38_10)
end

function var_0_0._showFirstTarget(arg_39_0)
	local var_39_0 = arg_39_0._notGotDisplayIndexes

	if not var_39_0 or #var_39_0 == 0 then
		arg_39_0:_setTargetActive(false)

		return
	end

	arg_39_0:_setTargetActive(true)

	local var_39_1 = var_39_0[1]
	local var_39_2 = arg_39_0._dataList[var_39_1]

	var_39_2._index = var_39_1

	arg_39_0._targetItem:refreshByDisplayTarget(var_39_2)
end

function var_0_0._setTargetActive(arg_40_0, arg_40_1)
	gohelper.setActive(arg_40_0._goTarget, arg_40_1)
end

return var_0_0
