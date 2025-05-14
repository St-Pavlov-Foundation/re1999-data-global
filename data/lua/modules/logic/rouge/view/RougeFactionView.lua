module("modules.logic.rouge.view.RougeFactionView", package.seeall)

local var_0_0 = class("RougeFactionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_Content")
	arg_1_0._gorougepageprogress = gohelper.findChild(arg_1_0.viewGO, "#go_rougepageprogress")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_start")
	arg_1_0._godifficultytips = gohelper.findChild(arg_1_0.viewGO, "#go_difficultytips")
	arg_1_0._txtDifficultyTiitle = gohelper.findChildText(arg_1_0.viewGO, "#go_difficultytips/#txt_DifficultyTiitle")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
end

local var_0_1 = "RougeFactionView:_btnstartOnClick"

function var_0_0._btnstartOnClick(arg_4_0)
	if not arg_4_0._lastSelectedIndex then
		return
	end

	UIBlockHelper.instance:startBlock(var_0_1, 1, arg_4_0.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_preparation_open_20190325)

	local var_4_0 = RougeConfig1.instance:season()
	local var_4_1 = arg_4_0:_selectedStyle()
	local var_4_2 = false
	local var_4_3 = false

	arg_4_0._itemList[arg_4_0._lastSelectedIndex]:setOnCloseEndCb(function()
		var_4_2 = true

		if not var_4_3 then
			return
		end

		UIBlockHelper.instance:endBlock(var_0_1)
		RougeController.instance:openRougeInitTeamView()
	end)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._itemList) do
		iter_4_1:playClose()
	end

	RougeRpc.instance:sendEnterRougeSelectStyleRequest(var_4_0, var_4_1, function(arg_6_0, arg_6_1)
		if arg_6_1 ~= 0 then
			logError("RougeFactionView:_btnstartOnClick resultCode=" .. tostring(arg_6_1))

			return
		end

		var_4_3 = true

		if not var_4_2 then
			return
		end

		UIBlockHelper.instance:endBlock(var_0_1)
		RougeController.instance:openRougeInitTeamView()
	end)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._btnstartGo = arg_7_0._btnstart.gameObject

	arg_7_0:_initScrollView()
	arg_7_0:_setActiveBtnStart(false)
end

function var_0_0._initScrollView(arg_8_0)
	arg_8_0._scrollViewGo = arg_8_0._scrollview.gameObject
	arg_8_0._scrollViewTrans = arg_8_0._scrollViewGo.transform
	arg_8_0._scrollViewLimitScrollCmp = arg_8_0._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	arg_8_0._goContentHLayout = arg_8_0._goContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_8_0._drag = UIDragListenerHelper.New()

	arg_8_0._drag:createByScrollRect(arg_8_0._scrollViewLimitScrollCmp)
	arg_8_0._drag:registerCallback(arg_8_0._drag.EventDragging, arg_8_0._onDragging, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_setActiveBlock(false)
	arg_9_0:_refresh()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._lastSelectedIndex = false
	arg_10_0._dataList = RougeOutsideModel.instance:getStyleInfoList(arg_10_0:_versionList())

	arg_10_0:_initDifficultyTips()
	arg_10_0:_initPageProgress()
	arg_10_0:onUpdateParam()
	arg_10_0:_onSelectIndex(nil)
	arg_10_0.viewContainer:registerCallback(RougeEvent.RougeFactionView_OnSelectIndex, arg_10_0._onSelectIndex, arg_10_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_10_0._onScreenResize, arg_10_0)
end

function var_0_0.onOpenFinish(arg_11_0)
	arg_11_0:_onScreenResize()
	arg_11_0:_tweenOpenAnim()
	ViewMgr.instance:closeView(ViewName.RougeDifficultyView)
	ViewMgr.instance:closeView(ViewName.RougeCollectionGiftView)
end

function var_0_0._getNewUnlockStateList(arg_12_0)
	local var_12_0 = {}
	local var_12_1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._dataList) do
		local var_12_2 = iter_12_1.style
		local var_12_3 = RougeOutsideModel.instance:getIsNewUnlockStyle(var_12_2)

		var_12_0[iter_12_0] = var_12_3

		if not var_12_1 and var_12_3 then
			var_12_1 = iter_12_0
		end
	end

	return var_12_0, var_12_1
end

