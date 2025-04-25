module("modules.logic.lifecircle.view.LifeCircleSignView", package.seeall)

slot0 = class("LifeCircleSignView", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._simageBG2 = gohelper.findChildSingleImage(slot0.viewGO, "BG/#simage_BG2")
	slot0._simageBG1 = gohelper.findChildSingleImage(slot0.viewGO, "BG/#simage_BG1")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Title")
	slot0._txtDays = gohelper.findChildText(slot0.viewGO, "#txt_Days")
	slot0._txt = gohelper.findChildText(slot0.viewGO, "txtbg/#txt")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Reward")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_Reward/Viewport/#go_Content")
	slot0._goGrayLine = gohelper.findChild(slot0.viewGO, "#scroll_Reward/Viewport/#go_Content/#go_GrayLine")
	slot0._goNormalLine = gohelper.findChild(slot0.viewGO, "#scroll_Reward/Viewport/#go_Content/#go_NormalLine")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = ZProj.TweenHelper
slot2 = table.insert
slot3 = string.format
slot4 = 200
slot5 = 90.86

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._txtbgGO = gohelper.findChild(slot0.viewGO, "txtbg")
	slot0._scrollRewardGo = slot0._scrollReward.gameObject
	slot0._goGraylineTran = slot0._goGrayLine.transform
	slot0._goNormallineTran = slot0._goNormalLine.transform
	slot0._goContentTran = slot0._goContent.transform
	slot0._rectViewPortTran = gohelper.findChild(slot0._scrollRewardGo, "Viewport").transform
	slot0._hLayoutGroup = slot0._goContentTran:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	slot0._goGraylinePosX = recthelper.getAnchorX(slot0._goGraylineTran)
	slot0._scrollRewardTrans = slot0._scrollRewardGo.transform

	recthelper.setAnchorX(slot0._goContentTran, 0)

	slot0._itemList = {}
end

