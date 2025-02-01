module("modules.logic.rouge.view.RougeDifficultyView", package.seeall)

slot0 = class("RougeDifficultyView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagemask2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask2")
	slot0._simagemask3 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask3")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "Middle/#scroll_view")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	slot0._btnleftarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#btn_leftarrow")
	slot0._btnrightarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#btn_rightarrow")
	slot0._gorougepageprogress = gohelper.findChild(slot0.viewGO, "#go_rougepageprogress")
	slot0._btnstart1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_start1")
	slot0._btnstart2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_start2")
	slot0._btnstart3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_start3")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_block")
	slot0._gooverviewtips = gohelper.findChild(slot0.viewGO, "#go_overviewtips")
	slot0._godecitem = gohelper.findChild(slot0.viewGO, "#go_overviewtips/#scroll_overview/Viewport/Content/#txt_decitem")
	slot0._gobalancetips = gohelper.findChild(slot0.viewGO, "#go_balancetips")
	slot0._golevelitem = gohelper.findChild(slot0.viewGO, "#go_balancetips/#scroll_details/Viewport/Content/level/#go_levelitem")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleftarrow:AddClickListener(slot0._btnleftarrowOnClick, slot0)
	slot0._btnrightarrow:AddClickListener(slot0._btnrightarrowOnClick, slot0)
	slot0._btnstart1:AddClickListener(slot0._btnstart1OnClick, slot0)
	slot0._btnstart2:AddClickListener(slot0._btnstart2OnClick, slot0)
	slot0._btnstart3:AddClickListener(slot0._btnstart3OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleftarrow:RemoveClickListener()
	slot0._btnrightarrow:RemoveClickListener()
	slot0._btnstart1:RemoveClickListener()
	slot0._btnstart2:RemoveClickListener()
	slot0._btnstart3:RemoveClickListener()
end

slot1 = ZProj.TweenHelper
slot2 = 100
slot3 = 0.3
slot4 = 0.6
slot5 = 2

function slot0._btnleftarrowOnClick(slot0)
	slot0:_moveByArrow(true)
end

function slot0._btnrightarrowOnClick(slot0)
	slot0:_moveByArrow(false)
end

function slot0._moveByArrow(slot0, slot1)
	slot0._drag:clear()

	slot2 = slot0._lastSelectedIndex or slot1 and 2 or 0

	slot0:_onSelectIndex(slot0:_validateIndex(slot1 and slot2 - 1 or slot2 + 1))
end

function slot0._btnstart1OnClick(slot0)
	slot0:_btnStartOnClick()
end

function slot0._btnstart2OnClick(slot0)
	slot0:_btnStartOnClick()
end

function slot0._btnstart3OnClick(slot0)
	slot0:_btnStartOnClick()
end

slot6 = "RougeDifficultyView:_btnStartOnClick"

function slot0._btnStartOnClick(slot0)
	slot1 = RougeOutsideModel.instance:season()
	slot3 = slot0:difficulty()
	slot4 = nil

	if tabletool.indexOf(slot0:_versionList(), RougeDLCEnum.DLCEnum.DLC_101) then
		slot4 = RougeDLCModel101.instance:getLimiterClientMo()
	end

	if not slot0._lastSelectedIndex then
		return
	end

	UIBlockHelper.instance:startBlock(uv0, 1, slot0.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_columns_update_20190318)

	slot5 = false
	slot6 = false

	slot0._itemList[slot0._lastSelectedIndex]:setOnCloseEndCb(function ()
		uv0 = true

		if not uv1 then
			return
		end

		UIBlockHelper.instance:endBlock(uv2)
		uv3:_directOpenNextView()
	end)

	for slot13 = slot0:_validateIndex(slot0._lastSelectedIndex - 2), slot0:_validateIndex(slot0._lastSelectedIndex + 2) do
		slot0._itemList[slot13]:playClose()
	end

	RougeRpc.instance:sendEnterRougeSelectDifficultyRequest(slot1, slot2, slot3, slot4, function (slot0, slot1)
		if slot1 ~= 0 then
			logError("RougeDifficultyView:_btnStartOnClick resultCode=" .. tostring(slot1))

			return
		end

		RougeOutsideModel.instance:setLastMarkSelectedDifficulty(uv0)

		uv1 = true

		if not uv2 then
			return
		end

		UIBlockHelper.instance:endBlock(uv3)
		uv4:_directOpenNextView()
	end)
end

function slot0._directOpenNextView(slot0)
	if RougeModel.instance:isCanSelectRewards() then
		RougeController.instance:openRougeSelectRewardsView()
	else
		RougeController.instance:openRougeFactionView()
	end
end

function slot0._editableInitView(slot0)
	slot0._goblockClick = gohelper.findChildClick(slot0._goblock, "")

	slot0._goblockClick:AddClickListener(slot0._goblockClickonClick, slot0)

	slot0._decitemTextList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._godecitem, false)

	slot0._golevelitemList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._golevelitem, false)
	slot0:_setActiveOverviewTips(false)
	slot0:_setActiveBalanceTips(false)
	slot0:_initScrollView()
	slot0:_initPageProgress()
	slot0:_initViewStyles()
