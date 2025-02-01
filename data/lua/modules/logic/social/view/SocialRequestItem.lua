module("modules.logic.social.view.SocialRequestItem", package.seeall)

slot0 = class("SocialRequestItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "#go_playericon")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtstatus = gohelper.findChildText(slot0.viewGO, "status/#txt_status")
	slot0._txtofflinetime = gohelper.findChildText(slot0.viewGO, "status/#txt_offlinetime")
	slot0._goofflinebg = gohelper.findChild(slot0.viewGO, "status/bg")
	slot0._txtuid = gohelper.findChildText(slot0.viewGO, "#txt_uid")
	slot0._btnagree = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_agree")
	slot0._btnreject = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reject")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnagree:AddClickListener(slot0._btnagreeOnClick, slot0)
	slot0._btnreject:AddClickListener(slot0._btnrejectOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnagree:RemoveClickListener()
	slot0._btnreject:RemoveClickListener()
end

function slot0._btnagreeOnClick(slot0)
	if SocialConfig.instance:getMaxFriendsCount() <= SocialModel.instance:getFriendsCount() then
		GameFacade.showToast(ToastEnum.SocialRequest1)

		return
	end

	if SocialModel.instance:isMyBlackListByUserId(slot0._mo.userId) then
		GameFacade.showToast(ToastEnum.SocialRequest2)

		return
	end

	FriendRpc.instance:sendHandleApplyRequest(slot0._mo.userId, true)
end

function slot0._btnrejectOnClick(slot0)
	FriendRpc.instance:sendHandleApplyRequest(slot0._mo.userId, false)
end

function slot0._editableInitView(slot0)
	slot0._heros = {}
	slot0._heroParents = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0._heroParents[slot4] = gohelper.findChild(slot0.viewGO, "Role/" .. slot4)
	end

	slot0._playericon = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericon)
end

function slot0._refreshUI(slot0)
	slot0._playericon:onUpdateMO(slot0._mo)
	slot0._playericon:setShowLevel(true)

	slot0._txtname.text = slot0._mo.name
	slot0._txtuid.text = tostring(slot0._mo.userId)
	slot0._txtstatus.text = SocialConfig.instance:getRequestTimeText(slot0._mo.time)

	gohelper.setActive(slot0._goofflinebg, false)

	if not slot0._mo.bg or slot0._mo.bg == 0 then
		gohelper.setActive(slot0._simagebg, false)
	else
		gohelper.setActive(slot0._simagebg, true)
		slot0._simagebg:LoadImage(string.format("singlebg/playerinfo/%s.png", PlayerConfig.instance:getBgCo(slot0._mo.bg).chatbg))
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()

	for slot7 = 1, 3 do
		if slot7 <= #(slot1.infos or {}) then
			slot0:getHeroIcon(slot7):updateMo(slot2[slot7])
		else
			slot8:setActive(false)
		end
	end
end

function slot0.getHeroIcon(slot0, slot1)
	if not slot0._heros[slot1] then
		slot0._heros[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst("ui/viewres/social/socialheroitem.prefab", slot0._heroParents[slot1], "HeroItem"), SocialHeroItem)
	end

	return slot0._heros[slot1]
end

function slot0.onDestroy(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
