module("modules.logic.lifecircle.view.LifeCircleSignView", package.seeall)

local var_0_0 = class("LifeCircleSignView", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/#simage_BG2")
	arg_1_0._simageBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/#simage_BG1")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Title")
	arg_1_0._txtDays = gohelper.findChildText(arg_1_0.viewGO, "#txt_Days")
	arg_1_0._txt = gohelper.findChildText(arg_1_0.viewGO, "txtbg/#txt")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Reward")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_Reward/Viewport/#go_Content")
	arg_1_0._goGrayLine = gohelper.findChild(arg_1_0.viewGO, "#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	arg_1_0._goNormalLine = gohelper.findChild(arg_1_0.viewGO, "#scroll_Reward/Viewport/#go_Content/#go_NormalLine")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = ZProj.TweenHelper
local var_0_2 = table.insert
local var_0_3 = string.format
local var_0_4 = 200
local var_0_5 = 90.86

function var_0_0.ctor(arg_4_0, ...)
	arg_4_0:__onInit()
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._txtbgGO = gohelper.findChild(arg_5_0.viewGO, "txtbg")
	arg_5_0._scrollRewardGo = arg_5_0._scrollReward.gameObject
	arg_5_0._goGraylineTran = arg_5_0._goGrayLine.transform
	arg_5_0._goNormallineTran = arg_5_0._goNormalLine.transform
	arg_5_0._goContentTran = arg_5_0._goContent.transform
	arg_5_0._rectViewPortTran = gohelper.findChild(arg_5_0._scrollRewardGo, "Viewport").transform
	arg_5_0._hLayoutGroup = arg_5_0._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_5_0._goGraylinePosX = recthelper.getAnchorX(arg_5_0._goGraylineTran)
	arg_5_0._scrollRewardTrans = arg_5_0._scrollRewardGo.transform

	recthelper.setAnchorX(arg_5_0._goContentTran, 0)

	arg_5_0._itemList = {}
end

function var_0_0._onDragBegin(arg_6_0)
	arg_6_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_7_0)
	arg_7_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_8_0)
	arg_8_0._audioScroll:onClickDown()
end

function var_0_0._stagetitle(arg_9_0)
	local var_9_0 = arg_9_0:totalLoginDays()
	local var_9_1 = arg_9_0:_COList()
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if var_9_0 >= iter_9_1.logindaysid then
			var_9_2 = iter_9_0
		else
			break
		end
	end

	return var_9_1[var_9_2] and var_9_1[var_9_2].stagetitle or ""
end

function var_0_0._getLatestIndex(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._itemList) do
		if iter_10_1:isClaimable() then
			return iter_10_0
		elseif iter_10_1:isClaimed() then
			var_10_0 = iter_10_0
		end
	end

	return var_10_0
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:_refresh()
	arg_11_0:_refreshContentPosX(arg_11_0:_getLatestIndex())
	arg_11_0:_tryClaimAccumulateReward()
end

function var_0_0._calcHLayoutContentMaxWidth(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or #arg_12_0:_COList()

	local var_12_0 = var_0_4
	local var_12_1 = var_0_5
	local var_12_2 = arg_12_0._hLayoutGroup.padding
	local var_12_3 = arg_12_0._hLayoutGroup.spacing
	local var_12_4 = var_12_2.left

	return (var_12_0 + var_12_3) * math.max(0, arg_12_1) - var_12_4 - var_12_0 / 2 + var_12_1
end

function var_0_0.onOpen(arg_13_0)
	SignInController.instance:registerCallback(SignInEvent.OnSignInTotalRewardReply, arg_13_0._onSignInTotalRewardReply, arg_13_0)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, arg_13_0._onReceiveSignInTotalRewardAllReply, arg_13_0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, arg_13_0._onChangePlayerinfo, arg_13_0)
	arg_13_0:onUpdateParam()
	LifeCircleController.instance:markLatestConfigCount()
end