end

function slot0._goblockClickonClick(slot0)
	slot0:_setActiveBlock(false)
end

function slot0._setActiveOverviewTips(slot0, slot1)
	gohelper.setActive(slot0._gooverviewtips, slot1)
end

function slot0._setActiveBalanceTips(slot0, slot1)
	gohelper.setActive(slot0._gobalancetips, slot1)
end

function slot0._initScrollView(slot0)
	slot0._scrollViewGo = slot0._scrollview.gameObject
	slot0._scrollViewTrans = slot0._scrollViewGo.transform
	slot0._scrollViewLimitScrollCmp = slot0._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	slot0._goContentHLayout = slot0._goContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	slot0._drag = UIDragListenerHelper.New()

	slot0._drag:createByScrollRect(slot0._scrollViewLimitScrollCmp)
	slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBeginHandler, slot0)
	slot0._drag:registerCallback(slot0._drag.EventDragging, slot0._onDragging, slot0)
	slot0._scrollview:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
end

function slot0._initPageProgress(slot0)
	slot1 = RougePageProgress
	slot0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, slot0._gorougepageprogress, slot1.__cname), slot1)

	slot0._pageProgress:setData()
end

function slot0._initViewStyles(slot0)
	slot0._transBtnStartList = slot0:getUserDataTb_()
	slot0._animBtnStartList = slot0:getUserDataTb_()
	slot2 = slot0["_btnstart" .. 1]

	while slot2 ~= nil do
		slot3 = slot2.gameObject
		slot4 = slot3.transform

		table.insert(slot0._transBtnStartList, slot4)
		table.insert(slot0._animBtnStartList, slot3:GetComponent(gohelper.Type_Animator))
		gohelper.setActive(slot3, true)
		GameUtil.setActive01(slot4, false)

		slot2 = slot0["_btnstart" .. slot1 + 1]
	end

	slot0._transSimageMaskList = slot0:getUserDataTb_()
	slot0._animSimageMaskList = slot0:getUserDataTb_()

	for slot6 = 1, #slot0._transBtnStartList do
		if slot0["_simagemask" .. slot6] then
			slot8 = slot7.gameObject
			slot9 = slot8.transform
			slot0._transSimageMaskList[slot6] = slot9
			slot0._animSimageMaskList[slot6] = slot8:GetComponent(gohelper.Type_Animator)

			GameUtil.setActive01(slot9, false)
			gohelper.setActive(slot8, true)
		end
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
	slot0:_onSelectIndex(slot0:_onOpenSelectedIndex())
end

