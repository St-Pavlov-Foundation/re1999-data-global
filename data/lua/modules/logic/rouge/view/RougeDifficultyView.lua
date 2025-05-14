module("modules.logic.rouge.view.RougeDifficultyView", package.seeall)

local var_0_0 = class("RougeDifficultyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagemask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask2")
	arg_1_0._simagemask3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask3")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "Middle/#scroll_view")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_leftarrow")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_rightarrow")
	arg_1_0._gorougepageprogress = gohelper.findChild(arg_1_0.viewGO, "#go_rougepageprogress")
	arg_1_0._btnstart1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_start1")
	arg_1_0._btnstart2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_start2")
	arg_1_0._btnstart3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_start3")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")
	arg_1_0._gooverviewtips = gohelper.findChild(arg_1_0.viewGO, "#go_overviewtips")
	arg_1_0._godecitem = gohelper.findChild(arg_1_0.viewGO, "#go_overviewtips/#scroll_overview/Viewport/Content/#txt_decitem")
	arg_1_0._gobalancetips = gohelper.findChild(arg_1_0.viewGO, "#go_balancetips")
	arg_1_0._golevelitem = gohelper.findChild(arg_1_0.viewGO, "#go_balancetips/#scroll_details/Viewport/Content/level/#go_levelitem")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
	arg_2_0._btnstart1:AddClickListener(arg_2_0._btnstart1OnClick, arg_2_0)
	arg_2_0._btnstart2:AddClickListener(arg_2_0._btnstart2OnClick, arg_2_0)
	arg_2_0._btnstart3:AddClickListener(arg_2_0._btnstart3OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
	arg_3_0._btnstart1:RemoveClickListener()
	arg_3_0._btnstart2:RemoveClickListener()
	arg_3_0._btnstart3:RemoveClickListener()
end

local var_0_1 = ZProj.TweenHelper
local var_0_2 = 100
local var_0_3 = 0.3
local var_0_4 = 0.6
local var_0_5 = 2

function var_0_0._btnleftarrowOnClick(arg_4_0)
	arg_4_0:_moveByArrow(true)
end

function var_0_0._btnrightarrowOnClick(arg_5_0)
	arg_5_0:_moveByArrow(false)
end

function var_0_0._moveByArrow(arg_6_0, arg_6_1)
	arg_6_0._drag:clear()

	local var_6_0 = arg_6_0._lastSelectedIndex or arg_6_1 and 2 or 0
	local var_6_1 = arg_6_1 and var_6_0 - 1 or var_6_0 + 1

	arg_6_0:_onSelectIndex(arg_6_0:_validateIndex(var_6_1))
end

function var_0_0._btnstart1OnClick(arg_7_0)
	arg_7_0:_btnStartOnClick()
end

function var_0_0._btnstart2OnClick(arg_8_0)
	arg_8_0:_btnStartOnClick()
end

function var_0_0._btnstart3OnClick(arg_9_0)
	arg_9_0:_btnStartOnClick()
end

local var_0_6 = "RougeDifficultyView:_btnStartOnClick"

function var_0_0._btnStartOnClick(arg_10_0)
	local var_10_0 = RougeOutsideModel.instance:season()
	local var_10_1 = arg_10_0:_versionList()
	local var_10_2 = arg_10_0:difficulty()
	local var_10_3

	if tabletool.indexOf(var_10_1, RougeDLCEnum.DLCEnum.DLC_101) then
		var_10_3 = RougeDLCModel101.instance:getLimiterClientMo()
	end

	if not arg_10_0._lastSelectedIndex then
		return
	end

	UIBlockHelper.instance:startBlock(var_0_6, 1, arg_10_0.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_columns_update_20190318)

	local var_10_4 = false
	local var_10_5 = false

	arg_10_0._itemList[arg_10_0._lastSelectedIndex]:setOnCloseEndCb(function()
		var_10_4 = true

		if not var_10_5 then
			return
		end

		UIBlockHelper.instance:endBlock(var_0_6)
		arg_10_0:_directOpenNextView()
	end)

	local var_10_6 = arg_10_0:_validateIndex(arg_10_0._lastSelectedIndex - 2)
	local var_10_7 = arg_10_0:_validateIndex(arg_10_0._lastSelectedIndex + 2)

	for iter_10_0 = var_10_6, var_10_7 do
		arg_10_0._itemList[iter_10_0]:playClose()
	end

	RougeRpc.instance:sendEnterRougeSelectDifficultyRequest(var_10_0, var_10_1, var_10_2, var_10_3, function(arg_12_0, arg_12_1)
		if arg_12_1 ~= 0 then
			logError("RougeDifficultyView:_btnStartOnClick resultCode=" .. tostring(arg_12_1))

			return
		end

		RougeOutsideModel.instance:setLastMarkSelectedDifficulty(var_10_2)

		var_10_5 = true

		if not var_10_4 then
			return
		end

		UIBlockHelper.instance:endBlock(var_0_6)
		arg_10_0:_directOpenNextView()
	end)
end

function var_0_0._directOpenNextView(arg_13_0)
	if RougeModel.instance:isCanSelectRewards() then
		RougeController.instance:openRougeSelectRewardsView()
	else
		RougeController.instance:openRougeFactionView()
	end
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._goblockClick = gohelper.findChildClick(arg_14_0._goblock, "")

	arg_14_0._goblockClick:AddClickListener(arg_14_0._goblockClickonClick, arg_14_0)

	arg_14_0._decitemTextList = arg_14_0:getUserDataTb_()

	gohelper.setActive(arg_14_0._godecitem, false)

	arg_14_0._golevelitemList = arg_14_0:getUserDataTb_()

	gohelper.setActive(arg_14_0._golevelitem, false)
	arg_14_0:_setActiveOverviewTips(false)
	arg_14_0:_setActiveBalanceTips(false)
	arg_14_0:_initScrollView()
	arg_14_0:_initPageProgress()
	arg_14_0:_initViewStyles()
end

function var_0_0._goblockClickonClick(arg_15_0)
	arg_15_0:_setActiveBlock(false)
end

function var_0_0._setActiveOverviewTips(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._gooverviewtips, arg_16_1)
end

function var_0_0._setActiveBalanceTips(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._gobalancetips, arg_17_1)
end

function var_0_0._initScrollView(arg_18_0)
	arg_18_0._scrollViewGo = arg_18_0._scrollview.gameObject
	arg_18_0._scrollViewTrans = arg_18_0._scrollViewGo.transform
	arg_18_0._scrollViewLimitScrollCmp = arg_18_0._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	arg_18_0._goContentHLayout = arg_18_0._goContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_18_0._drag = UIDragListenerHelper.New()

	arg_18_0._drag:createByScrollRect(arg_18_0._scrollViewLimitScrollCmp)
	arg_18_0._drag:registerCallback(arg_18_0._drag.EventBegin, arg_18_0._onDragBeginHandler, arg_18_0)
	arg_18_0._drag:registerCallback(arg_18_0._drag.EventDragging, arg_18_0._onDragging, arg_18_0)
	arg_18_0._scrollview:AddOnValueChanged(arg_18_0._onScrollValueChanged, arg_18_0)
end

function var_0_0._initPageProgress(arg_19_0)
	local var_19_0 = RougePageProgress
	local var_19_1 = arg_19_0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, arg_19_0._gorougepageprogress, var_19_0.__cname)

	arg_19_0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_1, var_19_0)

	arg_19_0._pageProgress:setData()