function var_0_0._tweenOpenAnim(arg_13_0)
	UIBlockHelper.instance:startBlock("RougeFactionView:_tweenOpenAnim", 1, arg_13_0.viewName)

	local var_13_0 = arg_13_0:_getItemList()
	local var_13_1, var_13_2 = arg_13_0:_getNewUnlockStateList()

	var_13_2 = var_13_2 or 1

	local var_13_3 = var_13_0[var_13_2]

	local function var_13_4()
		UIBlockHelper.instance:endBlock("RougeFactionView:_tweenOpenAnim")
	end

	arg_13_0:_focusIndex(var_13_2)
	var_13_3:setOnOpenEndCb(var_13_4)

	if var_13_1[var_13_2] then
		var_13_3:setOnOpenEndCb(nil)
		var_13_3:setOnUnlockEndCb(var_13_4)
	else
		var_13_3:setOnOpenEndCb(var_13_4)
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_0 == 1 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
		end

		local var_13_5 = var_13_1 and var_13_1[iter_13_0] or nil

		if var_13_5 ~= nil then
			local var_13_6 = arg_13_0._dataList[iter_13_0].style

			iter_13_1:playOpen(var_13_5)

			if var_13_5 then
				RougeOutsideModel.instance:setIsNewUnlockStyle(var_13_6, false)
			end
		else
			iter_13_1:playOpen()
		end
	end
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:_clearTweenId()
	arg_15_0.viewContainer:unregisterCallback(RougeEvent.RougeFactionView_OnSelectIndex, arg_15_0._onSelectIndex, arg_15_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_15_0._onScreenResize, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0:_clearTweenId()
	GameUtil.onDestroyViewMember(arg_16_0, "_drag")
	GameUtil.onDestroyViewMemberList(arg_16_0, "_itemList")
end

function var_0_0._difficulty(arg_17_0)
	if not arg_17_0.viewParam then
		return RougeModel.instance:getDifficulty()
	end

	return arg_17_0.viewParam.selectedDifficulty or RougeModel.instance:getDifficulty()
end

function var_0_0._versionList(arg_18_0)
	if not arg_18_0.viewParam then
		return RougeModel.instance:getVersion()
	end

	return arg_18_0.viewParam.versionList or RougeModel.instance:getVersion()
end

function var_0_0._getDataList(arg_19_0)
	if not arg_19_0._dataList then
		arg_19_0._dataList = RougeOutsideModel.instance:getStyleInfoList(arg_19_0:_versionList())
	end

	return arg_19_0._dataList
end

function var_0_0._getDataListCount(arg_20_0)
	return #arg_20_0:_getDataList()
end

function var_0_0._validateIndex(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:_getDataListCount()

	return GameUtil.clamp(arg_21_1, 1, var_21_0)
end

function var_0_0._getItemList(arg_22_0)
	if not arg_22_0._itemList then
		arg_22_0:_refreshList()
	end

	return arg_22_0._itemList
end

function var_0_0._refresh(arg_23_0)
	arg_23_0:_refreshList()
end

function var_0_0._refreshList(arg_24_0)
	local var_24_0 = arg_24_0:_getDataList()

	arg_24_0._itemDataList = var_24_0

	if not arg_24_0._itemList then
		arg_24_0._itemList = {}
	end

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_24_1 = arg_24_0._itemList[iter_24_0]

		if not var_24_1 then
			var_24_1 = arg_24_0:_create_RougeFactionItem()

			var_24_1:setIndex(iter_24_0)
			table.insert(arg_24_0._itemList, var_24_1)
		end

		var_24_1:setData(iter_24_1)
		var_24_1:playIdle()
		var_24_1:setSelected(arg_24_0._lastSelectedIndex == iter_24_0)
	end
end

function var_0_0._onSelectIndex(arg_25_0, arg_25_1)
	if not arg_25_0._itemList then
		return
	end

	if arg_25_0._lastSelectedIndex then
		arg_25_0._itemList[arg_25_0._lastSelectedIndex]:setSelected(false)
	end

	if arg_25_0._lastSelectedIndex == arg_25_1 then
		arg_25_1 = nil

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190321)
	end

	if arg_25_1 then
		arg_25_0._itemList[arg_25_1]:setSelected(true)
		arg_25_0.viewContainer:rebuildLayout()
		arg_25_0:_focusIndex(arg_25_1, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190321)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_help_switch_20190322)
	end

	arg_25_0._lastSelectedIndex = arg_25_1

	arg_25_0:_setActiveBtnStart(arg_25_1 and true or false)
end

function var_0_0._setActiveBtnStart(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._btnstartGo, arg_26_1)
end

function var_0_0._clearTweenId(arg_27_0)
	GameUtil.onDestroyViewMember_TweenId(arg_27_0, "_tweenId")
end

function var_0_0._create_RougeFactionItem(arg_28_0)
	local var_28_0 = RougeFactionItem
	local var_28_1 = arg_28_0.viewContainer:getResInst(RougeEnum.ResPath.rougefactionitem, arg_28_0._goContent, var_28_0.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_28_1, var_28_0, {
		parent = arg_28_0,
		baseViewContainer = arg_28_0.viewContainer
	})
end

function var_0_0._selectedStyle(arg_29_0)
	if not arg_29_0._lastSelectedIndex then
		return
	end

	return arg_29_0._itemList[arg_29_0._lastSelectedIndex]:style()
end