function slot0.onOpen(slot0)
	slot0._lastSelectedIndex = false
	slot0._uiAduioLastDragNear = nil
	slot0._cache_difficultyCOList = nil
	slot0._cache_sumDescIndexList = nil

	slot0:_setActiveBlock(false)

	slot0._dataList = RougeOutsideModel.instance:getDifficultyInfoList(slot0:_versionList())

	slot0:_refresh()
	UpdateBeat:Add(slot0._update, slot0)
	slot0.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_OnSelectIndex, slot0._onSelectIndexByUser, slot0)
	slot0.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, slot0._btnTipsIconOnClick, slot0)
	slot0.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_btnBalanceOnClick, slot0._btnBalanceOnClick, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0:_onScreenResize()
	slot0:_tweenOpenAnim()
end

function slot0.onClose(slot0)
	slot0:_clearTweenOpenAnimFirstItemScaleTimer()
	UpdateBeat:Remove(slot0._update, slot0)
	slot0._goblockClick:RemoveClickListener()
	slot0._scrollview:RemoveOnValueChanged()
	slot0.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_OnSelectIndex, slot0._onSelectIndexByUser, slot0)
	slot0.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, slot0._btnTipsIconOnClick, slot0)
	slot0.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_btnBalanceOnClick, slot0._btnBalanceOnClick, slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:_killTween()
end

