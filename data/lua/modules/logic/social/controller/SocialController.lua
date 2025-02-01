module("modules.logic.social.controller.SocialController", package.seeall)

slot0 = class("SocialController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openSocialView(slot0, slot1)
	if SDKNativeUtil.isGamePad() then
		GameFacade.showToast(ToastEnum.ClassShow)
	else
		ViewMgr.instance:openView(ViewName.SocialView, slot1)
	end
end

function slot0.AddFriend(slot0, slot1, slot2, slot3)
	if PlayerModel.instance:getMyUserId() == slot1 then
		GameFacade.showToast(ToastEnum.SocialIsMyFriend)

		return false
	end

	if SocialModel.instance:isMyFriendByUserId(slot1) then
		GameFacade.showToast(ToastEnum.SocialIsMaxFriend)

		return false
	end

	if SocialConfig.instance:getMaxFriendsCount() <= SocialModel.instance:getFriendsCount() then
		GameFacade.showToast(ToastEnum.SocialRequest1)

		return false
	end

	FriendRpc.instance:sendApplyRequest(slot1, slot2, slot3)
end

function slot0.openInformPlayerTipView(slot0, slot1)
	if not ReportTypeListModel.instance:initDone() then
		slot0.informPlayerTipViewParam = slot1

		ChatRpc.instance:sendGetReportTypeRequest(slot0.onReceiveGetReportTypeReplay, slot0)

		return
	end

	ViewMgr.instance:openView(ViewName.InformPlayerTipView, slot1)
end

function slot0.onReceiveGetReportTypeReplay(slot0, slot1, slot2, slot3)
	ReportTypeListModel.instance:initType(slot3.reportTypes)
	ViewMgr.instance:openView(ViewName.InformPlayerTipView, slot0.informPlayerTipViewParam)

	slot0.informPlayerTipViewParam = nil
end

slot0.instance = slot0.New()

return slot0
