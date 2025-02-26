module("modules.logic.rouge.view.RougeFactionView", package.seeall)

slot0 = class("RougeFactionView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_Content")
	slot0._gorougepageprogress = gohelper.findChild(slot0.viewGO, "#go_rougepageprogress")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_start")
	slot0._godifficultytips = gohelper.findChild(slot0.viewGO, "#go_difficultytips")
	slot0._txtDifficultyTiitle = gohelper.findChildText(slot0.viewGO, "#go_difficultytips/#txt_DifficultyTiitle")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_block")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
end

slot1 = "RougeFactionView:_btnstartOnClick"

function slot0._btnstartOnClick(slot0)
	if not slot0._lastSelectedIndex then
		return
	end

	UIBlockHelper.instance:startBlock(uv0, 1, slot0.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_preparation_open_20190325)

	slot1 = RougeConfig1.instance:season()
	slot2 = slot0:_selectedStyle()
	slot3 = false
	slot4 = false

	slot0._itemList[slot0._lastSelectedIndex]:setOnCloseEndCb(function ()
		uv0 = true

		if not uv1 then
			return
		end

		UIBlockHelper.instance:endBlock(uv2)
		RougeController.instance:openRougeInitTeamView()
	end)

	for slot9, slot10 in ipairs(slot0._itemList) do
		slot10:playClose()
	end

	RougeRpc.instance:sendEnterRougeSelectStyleRequest(slot1, slot2, function (slot0, slot1)
		if slot1 ~= 0 then
			logError("RougeFactionView:_btnstartOnClick resultCode=" .. tostring(slot1))

			return
		end

		uv0 = true

		if not uv1 then
			return
		end

		UIBlockHelper.instance:endBlock(uv2)
		RougeController.instance:openRougeInitTeamView()
	end)
end

function slot0._editableInitView(slot0)
	slot0._btnstartGo = slot0._btnstart.gameObject

	slot0:_initScrollView()
	slot0:_setActiveBtnStart(false)
end

function slot0._initScrollView(slot0)
	slot0._scrollViewGo = slot0._scrollview.gameObject
	slot0._scrollViewTrans = slot0._scrollViewGo.transform
	slot0._scrollViewLimitScrollCmp = slot0._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	slot0._goContentHLayout = slot0._goContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	slot0._drag = UIDragListenerHelper.New()

	slot0._drag:createByScrollRect(slot0._scrollViewLimitScrollCmp)
	slot0._drag:registerCallback(slot0._drag.EventDragging, slot0._onDragging, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_setActiveBlock(false)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	slot0._lastSelectedIndex = false
	slot0._dataList = RougeOutsideModel.instance:getStyleInfoList(slot0:_versionList())

	slot0:_initDifficultyTips()
	slot0:_initPageProgress()
	slot0:onUpdateParam()
	slot0:_onSelectIndex(nil)
	slot0.viewContainer:registerCallback(RougeEvent.RougeFactionView_OnSelectIndex, slot0._onSelectIndex, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0:_onScreenResize()
	slot0:_tweenOpenAnim()
	ViewMgr.instance:closeView(ViewName.RougeDifficultyView)
	ViewMgr.instance:closeView(ViewName.RougeCollectionGiftView)
end

function slot0._getNewUnlockStateList(slot0)
	for slot6, slot7 in ipairs(slot0._dataList) do
		if not nil and slot9 then
			slot2 = slot6
		end
	end

	return {
		[slot6] = RougeOutsideModel.instance:getIsNewUnlockStyle(slot7.style)
	}, slot2
end

function slot0._tweenOpenAnim(slot0)
	UIBlockHelper.instance:startBlock("RougeFactionView:_tweenOpenAnim", 1, slot0.viewName)

	slot2, slot3 = slot0:_getNewUnlockStateList()
	slot3 = slot3 or 1

	slot0:_focusIndex(slot3)
	slot0:_getItemList()[slot3]:setOnOpenEndCb(function ()
		UIBlockHelper.instance:endBlock("RougeFactionView:_tweenOpenAnim")
	end)

	if slot2[slot3] then
		slot4:setOnOpenEndCb(nil)
		slot4:setOnUnlockEndCb(slot5)
	else
		slot4:setOnOpenEndCb(slot5)
	end

	for slot9, slot10 in ipairs(slot1) do
		if slot9 == 1 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
		end

		if (slot2 and slot2[slot9] or nil) ~= nil then
			slot10:playOpen(slot11)

			if slot11 then
				RougeOutsideModel.instance:setIsNewUnlockStyle(slot0._dataList[slot9].style, false)
			end
		else
			slot10:playOpen()
		end
	end
end

function slot0.onClose(slot0)
	slot0:_clearTweenId()
	slot0.viewContainer:unregisterCallback(RougeEvent.RougeFactionView_OnSelectIndex, slot0._onSelectIndex, slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_clearTweenId()
	GameUtil.onDestroyViewMember(slot0, "_drag")
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
end

function slot0._difficulty(slot0)
	if not slot0.viewParam then
		return RougeModel.instance:getDifficulty()
	end

	return slot0.viewParam.selectedDifficulty or RougeModel.instance:getDifficulty()
end

function slot0._versionList(slot0)
	if not slot0.viewParam then
		return RougeModel.instance:getVersion()
	end

	return slot0.viewParam.versionList or RougeModel.instance:getVersion()
end

function slot0._getDataList(slot0)
	if not slot0._dataList then
		slot0._dataList = RougeOutsideModel.instance:getStyleInfoList(slot0:_versionList())
	end

	return slot0._dataList
end

function slot0._getDataListCount(slot0)
	return #slot0:_getDataList()
end

function slot0._validateIndex(slot0, slot1)
	return GameUtil.clamp(slot1, 1, slot0:_getDataListCount())
end

function slot0._getItemList(slot0)
	if not slot0._itemList then
		slot0:_refreshList()
	end

	return slot0._itemList
end

function slot0._refresh(slot0)
	slot0:_refreshList()
end

function slot0._refreshList(slot0)
	slot0._itemDataList = slot0:_getDataList()

	if not slot0._itemList then
		slot0._itemList = {}
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._itemList[slot5] then
			slot7 = slot0:_create_RougeFactionItem()

			slot7:setIndex(slot5)
			table.insert(slot0._itemList, slot7)
		end

		slot7:setData(slot6)
		slot7:playIdle()
		slot7:setSelected(slot0._lastSelectedIndex == slot5)
	end
end

function slot0._onSelectIndex(slot0, slot1)
	if not slot0._itemList then
		return
	end

	if slot0._lastSelectedIndex then
		slot0._itemList[slot0._lastSelectedIndex]:setSelected(false)
	end

	if slot0._lastSelectedIndex == slot1 then
		slot1 = nil

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190321)
	end

	if slot1 then
		slot0._itemList[slot1]:setSelected(true)
		slot0.viewContainer:rebuildLayout()
		slot0:_focusIndex(slot1, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190321)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_help_switch_20190322)
	end

	slot0._lastSelectedIndex = slot1

	slot0:_setActiveBtnStart(slot1 and true or false)
end

function slot0._setActiveBtnStart(slot0, slot1)
	gohelper.setActive(slot0._btnstartGo, slot1)
end

function slot0._clearTweenId(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId")
end

function slot0._create_RougeFactionItem(slot0)
	slot1 = RougeFactionItem

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(RougeEnum.ResPath.rougefactionitem, slot0._goContent, slot1.__cname), slot1, {
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})
end

function slot0._selectedStyle(slot0)
	if not slot0._lastSelectedIndex then
		return
	end

	return slot0._itemList[slot0._lastSelectedIndex]:style()
end

function slot0._initPageProgress(slot0)
	slot1 = RougePageProgress
	slot0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, slot0._gorougepageprogress, slot1.__cname), slot1)

	slot0._pageProgress:setData()