function var_0_0._initPageProgress(arg_30_0)
	local var_30_0 = RougePageProgress
	local var_30_1 = arg_30_0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, arg_30_0._gorougepageprogress, var_30_0.__cname)

	arg_30_0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(var_30_1, var_30_0)

	arg_30_0._pageProgress:setData()
end

function var_0_0._initDifficultyTips(arg_31_0)
	local var_31_0 = arg_31_0:_difficulty()

	arg_31_0._txtDifficultyTiitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougefactionview_txtDifficultyTiitle"), RougeConfig1.instance:getDifficultyCOTitle(var_31_0))

	local var_31_1 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(var_31_0)
	local var_31_2 = gohelper.findChild(arg_31_0._godifficultytips, "red")
	local var_31_3 = gohelper.findChild(arg_31_0._godifficultytips, "orange")
	local var_31_4 = gohelper.findChild(arg_31_0._godifficultytips, "green")

	gohelper.setActive(var_31_4, var_31_1 == 1)
	gohelper.setActive(var_31_3, var_31_1 == 2)
	gohelper.setActive(var_31_2, var_31_1 == 3)
end

function var_0_0._focusIndex(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_3 = arg_32_3 or 0.3

	local var_32_0 = arg_32_0.viewContainer:getScrollContentTranform()
	local var_32_1 = arg_32_0:_calcFocusIndexPosX(arg_32_1)

	if arg_32_2 then
		arg_32_0:_clearTweenId()

		arg_32_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(var_32_0, -var_32_1, arg_32_3)
	else
		recthelper.setAnchorX(var_32_0, -var_32_1)
	end
end

function var_0_0._calcFocusIndexPosX(arg_33_0, arg_33_1)
	local var_33_0 = 0
	local var_33_1 = arg_33_0:_getMaxScrollX()

	if arg_33_1 <= 1 then
		return var_33_0, var_33_1
	end

	local var_33_2 = arg_33_0._itemList[arg_33_1]
	local var_33_3 = arg_33_0._goContentHLayout.padding.left
	local var_33_4 = arg_33_0:_getViewportW() * 0.5

	return GameUtil.clamp(var_33_2:posX() - var_33_3 - var_33_4, 0, var_33_1), var_33_1
end

function var_0_0._getViewportW(arg_34_0)
	return recthelper.getWidth(arg_34_0._scrollViewTrans)
end

function var_0_0._getViewportH(arg_35_0)
	return recthelper.getHeight(arg_35_0._scrollViewTrans)
end

function var_0_0._getViewportWH(arg_36_0)
	return arg_36_0:_getViewportW(), arg_36_0:_getViewportH()
end

function var_0_0._getMaxScrollX(arg_37_0)
	local var_37_0 = arg_37_0:_getViewportWH()
	local var_37_1 = arg_37_0:_calcContentWidth()

	return math.max(0, var_37_1 - var_37_0)
end

function var_0_0._calcContentWidth(arg_38_0)
	return recthelper.getWidth(arg_38_0.viewContainer:getScrollContentTranform())
end

function var_0_0._setActiveBlock(arg_39_0, arg_39_1)
	gohelper.setActive(arg_39_0._goblock, arg_39_1)
end

function var_0_0._onScreenResize(arg_40_0)
	arg_40_0.viewContainer:rebuildLayout()

	if arg_40_0._lastSelectedIndex then
		arg_40_0:_focusIndex(arg_40_0._lastSelectedIndex, true, 0.1)
	end
end

function var_0_0._calcSpaceOffset(arg_41_0)
	local var_41_0 = arg_41_0.viewContainer:getListScrollParam()
	local var_41_1 = arg_41_0:_getViewportW()
	local var_41_2 = var_41_0.cellWidth
	local var_41_3 = var_41_0.startSpace
	local var_41_4 = var_41_1 * 0.5 - var_41_2 * 0.5 - var_41_3

	return math.max(0, var_41_4)
end

function var_0_0._contentPosX(arg_42_0)
	return recthelper.getAnchorX(arg_42_0.viewContainer:getScrollContentTranform())
end

local var_0_2 = 139

function var_0_0._onDragging(arg_43_0)
	local var_43_0 = arg_43_0.viewContainer:getListScrollParamStep()
	local var_43_1 = arg_43_0:_contentPosX()

	if var_43_1 >= 0 then
		return
	end

	local var_43_2 = GameUtil.clamp(-var_43_1, 0, arg_43_0:_getMaxScrollX())

	if var_43_2 < var_0_2 then
		return
	end

	local var_43_3 = var_43_2 - var_0_2
	local var_43_4 = math.ceil(var_43_3 / var_43_0)

	if arg_43_0._lastScrollIndex == nil then
		arg_43_0._lastScrollIndex = var_43_4
	elseif arg_43_0._lastScrollIndex ~= var_43_4 then
		arg_43_0._lastScrollIndex = var_43_4

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_chain_20190320)
	end
end

return var_0_0
