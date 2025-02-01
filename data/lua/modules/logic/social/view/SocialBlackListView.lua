module("modules.logic.social.view.SocialBlackListView", package.seeall)

slot0 = class("SocialBlackListView", BaseView)

function slot0.onInitView(slot0)
	slot0._gohas = gohelper.findChild(slot0.viewGO, "#go_has")
	slot0._gono = gohelper.findChild(slot0.viewGO, "#go_no")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, slot0._refreshUI, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.AddUnknownBlackList, slot0._onAddUnknownBlackList, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, slot0._refreshUI, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.AddUnknownBlackList, slot0._onAddUnknownBlackList, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	FriendRpc.instance:sendGetBlacklistRequest()

	if slot0._notFirst then
		slot0:_refreshUI()
	else
		slot0:_refreshUI(true)
	end

	slot0._notFirst = true
end

function slot0._onAddUnknownBlackList(slot0)
	FriendRpc.instance:sendGetBlacklistRequest()
end

function slot0._refreshUI(slot0, slot1)
	slot2 = SocialModel.instance:getBlackListCount()

	if not slot1 then
		gohelper.setActive(slot0._gohas, slot2 > 0)
		gohelper.setActive(slot0._gono, slot2 <= 0)
	else
		gohelper.setActive(slot0._gohas, slot2 > 0)
		gohelper.setActive(slot0._gono, false)
	end
end

return slot0
