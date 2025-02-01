module("modules.logic.social.view.SocialRequestView", package.seeall)

slot0 = class("SocialRequestView", BaseView)

function slot0.onInitView(slot0)
	slot0._gonorequest = gohelper.findChild(slot0.viewGO, "#go_norequest")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#go_top")
	slot0._txtfriendscount = gohelper.findChildText(slot0.viewGO, "#go_top/#txt_friendscount")
	slot0._txtfriends = gohelper.findChildText(slot0.viewGO, "#go_top/#txt_friends")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, slot0._refreshUI, slot0)
end

function slot0.onOpen(slot0)
	FriendRpc.instance:sendGetApplyListRequest()
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._gonorequest, SocialModel.instance:getRequestCount() <= 0)
	gohelper.setActive(slot0._gobottom, slot1 > 0)

	if slot1 > 0 then
		slot0._txtfriendscount.text = string.format("%d/%d", SocialModel.instance:getRequestCount(), SocialConfig.instance:getMaxRequestCount())
		slot0._txtfriends.text = luaLang("social_tabviewinfo_request")
	end
end

return slot0
