module("modules.logic.handbook.view.HandbookSkinSuitDetailViewBase", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailViewBase", BaseView)
local var_0_1 = 50

function var_0_0.onInitView(arg_1_0)
	arg_1_0._skinItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_scroll/#go_storyStages")
	arg_1_0._imageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_scroll/Viewport/#go_storyStages/#simage_FullBG")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "#go_scroll")
	arg_1_0._scroll = arg_1_0._goscroll:GetComponent(gohelper.Type_ScrollRect)
	arg_1_0._textSkinThemeDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_scroll/Viewport/#go_storyStages/#txt_Descr")
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._bgTrans = arg_1_0._imageBg.transform

	local var_1_0 = recthelper.getWidth(arg_1_0._bgTrans)

	for iter_1_0 = 1, arg_1_0._bgTrans.childCount do
		local var_1_1 = arg_1_0._bgTrans:GetChild(iter_1_0 - 1)

		if var_1_1 then
			var_1_0 = var_1_0 + recthelper.getWidth(var_1_1)
		end
	end

	local var_1_2 = ViewMgr.instance:getUIRoot()

	if var_1_0 - recthelper.getWidth(var_1_2.transform) < var_0_1 then
		arg_1_0._scroll.horizontal = false
		arg_1_0._scroll.vertical = false
	end

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0.onViewOpenedFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)
end

function var_0_0._getPhotoRootGo(arg_5_0, arg_5_1)
	arg_5_0._skinItemGoList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, arg_5_1 do
		arg_5_0._skinItemGoList[iter_5_0] = gohelper.findChild(arg_5_0.viewGO, "#go_scroll/Viewport/#go_storyStages/handbookskinitem/photo" .. iter_5_0)
	end
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam

	arg_6_0._skinSuitId = var_6_0 and var_6_0.skinThemeGroupId
	arg_6_0._isSuitSwitch = var_6_0 and var_6_0.suitSwitch
	arg_6_0._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(arg_6_0._skinSuitId)
	arg_6_0._skinSuitGroupId = arg_6_0._skinSuitCfg.highId

	local var_6_1 = arg_6_0._skinSuitCfg.skinContain

	arg_6_0._skinIdList = string.splitToNumber(var_6_1, "|")

	arg_6_0:addSwitchSuitBtns()

	if arg_6_0._isSuitSwitch then
		arg_6_0._viewAnimator:Play(UIAnimationName.Open, 0, 1)
	end
end

function var_0_0.refreshUI(arg_7_0)
	return
end

function var_0_0.refreshBtnStatus(arg_8_0)
	return
end

function var_0_0._refreshDesc(arg_9_0)
	arg_9_0._textSkinThemeDescr.text = arg_9_0._skinSuitCfg.des
end

function var_0_0._refreshBg(arg_10_0)
	return
end

function var_0_0._refreshSkinItems(arg_11_0)
	arg_11_0._skinItemList = {}

	for iter_11_0 = 1, #arg_11_0._skinIdList do
		local var_11_0 = arg_11_0._skinItemGoList[iter_11_0]

		if var_11_0 then
			local var_11_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0, HandbookSkinItem, arg_11_0)

			var_11_1:setData(arg_11_0._skinSuitId)
			var_11_1:refreshItem(arg_11_0._skinIdList[iter_11_0])
			table.insert(arg_11_0._skinItemList, var_11_1)
		end
	end
end

function var_0_0.addSwitchSuitBtns(arg_12_0)
	local var_12_0 = arg_12_0.viewContainer:getSetting().otherRes[1]

	arg_12_0.goBtns = arg_12_0.viewContainer:getResInst(var_12_0, arg_12_0.viewGO)
	arg_12_0._btnLeftSuit = gohelper.findChildButton(arg_12_0.goBtns, "#btn_Left")
	arg_12_0._btnRightSuit = gohelper.findChildButton(arg_12_0.goBtns, "#btn_Right")

	local var_12_1 = HandbookConfig.instance:getSkinSuitCfgListInGroup(arg_12_0._skinSuitGroupId, true)

	arg_12_0._suitCount = #var_12_1

	table.sort(var_12_1, var_0_0._suitCfgSort)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if iter_12_1.id == arg_12_0._skinSuitId then
			arg_12_0._preSuitIdx = iter_12_0 - 1
			arg_12_0._curSuitIdx = iter_12_0
			arg_12_0._nextSuitIdx = iter_12_0 + 1

			break
		end
	end

	local var_12_2 = arg_12_0._preSuitIdx and arg_12_0._preSuitIdx >= 1
	local var_12_3 = arg_12_0._nextSuitIdx and arg_12_0._nextSuitIdx <= arg_12_0._suitCount

	if var_12_2 then
		local var_12_4 = var_12_1[arg_12_0._preSuitIdx].id

		arg_12_0._btnLeftSuit:AddClickListener(arg_12_0.OpenOtherSuitView, arg_12_0, var_12_4)
	else
		gohelper.setActive(arg_12_0._btnLeftSuit.gameObject, false)

		arg_12_0._btnLeftSuit = nil
	end

	if var_12_3 then
		local var_12_5 = var_12_1[arg_12_0._nextSuitIdx].id

		arg_12_0._btnRightSuit:AddClickListener(arg_12_0.OpenOtherSuitView, arg_12_0, var_12_5)
	else
		gohelper.setActive(arg_12_0._btnRightSuit.gameObject, false)

		arg_12_0._btnRightSuit = nil
	end
end

function var_0_0.OpenOtherSuitView(arg_13_0, arg_13_1)
	local var_13_0 = HandbookSkinScene.SkinSuitId2SuitView[arg_13_1]

	if var_13_0 then
		local var_13_1 = {
			suitSwitch = true,
			skinThemeGroupId = arg_13_1
		}

		arg_13_0._openOtherSuitView = var_13_0

		ViewMgr.instance:openView(var_13_0, var_13_1, true)
	end
end

function var_0_0.onViewOpenedFinish(arg_14_0, arg_14_1)
	if arg_14_0._openOtherSuitView == arg_14_1 then
		arg_14_0:closeThis()
	end
end

function var_0_0._suitCfgSort(arg_15_0, arg_15_1)
	if arg_15_0.show == 1 and arg_15_1.show == 0 then
		return true
	elseif arg_15_0.show == 0 and arg_15_1.show == 1 then
		return false
	else
		return arg_15_0.id > arg_15_1.id
	end
end

function var_0_0.onClose(arg_16_0)
	if arg_16_0._btnRightSuit then
		arg_16_0._btnRightSuit:RemoveClickListener()

		arg_16_0._btnRightSuit = nil
	end

	if arg_16_0._btnLeftSuit then
		arg_16_0._btnLeftSuit:RemoveClickListener()

		arg_16_0._btnLeftSuit = nil
	end
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