function var_0_0.onClose(arg_14_0)
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInTotalRewardReply, arg_14_0._onSignInTotalRewardReply, arg_14_0)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, arg_14_0._onReceiveSignInTotalRewardAllReply, arg_14_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, arg_14_0._onChangePlayerinfo, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInTotalRewardReply, arg_15_0._onSignInTotalRewardReply, arg_15_0)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, arg_15_0._onReceiveSignInTotalRewardAllReply, arg_15_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, arg_15_0._onChangePlayerinfo, arg_15_0)
	GameUtil.onDestroyViewMember(arg_15_0, "_drag")
	GameUtil.onDestroyViewMember_ClickDownListener(arg_15_0, "_touch")
	GameUtil.onDestroyViewMemberList(arg_15_0, "_itemList")
	var_0_0.super.onDestroyView(arg_15_0)
	arg_15_0:__onDispose()
end

function var_0_0._create_LifeCircleSignRewardsItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.viewContainer or arg_16_0:baseViewContainer()
	local var_16_1 = var_16_0:getResInst(SignInEnum.ResPath.lifecirclesignrewardsitem, arg_16_2)
	local var_16_2 = LifeCircleSignRewardsItem.New({
		parent = arg_16_0,
		baseViewContainer = var_16_0
	})

	var_16_2:setIndex(arg_16_1)
	var_16_2:init(var_16_1)

	return var_16_2
end

function var_0_0._onSignInTotalRewardReply(arg_17_0)
	arg_17_0:_refresh()
end

function var_0_0._onReceiveSignInTotalRewardAllReply(arg_18_0)
	arg_18_0:_scrollContentTo(arg_18_0:_getLatestIndex())
	arg_18_0:_refresh()
end

function var_0_0._onChangePlayerinfo(arg_19_0)
	arg_19_0:_refresh()
end

function var_0_0.totalLoginDays(arg_20_0)
	return PlayerModel.instance:getPlayinfo().totalLoginDays
end

function var_0_0._COList(arg_21_0)
	return lua_sign_in_lifetime_bonus.configList
end