end

function var_0_0._initViewStyles(arg_20_0)
	arg_20_0._transBtnStartList = arg_20_0:getUserDataTb_()
	arg_20_0._animBtnStartList = arg_20_0:getUserDataTb_()

	local var_20_0 = 1
	local var_20_1 = arg_20_0["_btnstart" .. var_20_0]

	while var_20_1 ~= nil do
		local var_20_2 = var_20_1.gameObject
		local var_20_3 = var_20_2.transform

		table.insert(arg_20_0._transBtnStartList, var_20_3)
		table.insert(arg_20_0._animBtnStartList, var_20_2:GetComponent(gohelper.Type_Animator))
		gohelper.setActive(var_20_2, true)
		GameUtil.setActive01(var_20_3, false)

		var_20_0 = var_20_0 + 1
		var_20_1 = arg_20_0["_btnstart" .. var_20_0]
	end

	arg_20_0._transSimageMaskList = arg_20_0:getUserDataTb_()
	arg_20_0._animSimageMaskList = arg_20_0:getUserDataTb_()

	for iter_20_0 = 1, #arg_20_0._transBtnStartList do
		local var_20_4 = arg_20_0["_simagemask" .. iter_20_0]

		if var_20_4 then
			local var_20_5 = var_20_4.gameObject
			local var_20_6 = var_20_5.transform

			arg_20_0._transSimageMaskList[iter_20_0] = var_20_6
			arg_20_0._animSimageMaskList[iter_20_0] = var_20_5:GetComponent(gohelper.Type_Animator)

			GameUtil.setActive01(var_20_6, false)
			gohelper.setActive(var_20_5, true)
		end
	end
