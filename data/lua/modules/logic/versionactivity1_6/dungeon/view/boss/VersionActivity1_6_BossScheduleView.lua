module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossScheduleView", package.seeall)

local var_0_0 = class("VersionActivity1_6_BossScheduleView", BaseView)

function var_0_0._getViewportW(arg_1_0)
	return recthelper.getWidth(arg_1_0._scrollReward.transform)
end

function var_0_0._calcContentWidth(arg_2_0)
	return recthelper.getWidth(arg_2_0._goContentTran)
end

function var_0_0._getMaxScrollX(arg_3_0)
	local var_3_0 = arg_3_0:_getViewportW()
	local var_3_1 = arg_3_0:_calcContentWidth()

	return math.max(0, var_3_1 - var_3_0)
end

local var_0_1 = 1.5
local var_0_2 = {
	Content = 2,
	ProgressBar = 1
}

function var_0_0.onInitView(arg_4_0)
	arg_4_0._simagePanelBG = gohelper.findChildSingleImage(arg_4_0.viewGO, "Root/#simage_PanelBG")
	arg_4_0._scrollReward = gohelper.findChildScrollRect(arg_4_0.viewGO, "Root/#scroll_Reward")
	arg_4_0._goContent = gohelper.findChild(arg_4_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content")
	arg_4_0._goGrayLine = gohelper.findChild(arg_4_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	arg_4_0._goNormalLine = gohelper.findChild(arg_4_0.viewGO, "Root/#scroll_Reward/Viewport/#go_Content/#go_NormalLine")
	arg_4_0._txtProgress = gohelper.findChildText(arg_4_0.viewGO, "Root/ProgressTip/#txt_Progress")
	arg_4_0._btnClose = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "Root/#btn_Close")
	arg_4_0._txtbestProgress = gohelper.findChildText(arg_4_0.viewGO, "Root/#txt_Progress")
	arg_4_0._btnClose = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "Root/#btn_Close")

	if arg_4_0._editableInitView then
		arg_4_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_5_0)
	arg_5_0._btnClose:AddClickListener(arg_5_0._btnCloseOnClick, arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	arg_6_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._scrollRewardGo = arg_9_0._scrollReward.gameObject
	arg_9_0._goGraylineTran = arg_9_0._goGrayLine.transform
	arg_9_0._goNormallineTran = arg_9_0._goNormalLine.transform
	arg_9_0._goContentTran = arg_9_0._goContent.transform
	arg_9_0._rectViewPortTran = gohelper.findChild(arg_9_0._scrollRewardGo, "Viewport").transform
	arg_9_0._hLayoutGroup = arg_9_0._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_9_0._goGraylinePosX = recthelper.getAnchorX(arg_9_0._goGraylineTran)

	arg_9_0._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_schedulebg"))

	arg_9_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_9_0._scrollRewardGo)

	arg_9_0._drag:AddDragBeginListener(arg_9_0._onDragBeginHandler, arg_9_0)
	arg_9_0._drag:AddDragEndListener(arg_9_0._onDragEndHandler, arg_9_0)

	arg_9_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_9_0._scrollRewardGo, DungeonMapEpisodeAudio, arg_9_0._scrollReward)
	arg_9_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_9_0._scrollRewardGo)

	arg_9_0._touch:AddClickDownListener(arg_9_0._onClickDownHandler, arg_9_0)
	arg_9_0._scrollReward:AddOnValueChanged(arg_9_0._onScrollChange, arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)
	recthelper.setAnchorX(arg_9_0._goContentTran, 0)

	arg_9_0._listStaticData = {}
end

function var_0_0._onDragBeginHandler(arg_10_0)
	arg_10_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_11_0)
	arg_11_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_12_0)
	arg_12_0._audioScroll:onClickDown()
end

function var_0_0._onScrollChange(arg_13_0, arg_13_1)
	return
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_setListStaticData(0, 0, 0)
	VersionActivity1_6ScheduleViewListModel.instance:setStaticData(arg_15_0._listStaticData)

	local var_15_0 = VersionActivity1_6DungeonBossModel.instance:getTotalScore()

	arg_15_0._isAutoClaim, arg_15_0._lastRewardIndex, arg_15_0._claimRewardIndex = VersionActivity1_6DungeonBossModel.instance:checkAbleGetReward(var_15_0)

	if arg_15_0._isAutoClaim then
		arg_15_0:_setListStaticData(0, arg_15_0._lastRewardIndex + 1, arg_15_0._claimRewardIndex)
	end

	arg_15_0:_refresh()
end

function var_0_0._setListStaticData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._listStaticData.curIndex = arg_16_1 or 0
	arg_16_0._listStaticData.fromIndex = arg_16_2 or 0
	arg_16_0._listStaticData.toIndex = arg_16_3 or 0