function var_0_0._maxLogindaysid(arg_22_0)
	local var_22_0 = arg_22_0:_COList()
	local var_22_1 = var_22_0[#var_22_0]

	return var_22_1 and var_22_1.logindaysid or 0
end

function var_0_0._COListCount(arg_23_0)
	local var_23_0 = arg_23_0:_COList()

	return var_23_0 and #var_23_0 or 0
end

function var_0_0._refreshProgress(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = var_0_4
	local var_24_1 = arg_24_0._hLayoutGroup.spacing
	local var_24_2 = arg_24_0._goGraylinePosX
	local var_24_3 = arg_24_0._hLayoutGroup.padding.left + var_24_0 / 2
	local var_24_4 = var_24_1 + var_24_0
	local var_24_5, var_24_6 = arg_24_0:_calcProgWidth(arg_24_1, var_24_1, var_24_0, var_24_3, var_24_4, var_24_2, -var_24_2)

	recthelper.setWidth(arg_24_0._goGraylineTran, var_24_6)
	recthelper.setWidth(arg_24_0._goNormallineTran, var_24_5)
end

function var_0_0._calcProgWidth(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6, arg_25_7)
	local var_25_0 = arg_25_0:_COList()
	local var_25_1 = #var_25_0

	if var_25_1 == 0 then
		return 0, 0
	end

	arg_25_6 = arg_25_6 or 0
	arg_25_7 = arg_25_7 or 0
	arg_25_4 = arg_25_4 or arg_25_3 / 2
	arg_25_5 = arg_25_5 or arg_25_3 + arg_25_2

	local var_25_2 = arg_25_4 + (var_25_1 - 1) * arg_25_5 + arg_25_7
	local var_25_3 = 0
	local var_25_4 = 0

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		local var_25_5 = iter_25_1.logindaysid
		local var_25_6 = iter_25_0 == 1 and arg_25_4 or arg_25_5

		if var_25_5 <= arg_25_1 then
			var_25_3 = var_25_3 + var_25_6
			var_25_4 = var_25_5
		else
			var_25_3 = var_25_3 + GameUtil.remap(arg_25_1, var_25_4, var_25_5, 0, var_25_6)

			break
		end
	end

	return math.max(0, var_25_3 - arg_25_6), var_25_2
end

function var_0_0._getContentPosXByIndex(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:_calcHorizontalLayoutPixel(arg_26_1)
	local var_26_1 = 0

	return -math.max(0, var_26_0 - var_26_1)
end

function var_0_0._refreshContentPosX(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:_getContentPosXByIndex(arg_27_1)

	recthelper.setAnchorX(arg_27_0._goContentTran, var_27_0)
end

function var_0_0._scrollContentTo(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:_getContentPosXByIndex(arg_28_1)

	var_0_1.DOAnchorPosX(arg_28_0._goContentTran, var_28_0, 1)
end

function var_0_0._calcHorizontalLayoutPixel(arg_29_0, arg_29_1)
	local var_29_0 = var_0_4
	local var_29_1 = arg_29_0._hLayoutGroup.spacing
	local var_29_2 = arg_29_0._hLayoutGroup.padding.left
	local var_29_3 = arg_29_0:_viewportWidth()
	local var_29_4 = recthelper.getWidth(arg_29_0._goContentTran)
	local var_29_5 = math.max(0, var_29_4 - var_29_3)

	if arg_29_1 <= 1 then
		return 0
	end

	return math.min(var_29_5, (arg_29_1 - 1) * (var_29_1 + var_29_0) + var_29_2)
end

function var_0_0._viewportWidth(arg_30_0)
	return recthelper.getWidth(arg_30_0._scrollRewardTrans)
end

function var_0_0._refresh(arg_31_0)
	local var_31_0 = arg_31_0:_stagetitle()

	arg_31_0._txt.text = var_31_0

	gohelper.setActive(arg_31_0._txtbgGO, not string.nilorempty(var_31_0))

	local var_31_1 = arg_31_0:totalLoginDays()

	arg_31_0._txtDays.text = var_0_3(luaLang("lifecirclesignview_txt_Days"), var_31_1)

	arg_31_0:_refreshProgress(var_31_1, arg_31_0:_maxLogindaysid())

	local var_31_2 = arg_31_0:_calcHLayoutContentMaxWidth(arg_31_0:_COListCount())

	recthelper.setWidth(arg_31_0._goContentTran, var_31_2)
	arg_31_0:_refreshItemList()
end

function var_0_0._refreshItemList(arg_32_0)
	local var_32_0 = arg_32_0:_COList()

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_1

		if iter_32_0 > #arg_32_0._itemList then
			var_32_1 = arg_32_0:_create_LifeCircleSignRewardsItem(iter_32_0, arg_32_0._goContent)

			var_0_2(arg_32_0._itemList, var_32_1)
		else
			var_32_1 = arg_32_0._itemList[iter_32_0]
		end

		var_32_1:onUpdateMO(iter_32_1)
		var_32_1:setActive(true)
	end

	for iter_32_2 = #var_32_0 + 1, #arg_32_0._itemList do
		arg_32_0._itemList[iter_32_2]:setActive(false)
	end
end

local var_0_6 = "LifeCircleSignView:_tryClaimAccumulateReward()"

function var_0_0._tryClaimAccumulateReward(arg_33_0)
	if not LifeCircleController.instance:isClaimableAccumulateReward() then
		return
	end

	UIBlockHelper.instance:startBlock(var_0_6, 5, arg_33_0.viewName)
	LifeCircleController.instance:sendSignInTotalRewardAllRequest(function(arg_34_0, arg_34_1)
		UIBlockHelper.instance:endBlock(var_0_6)

		if arg_34_1 ~= 0 then
			SignInController.instance:sendGetSignInInfoRequestIfUnlock()
		end
	end)
end

return var_0_0