end

function var_0_0.onUpdateParam(arg_21_0)
	arg_21_0:_refresh()
	arg_21_0:_onSelectIndex(arg_21_0:_onOpenSelectedIndex())
end

function var_0_0.onOpen(arg_22_0)
	arg_22_0._lastSelectedIndex = false
	arg_22_0._uiAduioLastDragNear = nil
	arg_22_0._cache_difficultyCOList = nil
	arg_22_0._cache_sumDescIndexList = nil

	arg_22_0:_setActiveBlock(false)

	arg_22_0._dataList = RougeOutsideModel.instance:getDifficultyInfoList(arg_22_0:_versionList())

	arg_22_0:_refresh()
	UpdateBeat:Add(arg_22_0._update, arg_22_0)
	arg_22_0.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_OnSelectIndex, arg_22_0._onSelectIndexByUser, arg_22_0)
	arg_22_0.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, arg_22_0._btnTipsIconOnClick, arg_22_0)
	arg_22_0.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_btnBalanceOnClick, arg_22_0._btnBalanceOnClick, arg_22_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_22_0._onScreenResize, arg_22_0)
end

function var_0_0.onOpenFinish(arg_23_0)
	arg_23_0:_onScreenResize()
	arg_23_0:_tweenOpenAnim()
end

function var_0_0.onClose(arg_24_0)
	arg_24_0:_clearTweenOpenAnimFirstItemScaleTimer()
	UpdateBeat:Remove(arg_24_0._update, arg_24_0)
	arg_24_0._goblockClick:RemoveClickListener()
	arg_24_0._scrollview:RemoveOnValueChanged()
	arg_24_0.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_OnSelectIndex, arg_24_0._onSelectIndexByUser, arg_24_0)
	arg_24_0.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, arg_24_0._btnTipsIconOnClick, arg_24_0)
	arg_24_0.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_btnBalanceOnClick, arg_24_0._btnBalanceOnClick, arg_24_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_24_0._onScreenResize, arg_24_0)
	arg_24_0:_killTween()
end

function var_0_0._killTween(arg_25_0)
	GameUtil.onDestroyViewMember_TweenId(arg_25_0, "_contentPosXTweenId")
end

function var_0_0._clearTweenOpenAnimFirstItemScaleTimer(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._tweenOpenAnimFirstItemScale, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0:_clearTweenOpenAnimFirstItemScaleTimer()
	UpdateBeat:Remove(arg_27_0._update, arg_27_0)
	GameUtil.onDestroyViewMember(arg_27_0, "_drag")
	GameUtil.onDestroyViewMemberList(arg_27_0, "_itemList")
end

function var_0_0._refresh(arg_28_0)
	arg_28_0:_refreshList()
end

function var_0_0._getNewUnlockStateList(arg_29_0)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._dataList) do
		local var_29_1 = iter_29_1.difficulty

		var_29_0[iter_29_0] = RougeOutsideModel.instance:getIsNewUnlockDifficulty(var_29_1)
	end

	return var_29_0
end

function var_0_0._tweenOpenAnimFirstItemScale(arg_30_0)
	if not arg_30_0._itemList then
		return
	end

	local var_30_0 = arg_30_0._itemList[1]

	if not var_30_0 then
		return
	end

	arg_30_0:_setScaleAdjacent(1, true)
	var_30_0:tweenScale(RougeDifficultyItem.ScalerSelected)
end