end

function var_0_0.onOpenFinish(arg_17_0)
	arg_17_0:_openTweenStart()
end

function var_0_0.onClose(arg_18_0)
	if arg_18_0._isAutoClaim then
		arg_18_0:_openTweenFinishInner()
	end
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._simagePanelBG:UnLoadImage()
	arg_19_0._scrollReward:RemoveOnValueChanged()
	arg_19_0:_deleteProgressTween()
	arg_19_0:_deleteContentTween()
	GameUtil.onDestroyViewMemberList(arg_19_0, "_itemList")

	if arg_19_0._drag then
		arg_19_0._drag:RemoveDragBeginListener()
		arg_19_0._drag:RemoveDragEndListener()
	end

	arg_19_0._drag = nil

	if arg_19_0._touch then
		arg_19_0._touch:RemoveClickDownListener()
	end

	arg_19_0._touch = nil

	if arg_19_0._audioScroll then
		arg_19_0._audioScroll:onDestroy()
	end

	arg_19_0._audioScroll = nil
end

function var_0_0._deleteProgressTween(arg_20_0)
	GameUtil.onDestroyViewMember_TweenId(arg_20_0, "_progressBarTweenId")
end

function var_0_0._deleteContentTween(arg_21_0)
	GameUtil.onDestroyViewMember_TweenId(arg_21_0, "_contentTweenId")
end