end

function slot0._initDifficultyTips(slot0)
	slot1 = slot0:_difficulty()
	slot0._txtDifficultyTiitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougefactionview_txtDifficultyTiitle"), RougeConfig1.instance:getDifficultyCOTitle(slot1))

	gohelper.setActive(gohelper.findChild(slot0._godifficultytips, "green"), RougeConfig1.instance:getRougeDifficultyViewStyleIndex(slot1) == 1)
	gohelper.setActive(gohelper.findChild(slot0._godifficultytips, "orange"), slot2 == 2)
	gohelper.setActive(gohelper.findChild(slot0._godifficultytips, "red"), slot2 == 3)
end

function slot0._focusIndex(slot0, slot1, slot2, slot3)
	if slot2 then
		slot0:_clearTweenId()

		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0.viewContainer:getScrollContentTranform(), -slot0:_calcFocusIndexPosX(slot1), slot3 or 0.3)
	else
		recthelper.setAnchorX(slot4, -slot5)
	end
end

function slot0._calcFocusIndexPosX(slot0, slot1)
	slot3 = slot0:_getMaxScrollX()

	if slot1 <= 1 then
		return 0, slot3
	end

	return GameUtil.clamp(slot0._itemList[slot1]:posX() - slot0._goContentHLayout.padding.left - slot0:_getViewportW() * 0.5, 0, slot3), slot3
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
	return math.max(0, slot0:_calcContentWidth() - slot0:_getViewportWH())
end

function slot0._calcContentWidth(slot0)
	return recthelper.getWidth(slot0.viewContainer:getScrollContentTranform())
end

function slot0._setActiveBlock(slot0, slot1)
	gohelper.setActive(slot0._goblock, slot1)
end

function slot0._onScreenResize(slot0)
	slot0.viewContainer:rebuildLayout()

	if slot0._lastSelectedIndex then
		slot0:_focusIndex(slot0._lastSelectedIndex, true, 0.1)
	end
end

function slot0._calcSpaceOffset(slot0)
	slot1 = slot0.viewContainer:getListScrollParam()

	return math.max(0, slot0:_getViewportW() * 0.5 - slot1.cellWidth * 0.5 - slot1.startSpace)
end

function slot0._contentPosX(slot0)
	return recthelper.getAnchorX(slot0.viewContainer:getScrollContentTranform())
end

slot2 = 139

function slot0._onDragging(slot0)
	slot1 = slot0.viewContainer:getListScrollParamStep()

	if slot0:_contentPosX() >= 0 then
		return
	end

	if GameUtil.clamp(-slot2, 0, slot0:_getMaxScrollX()) < uv0 then
		return
	end

	if slot0._lastScrollIndex == nil then
		slot0._lastScrollIndex = math.ceil((slot3 - uv0) / slot1)
	elseif slot0._lastScrollIndex ~= slot4 then
		slot0._lastScrollIndex = slot4

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_chain_20190320)
	end
end

return slot0