function slot0._killTween(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_contentPosXTweenId")
end

function slot0._clearTweenOpenAnimFirstItemScaleTimer(slot0)
	TaskDispatcher.cancelTask(slot0._tweenOpenAnimFirstItemScale, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_clearTweenOpenAnimFirstItemScaleTimer()
	UpdateBeat:Remove(slot0._update, slot0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
end

function slot0._refresh(slot0)
	slot0:_refreshList()
end

function slot0._getNewUnlockStateList(slot0)
	for slot5, slot6 in ipairs(slot0._dataList) do
		-- Nothing
	end

	return {
		[slot5] = RougeOutsideModel.instance:getIsNewUnlockDifficulty(slot6.difficulty)
	}
end

function slot0._tweenOpenAnimFirstItemScale(slot0)
	if not slot0._itemList then
		return
	end

	if not slot0._itemList[1] then
		return
	end

	slot0:_setScaleAdjacent(1, true)
	slot1:tweenScale(RougeDifficultyItem.ScalerSelected)
end

function slot0._tweenOpenAnim(slot0)
	UIBlockHelper.instance:startBlock("RougeDifficultyView:_tweenOpenAnim", 1.9, slot0.viewName)

	slot2 = slot0:_getNewUnlockStateList()
	slot3 = slot0:_onOpenSelectedIndex()
	slot4 = slot0:_getItemList()[slot3]

	function slot5()
		UIBlockHelper.instance:endBlock("RougeRougeDifficultyViewFactionView:_tweenOpenAnim")
		uv0:_onSelectIndex(uv1)
	end

	if slot3 == 1 then
		slot0:_clearTweenOpenAnimFirstItemScaleTimer()
		TaskDispatcher.runDelay(slot0._tweenOpenAnimFirstItemScale, slot0, slot2[slot3] and uv0 or uv1)
	end

	slot4:setOnOpenEndCb(slot5)

	if slot2[slot3] then
		slot4:setOnOpenEndCb(nil)
		slot4:setOnUnlockEndCb(slot5)
	end

	for slot9, slot10 in ipairs(slot1) do
		slot11 = slot2 and slot2[slot9] or nil

		if slot9 == 1 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190313)
		end

		if slot11 ~= nil then
			slot10:playOpen(slot11)

			if slot11 then
				RougeOutsideModel.instance:setIsNewUnlockDifficulty(slot0._dataList[slot9].difficulty, false)
			end
		else
			slot10:playOpen()
		end
	end
end

function slot0._versionList(slot0)
	if not slot0.viewParam then
		return RougeModel.instance:getVersion()
	end

	return slot0.viewParam.versionList or RougeModel.instance:getVersion()
end

function slot0._trySelectDifficulty2TabIndex(slot0, slot1)
	if slot1 > #slot0:_getDataList() then
		return 1
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7.difficulty == slot1 then
			return slot7.isUnLocked and slot6 or 1
		end
	end

	return 1
end

function slot0._selectedDifficultyOnOpen(slot0)
	if not slot0.viewParam then
		return slot0:_trySelectDifficulty2TabIndex(RougeOutsideModel.instance:getLastMarkSelectedDifficulty(1))
	end

	return slot0.viewParam.selectedDifficulty or slot0:_trySelectDifficulty2TabIndex(RougeOutsideModel.instance:getLastMarkSelectedDifficulty(1))
end

function slot0.difficulty(slot0)
	return slot0._lastSelectedIndex or slot0:_onOpenSelectedIndex()
end

function slot0._difficultyCOList(slot0)
	if slot0._cache_difficultyCOList then
		return slot0._cache_difficultyCOList
	end

	slot2 = RougeOutsideModel.instance:config():getDifficultyCOListByVersions(slot0:_versionList())
	slot0._cache_difficultyCOList = slot2

	return slot2
end

function slot0._onOpenSelectedIndex(slot0)
	if (slot0._lastSelectedIndex or slot0:_selectedDifficultyOnOpen()) > #slot0._itemList then
		return 1
	end

	return slot1
end

function slot0._onSelectIndexByUser(slot0, slot1)
	slot0._drag:stopMovement()
	slot0:_onSelectIndex(slot1)
end

function slot0._guessIsStopedScrolling(slot0)
	if not slot0._drag:isStoped() then
		return false
	end

	if not slot0:_isScrollSlowly() then
		return false
	end

	return true
end

function slot0._btnTipsIconOnClick(slot0, slot1)
	if not slot0:_guessIsStopedScrolling() then
		return
	end

	slot0:_setExtendProp(slot1)
	slot0:_setActiveOverviewTips(true)
	slot0:_setActiveBlock(true)
end

function slot0._btnBalanceOnClick(slot0, slot1)
	if not slot0:_guessIsStopedScrolling() then
		return
	end

	slot0:_setBalance(slot1)
	slot0:_setActiveBalanceTips(true)
	slot0:_setActiveBlock(true)
end

function slot0._onSelectIndex(slot0, slot1)
	if slot0._lastSelectedIndex == slot1 then
		slot0:_animFocusIndex(slot1)

		return
	end

	if slot0._lastSelectedIndex then
		slot0._itemList[slot0._lastSelectedIndex]:setSelected(false)
	end

	slot0._itemList[slot1]:setSelected(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_insight_close_20190315)
	slot0:_setScaleAdjacent(slot1, true)
	slot0:_refreshStartBtn(slot0._lastSelectedIndex, slot1)

	slot0._lastSelectedIndex = slot1

	slot0:_animFocusIndex(slot1)
end

function slot0._hideAllStartBtn(slot0)
	for slot4, slot5 in ipairs(slot0._transBtnStartList) do
		GameUtil.setActive01(slot5, false)
	end
end

function slot0._hideAllSimageMask(slot0)
	for slot4, slot5 in ipairs(slot0._transSimageMaskList) do
		GameUtil.setActive01(slot5, false)
	end
end

slot7 = UIAnimationName.Open
slot8 = UIAnimationName.Close

function slot0._setSingleStyleActive(slot0, slot1, slot2)
	slot0:_setActiveStartBtn(slot1, slot2)
	slot0:_setActiveSimageMask(slot1, slot2)
end

function slot0._setActiveStartBtn(slot0, slot1, slot2)
	GameUtil.setActive01(slot0._transBtnStartList[slot1], slot2)
	slot0._animBtnStartList[slot1]:Play(slot2 and uv0 or uv1, 0, 0)
end

function slot0._setActiveSimageMask(slot0, slot1, slot2)
	if not slot0._transSimageMaskList[slot1] then
		return
	end

	GameUtil.setActive01(slot3, slot2)
	slot0._animSimageMaskList[slot1]:Play(slot2 and uv0 or uv1, 0, 0)
end

function slot0._refreshStartBtn(slot0, slot1, slot2)
	if slot1 == slot2 then
		return
	end

	slot3 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(slot1)
	slot4 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(slot2 or slot0:difficulty())
	slot6 = slot0:_getDataList()[slot2].isUnLocked
	slot7 = nil

	if slot1 then
		slot7 = slot5[slot1].isUnLocked
	end

	if slot3 == slot4 and slot6 == slot7 then
		return
	end

	if not slot3 then
		slot0:_hideAllStartBtn()
		slot0:_hideAllSimageMask()
	else
		slot0:_setSingleStyleActive(slot3, false)
	end

	if slot6 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open_20190317)
	end

	slot0:_setSingleStyleActive(slot4, slot6)
end

function slot0._refreshList(slot0)
	slot1 = slot0:_getDataList()

	if not slot0._itemList then
		slot0._itemList = {}
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._itemList[slot5] then
			slot7 = slot0:_create_RougeDifficultyItem()

			slot7:setIndex(slot5)
			table.insert(slot0._itemList, slot7)
		end

		slot7:setData(slot6)
		slot7:playIdle()
		slot7:setSelected(slot0._lastSelectedIndex == slot5)
	end
end

function slot0._setScaleAdjacent(slot0, slot1, slot2)
	if not slot0._itemList[slot1] then
		return
	end

	if slot0._itemList[slot1 - 1] then
		slot5:setScale(RougeDifficultyItem.ScalerSelectedAdjacent, slot2)

		if slot0._itemList[slot4 - 1] then
			slot6:setScale(RougeDifficultyItem.ScalerNormal, slot2)
		end
	end

	if slot0._itemList[slot1 + 1] then
		slot7:setScale(RougeDifficultyItem.ScalerSelectedAdjacent, slot2)

		if slot0._itemList[slot6 + 1] then
			slot8:setScale(RougeDifficultyItem.ScalerNormal, slot2)
		end
	end
end

function slot0._create_RougeDifficultyItem(slot0)
	slot1 = RougeDifficultyItem

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(RougeEnum.ResPath.rougedifficultyitem, slot0.viewContainer:getScrollContentGo(), slot1.__cname), slot1, {
		baseViewContainer = slot0.viewContainer
	})