function var_0_0._refresh(arg_22_0)
	local var_22_0 = VersionActivity1_6DungeonBossModel.instance:getScheduleViewRewardList()
	local var_22_1 = {}
	local var_22_2 = Activity149Config.instance:getBossRewardCfgList()
	local var_22_3 = VersionActivity1_6DungeonBossModel.instance:getAleadyGotBonusIds()

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		if not var_22_0[iter_22_0].isGot then
			var_22_1[#var_22_1 + 1] = iter_22_0
		end
	end

	arg_22_0._dataList = var_22_0

	recthelper.setWidth(arg_22_0._goContentTran, arg_22_0:_calcHLayoutContentMaxWidth(#var_22_0))
	arg_22_0:_initItemList(var_22_0)
	arg_22_0:_refreshContentOffset(arg_22_0._lastRewardIndex)
	arg_22_0:_refreshBestProgress()
end

function var_0_0._createScheduleItem(arg_23_0)
	local var_23_0 = arg_23_0.viewContainer:getListScrollParam()
	local var_23_1 = var_23_0.cellClass
	local var_23_2 = arg_23_0.viewContainer:getResInst(var_23_0.prefabUrl, arg_23_0._goContent, var_23_1.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_23_2, var_23_1)
end

function var_0_0._initItemList(arg_24_0, arg_24_1)
	if arg_24_0._itemList then
		return
	end

	arg_24_0._itemList = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		local var_24_0 = arg_24_0:_createScheduleItem()

		var_24_0._index = iter_24_0

		var_24_0:setData(iter_24_1)
		table.insert(arg_24_0._itemList, var_24_0)
	end
end

function var_0_0._openTweenStart(arg_25_0)
	arg_25_0._openedTweens = {
		[var_0_2.ProgressBar] = true,
		[var_0_2.Content] = true
	}

	arg_25_0:_tweenContent()
	arg_25_0:_tweenProgress()
end

function var_0_0._tweenContent(arg_26_0)
	arg_26_0:_deleteContentTween()

	if not arg_26_0._isAutoClaim then
		arg_26_0:_openTweenFinish(var_0_2.Content)

		return
	end

	local var_26_0 = arg_26_0._claimRewardIndex
	local var_26_1 = -recthelper.getAnchorX(arg_26_0._goContentTran)
	local var_26_2 = arg_26_0:_calcHorizontalLayoutPixel(var_26_0)

	if math.abs(var_26_1 - var_26_2) < 0.1 then
		arg_26_0:_openTweenFinish(var_0_2.Content)

		return
	end

	arg_26_0._contentTweenId = ZProj.TweenHelper.DOTweenFloat(var_26_1, var_26_2, var_0_1, arg_26_0._contentTweenUpdateCb, arg_26_0._contentTweenFinishedCb, arg_26_0, nil, EaseType.Linear)
end

function var_0_0._openTweenFinish(arg_27_0, arg_27_1)
	arg_27_0._openedTweens[arg_27_1] = nil

	if next(arg_27_0._openedTweens) then
		return
	end

	arg_27_0:_openTweenFinishInner()
end

function var_0_0._contentTweenUpdateCb(arg_28_0, arg_28_1)
	recthelper.setAnchorX(arg_28_0._goContentTran, -arg_28_1)
end

function var_0_0._contentTweenFinishedCb(arg_29_0)
	arg_29_0:_openTweenFinish(var_0_2.Content)
end

function var_0_0._tweenProgress(arg_30_0)
	arg_30_0:_deleteProgressTween()

	local var_30_0 = VersionActivity1_6DungeonBossModel.instance
	local var_30_1 = var_30_0:getScorePrefValue()
	local var_30_2 = var_30_0:getTotalScore()

	if var_30_2 == 0 then
		arg_30_0:_progressBarTweenUpdateCb(0)
	end

	if math.abs(var_30_1 - var_30_2) < 0.1 then
		local var_30_3 = Activity149Config.instance:getBossRewardMaxScore()

		arg_30_0:_refreshProgress(var_30_2, var_30_3)
		arg_30_0:_openTweenFinish(var_0_2.ProgressBar)

		return
	end

	var_30_0:setScorePrefValue(var_30_2)

	arg_30_0._progressBarTweenId = ZProj.TweenHelper.DOTweenFloat(var_30_1, var_30_2, var_0_1, arg_30_0._progressBarTweenUpdateCb, arg_30_0._progressBarTweenFinishedCb, arg_30_0, nil, EaseType.Linear)
end

function var_0_0._progressBarTweenUpdateCb(arg_31_0, arg_31_1)
	arg_31_1 = math.floor(arg_31_1)

	local var_31_0 = Activity149Config.instance:getBossRewardMaxScore()

	arg_31_0:_refreshProgress(arg_31_1, var_31_0)
end

function var_0_0._progressBarTweenFinishedCb(arg_32_0)
	arg_32_0:_openTweenFinish(var_0_2.ProgressBar)
end

function var_0_0._openTweenFinishInner(arg_33_0)
	if not arg_33_0._isAutoClaim then
		return
	end

	arg_33_0._isAutoClaim = false

	VersionActivity1_6DungeonRpc.instance:sendAct149GetScoreRewardsRequest()
end

function var_0_0._refreshProgress(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.viewContainer:getListScrollParam().cellWidth
	local var_34_1 = arg_34_0:_getCellSpaceH()
	local var_34_2 = arg_34_0._goGraylinePosX
	local var_34_3 = arg_34_0._hLayoutGroup.padding.left + var_34_0 / 2
	local var_34_4 = var_34_1 + var_34_0
	local var_34_5, var_34_6 = Activity149Config.instance:calRewardProgressWidth(arg_34_1, var_34_1, var_34_0, var_34_3, var_34_4, var_34_2, -var_34_2)

	recthelper.setWidth(arg_34_0._goGraylineTran, var_34_6)
	recthelper.setWidth(arg_34_0._goNormallineTran, var_34_5)

	if LangSettings.instance:isEn() then
		arg_34_0._txtProgress.text = string.format(" <color=#b34a16>%s</color>/%s", arg_34_1, arg_34_2)
	else
		arg_34_0._txtProgress.text = string.format("<color=#b34a16>%s</color>/%s", arg_34_1, arg_34_2)
	end
end

function var_0_0._refreshBestProgress(arg_35_0)
	local var_35_0 = VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()

	if LangSettings.instance:isEn() then
		arg_35_0._txtbestProgress.text = " " .. var_35_0
	else
		arg_35_0._txtbestProgress.text = var_35_0
	end
end

function var_0_0._refreshContentOffset(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:_calcHorizontalLayoutPixel(arg_36_1)

	recthelper.setAnchorX(arg_36_0._goContentTran, -var_36_0)
end

local var_0_3 = 200

function var_0_0._calcHorizontalLayoutPixel(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:_getCellSpaceH()
	local var_37_1 = arg_37_0._hLayoutGroup.padding.left
	local var_37_2 = recthelper.getWidth(arg_37_0._goContentTran)
	local var_37_3 = arg_37_0:_getMaxScrollX()

	if arg_37_1 <= 1 then
		return 0
	end

	return math.min(var_37_3, (arg_37_1 - 1) * (var_37_0 + var_0_3) + var_37_1)
end

function var_0_0._getCellSpaceH(arg_38_0)
	return arg_38_0._hLayoutGroup.spacing
end

function var_0_0._calcHLayoutContentMaxWidth(arg_39_0, arg_39_1)
	arg_39_1 = arg_39_1 or #arg_39_0._dataList

	local var_39_0 = arg_39_0.viewContainer:getListScrollParam()
	local var_39_1 = var_39_0.cellWidth
	local var_39_2 = var_39_0.endSpace
	local var_39_3 = arg_39_0:_getCellSpaceH()
	local var_39_4 = arg_39_0._hLayoutGroup.padding.left

	return (var_39_1 + var_39_3) * math.max(0, arg_39_1) - var_39_4 - var_39_1 / 2 + var_39_2
end

return var_0_0