function var_0_0._tweenOpenAnim(arg_31_0)
	UIBlockHelper.instance:startBlock("RougeDifficultyView:_tweenOpenAnim", 1.9, arg_31_0.viewName)

	local var_31_0 = arg_31_0:_getItemList()
	local var_31_1 = arg_31_0:_getNewUnlockStateList()
	local var_31_2 = arg_31_0:_onOpenSelectedIndex()
	local var_31_3 = var_31_0[var_31_2]

	local function var_31_4()
		UIBlockHelper.instance:endBlock("RougeRougeDifficultyViewFactionView:_tweenOpenAnim")
		arg_31_0:_onSelectIndex(var_31_2)
	end

	if var_31_2 == 1 then
		arg_31_0:_clearTweenOpenAnimFirstItemScaleTimer()
		TaskDispatcher.runDelay(arg_31_0._tweenOpenAnimFirstItemScale, arg_31_0, var_31_1[var_31_2] and var_0_5 or var_0_4)
	end

	var_31_3:setOnOpenEndCb(var_31_4)

	if var_31_1[var_31_2] then
		var_31_3:setOnOpenEndCb(nil)
		var_31_3:setOnUnlockEndCb(var_31_4)
	end

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		local var_31_5 = var_31_1 and var_31_1[iter_31_0] or nil

		if iter_31_0 == 1 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190313)
		end

		if var_31_5 ~= nil then
			local var_31_6 = arg_31_0._dataList[iter_31_0].difficulty

			iter_31_1:playOpen(var_31_5)

			if var_31_5 then
				RougeOutsideModel.instance:setIsNewUnlockDifficulty(var_31_6, false)
			end
		else
			iter_31_1:playOpen()
		end
	end
end

function var_0_0._versionList(arg_33_0)
	if not arg_33_0.viewParam then
		return RougeModel.instance:getVersion()
	end

	return arg_33_0.viewParam.versionList or RougeModel.instance:getVersion()
end