end

function slot0._getDataList(slot0)
	if not slot0._dataList then
		slot0._dataList = RougeOutsideModel.instance:getDifficultyInfoList(slot0:_versionList())
	end

	return slot0._dataList
end

function slot0._getItemList(slot0)
	if not slot0._itemList then
		slot0:_refreshList()
	end

	return slot0._itemList
end

function slot0._getDataListCount(slot0)
	return #slot0:_getDataList()
end

function slot0._validateIndex(slot0, slot1)
	return GameUtil.clamp(slot1, 1, slot0:_getDataListCount())
end

function slot0._contentPosX(slot0)
	return recthelper.getAnchorX(slot0.viewContainer:getScrollContentTranform())
end

function slot0._contentAbsPosX(slot0)
	return slot0:_contentPosX() <= 0 and -slot1 or 0
end

function slot0._onScrollValueChanged(slot0)
	slot0:_tweenSelectItemsInBetween()
end

function slot0._getIndexFactorInbetween(slot0)
	slot1 = slot0.viewContainer:getListScrollParamStep()
	slot2 = slot0:_contentAbsPosX()
	slot3 = math.ceil(slot2 / slot1)

	if slot2 % slot1 == 0 then
		slot4 = slot1 or slot4
	end

	slot5 = slot4 / (slot1 * 0.5) > 1 and 1 or 0
	slot8 = slot0
	slot8 = GameUtil.saturate(GameUtil.remap01(slot4, 0, slot1))
	slot10 = 1 - (slot5 == 1 and slot8 or 1 - slot8)

	if slot0:_validateIndex(slot3 + slot5) == slot0._validateIndex(slot8, slot5 == 1 and slot3 or slot3 + 1) then
		slot10 = 1
		slot9 = 1
	end

	return slot6, slot9, slot7, slot10