function slot0._onDragBegin(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEnd(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDownHandler(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0._stagetitle(slot0)
	slot3 = 0

	for slot7, slot8 in ipairs(slot0:_COList()) do
		if slot8.logindaysid <= slot0:totalLoginDays() then
			slot3 = slot7
		else
			break
		end
	end

	return slot2[slot3] and slot2[slot3].stagetitle or ""
end

function slot0._getLatestIndex(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0._itemList) do
		if slot6:isClaimable() then
			return slot5
		elseif slot6:isClaimed() then
			slot1 = slot5
		end
	end

	return slot1
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
	slot0:_refreshContentPosX(slot0:_getLatestIndex())
	slot0:_tryClaimAccumulateReward()
end

function slot0._calcHLayoutContentMaxWidth(slot0, slot1)
	slot2 = uv0

	return (slot2 + slot0._hLayoutGroup.spacing) * math.max(0, slot1 or #slot0:_COList()) - slot0._hLayoutGroup.padding.left - slot2 / 2 + uv1
end

function slot0.onOpen(slot0)
	SignInController.instance:registerCallback(SignInEvent.OnSignInTotalRewardReply, slot0._onSignInTotalRewardReply, slot0)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, slot0._onReceiveSignInTotalRewardAllReply, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, slot0._onChangePlayerinfo, slot0)
	slot0:onUpdateParam()
	LifeCircleController.instance:markLatestConfigCount()
end

function slot0.onClose(slot0)
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInTotalRewardReply, slot0._onSignInTotalRewardReply, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, slot0._onReceiveSignInTotalRewardAllReply, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, slot0._onChangePlayerinfo, slot0)
end

function slot0.onDestroyView(slot0)
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInTotalRewardReply, slot0._onSignInTotalRewardReply, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, slot0._onReceiveSignInTotalRewardAllReply, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, slot0._onChangePlayerinfo, slot0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
	GameUtil.onDestroyViewMember_ClickDownListener(slot0, "_touch")
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0._create_LifeCircleSignRewardsItem(slot0, slot1, slot2)
	slot3 = slot0.viewContainer or slot0:baseViewContainer()
	slot5 = LifeCircleSignRewardsItem.New({
		parent = slot0,
		baseViewContainer = slot3
	})

	slot5:setIndex(slot1)
	slot5:init(slot3:getResInst(SignInEnum.ResPath.lifecirclesignrewardsitem, slot2))

	return slot5
end

function slot0._onSignInTotalRewardReply(slot0)
	slot0:_refresh()
end

function slot0._onReceiveSignInTotalRewardAllReply(slot0)
	slot0:_scrollContentTo(slot0:_getLatestIndex())
	slot0:_refresh()
end

function slot0._onChangePlayerinfo(slot0)
	slot0:_refresh()
end

function slot0.totalLoginDays(slot0)
	return PlayerModel.instance:getPlayinfo().totalLoginDays
end

function slot0._COList(slot0)
	return lua_sign_in_lifetime_bonus.configList
end

function slot0._maxLogindaysid(slot0)
	slot1 = slot0:_COList()

	return slot1[#slot1] and slot2.logindaysid or 0
end

function slot0._COListCount(slot0)
	return slot0:_COList() and #slot1 or 0
end

function slot0._refreshProgress(slot0, slot1, slot2)
	slot3 = uv0
	slot4 = slot0._hLayoutGroup.spacing
	slot5 = slot0._goGraylinePosX
	slot10, slot11 = slot0:_calcProgWidth(slot1, slot4, slot3, slot0._hLayoutGroup.padding.left + slot3 / 2, slot4 + slot3, slot5, -slot5)

	recthelper.setWidth(slot0._goGraylineTran, slot11)
	recthelper.setWidth(slot0._goNormallineTran, slot10)
end

function slot0._calcProgWidth(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if #slot0:_COList() == 0 then
		return 0, 0
	end

	slot6 = slot6 or 0
	slot10 = (slot4 or slot3 / 2) + (slot9 - 1) * (slot5 or slot3 + slot2) + (slot7 or 0)
	slot12 = 0

	for slot16, slot17 in ipairs(slot8) do
		if slot17.logindaysid <= slot1 then
			slot11 = 0 + (slot16 == 1 and slot4 or slot5)
			slot12 = slot18
		else
			slot11 = slot11 + GameUtil.remap(slot1, slot12, slot18, 0, slot19)

			break
		end
	end

	return math.max(0, slot11 - slot6), slot10
end

function slot0._getContentPosXByIndex(slot0, slot1)
	return -math.max(0, slot0:_calcHorizontalLayoutPixel(slot1) - 0)
end

function slot0._refreshContentPosX(slot0, slot1)
	recthelper.setAnchorX(slot0._goContentTran, slot0:_getContentPosXByIndex(slot1))
end

function slot0._scrollContentTo(slot0, slot1)
	uv0.DOAnchorPosX(slot0._goContentTran, slot0:_getContentPosXByIndex(slot1), 1)
end

function slot0._calcHorizontalLayoutPixel(slot0, slot1)
	slot2 = uv0
	slot3 = slot0._hLayoutGroup.spacing
	slot5 = slot0._hLayoutGroup.padding.left
	slot8 = math.max(0, recthelper.getWidth(slot0._goContentTran) - slot0:_viewportWidth())

	if slot1 <= 1 then
		return 0
	end

	return math.min(slot8, (slot1 - 1) * (slot3 + slot2) + slot5)
end

function slot0._viewportWidth(slot0)
	return recthelper.getWidth(slot0._scrollRewardTrans)
end

function slot0._refresh(slot0)
	slot1 = slot0:_stagetitle()
	slot0._txt.text = slot1

	gohelper.setActive(slot0._txtbgGO, not string.nilorempty(slot1))

	slot2 = slot0:totalLoginDays()
	slot0._txtDays.text = uv0(luaLang("lifecirclesignview_txt_Days"), slot2)

	slot0:_refreshProgress(slot2, slot0:_maxLogindaysid())
	recthelper.setWidth(slot0._goContentTran, slot0:_calcHLayoutContentMaxWidth(slot0:_COListCount()))
	slot0:_refreshItemList()
end

function slot0._refreshItemList(slot0)
	for slot5, slot6 in ipairs(slot0:_COList()) do
		slot7 = nil

		if slot5 > #slot0._itemList then
			uv0(slot0._itemList, slot0:_create_LifeCircleSignRewardsItem(slot5, slot0._goContent))
		else
			slot7 = slot0._itemList[slot5]
		end

		slot7:onUpdateMO(slot6)
		slot7:setActive(true)
	end

	for slot5 = #slot1 + 1, #slot0._itemList do
		slot0._itemList[slot5]:setActive(false)
	end
end

slot6 = "LifeCircleSignView:_tryClaimAccumulateReward()"

function slot0._tryClaimAccumulateReward(slot0)
	if not LifeCircleController.instance:isClaimableAccumulateReward() then
		return
	end

	UIBlockHelper.instance:startBlock(uv0, 5, slot0.viewName)
	LifeCircleController.instance:sendSignInTotalRewardAllRequest(function (slot0, slot1)
		UIBlockHelper.instance:endBlock(uv0)

		if slot1 ~= 0 then
			SignInController.instance:sendGetSignInInfoRequestIfUnlock()
		end
	end)
end

return slot0