function var_0_0._trySelectDifficulty2TabIndex(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:_getDataList()

	if arg_34_1 > #var_34_0 then
		return 1
	end

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		if iter_34_1.difficulty == arg_34_1 then
			return iter_34_1.isUnLocked and iter_34_0 or 1
		end
	end

	return 1
end

function var_0_0._selectedDifficultyOnOpen(arg_35_0)
	if not arg_35_0.viewParam then
		return arg_35_0:_trySelectDifficulty2TabIndex(RougeOutsideModel.instance:getLastMarkSelectedDifficulty(1))
	end

	return arg_35_0.viewParam.selectedDifficulty or arg_35_0:_trySelectDifficulty2TabIndex(RougeOutsideModel.instance:getLastMarkSelectedDifficulty(1))
end

function var_0_0.difficulty(arg_36_0)
	return arg_36_0._lastSelectedIndex or arg_36_0:_onOpenSelectedIndex()
end

function var_0_0._difficultyCOList(arg_37_0)
	if arg_37_0._cache_difficultyCOList then
		return arg_37_0._cache_difficultyCOList
	end

	local var_37_0 = RougeOutsideModel.instance:config():getDifficultyCOListByVersions(arg_37_0:_versionList())

	arg_37_0._cache_difficultyCOList = var_37_0

	return var_37_0
end

function var_0_0._onOpenSelectedIndex(arg_38_0)
	local var_38_0 = arg_38_0._lastSelectedIndex or arg_38_0:_selectedDifficultyOnOpen()

	if var_38_0 > #arg_38_0._itemList then
		return 1
	end

	return var_38_0
end

function var_0_0._onSelectIndexByUser(arg_39_0, arg_39_1)
	arg_39_0._drag:stopMovement()
	arg_39_0:_onSelectIndex(arg_39_1)
end

function var_0_0._guessIsStopedScrolling(arg_40_0)
	if not arg_40_0._drag:isStoped() then
		return false
	end

	if not arg_40_0:_isScrollSlowly() then
		return false
	end

	return true
end

function var_0_0._btnTipsIconOnClick(arg_41_0, arg_41_1)
	if not arg_41_0:_guessIsStopedScrolling() then
		return
	end

	arg_41_0:_setExtendProp(arg_41_1)
	arg_41_0:_setActiveOverviewTips(true)
	arg_41_0:_setActiveBlock(true)
end

function var_0_0._btnBalanceOnClick(arg_42_0, arg_42_1)
	if not arg_42_0:_guessIsStopedScrolling() then
		return
	end

	arg_42_0:_setBalance(arg_42_1)
	arg_42_0:_setActiveBalanceTips(true)
	arg_42_0:_setActiveBlock(true)
end

function var_0_0._onSelectIndex(arg_43_0, arg_43_1)
	if arg_43_0._lastSelectedIndex == arg_43_1 then
		arg_43_0:_animFocusIndex(arg_43_1)

		return
	end

	if arg_43_0._lastSelectedIndex then
		arg_43_0._itemList[arg_43_0._lastSelectedIndex]:setSelected(false)
	end

	arg_43_0._itemList[arg_43_1]:setSelected(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_insight_close_20190315)
	arg_43_0:_setScaleAdjacent(arg_43_1, true)
	arg_43_0:_refreshStartBtn(arg_43_0._lastSelectedIndex, arg_43_1)

	arg_43_0._lastSelectedIndex = arg_43_1

	arg_43_0:_animFocusIndex(arg_43_1)
end

function var_0_0._hideAllStartBtn(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(arg_44_0._transBtnStartList) do
		GameUtil.setActive01(iter_44_1, false)
	end
end

function var_0_0._hideAllSimageMask(arg_45_0)
	for iter_45_0, iter_45_1 in ipairs(arg_45_0._transSimageMaskList) do
		GameUtil.setActive01(iter_45_1, false)
	end
end

local var_0_7 = UIAnimationName.Open
local var_0_8 = UIAnimationName.Close

function var_0_0._setSingleStyleActive(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0:_setActiveStartBtn(arg_46_1, arg_46_2)
	arg_46_0:_setActiveSimageMask(arg_46_1, arg_46_2)
end

function var_0_0._setActiveStartBtn(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0._transBtnStartList[arg_47_1]
	local var_47_1 = arg_47_0._animBtnStartList[arg_47_1]
	local var_47_2 = arg_47_2 and var_0_7 or var_0_8

	GameUtil.setActive01(var_47_0, arg_47_2)
	var_47_1:Play(var_47_2, 0, 0)
end

function var_0_0._setActiveSimageMask(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0._transSimageMaskList[arg_48_1]

	if not var_48_0 then
		return
	end

	local var_48_1 = arg_48_2 and var_0_7 or var_0_8
	local var_48_2 = arg_48_0._animSimageMaskList[arg_48_1]

	GameUtil.setActive01(var_48_0, arg_48_2)
	var_48_2:Play(var_48_1, 0, 0)
end

function var_0_0._refreshStartBtn(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1 == arg_49_2 then
		return
	end

	local var_49_0 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(arg_49_1)
	local var_49_1 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(arg_49_2 or arg_49_0:difficulty())
	local var_49_2 = arg_49_0:_getDataList()
	local var_49_3 = var_49_2[arg_49_2].isUnLocked
	local var_49_4

	if arg_49_1 then
		var_49_4 = var_49_2[arg_49_1].isUnLocked
	end

	if var_49_0 == var_49_1 and var_49_3 == var_49_4 then
		return
	end

	if not var_49_0 then
		arg_49_0:_hideAllStartBtn()
		arg_49_0:_hideAllSimageMask()
	else
		arg_49_0:_setSingleStyleActive(var_49_0, false)
	end

	if var_49_3 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open_20190317)
	end

	arg_49_0:_setSingleStyleActive(var_49_1, var_49_3)
end

function var_0_0._refreshList(arg_50_0)
	local var_50_0 = arg_50_0:_getDataList()

	if not arg_50_0._itemList then
		arg_50_0._itemList = {}
	end

	for iter_50_0, iter_50_1 in ipairs(var_50_0) do
		local var_50_1 = arg_50_0._itemList[iter_50_0]

		if not var_50_1 then
			var_50_1 = arg_50_0:_create_RougeDifficultyItem()

			var_50_1:setIndex(iter_50_0)
			table.insert(arg_50_0._itemList, var_50_1)
		end

		var_50_1:setData(iter_50_1)
		var_50_1:playIdle()
		var_50_1:setSelected(arg_50_0._lastSelectedIndex == iter_50_0)
	end
end

function var_0_0._setScaleAdjacent(arg_51_0, arg_51_1, arg_51_2)
	if not arg_51_0._itemList[arg_51_1] then
		return
	end

	local var_51_0 = arg_51_1 - 1
	local var_51_1 = arg_51_0._itemList[var_51_0]

	if var_51_1 then
		var_51_1:setScale(RougeDifficultyItem.ScalerSelectedAdjacent, arg_51_2)

		local var_51_2 = var_51_0 - 1
		local var_51_3 = arg_51_0._itemList[var_51_2]

		if var_51_3 then
			var_51_3:setScale(RougeDifficultyItem.ScalerNormal, arg_51_2)
		end
	end

	local var_51_4 = arg_51_1 + 1
	local var_51_5 = arg_51_0._itemList[var_51_4]

	if var_51_5 then
		var_51_5:setScale(RougeDifficultyItem.ScalerSelectedAdjacent, arg_51_2)

		local var_51_6 = var_51_4 + 1
		local var_51_7 = arg_51_0._itemList[var_51_6]

		if var_51_7 then
			var_51_7:setScale(RougeDifficultyItem.ScalerNormal, arg_51_2)
		end
	end
end

function var_0_0._create_RougeDifficultyItem(arg_52_0)
	local var_52_0 = RougeDifficultyItem
	local var_52_1 = arg_52_0.viewContainer:getResInst(RougeEnum.ResPath.rougedifficultyitem, arg_52_0.viewContainer:getScrollContentGo(), var_52_0.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_52_1, var_52_0, {
		baseViewContainer = arg_52_0.viewContainer
	})
end

function var_0_0._getDataList(arg_53_0)
	if not arg_53_0._dataList then
		arg_53_0._dataList = RougeOutsideModel.instance:getDifficultyInfoList(arg_53_0:_versionList())
	end

	return arg_53_0._dataList
end

function var_0_0._getItemList(arg_54_0)
	if not arg_54_0._itemList then
		arg_54_0:_refreshList()
	end

	return arg_54_0._itemList
end

function var_0_0._getDataListCount(arg_55_0)
	return #arg_55_0:_getDataList()
end

function var_0_0._validateIndex(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0:_getDataListCount()

	return GameUtil.clamp(arg_56_1, 1, var_56_0)
end

function var_0_0._contentPosX(arg_57_0)
	return recthelper.getAnchorX(arg_57_0.viewContainer:getScrollContentTranform())
end

function var_0_0._contentAbsPosX(arg_58_0)
	local var_58_0 = arg_58_0:_contentPosX()

	return var_58_0 <= 0 and -var_58_0 or 0
end

function var_0_0._onScrollValueChanged(arg_59_0)
	arg_59_0:_tweenSelectItemsInBetween()
end

function var_0_0._getIndexFactorInbetween(arg_60_0)
	local var_60_0 = arg_60_0.viewContainer:getListScrollParamStep()
	local var_60_1 = arg_60_0:_contentAbsPosX()
	local var_60_2 = math.ceil(var_60_1 / var_60_0)
	local var_60_3 = var_60_1 % var_60_0

	var_60_3 = var_60_3 == 0 and var_60_0 or var_60_3

	local var_60_4 = var_60_3 / (var_60_0 * 0.5) > 1 and 1 or 0
	local var_60_5 = arg_60_0:_validateIndex(var_60_2 + var_60_4)
	local var_60_6 = arg_60_0:_validateIndex(var_60_4 == 1 and var_60_2 or var_60_2 + 1)
	local var_60_7 = GameUtil.saturate(GameUtil.remap01(var_60_3, 0, var_60_0))
	local var_60_8 = var_60_4 == 1 and var_60_7 or 1 - var_60_7
	local var_60_9 = 1 - var_60_8

	if var_60_5 == var_60_6 then
		var_60_9 = 1
		var_60_8 = 1
	end

	return var_60_5, var_60_8, var_60_6, var_60_9
end

function var_0_0._tweenSelectItemsInBetween(arg_61_0)
	local var_61_0, var_61_1, var_61_2, var_61_3 = arg_61_0:_getIndexFactorInbetween()
	local var_61_4 = arg_61_0._itemList[var_61_0]
	local var_61_5 = arg_61_0._itemList[var_61_2]

	var_61_4:setScale01(var_61_1)
	var_61_5:setScale01(var_61_3)
end

function var_0_0._onDragBeginHandler(arg_62_0)
	arg_62_0:_killTween()
end

function var_0_0._onDragging(arg_63_0)
	arg_63_0:_playAudioOnDragging()
end

function var_0_0._playAudioOnDragging(arg_64_0)
	local var_64_0 = arg_64_0:_getIndexFactorInbetween()

	if arg_64_0._uiAduioLastDragNear == nil then
		arg_64_0._uiAduioLastDragNear = var_64_0
	elseif arg_64_0._uiAduioLastDragNear ~= var_64_0 then
		arg_64_0._uiAduioLastDragNear = var_64_0

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_chain_20190314)
	end
end

function var_0_0._calcContentWidth(arg_65_0)
	return arg_65_0._goContentHLayout.preferredWidth
end

function var_0_0._getViewportW(arg_66_0)
	return recthelper.getWidth(arg_66_0._scrollViewTrans)
end

function var_0_0._getViewportH(arg_67_0)
	return recthelper.getHeight(arg_67_0._scrollViewTrans)
end

function var_0_0._getViewportWH(arg_68_0)
	return arg_68_0:_getViewportW(), arg_68_0:_getViewportH()
end

function var_0_0._getMaxScrollX(arg_69_0)
	local var_69_0 = arg_69_0:_getViewportW()
	local var_69_1 = arg_69_0:_calcContentWidth()

	return math.max(0, var_69_1 - var_69_0)
end

function var_0_0._calcFocusIndexPosX(arg_70_0, arg_70_1)
	local var_70_0 = 0
	local var_70_1 = arg_70_0:_getMaxScrollX()

	if arg_70_1 <= 1 then
		return var_70_0, var_70_1
	end

	local var_70_2 = arg_70_0._itemList[arg_70_1]
	local var_70_3 = arg_70_0._goContentHLayout.padding.left
	local var_70_4 = arg_70_0.viewContainer:getListScrollParam_cellSize() * 0.5

	return var_70_2:posX() - var_70_4 - var_70_3, var_70_1
end

function var_0_0._animFocusIndex(arg_71_0, arg_71_1)
	arg_71_0:_killTween()

	local var_71_0 = -arg_71_0:_calcFocusIndexPosX(arg_71_1)

	arg_71_0._contentPosXTweenId = var_0_1.DOAnchorPosX(arg_71_0.viewContainer:getScrollContentTranform(), var_71_0, var_0_3, nil, nil, nil, EaseType.OutQuad)
end

function var_0_0._noAnimFocusIndex(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0.viewContainer:getScrollContentTranform()
	local var_72_1 = -arg_72_0:_calcFocusIndexPosX(arg_72_1)

	recthelper.setAnchorX(var_72_0, var_72_1)
end

function var_0_0._scrollVelocityX(arg_73_0)
	if not arg_73_0._scrollViewLimitScrollCmp then
		return nil
	end

	return arg_73_0._scrollViewLimitScrollCmp.velocity.x
end

function var_0_0._isScrollSlowly(arg_74_0)
	local var_74_0 = arg_74_0:_scrollVelocityX()

	if not var_74_0 then
		return false
	end

	return math.abs(var_74_0) < var_0_2
end

function var_0_0._update(arg_75_0)
	if not arg_75_0._drag:isEndedDrag() then
		return
	end

	if arg_75_0:_isScrollSlowly() then
		arg_75_0._drag:clear()

		local var_75_0 = arg_75_0:_getIndexFactorInbetween()

		arg_75_0:_onSelectIndex(var_75_0)
	end
end

function var_0_0._setActiveBlock(arg_76_0, arg_76_1)
	gohelper.setActive(arg_76_0._goblock, arg_76_1)

	if not arg_76_1 then
		arg_76_0:_setActiveOverviewTips(false)
		arg_76_0:_setActiveBalanceTips(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190316)
	end
end

function var_0_0._calcLeftRightOffset(arg_77_0)
	local var_77_0 = arg_77_0:_getViewportW()
	local var_77_1 = arg_77_0.viewContainer:getListScrollParam().cellWidth

	return Mathf.Round(var_77_0 * 0.5 - var_77_1 * 0.5)
end

function var_0_0._onScreenResize(arg_78_0)
	local var_78_0 = arg_78_0:_calcLeftRightOffset()

	arg_78_0._goContentHLayout.padding.left = var_78_0
	arg_78_0._goContentHLayout.padding.right = var_78_0

	arg_78_0.viewContainer:rebuildLayout()
end

function var_0_0._calcSpaceOffset(arg_79_0)
	local var_79_0 = arg_79_0.viewContainer:getListScrollParam()
	local var_79_1 = arg_79_0:_getViewportW()
	local var_79_2 = var_79_0.cellWidth
	local var_79_3 = var_79_0.startSpace
	local var_79_4 = var_79_1 * 0.5 - var_79_2 * 0.5 - var_79_3

	return math.max(0, var_79_4)
end

function var_0_0._setExtendProp(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0:getSumDescIndexList(arg_80_1)
	local var_80_1 = arg_80_0:_difficultyCOList()
	local var_80_2 = 0

	for iter_80_0, iter_80_1 in ipairs(var_80_0) do
		local var_80_3 = var_80_1[iter_80_1]
		local var_80_4 = string.split(var_80_3.desc, "\n")

		for iter_80_2, iter_80_3 in ipairs(var_80_4) do
			if not string.nilorempty(iter_80_3) then
				var_80_2 = var_80_2 + 1

				local var_80_5

				if var_80_2 > #arg_80_0._decitemTextList then
					var_80_5 = {}

					local var_80_6 = gohelper.cloneInPlace(arg_80_0._godecitem)

					var_80_5.txt = var_80_6:GetComponent(gohelper.Type_TextMesh)
					var_80_5.go = var_80_6

					table.insert(arg_80_0._decitemTextList, var_80_5)
					gohelper.setActive(var_80_6, true)
				else
					var_80_5 = arg_80_0._decitemTextList[var_80_2]

					gohelper.setActive(var_80_5.go, true)
				end

				var_80_5.txt.text = iter_80_3
			end
		end
	end

	for iter_80_4 = var_80_2 + 1, #arg_80_0._decitemTextList do
		local var_80_7 = arg_80_0._decitemTextList[iter_80_4]

		gohelper.setActive(var_80_7.go, false)
	end
end

function var_0_0.getSumDescIndexList(arg_81_0, arg_81_1)
	arg_81_0._cache_sumDescIndexList = arg_81_0._cache_sumDescIndexList or {}

	if arg_81_0._cache_sumDescIndexList[arg_81_1] then
		return arg_81_0._cache_sumDescIndexList[arg_81_1]
	end

	local var_81_0 = {}
	local var_81_1 = arg_81_0:_difficultyCOList()

	for iter_81_0, iter_81_1 in ipairs(var_81_1) do
		if arg_81_1 <= iter_81_1.difficulty then
			break
		end

		if not string.nilorempty(iter_81_1.desc) then
			table.insert(var_81_0, iter_81_0)
		end
	end

	arg_81_0._cache_sumDescIndexList[arg_81_1] = var_81_0

	return var_81_0
end

local var_0_9 = {
	"p_herogroupbalancetipview_txt_RoleLevel",
	"p_herogroupbalancetipview_txt_TalentLevel",
	"p_herogroupbalancetipview_txt_HeartLevel"
}
local var_0_10 = 3
local var_0_11 = 3

function var_0_0._setBalance(arg_82_0, arg_82_1)
	local var_82_0 = RougeOutsideModel.instance:config():getDifficultyCO(arg_82_1).balanceLevel

	if not not string.nilorempty(var_82_0) then
		return
	end

	local var_82_1 = string.splitToNumber(var_82_0, "#")

	for iter_82_0 = 1, var_0_10 do
		local var_82_2

		if iter_82_0 > #arg_82_0._golevelitemList then
			var_82_2 = {}

			local var_82_3 = gohelper.cloneInPlace(arg_82_0._golevelitem)

			var_82_2.go = var_82_3
			var_82_2.txtTitle = gohelper.findChildText(var_82_3, "#txt_smalltitle")
			var_82_2.txtLevel = gohelper.findChildText(var_82_3, "#txt_level")

			for iter_82_1 = 1, var_0_11 do
				local var_82_4 = gohelper.findChild(var_82_3, "#txt_level/rank" .. iter_82_1)

				var_82_2["rankGO" .. iter_82_1] = var_82_4

				gohelper.setActive(var_82_4, false)
			end

			gohelper.setActive(var_82_3, true)
			table.insert(arg_82_0._golevelitemList, var_82_2)
		else
			var_82_2 = arg_82_0._golevelitemList[iter_82_0]

			gohelper.setActive(var_82_2.go, true)
		end

		var_82_2.txtTitle.text = luaLang(var_0_9[iter_82_0])

		local var_82_5 = 0
		local var_82_6 = 0

		if iter_82_0 == 1 then
			local var_82_7

			var_82_7, var_82_6 = HeroConfig.instance:getShowLevel(var_82_1[iter_82_0])
			var_82_2.txtLevel.text = formatLuaLang("v1a5_aizila_level", var_82_7)
		else
			var_82_2.txtLevel.text = formatLuaLang("v1a5_aizila_level", var_82_1[iter_82_0])
		end

		for iter_82_2 = 1, var_0_11 do
			local var_82_8 = var_82_2["rankGO" .. iter_82_2]

			gohelper.setActive(var_82_8, iter_82_0 == 1 and iter_82_2 == var_82_6 - 1)
		end
	end
end

return var_0_0