end

function slot0._tweenSelectItemsInBetween(slot0)
	slot1, slot2, slot3, slot4 = slot0:_getIndexFactorInbetween()

	slot0._itemList[slot1]:setScale01(slot2)
	slot0._itemList[slot3]:setScale01(slot4)
end

function slot0._onDragBeginHandler(slot0)
	slot0:_killTween()
end

function slot0._onDragging(slot0)
	slot0:_playAudioOnDragging()
end

function slot0._playAudioOnDragging(slot0)
	if slot0._uiAduioLastDragNear == nil then
		slot0._uiAduioLastDragNear = slot0:_getIndexFactorInbetween()
	elseif slot0._uiAduioLastDragNear ~= slot1 then
		slot0._uiAduioLastDragNear = slot1

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_chain_20190314)
	end
end

function slot0._calcContentWidth(slot0)
	return slot0._goContentHLayout.preferredWidth
end

function slot0._getViewportW(slot0)
	return recthelper.getWidth(slot0._scrollViewTrans)
end

function slot0._getViewportH(slot0)
	return recthelper.getHeight(slot0._scrollViewTrans)
end

function slot0._getViewportWH(slot0)
	return slot0:_getViewportW(), slot0:_getViewportH()
end

function slot0._getMaxScrollX(slot0)
	return math.max(0, slot0:_calcContentWidth() - slot0:_getViewportW())
end

function slot0._calcFocusIndexPosX(slot0, slot1)
	slot3 = slot0:_getMaxScrollX()

	if slot1 <= 1 then
		return 0, slot3
	end

	return slot0._itemList[slot1]:posX() - slot0.viewContainer:getListScrollParam_cellSize() * 0.5 - slot0._goContentHLayout.padding.left, slot3
end

function slot0._animFocusIndex(slot0, slot1)
	slot0:_killTween()

	slot0._contentPosXTweenId = uv0.DOAnchorPosX(slot0.viewContainer:getScrollContentTranform(), -slot0:_calcFocusIndexPosX(slot1), uv1, nil, , , EaseType.OutQuad)
end

function slot0._noAnimFocusIndex(slot0, slot1)
	recthelper.setAnchorX(slot0.viewContainer:getScrollContentTranform(), -slot0:_calcFocusIndexPosX(slot1))
end

function slot0._scrollVelocityX(slot0)
	if not slot0._scrollViewLimitScrollCmp then
		return nil
	end

	return slot0._scrollViewLimitScrollCmp.velocity.x
end

function slot0._isScrollSlowly(slot0)
	if not slot0:_scrollVelocityX() then
		return false
	end

	return math.abs(slot1) < uv0
end

function slot0._update(slot0)
	if not slot0._drag:isEndedDrag() then
		return
	end

	if slot0:_isScrollSlowly() then
		slot0._drag:clear()
		slot0:_onSelectIndex(slot0:_getIndexFactorInbetween())
	end
end

function slot0._setActiveBlock(slot0, slot1)
	gohelper.setActive(slot0._goblock, slot1)

	if not slot1 then
		slot0:_setActiveOverviewTips(false)
		slot0:_setActiveBalanceTips(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190316)
	end
end

function slot0._calcLeftRightOffset(slot0)
	return Mathf.Round(slot0:_getViewportW() * 0.5 - slot0.viewContainer:getListScrollParam().cellWidth * 0.5)
end

function slot0._onScreenResize(slot0)
	slot1 = slot0:_calcLeftRightOffset()
	slot0._goContentHLayout.padding.left = slot1
	slot0._goContentHLayout.padding.right = slot1

	slot0.viewContainer:rebuildLayout()
end

function slot0._calcSpaceOffset(slot0)
	slot1 = slot0.viewContainer:getListScrollParam()

	return math.max(0, slot0:_getViewportW() * 0.5 - slot1.cellWidth * 0.5 - slot1.startSpace)
end

function slot0._setExtendProp(slot0, slot1)
	slot3 = slot0:_difficultyCOList()
	slot4 = 0

	for slot8, slot9 in ipairs(slot0:getSumDescIndexList(slot1)) do
		for slot15, slot16 in ipairs(string.split(slot3[slot9].desc, "\n")) do
			if not string.nilorempty(slot16) then
				slot17 = nil

				if slot4 + 1 > #slot0._decitemTextList then
					slot18 = gohelper.cloneInPlace(slot0._godecitem)

					table.insert(slot0._decitemTextList, {
						txt = slot18:GetComponent(gohelper.Type_TextMesh),
						go = slot18
					})
					gohelper.setActive(slot18, true)
				else
					gohelper.setActive(slot0._decitemTextList[slot4].go, true)
				end

				slot17.txt.text = slot16
			end
		end
	end

	for slot8 = slot4 + 1, #slot0._decitemTextList do
		gohelper.setActive(slot0._decitemTextList[slot8].go, false)
	end
end

function slot0.getSumDescIndexList(slot0, slot1)
	slot0._cache_sumDescIndexList = slot0._cache_sumDescIndexList or {}

	if slot0._cache_sumDescIndexList[slot1] then
		return slot0._cache_sumDescIndexList[slot1]
	end

	slot2 = {}

	for slot7, slot8 in ipairs(slot0:_difficultyCOList()) do
		if slot1 <= slot8.difficulty then
			break
		end

		if not string.nilorempty(slot8.desc) then
			table.insert(slot2, slot7)
		end
	end

	slot0._cache_sumDescIndexList[slot1] = slot2

	return slot2
end

slot9 = {
	"p_herogroupbalancetipview_txt_RoleLevel",
	"p_herogroupbalancetipview_txt_TalentLevel",
	"p_herogroupbalancetipview_txt_HeartLevel"
}
slot10 = 3
slot11 = 3

function slot0._setBalance(slot0, slot1)
	if not not string.nilorempty(RougeOutsideModel.instance:config():getDifficultyCO(slot1).balanceLevel) then
		return
	end

	slot6 = string.splitToNumber(slot4, "#")

	for slot10 = 1, uv0 do
		slot11 = nil

		if slot10 > #slot0._golevelitemList then
			slot12 = gohelper.cloneInPlace(slot0._golevelitem)

			for slot16 = 1, uv1 do
				gohelper.setActive(gohelper.findChild(slot12, "#txt_level/rank" .. slot16), false)
			end

			gohelper.setActive(slot12, true)
			table.insert(slot0._golevelitemList, {
				go = slot12,
				txtTitle = gohelper.findChildText(slot12, "#txt_smalltitle"),
				txtLevel = gohelper.findChildText(slot12, "#txt_level"),
				["rankGO" .. slot16] = slot17
			})
		else
			gohelper.setActive(slot0._golevelitemList[slot10].go, true)
		end

		slot11.txtTitle.text = luaLang(uv2[slot10])
		slot12 = 0
		slot13 = 0

		if slot10 == 1 then
			slot14, slot13 = HeroConfig.instance:getShowLevel(slot6[slot10])
			slot11.txtLevel.text = formatLuaLang("v1a5_aizila_level", slot14)
		else
			slot11.txtLevel.text = formatLuaLang("v1a5_aizila_level", slot6[slot10])
		end

		for slot17 = 1, uv1 do
			gohelper.setActive(slot11["rankGO" .. slot17], slot10 == 1 and slot17 == slot13 - 1)
		end
	end
end

return slot0
